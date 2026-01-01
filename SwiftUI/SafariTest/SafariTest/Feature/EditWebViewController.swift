//
//  EditWebViewController.swift
//  SafariTest
//
<<<<<<< Updated upstream
//  Created by 이안 on 10/13/25.
=======
//  Created by 이승진 on 10/13/25.
>>>>>>> Stashed changes
//

import UIKit
import WebKit

final class EditWebViewController: UIViewController, WKScriptMessageHandler, WKNavigationDelegate {
<<<<<<< Updated upstream
  
  private let article: SharedArticle
  private let onSave: (SharedArticle) -> Void
  private let onCancel: () -> Void
  
  private var webView: WKWebView!
  private let spinner = UIActivityIndicatorView(style: .large)
  
  init(article: SharedArticle,
       onSave: @escaping (SharedArticle) -> Void,
       onCancel: @escaping () -> Void) {
    self.article = article
    self.onSave = onSave
    self.onCancel = onCancel
    super.init(nibName: nil, bundle: nil)
  }
  required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .systemBackground
    title = "편집"
    
    // 네비 버튼
    navigationItem.leftBarButtonItem = UIBarButtonItem(
      title: "취소", style: .plain, target: self, action: #selector(tapCancel)
    )
    navigationItem.rightBarButtonItem = UIBarButtonItem(
      title: "저장", style: .done, target: self, action: #selector(tapSave)
    )
    
    // WKWebView 구성
    let config = WKWebViewConfiguration()
    let uc = WKUserContentController()
    
    // JS 브릿지
    uc.add(self, name: "asBridge")
    
    // 1) 하이라이트/메모 UI & 동작 스크립트 삽입 (페이지 시작 시)
    let coreJS = WKUserScript(
      source: Self.coreHighlightJS,
      injectionTime: .atDocumentEnd,
      forMainFrameOnly: true
    )
    uc.addUserScript(coreJS)
    
    // 2) 브릿지 유틸 (collect()가 postMessage로 네이티브로 보냄)
    let bridgeJS = WKUserScript(
      source: Self.bridgeJS,
      injectionTime: .atDocumentEnd,
      forMainFrameOnly: true
    )
    uc.addUserScript(bridgeJS)
    
    config.userContentController = uc
    
    webView = WKWebView(frame: .zero, configuration: config)
    webView.navigationDelegate = self
    webView.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(webView)
    
    NSLayoutConstraint.activate([
      webView.topAnchor.constraint(equalTo: view.topAnchor),
      webView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
      webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
    ])
    
