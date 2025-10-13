 (function () {
   if (window.__AS_INIT__) return;
   window.__AS_INIT__ = true;
   console.log("[AS] content init:", location.href);
   
   /** =========================
    *  0) 스타일 주입
    * ========================= */
   const style = document.createElement("style");
   style.textContent = `
     .highlighted-text { cursor: pointer; transition: background-color .2s ease; }
     .highlighted-text[data-color="what"]  { background-color: #FEE8D6 !important; }
     .highlighted-text[data-color="why"]   { background-color: #F1FFD9 !important; }
     .highlighted-text[data-color="detail"]{ background-color: #D9F5FF !important; }
     .highlighted-text[data-color="memo"]  { background-color: #CDCDD1 !important; }
   
     .as-tooltip {
       position: fixed; display: flex; gap: 8px;
       background: rgba(255,255,255,.98);
       padding: 8px 12px; border-radius: 20px;
       box-shadow: 0 4px 16px rgba(0,0,0,.18);
       z-index: 2147483647; opacity: 0; pointer-events: none;
       transition: opacity .15s ease;
     }
     .as-tooltip.show { opacity: 1; pointer-events: auto; }
     .as-tooltip button { width: 28px; height: 28px; border-radius: 50%; border: none; cursor: pointer; }
     .as-btn-what  { background:#FEE8D6; }
     .as-btn-why   { background:#F1FFD9; }
     .as-btn-detail{ background:#D9F5FF; }
     .as-btn-memo  { background:#CDCDD1; }
     .as-btn-del   { width:auto; height:auto; padding:4px 8px; border-radius:8px; background:#eee; font-size:12px; }
   
     /* 메모 박스 */
     .as-memo-box {
       margin-top: 6px;
       background: #fafafa;
       border: 1px solid #ddd;
       border-radius: 8px;
       padding: 6px;
       font-size: 14px;
       box-shadow: 0 2px 6px rgba(0,0,0,0.1);
     }
     .as-memo-box textarea {
       width: 100%;
       height: 60px;
       resize: none;
       border: none;
       outline: none;
       background: transparent;
       font-family: inherit;
       font-size: 14px;
     }
     .as-memo-actions {
       display: flex; justify-content: flex-end; gap: 6px;
       margin-top: 4px;
     }
     .as-memo-actions button {
       padding: 4px 10px;
       border-radius: 6px;
       border: none;
       cursor: pointer;
       font-size: 13px;
     }
   .as-memo-box { display:block; }
     .as-save-btn { background: #15ACE5; color: white; }
     .as-cancel-btn { background: #eee; }
   `;
   (document.head || document.documentElement).appendChild(style);
   
   // === 확장 저장소 유틸 ===
   const api = typeof browser !== "undefined" ? browser : (typeof chrome !== "undefined" ? chrome : null);
   const isSafari = /^((?!chrome|android).)*safari/i.test(navigator.userAgent);

   const storage = {
     async set(key, val) {
       // ✅ Safari에서는 localStorage만 사용
       if (isSafari) {
         if (val === null) localStorage.removeItem(key);
         else localStorage.setItem(key, JSON.stringify(val));
         return;
       }

       try {
         if (api?.storage?.local) {
           await new Promise(res => api.storage.local.set({ [key]: val }, res));
         } else {
           if (val === null) localStorage.removeItem(key);
           else localStorage.setItem(key, JSON.stringify(val));
         }
       } catch {
         if (val === null) localStorage.removeItem(key);
         else localStorage.setItem(key, JSON.stringify(val));
       }
     },

     async get(key) {
       if (isSafari) {
         const raw = localStorage.getItem(key);
         return raw ? JSON.parse(raw) : null;
       }
       try {
         if (api?.storage?.local) {
           return await new Promise(res => api.storage.local.get(key, d => res(d[key])));
         }
         const raw = localStorage.getItem(key);
         return raw ? JSON.parse(raw) : null;
       } catch {
         const raw = localStorage.getItem(key);
         return raw ? JSON.parse(raw) : null;
       }
     },

     async getAll() {
       if (isSafari) {
         const all = {};
         for (let i = 0; i < localStorage.length; i++) {
           const k = localStorage.key(i);
           try { all[k] = JSON.parse(localStorage.getItem(k)); } catch {}
         }
         return all;
       }

       try {
         if (api?.storage?.local) {
           return await new Promise(res => api.storage.local.get(null, d => res(d)));
         }
         const all = {};
         for (let i = 0; i < localStorage.length; i++) {
           const k = localStorage.key(i);
           try { all[k] = JSON.parse(localStorage.getItem(k)); } catch {}
         }
         return all;
       } catch {
         const all = {};
         for (let i = 0; i < localStorage.length; i++) {
           const k = localStorage.key(i);
           try { all[k] = JSON.parse(localStorage.getItem(k)); } catch {}
         }
         return all;
       }
     }
   };
   
   function normalizeForMatch(s) {
     // 공백/개행 차이, 연속 공백을 동일하게 취급
     return s.replace(/\s+/g, " ").trim();
   }

   // articleRoot 내부에서 quote(문장)과 매칭되는 Range 만들기 (노드 경계 무시)
   function findRangeAcrossNodes(articleRoot, quote) {
     const needle = normalizeForMatch(quote);
     if (!needle) return null;

     const walker = document.createTreeWalker(
       articleRoot,
       NodeFilter.SHOW_TEXT,
       {
         acceptNode: (n) => n.nodeValue && n.nodeValue.trim() ? NodeFilter.FILTER_ACCEPT : NodeFilter.FILTER_REJECT
       }
     );

     // 텍스트 노드들을 순회하며 누적 문자열을 만들고, 매칭 시작/끝 위치를 Range로 역매핑
     let acc = "";
     let map = []; // [{node, startInAcc, endInAcc}]
     let node;
     while ((node = walker.nextNode())) {
       const raw = node.nodeValue;
       const start = acc.length;
       acc += normalizeForMatch(raw);
       const end = acc.length;
       map.push({ node, startInAcc: start, endInAcc: end, raw });
     }

     const startIdx = acc.indexOf(needle);
     if (startIdx < 0) return null;
     const endIdx = startIdx + needle.length;

     // startIdx/endIdx를 실제 노드/오프셋으로 변환
     let startNode = null, startOffset = 0, endNode = null, endOffset = 0;

     for (const seg of map) {
       if (startNode == null && startIdx >= seg.startInAcc && startIdx <= seg.endInAcc) {
         // seg.raw에서 startIdx에 해당하는 오리지널 offset을 역추정
         startNode = seg.node;
         // 역매핑: normalizeForMatch에서 공백이 축약되었으므로 원문에서 같은 위치를 대충 근사
         // 충분히 잘 맞음: 공백을 제외한 문자 기준으로 offset 계산
         startOffset = approximateOffset(seg.raw, startIdx - seg.startInAcc);
       }
       if (endNode == null && endIdx >= seg.startInAcc && endIdx <= seg.endInAcc) {
         endNode = seg.node;
         endOffset = approximateOffset(seg.raw, endIdx - seg.startInAcc);
         break;
       }
     }

     if (!startNode || !endNode) return null;

     const range = document.createRange();
     range.setStart(startNode, startOffset);
     range.setEnd(endNode, endOffset);
     return range;

     function approximateOffset(raw, normalizedOffset) {
       // raw에서 공백 여러개를 1칸으로 본 normalizedOffset에 대응하는 대략적 오프셋을 찾는다
       let normCount = 0;
       for (let i = 0; i < raw.length; i++) {
         const ch = raw[i];
         if (/\s/.test(ch)) {
           // 연속 공백을 하나로 셈
           // 다음도 공백이면 continue
           if (i > 0 && /\s/.test(raw[i-1])) continue;
           normCount += 1;
         } else {
           normCount += 1;
         }
         if (normCount >= normalizedOffset) return i + 1;
       }
       return raw.length;
     }
   }
   
   /** =========================
    *  1) 툴팁
    * ========================= */
   const tooltip = document.createElement("div");
   tooltip.className = "as-tooltip";
   tooltip.innerHTML = `
     <button class="as-btn-what"   title="what"></button>
     <button class="as-btn-why"    title="why"></button>
     <button class="as-btn-detail" title="detail"></button>
     <button class="as-btn-memo"   title="memo"></button>
     <button class="as-btn-del"    title="삭제">삭제</button>
   `;
   document.body.appendChild(tooltip);
   
   let currentHL = null;
   
   tooltip.addEventListener("click", async (e) => {
     if (!currentHL) return;
     const btn = e.target.closest("button");
     if (!btn) return;
     
     // 삭제
     if (btn.classList.contains("as-btn-del")) {
       const id = currentHL.dataset.id;
       if (id) {
         const storageKey = `memo:${getCleanUrl()}:${id}`;
         await storage.set(storageKey, null);
       }
       unwrap(currentHL);
       hideTooltip();
       return;
     }
     
     // 메모
     if (btn.classList.contains("as-btn-memo")) {
       const target = currentHL;
       hideTooltip({ keepCurrent: true });
       if (target) showMemoBox(target);
       return;
     }
     
     // 색 변경
     const map = {
       "as-btn-what":   ["what",   "#FEE8D6"],
       "as-btn-why":    ["why",    "#F1FFD9"],
       "as-btn-detail": ["detail", "#D9F5FF"],
     };
     for (const k in map) {
       if (btn.classList.contains(k)) {
         const [token, color] = map[k];
         currentHL.setAttribute("data-color", token);
         currentHL.style.setProperty("background-color", color, "important");
         break;
       }
     }
     hideTooltip();
   });
   
   function showTooltip(target) {
     tooltip.classList.add("show");
     currentHL = target;
     requestAnimationFrame(() => {
       const r = target.getBoundingClientRect();
       const tRect = tooltip.getBoundingClientRect();
       const top = Math.max(r.top - tRect.height - 8, 8);
       const left = Math.max(r.left + r.width/2 - tRect.width/2, 8);
       tooltip.style.top = `${top}px`;
       tooltip.style.left = `${left}px`;
     });
   }
   
   function hideTooltip(opts = {}) {
     const { keepCurrent = false } = opts;
     tooltip.classList.remove("show");
     if (!keepCurrent) currentHL = null;
   }
   
   // 🔧 URL을 항상 pathname 기준으로만 통일
   function getCleanUrl() {
     return location.origin + location.pathname;
   }
   
   /** =========================
    *  2) 메모 박스
    * ========================= */
   function showMemoBox(target) {
     const next = target.nextSibling;
     if (next && next.nodeType === Node.ELEMENT_NODE && next.classList?.contains("as-memo-box")) {
       next.querySelector("textarea")?.focus();
       return;
     }
     
     const memoBox = document.createElement("span");
     memoBox.className = "as-memo-box";
     memoBox.innerHTML = `
      <textarea placeholder="메모를 입력하세요..."></textarea>
      <div class="as-memo-actions">
        <button class="as-save-btn">저장</button>
        <button class="as-cancel-btn">닫기</button>
      </div>
    `;
     target.insertAdjacentElement("afterend", memoBox);
     
     const textarea = memoBox.querySelector("textarea");
     textarea.focus();
     
     if (!target.dataset.id) target.dataset.id = Date.now().toString();
     const storageKey = `memo:${getCleanUrl()}:${target.dataset.id}`;
     
     // 기존 메모 불러오기
     storage.get(storageKey).then(existing => {
       if (existing?.memo) textarea.value = existing.memo;
     });
     
     // 저장 버튼
     memoBox.querySelector(".as-save-btn").addEventListener("click", async () => {
       const text = textarea.value.trim();
       if (!text) return;
       
       const payload = {
         memo: text,
         url: location.href,
         color: target.getAttribute("data-color"),
         quote: target.textContent,
         date: new Date().toISOString(),
       };
       await storage.set(storageKey, payload);
       console.log("💾 저장됨:", storageKey, payload);
       
       // 기존 미리보기 있으면 삭제
       const exist = target.nextSibling;
       if (exist && exist.classList?.contains("as-memo-preview")) exist.remove();
       
       
       const colorMap = {
         what:   { bg: "#FEE8D6", border: "#FF8018", text: "#FF8018" },
         why:    { bg: "#F1FFD9", border: "#91E500", text: "#91E500" },
         detail: { bg: "#D9F5FF", border: "#15ACE5", text: "#15ACE5" }
       };
       
       const type = target.getAttribute("data-color") || "what";
       const theme = colorMap[type] || colorMap.what;
       
       const chip = document.createElement("div");
       chip.className = "as-memo-preview";
       chip.innerHTML = `
        <span class="as-chip-text">${text.length > 15 ? text.slice(0,15)+'...' : text}</span>
        <button class="as-chip-del">✕</button>
      `;
       
       target.insertAdjacentHTML("afterend", "<br>");
       target.nextSibling.insertAdjacentElement("afterend", chip);
       
       // 칩 스타일
       chip.style.cssText = `
        display: inline-flex;
        align-items: center;
        gap: 6px;
        margin-top: 6px;
        background: ${theme.bg};
        border: 1px solid ${theme.border};
        color: ${theme.text};
        border-radius: 20px;
        padding: 4px 10px;
        font-size: 13px;
        cursor: pointer;
        line-height: 1.4;
        position: relative;
        top: 6px;
        width: fit-content;          
        max-width: 90%;              
        word-break: break-word;     
      `;
       
       chip.querySelector(".as-chip-text").style.cssText = `
        white-space: nowrap;
        overflow: hidden;
        text-overflow: ellipsis;
        max-width: 140px;
      `;
       
       // 칩 클릭 → 수정창 다시 열기
       chip.addEventListener("click", (e) => {
         if (e.target.classList.contains("as-chip-del")) return;
         showMemoBox(target);
       });
       
       // 삭제 버튼
       chip.querySelector(".as-chip-del").addEventListener("click", async (e) => {
         e.stopPropagation();
         await storage.set(storageKey, null);
         chip.remove();
       });
       
       memoBox.remove();
     });
     
     // 닫기
     memoBox.querySelector(".as-cancel-btn").addEventListener("click", () => {
       memoBox.remove();
     });
   }
   
   /** 가장 가까운 블록 컨테이너 찾기 */
   function findBlockContainer(el) {
     // 우선 흔한 블록 태그 우선 탐색
     const selector = "p, li, blockquote, dd, dt, figure, table, section, article, div";
     let node = el.closest(selector);
     if (node) return node;
     
     // 위 selector에 안 걸리는 경우, display가 block/contents/table 계열인 곳까지 올라감
     node = el.parentElement;
     while (node && node !== document.body) {
       const disp = getComputedStyle(node).display;
       if (disp && disp !== "inline" && disp !== "inline-block" && disp !== "contents") return node;
       node = node.parentElement;
     }
     // 최후: 자기 자신
     return el;
   }
   
   /** =========================
    *  3) 더블탭 감지 + 싱글탭
    * ========================= */
   const DBL_MS  = 350;
   const DBL_PX  = 18;
   const MOVE_PX = 6;
   
   let lastUp = null;
   let downPt = null;
   let moved = false;
   let singleTimer = null;
   
   const d2 = (x1,y1,x2,y2)=>{ const dx=x1-x2, dy=y1-y2; return dx*dx+dy*dy; };
   
   document.addEventListener('pointerdown', (e) => {
     if (e.pointerType !== 'touch') return;
     downPt = { x: e.clientX, y: e.clientY };
     moved = false;
   }, { passive:true });
   
   document.addEventListener('pointermove', (e) => {
     if (e.pointerType !== 'touch' || !downPt) return;
     if (!moved && Math.sqrt(d2(downPt.x,downPt.y,e.clientX,e.clientY)) > MOVE_PX) moved = true;
   }, { passive:true });
   
   document.addEventListener('pointerup', (e) => {
     if (e.pointerType !== 'touch') return;
     if (moved) { resetTouchState(); return; }
     
     const nowUp = { t: Date.now(), x: e.clientX, y: e.clientY, target: e.target };
     
     if (lastUp && (nowUp.t - lastUp.t) <= DBL_MS && d2(nowUp.x,nowUp.y,lastUp.x,lastUp.y) <= DBL_PX*DBL_PX) {
       if (singleTimer) { clearTimeout(singleTimer); singleTimer = null; }
       handleDoubleAt(nowUp.x, nowUp.y);
       lastUp = null;
       resetTouchState();
       return;
     }
     
     if (singleTimer) clearTimeout(singleTimer);
     singleTimer = setTimeout(() => {
       handleSingleAt(nowUp.x, nowUp.y);
       singleTimer = null;
       lastUp = null;
     }, DBL_MS + 10);
     
     lastUp = nowUp;
     resetTouchState();
   }, { passive:true });
   
   document.addEventListener('pointercancel', () => resetTouchState(), { passive:true });
   document.addEventListener("dblclick", (e) => handleDoubleAt(e.clientX, e.clientY));
   document.addEventListener("mousedown", (e) => setTimeout(() => handleSingleAt(e.clientX, e.clientY), 10));
   document.addEventListener('gesturestart', e => e.preventDefault(), { passive:false });
   
   function resetTouchState(){ downPt = null; moved = false; }
   
   /** =========================
    *  4) 더블탭 → 문장 하이라이트
    * ========================= */
   function handleDoubleAt(x, y) {
     hideTooltip();
     
     const caret = caretRangeAt(x, y);
     if (!caret) return;
     
     let node = caret.startContainer;
     node = (node && node.nodeType === Node.TEXT_NODE) ? node : nearestTextNodeAtPoint(x, y, node);
     if (!node || !node.textContent || !node.textContent.trim()) return;
     
     const existing = node.parentElement?.closest?.(".highlighted-text");
     if (existing) { unwrap(existing); return; }
     
     const text = node.textContent;
     const offset = clamp(caret.startOffset || 0, 0, text.length);
     const { start, end } = sentenceBounds(text, offset);
     if (start === end) return;
     
     const range = document.createRange();
     range.setStart(node, start);
     range.setEnd(node, end);
     
     const span = document.createElement("span");
     span.className = "highlighted-text";
     span.setAttribute("data-color", "what");
     span.dataset.id = Date.now().toString();
     span.style.setProperty("background-color", "#FEE8D6", "important");
     
     try {
       range.surroundContents(span);
     } catch {
       const frag = range.extractContents();
       span.appendChild(frag);
       range.insertNode(span);
     }
   }
   
   /** =========================
    *  5) 싱글탭 → 툴팁
    * ========================= */
   function handleSingleAt(x, y) {
     const el = document.elementFromPoint(x, y);
     const hl = el?.closest?.(".highlighted-text");
     if (!hl) return;
     showTooltip(hl);
   }
   
   /** =========================
    *  6) 유틸
    * ========================= */
   function caretRangeAt(x, y){
     if (document.caretRangeFromPoint) return document.caretRangeFromPoint(x, y);
     if (document.caretPositionFromPoint){
       const pos = document.caretPositionFromPoint(x, y);
       if (!pos) return null;
       const r = document.createRange();
       r.setStart(pos.offsetNode, pos.offset);
       r.collapse(true);
       return r;
     }
     const el = document.elementFromPoint(x, y);
     if (!el) return null;
     const tn = nearestTextNode(el);
     if (!tn) return null;
     const r = document.createRange();
     r.setStart(tn, 0);
     r.collapse(true);
     return r;
   }
   
   function nearestTextNodeAtPoint(x, y, baseNode){
     let el = document.elementFromPoint(x, y);
     if (!el && baseNode && baseNode.nodeType === 1) el = baseNode;
     if (!el) return null;
     return nearestTextNode(el);
   }
   
   function nearestTextNode(el){
     if (!el) return null;
     const w = document.createTreeWalker(el, NodeFilter.SHOW_TEXT, {
       acceptNode: n => (n.nodeValue && n.nodeValue.trim()) ? NodeFilter.FILTER_ACCEPT : NodeFilter.FILTER_REJECT
     });
     return w.nextNode();
   }
   
   // 숫자/문장 끝 판단 유틸
   function isDigit(ch){ return ch >= '0' && ch <= '9'; }
   
   function isEllipsis(text, i){
     // '...' 또는 한국어 '…'
     return (text.substr(i,3) === '...') || (text[i] === '…');
   }
   
   function isAbbrevBeforeDot(text, i){
     // i는 '.' 위치
     // 점 앞 단어 추출
     let j = i - 1;
     while (j >= 0 && /\s/.test(text[j])) j--;
     let end = j;
     while (j >= 0 && /[A-Za-z]/.test(text[j])) j--;
     const word = text.slice(j+1, end+1).toLowerCase();
     // 자주 쓰는 약어
     const ABBR = new Set(['mr','mrs','ms','dr','prof','sr','jr','vs','etc','e.g','i.e','inc','corp']);
     if (ABBR.has(word)) return true;
     // U.S. / U.K. 같은 한 글자 대문자 약어 패턴 (A.)
     if (/^[A-Za-z]$/.test(word)) return true;
     return false;
   }
   
   function isSentenceEndChar(text, i){
     const ch = text[i];
     if (!ch) return false;
     
     // 명백한 끝 구두점
     if (ch === '!' || ch === '?' || ch === '。' || ch === '！' || ch === '？') return true;
     if (isEllipsis(text, i)) return true;
     
     if (ch === '.') {
       // 1) 소수점/날짜/버전: 숫자 사이의 점이면 문장 끝 아님 (예: 4.23, 2025.10.10, v1.2.3)
       const prev = text[i-1], next = text[i+1];
       if (isDigit(prev) && isDigit(next)) return false;
       
       // 2) 잘 알려진 약어 뒤의 마침표는 문장 끝로 보지 않음 (Mr., Dr., e.g., U.S.)
       if (isAbbrevBeforeDot(text, i)) return false;
       
       // 그 외의 마침표는 문장 끝
       return true;
     }
     return false;
   }
   
   function sentenceBounds(text, offset){
     let s = offset, e = offset;
     
     // 왼쪽으로 가며 직전 문장 끝을 찾되, 숫자 내 점은 제외
     while (s > 0 && !isSentenceEndChar(text, s-1)) s--;
     // 문장 끝 문자 바로 뒤부터 시작
     if (s > 0) s++;
     
     // 공백 스킵
     while (s < text.length && /\s/.test(text[s])) s++;
     
     // 오른쪽으로 가며 다음 문장 끝 찾기
     while (e < text.length && !isSentenceEndChar(text, e)) e++;
     // 끝 구두점 포함
     if (e < text.length) {
       if (isEllipsis(text, e)) {
         e += (text.substr(e,3) === '...') ? 3 : 1;
       } else {
         e += 1;
       }
     }
     
     // 오른쪽 공백 정리
     while (e > s && /\s/.test(text[e-1])) e--;
     
     return { start: s, end: e };
   }
   
   function unwrap(span){
     const p = span.parentNode;
     while (span.firstChild) p.insertBefore(span.firstChild, span);
     p.removeChild(span);
   }
   
   
   function clamp(v,min,max){ return Math.max(min, Math.min(max, v)); }
   
   /** =========================
    *  7) 공유 함수: 현재 페이지의 하이라이트 + 메모를 앱으로 전달
    * ========================= */
   async function shareHighlightsToApp() {
     const all = await storage.getAll();
     const keyPrefix = `memo:${location.origin}${location.pathname}:`;

     const highlights = Array.from(document.querySelectorAll(".highlighted-text")).map(span => {
       const id = span.dataset.id || "";
       const stored = all[`${keyPrefix}${id}`];
       return {
         sentence: span.innerText.trim(),
         color: span.dataset.color || null,
         memo: stored?.memo || ""
       };
     });

     const payload = {
       url: location.href,
       highlights
     };

     const json = JSON.stringify(payload);
     const base64 = btoa(unescape(encodeURIComponent(json))); // UTF-8 → base64
     const markerText = `ASJSON:${base64}`;

     try {
       await navigator.share({
         title: document.title,
         text: markerText,      // ✅ JSON은 text에
         url: location.href     // ✅ URL도 같이
       });
       console.log("✅ 공유 시트 표시됨");
     } catch (err) {
       console.error("❌ 공유 실패:", err);
     }
   }
   
   /** =========================
    *  8) 페이지 로드 시 저장된 하이라이트 복원
    * ========================= */
   async function restoreHighlights() {
     const keyPrefix = `memo:${getCleanUrl()}:`;
     const all = await storage.getAll();

     const entries = Object.entries(all)
       .filter(([k, v]) => k.startsWith(keyPrefix) && v && v.quote);

     const articleRoot = document.querySelector("#dic_area") || document.body;

     if (!entries.length || !articleRoot) {
       console.log("ℹ️ 복원할 데이터 없음 또는 본문 없음");
       return;
     }

     let restoredCount = 0;

     for (const [k, data] of entries) {
       const quote = data.quote?.trim();
       const color = data.color || "what";
       const memo = data.memo || "";
       const id = k.split(":").pop();

       // 이미 같은 문장 하이라이트 존재 시 skip
       if ([...articleRoot.querySelectorAll(".highlighted-text")].some(span => span.textContent.trim() === quote)) {
         continue;
       }

       // ✅ 이제 findRangeAcrossNodes만 사용
       const range = findRangeAcrossNodes(articleRoot, quote);
       if (!range) continue;

       const span = document.createElement("span");
       span.className = "highlighted-text";
       span.setAttribute("data-color", color);
       span.dataset.id = id;
       span.style.setProperty(
         "background-color",
         color === "why" ? "#F1FFD9"
           : color === "detail" ? "#D9F5FF"
           : "#FEE8D6",
         "important"
       );

       try {
         range.surroundContents(span);
       } catch {
         const frag = range.cloneContents();
         span.appendChild(frag);
         range.deleteContents();
         range.insertNode(span);
       }

       if (memo) {
         const chip = document.createElement("div");
         chip.className = "as-memo-preview";
         chip.textContent = memo.length > 15 ? memo.slice(0,15) + "..." : memo;
         span.insertAdjacentElement("afterend", chip);
       }

       restoredCount++;
     }

     console.log(`✅ 복원 완료: ${restoredCount}개 하이라이트`);
   }

   function waitForArticleAndRestore() {
     const check = setInterval(() => {
       const article = document.querySelector("#dic_area");
       if (article) {
         clearInterval(check);
         restoreHighlights();
       }
     }, 600);
   }

   const observer = new MutationObserver(() => {
     if (document.querySelector("#dic_area")) {
       restoreHighlights();
     }
   });

   if (document.readyState === "complete") {
     waitForArticleAndRestore();
     observer.observe(document.body, { childList: true, subtree: true });
   } else {
     window.addEventListener("load", () => {
       waitForArticleAndRestore();
       observer.observe(document.body, { childList: true, subtree: true });
     });
   }
 })();
