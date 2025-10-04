 (function () {
   const SENTENCE_END = /[.!?。！？]/;

   document.addEventListener("selectionchange", () => {
     const sel = window.getSelection();
     if (!sel.rangeCount) return;

     const range = sel.getRangeAt(0);
     if (range.collapsed) return; // 선택이 없으면 무시

     let node = range.startContainer;
     if (node.nodeType !== Node.TEXT_NODE) {
       if (node.firstChild && node.firstChild.nodeType === Node.TEXT_NODE) {
         node = node.firstChild;
       } else {
         return;
       }
     }

     const text = node.textContent ?? "";
     const start = range.startOffset;
     const end = range.endOffset;

     // 왼쪽 경계 (최근 구두점)
     let left = start - 1;
     while (left >= 0 && !SENTENCE_END.test(text[left])) left--;
     left = (left >= 0) ? left + 1 : 0;
     while (left < text.length && /\s/.test(text[left])) left++;

     // 오른쪽 경계 (다음 구두점)
     let right = end;
     while (right < text.length && !SENTENCE_END.test(text[right])) right++;
     if (right < text.length) right++;
     while (right < text.length && /\s/.test(text[right])) right++;

     if (left >= right) return;

     // 새로운 Range
     const sentenceRange = document.createRange();
     sentenceRange.setStart(node, left);
     sentenceRange.setEnd(node, right);

     const span = document.createElement("span");
     span.className = "my-ext-highlight";
     span.style.backgroundColor = "yellow";

     try {
       sentenceRange.surroundContents(span);
       sel.removeAllRanges(); // 파란 선택 해제
     } catch (e) {
       console.warn("하이라이트 실패 (DOM 섞임 가능):", e);
     }
   });
 })();

(function () {
  if (document.getElementById("myExtBottomBar")) return;

  const bar = document.createElement("div");
  bar.id = "myExtBottomBar";
  Object.assign(bar.style, {
    position: "fixed",
    left: "0",
    right: "0",
    bottom: "env(safe-area-inset-bottom)",     // ← 안전영역만큼 올림
    height: "-35px",
    background: "rgba(255,255,255,1)",
    backdropFilter: "blur(12px)", WebkitBackdropFilter: "blur(12px)",
    zIndex: "2147483647",
    paddingBottom: "env(safe-area-inset-bottom)" // 텍스트/버튼이 잘리지 않게
  });

  bar.innerText = "🌞 내 확장 바";
  document.body.appendChild(bar);
})();