    // 스피너
    spinner.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(spinner)
    NSLayoutConstraint.activate([
      spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor)
    ])
    
    // URL 로드
    if let url = URL(string: article.url) {
      spinner.startAnimating()
      webView.load(URLRequest(url: url))
    }
  }
  
  // 페이지 로드 완료 후: 저장된 하이라이트를 localStorage에 심고 복원 실행
  func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
    spinner.stopAnimating()
    injectInitialHighlights()
  }
  
  // MARK: - 주입: 기존 하이라이트를 localStorage로 넣고 복원
  private func injectInitialHighlights() {
    // article.highlights -> JS 배열 문자열
    let jsArray: String = article.highlights.map { h in
      let s = (h.sentence
        .replacingOccurrences(of: "\\", with: "\\\\")
        .replacingOccurrences(of: "`", with: "\\`")
        .replacingOccurrences(of: "\n", with: "\\n"))
      let color = (h.color ?? "")
      let memo = (h.memo ?? "")
        .replacingOccurrences(of: "\\", with: "\\\\")
        .replacingOccurrences(of: "`", with: "\\`")
        .replacingOccurrences(of: "\n", with: "\\n")
      return "{sentence:`\(s)`, color:`\(color)`, memo:`\(memo)`}"
    }.joined(separator: ",")
    
    let restoreJS = """
    (function(){
      if (!window.AS) return;
      const items = [\(jsArray)];
      // 현재 페이지 기준의 keyPrefix 사용
      const prefix = 'memo:' + location.origin + location.pathname + ':';
      // 모두 비우고 다시 세팅(중복 방지)
      Object.keys(localStorage).forEach(k => {
        if (k.indexOf(prefix) === 0) localStorage.removeItem(k);
      });
      items.forEach((it, idx) => {
        const id = Date.now().toString() + '-' + idx;
        const storageKey = prefix + id;
        const payload = {
          memo: it.memo || '',
          url: location.href,
          color: it.color || 'what',
          quote: it.sentence || '',
          date: new Date().toISOString()
        };
        localStorage.setItem(storageKey, JSON.stringify(payload));
      });
      // 복원
      if (window.AS && typeof window.AS.restoreHighlights === 'function') {
        window.AS.restoreHighlights();
      }
    })();
    """
    
    webView.evaluateJavaScript(restoreJS, completionHandler: nil)
  }
  
  // MARK: - Nav actions
  @objc private func tapCancel() {
    onCancel()
    dismiss(animated: true)
  }
  
  @objc private func tapSave() {
    let js = "window.AS && typeof window.AS.collect === 'function' ? window.AS.collect() : null;"
    webView.evaluateJavaScript(js) { [weak self] _, _ in
      // collect()는 JS에서 postMessage로 네이티브에 보냄 (message.name == "asBridge")
    }
  }
  
  // MARK: - WKScriptMessageHandler
  func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
    guard message.name == "asBridge" else { return }
    guard let body = message.body as? [String: Any],
          let type = body["type"] as? String else { return }
    
    if type == "save",
       let urlStr = body["url"] as? String,
       let arr = body["highlights"] as? [[String: Any]] {
      
      let hs: [SharedArticle.Highlight] = arr.compactMap { d in
        guard let sentence = d["sentence"] as? String else { return nil }
        let color = d["color"] as? String
        let memo = d["memo"] as? String
        return .init(sentence: sentence, color: color, memo: memo)
      }
      var updated = article
      updated.highlights = hs
      onSave(updated)
      dismiss(animated: true)
    }
  }
}

// MARK: - 주입할 JS
private extension EditWebViewController {
  
