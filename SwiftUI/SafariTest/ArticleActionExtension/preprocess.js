// preprocess.js  (Bundle root, Copy Bundle Resources 포함)

//var ExtensionPreprocessingJS = {
//  run: function (arguments) {
//    try {
//      // 1) url
//      var url = (typeof location !== 'undefined' && location.href) ? location.href : '';
//
//      // 2) 하이라이트 수집 (없으면 빈 배열)
//      var highlights = [];
//      try {
//        // 예: 우리가 content script에서 localStorage에 저장한 키 포맷
//        var keys = Object.keys(localStorage || {}).filter(function(k){
//          return k.indexOf('memo:' + location.origin + location.pathname + ':') === 0;
//        });
//        for (var i = 0; i < keys.length; i++) {
//          try {
//            var v = JSON.parse(localStorage.getItem(keys[i]));
//            if (v && v.quote) {
//              highlights.push({
//                sentence: v.quote,
//                color: v.color || null,
//                memo: v.memo || null
//              });
//            }
//          } catch (e) {}
//        }
//      } catch (e) {}
//
//      var payload = { url: url, highlights: highlights };
//
//      // ✅ 반드시 completionFunction으로 반환해야 Swift 쪽에 들어감
//      arguments.completionFunction(payload);
//    } catch (err) {
//      // 실패해도 빈 값 넘겨서 Swift가 크래시 나지 않도록
//      arguments.completionFunction({ url: '', highlights: [] });
//    }
//  },
//
//  // finalize는 선택사항 (여기선 사용 안 함)
//  finalize: function (arguments) { }
//};

// preprocess.js  (Action Extension 번들, Copy Bundle Resources 포함)

var ExtensionPreprocessingJS = {
  run: function (arguments) {
    try {
      var url = (typeof location !== 'undefined' && location.href) ? location.href : '';

      var highlights = [];
      try {
        var keys = Object.keys(localStorage || {}).filter(function(k){
          return k.indexOf('memo:' + location.origin + location.pathname + ':') === 0;
        });
        for (var i = 0; i < keys.length; i++) {
          try {
            var v = JSON.parse(localStorage.getItem(keys[i]));
            if (v && v.quote) {
              highlights.push({
                sentence: v.quote,
                color: v.color || null,
                memo: v.memo || null
              });
            }
          } catch (e) {}
        }
      } catch (e) {}

      arguments.completionFunction({ url: url, highlights: highlights });
    } catch (err) {
      arguments.completionFunction({ url: '', highlights: [] });
    }
  },

  // ✅ Safari가 completeRequest(returningItems:)로 넘긴 값을 가지고
  //    이 finalize(arguments)를 호출한다.
  finalize: function (arguments) {
    try {
      var data = arguments || {};
      var url = (typeof data.url === 'string') ? data.url : (location && location.href) || '';
      var highlights = Array.isArray(data.highlights) ? data.highlights : [];
        
        // 기존 마킹 제거(중복/삭제 반영)
        (function removeOld(){
            var nodes = Array.from(document.querySelectorAll('.highlighted-text'));
            nodes.forEach(function(span){
                var p = span.parentNode;
                while (span.firstChild) p.insertBefore(span.firstChild, span);
                p.removeChild(span);
            });
        })();

      (function(){
        function injectStyle() {
          if (document.getElementById('__as_style__')) return;
          var style = document.createElement('style');
          style.id = '__as_style__';
          style.textContent =
            '.highlighted-text{cursor:pointer;transition:background-color .2s}' +
            '.highlighted-text[data-color="what"]{background:#FEE8D6!important}' +
            '.highlighted-text[data-color="why"]{background:#F1FFD9!important}' +
            '.highlighted-text[data-color="detail"]{background:#D9F5FF!important}';
          (document.head||document.documentElement).appendChild(style);
        }
        injectStyle();

        function normalize(s){ return (s||'').replace(/\s+/g,' ').trim(); }

        function applyOne(hl) {
          var quote = normalize(hl.sentence||'');
          if (!quote) return;

          var walker = document.createTreeWalker(document.body, NodeFilter.SHOW_TEXT, {
            acceptNode: function(n){
              return (n.nodeValue && n.nodeValue.indexOf(quote) >= 0)
                ? NodeFilter.FILTER_ACCEPT : NodeFilter.FILTER_SKIP;
            }
          });
          var tn = walker.nextNode();
          if (!tn) return;
          var idx = tn.nodeValue.indexOf(quote);
          if (idx < 0) return;

          var range = document.createRange();
          range.setStart(tn, idx);
          range.setEnd(tn, idx + quote.length);

          var span = document.createElement('span');
          span.className = 'highlighted-text';
          span.setAttribute('data-color', hl.color || 'what');
          var color = hl.color==='why' ? '#F1FFD9' : (hl.color==='detail' ? '#D9F5FF' : '#FEE8D6');
          span.style.setProperty('background-color', color, 'important');

          try {
            range.surroundContents(span);
          } catch {
            var frag = range.extractContents();
            span.appendChild(frag);
            range.insertNode(span);
          }
        }

        highlights.forEach(applyOne);
      })();

      return true;
    } catch(e) {
      return false;
    }
  }
};
