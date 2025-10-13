// preprocess.js  (Bundle root, Copy Bundle Resources 포함)

var ExtensionPreprocessingJS = {
  run: function (arguments) {
    try {
      // 1) url
      var url = (typeof location !== 'undefined' && location.href) ? location.href : '';

      // 2) 하이라이트 수집 (없으면 빈 배열)
      var highlights = [];
      try {
        // 예: 우리가 content script에서 localStorage에 저장한 키 포맷
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

      var payload = { url: url, highlights: highlights };

      // ✅ 반드시 completionFunction으로 반환해야 Swift 쪽에 들어감
      arguments.completionFunction(payload);
    } catch (err) {
      // 실패해도 빈 값 넘겨서 Swift가 크래시 나지 않도록
      arguments.completionFunction({ url: '', highlights: [] });
    }
  },

  // finalize는 선택사항 (여기선 사용 안 함)
  finalize: function (arguments) { }
};