  /// 하이라이트/메모 UI + 복원/수집(간소화판)
  static let coreHighlightJS: String = """
  (function(){
    if (window.AS) return;
    window.AS = {};
  
    // 스타일
    const style = document.createElement('style');
    style.textContent = `
      .highlighted-text { cursor:pointer; transition: background-color .2s; }
      .highlighted-text[data-color="what"]  { background:#FEE8D6 !important; }
      .highlighted-text[data-color="why"]   { background:#F1FFD9 !important; }
      .highlighted-text[data-color="detail"]{ background:#D9F5FF !important; }
      .as-chip { display:inline-flex; gap:6px; margin-left:6px; padding:2px 8px; border-radius:14px; font-size:12px; border:1px solid #ddd; background:#fafafa; color:#333; }
      .as-chip button { border:none; background:transparent; cursor:pointer; font-size:12px; }
    `;
    (document.head||document.documentElement).appendChild(style);
  
    function getCleanUrl(){ return location.origin + location.pathname; }
    function normalize(s){ return (s||'').replace(/\\s+/g,' ').trim(); }
  
    // 문장 경계 대충 처리(간소화)
    function isEnd(ch){ return /[.!?\\u0021\\u003F\\u3002\\uFF01\\uFF1F]/.test(ch); }
    function sentenceBounds(text, offset){
      let s = offset, e = offset;
      while (s>0 && !isEnd(text[s-1])) s--;
      if (s>0) s++;
      while (e<text.length && !isEnd(text[e])) e++;
      if (e<text.length) e++;
      while (e>s && /\\s/.test(text[e-1])) e--;
      return {start:s, end:e};
    }
  
    function caretRangeAt(x,y){
      if (document.caretRangeFromPoint) return document.caretRangeFromPoint(x,y);
      const el = document.elementFromPoint(x,y);
      if (!el) return null;
      const r = document.createRange();
      r.setStart(el,0);
      r.collapse(true);
      return r;
    }
  
    function nearestTextNode(el){
      if (!el) return null;
      const w = document.createTreeWalker(el, NodeFilter.SHOW_TEXT, {
        acceptNode:n => (n.nodeValue && n.nodeValue.trim())?NodeFilter.FILTER_ACCEPT:NodeFilter.FILTER_REJECT
      });
      return w.nextNode();
    }
  
    function nearestTextNodeAtPoint(x,y,base){
      let el = document.elementFromPoint(x,y) || base;
      return nearestTextNode(el);
    }
  
    function unwrap(span){
      const p = span.parentNode;
      while (span.firstChild) p.insertBefore(span.firstChild, span);
      p.removeChild(span);
    }
  
    // 더블클릭 → 문장 하이라이트 토글
    function handleDoubleAt(x,y){
      const caret = caretRangeAt(x,y); if (!caret) return;
      let node = caret.startContainer;
      node = (node && node.nodeType===3)?node:nearestTextNodeAtPoint(x,y,node);
      if (!node || !node.textContent || !node.textContent.trim()) return;
  
      const existing = node.parentElement?.closest?.('.highlighted-text');
      if (existing) { unwrap(existing); return; }
  
      const text = node.textContent;
      const off = Math.max(0, Math.min(caret.startOffset||0, text.length));
      const {start, end} = sentenceBounds(text, off);
      if (start===end) return;
  
      const range = document.createRange();
      range.setStart(node, start);
      range.setEnd(node, end);
  
      const span = document.createElement('span');
      span.className = 'highlighted-text';
      span.setAttribute('data-color','what');
      span.style.setProperty('background-color','#FEE8D6','important');
  
      try {
        range.surroundContents(span);
      } catch {
        const frag = range.extractContents();
        span.appendChild(frag);
        range.insertNode(span);
      }
    }
  
    document.addEventListener('dblclick', e => handleDoubleAt(e.clientX, e.clientY), false);
  
    // 복원: localStorage에서 현재 페이지 프리픽스 찾고 quote 매칭 → span으로 감쌈
    window.AS.restoreHighlights = function(){
      const prefix = 'memo:' + getCleanUrl() + ':';
      const keys = Object.keys(localStorage).filter(k=>k.indexOf(prefix)===0);
      const root = document.body;
      keys.forEach(k=>{
        try{
          const v = JSON.parse(localStorage.getItem(k)||'{}');
          const quote = normalize(v.quote||'');
          if (!quote) return;
  
          // 텍스트 노드 순회하며 첫 매칭에만 사용(간소화)
          const walker = document.createTreeWalker(root, NodeFilter.SHOW_TEXT, {
            acceptNode:n => (n.nodeValue && n.nodeValue.includes(quote)) ? NodeFilter.FILTER_ACCEPT : NodeFilter.FILTER_SKIP
          });
          const tn = walker.nextNode();
          if (!tn) return;
          const idx = tn.nodeValue.indexOf(quote);
          if (idx<0) return;
  
          const range = document.createRange();
          range.setStart(tn, idx);
          range.setEnd(tn, idx + quote.length);
  
          const span = document.createElement('span');
          span.className = 'highlighted-text';
          span.setAttribute('data-color', v.color || 'what');
          const color = v.color==='why' ? '#F1FFD9' : (v.color==='detail' ? '#D9F5FF' : '#FEE8D6');
          span.style.setProperty('background-color', color, 'important');
  
          try {
            range.surroundContents(span);
          } catch {
            const frag = range.extractContents();
            span.appendChild(frag);
            range.insertNode(span);
          }
  
          if (v.memo) {
            const chip = document.createElement('span');
            chip.className = 'as-chip';
            chip.textContent = v.memo.length>18 ? v.memo.slice(0,18)+'…' : v.memo;
            span.insertAdjacentElement('afterend', chip);
          }
        }catch(e){}
      });
    };
  
    // 수집: 현재 문서의 .highlighted-text + localStorage 메모 병합해 반환
    window.AS.collect = function(){
      const prefix = 'memo:' + getCleanUrl() + ':';
      const all = {};
      Object.keys(localStorage).forEach(k=>{
        if (k.indexOf(prefix)===0) {
          try{ all[k] = JSON.parse(localStorage.getItem(k)||'{}'); }catch(e){}
        }
      });
  
      const out = [];
      document.querySelectorAll('.highlighted-text').forEach(span=>{
        const sentence = (span.textContent||'').trim();
        const color = span.getAttribute('data-color')||'what';
        // localStorage에서 같은 quote 찾기(첫 일치)
        let memo = '';
        for (const k in all) {
          if ((all[k]?.quote||'') === sentence) { memo = all[k]?.memo || ''; break; }
        }
        out.push({ sentence, color, memo });
      });
  
      try {
        window.webkit?.messageHandlers?.asBridge?.postMessage({
          type: 'save',
          url: location.href,
          highlights: out
        });
      } catch(e) {}
      return true;
    };
  
    // 최초 진입 시 자동 복원 (localStorage 데이터가 미리 세팅되면 보임)
    try { window.AS.restoreHighlights(); } catch(e){}
  })();
  """
  
