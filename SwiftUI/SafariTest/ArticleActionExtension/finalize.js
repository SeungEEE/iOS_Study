//// finalize.js
//var ExtensionJavaScriptFinalize = function(arguments) {
//  try {
//    var data = arguments || {};
//    var url = (typeof data.url === 'string') ? data.url : (location && location.href) || '';
//    var highlights = Array.isArray(data.highlights) ? data.highlights : [];
//
//    // 기존 페이지에 우리가 쓰던 스타일/유틸(아주 축약본)
//    (function(){
//      function injectStyle() {
//        if (document.getElementById('__as_style__')) return;
//        var style = document.createElement('style');
//        style.id = '__as_style__';
//        style.textContent =
//          '.highlighted-text{cursor:pointer;transition:background-color .2s}' +
//          '.highlighted-text[data-color="what"]{background:#FEE8D6!important}' +
//          '.highlighted-text[data-color="why"]{background:#F1FFD9!important}' +
//          '.highlighted-text[data-color="detail"]{background:#D9F5FF!important}';
//        (document.head||document.documentElement).appendChild(style);
//      }
//      injectStyle();
//
//      function normalize(s){ return (s||'').replace(/\s+/g,' ').trim(); }
//
//      // 간단 매칭: 텍스트 노드에서 first match
//      function applyOne(hl) {
//        var quote = normalize(hl.sentence||'');
//        if (!quote) return;
//        var walker = document.createTreeWalker(document.body, NodeFilter.SHOW_TEXT, {
//          acceptNode: function(n){
//            return (n.nodeValue && n.nodeValue.indexOf(quote) >= 0) ?
//              NodeFilter.FILTER_ACCEPT : NodeFilter.FILTER_SKIP;
//          }
//        });
//        var tn = walker.nextNode();
//        if (!tn) return;
//        var idx = tn.nodeValue.indexOf(quote);
//        if (idx < 0) return;
//
//        var range = document.createRange();
//        range.setStart(tn, idx);
//        range.setEnd(tn, idx + quote.length);
//
//        var span = document.createElement('span');
//        span.className = 'highlighted-text';
//        span.setAttribute('data-color', hl.color || 'what');
//        var color = hl.color==='why' ? '#F1FFD9' : (hl.color==='detail' ? '#D9F5FF' : '#FEE8D6');
//        span.style.setProperty('background-color', color, 'important');
//
//        try {
//          range.surroundContents(span);
//        } catch {
//          var frag = range.extractContents();
//          span.appendChild(frag);
//          range.insertNode(span);
//        }
//      }
//
//      highlights.forEach(applyOne);
//    })();
//
//    return true;
//  } catch(e) {
//    return false;
//  }
//};