  /// 네이티브로 저장 호출 브릿지 (보조)
  static let bridgeJS: String = """
  (function(){
    // 여긴 별도 로직 없음. core에서 collect()가 postMessage 호출.
  })();
  """
=======
//  private var web: WKWebView!
//  private let article: SharedArticle
//
//  init(article: SharedArticle) {
//    self.article = article
//    super.init(nibName: nil, bundle: nil)
//  }
//  required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
  var article: SharedArticle!
    var onSave: ((SharedArticle) -> Void)?
    var onCancel: (() -> Void)?

    convenience init(article: SharedArticle,
                     onSave: @escaping (SharedArticle) -> Void,
                     onCancel: @escaping () -> Void) {
      self.init(nibName: nil, bundle: nil)
      self.article = article
      self.onSave = onSave
      self.onCancel = onCancel
    }

    required init?(coder: NSCoder) { super.init(coder: coder) }

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .systemBackground

    // 1) 구성 + content.js 삽입
    let cfg = WKWebViewConfiguration()
    cfg.userContentController.add(self, name: "native")

    // (1) content.js 번들에 넣어둔 파일 읽어서 주입 (지금 사파리용 content.js 재사용)
    if let url = Bundle.main.url(forResource: "content", withExtension: "js"),
       let js = try? String(contentsOf: url) {
      let script = WKUserScript(source: js, injectionTime: .atDocumentEnd, forMainFrameOnly: true)
      cfg.userContentController.addUserScript(script)
    }

    // (2) 네이티브 ↔︎ JS 브리지 헬퍼 (아래 2장에서 JS 함수 정의)
    let bridgeJS = """
    // 네이티브에서 호출: 저장된 하이라이트 적용
    window.__AS_LOAD_SAVED__ = function(saved) {
      try {
        if (!Array.isArray(saved)) return;
        // content.js가 restoreHighlights 로직을 이미 갖고 있으면,
        // "quote"와 "color","memo"를 이용해 문장 매칭해서 래핑하면 됨.
        // 여기선 간단히 저장 포맷을 localStorage에 넣고, 기존 restore를 재사용하는 방식도 가능.
        (window.__AS_APPLY_SAVED && window.__AS_APPLY_SAVED__(saved));
      } catch(e) { console.error(e); }
    };

    // JS → 네이티브로 현재 상태 전달
    window.__AS_EXPORT_TO_APP__ = function(payload) {
      if (window.webkit && window.webkit.messageHandlers && window.webkit.messageHandlers.native) {
        window.webkit.messageHandlers.native.postMessage({ type: "save", data: payload });
      }
    };
    """
    let bridgeScript = WKUserScript(source: bridgeJS, injectionTime: .atDocumentEnd, forMainFrameOnly: true)
    cfg.userContentController.addUserScript(bridgeScript)

    web = WKWebView(frame: view.bounds, configuration: cfg)
    web.navigationDelegate = self
    web.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    view.addSubview(web)

    navigationItem.rightBarButtonItem = UIBarButtonItem(title: "저장", style: .done, target: self, action: #selector(saveTapped))

    // 2) 페이지 열기
    if let u = URL(string: article.url) {
      web.load(URLRequest(url: u))
    }
  }

  // 페이지 로드 완료 → 저장된 하이라이트를 JS로 전달해 복원
  func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
    let saved = article.highlights // [SharedArticle.Highlight]
    if let data = try? JSONEncoder().encode(saved),
       let json = String(data: data, encoding: .utf8) {
      let inject = "window.__AS_LOAD_SAVED__(\(json));"
      webView.evaluateJavaScript(inject, completionHandler: nil)
    }
  }

  // 네비바 "저장" 눌렀을 때 → JS에게 현재 하이라이트 수집 요청
  @objc private func saveTapped() {
    // content.js에 수집 함수가 이미 있다면 그걸 호출
    let collectJS = """
    (function(){
      if (window.__AS_COLLECT__) {
        var payload = window.__AS_COLLECT__(); // { url, highlights:[{sentence,color,memo}] }
        window.__AS_EXPORT_TO_APP__(payload);
      } else if (window.shareHighlights) {
        // 기존 shareHighlights가 navigator.share로만 보내면 수집만 해서 넘겨주는 버전 하나 더 만들어두자
        var p = (window.__AS_COLLECT__ && window.__AS_COLLECT__()) || { url: location.href, highlights: [] };
        window.__AS_EXPORT_TO_APP__(p);
      } else {
        // 최소 fallback
        window.__AS_EXPORT_TO_APP__({ url: location.href, highlights: [] });
      }
    })();
    """
    web.evaluateJavaScript(collectJS, completionHandler: nil)
  }

  // JS → Native
  func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
    guard message.name == "native",
          let body = message.body as? [String: Any],
          let type = body["type"] as? String,
          type == "save",
          let data = body["data"] as? [String: Any],
          let url = data["url"] as? String,
          let arr = data["highlights"] as? [[String: Any]] else { return }

    let highlights: [SharedArticle.Highlight] = arr.compactMap { d in
      guard let sentence = d["sentence"] as? String else { return nil }
      return .init(sentence: sentence, color: d["color"] as? String, memo: d["memo"] as? String)
    }

    // App Group에 병합 저장 (중복 문장 제거/업데이트)
    let updated = mergeIntoAppGroup(url: url, incoming: highlights)
    print("✅ 편집 저장 완료: \(url) (\(updated.count) highlights)")
    navigationController?.popViewController(animated: true)
  }

  // 문장 기준 중복 제거 + 메모/색상 업데이트
  private func mergeIntoAppGroup(url: String, incoming: [SharedArticle.Highlight]) -> [SharedArticle.Highlight] {
    guard let defaults = UserDefaults(suiteName: SharedConstants.appGroupID) else { return incoming }
    var list = (try? JSONDecoder().decode([SharedArticle].self,
                 from: defaults.data(forKey: SharedConstants.storeKey) ?? Data())) ?? []

    // 같은 URL 기사 찾기 (없으면 새로 추가)
    if let idx = list.firstIndex(where: { $0.url == url }) {
      var base = list[idx]

      // 기존 + 신규 병합 (sentence를 키로)
      var map = Dictionary(uniqueKeysWithValues: base.highlights.map { ($0.sentence, $0) })
      for h in incoming {
        if var old = map[h.sentence] {
          // 업데이트 정책: memo가 비어있지 않으면 덮어쓰기, color 있으면 갱신
          if let m = h.memo { old = .init(sentence: old.sentence, color: h.color ?? old.color, memo: m) }
          else if let c = h.color { old = .init(sentence: old.sentence, color: c, memo: old.memo) }
          map[h.sentence] = old
        } else {
          map[h.sentence] = h
        }
      }
      base.highlights = Array(map.values)
      list[idx] = base
    } else {
      list.append(.init(url: url, highlights: incoming))
    }

    if let encoded = try? JSONEncoder().encode(list) {
      defaults.set(encoded, forKey: SharedConstants.storeKey)
    }
    return list.first(where: { $0.url == url })?.highlights ?? incoming
  }
>>>>>>> Stashed changes
}
