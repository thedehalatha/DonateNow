<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="true"%>
<%
  String ngoUser = (String) session.getAttribute("ngoUser");
  if (ngoUser == null) { response.sendRedirect("ngoLogin.jsp"); return; }
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>DonateNow — NGO Dashboard</title>
<link href="https://fonts.googleapis.com/css2?family=Syne:wght@700;800&family=DM+Sans:wght@300;400;500&display=swap" rel="stylesheet">
<style>
*,*::before,*::after{box-sizing:border-box;margin:0;padding:0}
:root{--bg:#0a0a0f;--surface:#13131a;--surface2:#1c1c26;--border:rgba(255,255,255,0.07);--accent:#f97316;--green:#22c55e;--red:#ef4444;--blue:#3b82f6;--text:#f1f0ee;--muted:#6b6a72}
body{background:var(--bg);color:var(--text);font-family:'DM Sans',sans-serif;min-height:100vh}
body::before{content:'';position:fixed;inset:0;background-image:linear-gradient(rgba(249,115,22,0.03) 1px,transparent 1px),linear-gradient(90deg,rgba(249,115,22,0.03) 1px,transparent 1px);background-size:40px 40px;pointer-events:none;z-index:0}
header{position:relative;z-index:2;background:var(--surface);border-bottom:1px solid var(--border);padding:0 32px;height:64px;display:flex;align-items:center;justify-content:space-between}
.logo{display:flex;align-items:center;gap:10px}
.logo-icon{width:36px;height:36px;background:var(--accent);border-radius:9px;display:flex;align-items:center;justify-content:center;font-size:18px}
.logo-text{font-family:'Syne',sans-serif;font-size:20px;font-weight:800}
.logo-text span{color:var(--accent)}
.header-right{display:flex;align-items:center;gap:14px}
.live-badge{display:flex;align-items:center;gap:7px;background:rgba(34,197,94,0.1);border:1px solid rgba(34,197,94,0.2);color:var(--green);font-size:12px;font-weight:500;padding:5px 12px;border-radius:100px}
.live-dot{width:6px;height:6px;background:var(--green);border-radius:50%;animation:pulse 2s infinite}
@keyframes pulse{0%,100%{opacity:1;transform:scale(1)}50%{opacity:0.4;transform:scale(0.8)}}
.user-name{font-size:13px;color:var(--muted)}
.logout{font-size:12px;color:var(--red);text-decoration:none;padding:5px 12px;border:1px solid rgba(239,68,68,0.25);border-radius:8px;transition:all 0.2s}
.logout:hover{background:rgba(239,68,68,0.1)}
.wrap{position:relative;z-index:1;max-width:1200px;margin:0 auto;padding:40px 24px 80px}
.top{display:flex;align-items:flex-end;justify-content:space-between;margin-bottom:32px;gap:20px;flex-wrap:wrap}
.hero h1{font-family:'Syne',sans-serif;font-size:clamp(24px,4vw,38px);font-weight:800;letter-spacing:-1.5px;margin-bottom:6px}
.hero h1 em{font-style:normal;color:var(--accent)}
.hero p{color:var(--muted);font-size:14px;font-weight:300}
.stats{display:grid;grid-template-columns:repeat(3,1fr);gap:14px;margin-bottom:32px}
.stat-card{background:var(--surface);border:1px solid var(--border);border-radius:14px;padding:18px 20px}
.stat-label{font-size:11px;font-weight:500;color:var(--muted);text-transform:uppercase;letter-spacing:1px;margin-bottom:6px}
.stat-value{font-family:'Syne',sans-serif;font-size:28px;font-weight:700}
.stat-value.green{color:var(--green)}
.stat-value.orange{color:var(--accent)}
.main-grid{display:grid;grid-template-columns:1fr 340px;gap:24px;align-items:start}
.section-title{font-family:'Syne',sans-serif;font-size:11px;font-weight:600;color:var(--muted);text-transform:uppercase;letter-spacing:2px;margin-bottom:16px;display:flex;align-items:center;gap:10px}
.section-title::after{content:'';flex:1;height:1px;background:var(--border)}
.filter-bar{display:flex;gap:8px;margin-bottom:20px;flex-wrap:wrap}
.filter-btn{font-family:'DM Sans',sans-serif;font-size:12px;font-weight:500;padding:6px 16px;border-radius:100px;border:1px solid var(--border);background:transparent;color:var(--muted);cursor:pointer;transition:all 0.2s}
.filter-btn:hover{border-color:rgba(249,115,22,0.4);color:var(--text)}
.filter-btn.active{background:rgba(249,115,22,0.12);border-color:rgba(249,115,22,0.4);color:var(--accent)}
#requests{display:flex;flex-direction:column;gap:12px}
.req-card{background:var(--surface);border:1px solid var(--border);border-radius:16px;padding:18px 22px;display:flex;align-items:center;justify-content:space-between;gap:16px;transition:all 0.3s;position:relative;overflow:hidden;animation:slideIn 0.3s ease forwards}
.req-card::before{content:'';position:absolute;left:0;top:0;bottom:0;width:3px;background:var(--accent)}
.req-card.accepted::before{background:var(--green)}
.req-card.rejected::before{background:var(--red)}
.req-card:hover{border-color:rgba(249,115,22,0.2);background:var(--surface2)}
@keyframes slideIn{from{opacity:0;transform:translateY(8px)}to{opacity:1;transform:translateY(0)}}
.req-left{display:flex;align-items:center;gap:12px;flex:1;min-width:0}
.req-emoji{width:40px;height:40px;background:var(--surface2);border-radius:10px;display:flex;align-items:center;justify-content:center;font-size:20px;flex-shrink:0}
.req-info h3{font-family:'Syne',sans-serif;font-size:14px;font-weight:700;margin-bottom:3px;white-space:nowrap;overflow:hidden;text-overflow:ellipsis}
.req-meta{display:flex;gap:10px;align-items:center}
.req-time{font-size:11px;color:var(--muted)}
.req-ago{font-size:11px;color:var(--accent);background:rgba(249,115,22,0.1);padding:2px 8px;border-radius:100px}
.req-right{display:flex;align-items:center;gap:8px;flex-shrink:0}
.status-pill{font-size:11px;font-weight:500;padding:4px 10px;border-radius:100px;text-transform:capitalize;white-space:nowrap}
.status-pill.pending{background:rgba(249,115,22,0.12);color:var(--accent);border:1px solid rgba(249,115,22,0.25)}
.status-pill.accepted{background:rgba(34,197,94,0.12);color:var(--green);border:1px solid rgba(34,197,94,0.25)}
.status-pill.rejected{background:rgba(239,68,68,0.12);color:var(--red);border:1px solid rgba(239,68,68,0.25)}
.btn{font-family:'DM Sans',sans-serif;font-size:11px;font-weight:500;padding:6px 14px;border-radius:8px;border:none;cursor:pointer;text-decoration:none;transition:all 0.2s;display:inline-flex;align-items:center;gap:4px;white-space:nowrap}
.btn-accept{background:rgba(34,197,94,0.15);color:var(--green);border:1px solid rgba(34,197,94,0.3)}
.btn-accept:hover{background:rgba(34,197,94,0.25)}
.btn-reject{background:rgba(239,68,68,0.1);color:var(--red);border:1px solid rgba(239,68,68,0.2)}
.btn-reject:hover{background:rgba(239,68,68,0.2)}
.empty{text-align:center;padding:50px 20px;color:var(--muted)}
.empty-icon{font-size:36px;margin-bottom:10px;opacity:0.4}
.empty h3{font-family:'Syne',sans-serif;font-size:16px;font-weight:700;color:var(--text);margin-bottom:5px;opacity:0.5}
.side-panel{display:flex;flex-direction:column;gap:20px}
.panel-card{background:var(--surface);border:1px solid var(--border);border-radius:16px;padding:20px}
.donor-entry{padding:12px 0;border-bottom:1px solid var(--border)}
.donor-entry:last-child{border-bottom:none;padding-bottom:0}
.donor-entry:first-child{padding-top:0}
.donor-name{font-family:'Syne',sans-serif;font-size:13px;font-weight:700;margin-bottom:4px}
.donor-detail{font-size:11px;color:var(--muted);margin-bottom:3px}
.donor-types{display:flex;gap:4px;flex-wrap:wrap;margin-top:6px}
.type-tag{font-size:10px;padding:2px 8px;border-radius:100px;background:rgba(34,197,94,0.1);color:var(--green);border:1px solid rgba(34,197,94,0.2)}
.no-donors{text-align:center;padding:20px;color:var(--muted);font-size:13px}
footer{margin-top:60px;padding-top:20px;border-top:1px solid var(--border);text-align:center;color:var(--muted);font-size:12px}
@media(max-width:900px){.main-grid{grid-template-columns:1fr}.stats{grid-template-columns:1fr 1fr}}
@media(max-width:500px){.stats{grid-template-columns:1fr}.req-card{flex-direction:column;align-items:flex-start}.req-right{width:100%}}
</style>
</head>
<body>
<header>
  <div class="logo">
    <div class="logo-icon">&#x1F91D;</div>
    <div class="logo-text">Donate<span>Now</span></div>
  </div>
  <div class="header-right">
    <div class="live-badge"><div class="live-dot"></div>Live</div>
    <span class="user-name">NGO: <%= ngoUser %></span>
    <a href="ngoLogout" class="logout">Logout</a>
  </div>
</header>
<div class="wrap">
  <div class="top">
    <div class="hero">
      <h1>Live Help <em>Requests</em></h1>
      <p>Voice requests from people in need — accept or reject in real time.</p>
    </div>
  </div>
  <div class="stats">
    <div class="stat-card"><div class="stat-label">Total Requests</div><div class="stat-value orange" id="stat-total">0</div></div>
    <div class="stat-card"><div class="stat-label">Accepted</div><div class="stat-value green" id="stat-accepted">0</div></div>
    <div class="stat-card"><div class="stat-label">Pending</div><div class="stat-value" id="stat-pending">0</div></div>
  </div>
  <div class="main-grid">
    <div>
      <div class="section-title">Incoming Requests</div>
      <div class="filter-bar">
        <button class="filter-btn active" onclick="setFilter('all',this)">All</button>
        <button class="filter-btn" onclick="setFilter('food',this)">&#x1F35B; Food</button>
        <button class="filter-btn" onclick="setFilter('clothes',this)">&#x1F455; Clothes</button>
        <button class="filter-btn" onclick="setFilter('other',this)">&#x2795; Other</button>
      </div>
      <div id="requests">
        <div class="empty"><div class="empty-icon">&#x1F4E1;</div><h3>Waiting for requests</h3><p>Voice requests appear here instantly</p></div>
      </div>
    </div>
    <div class="side-panel">
      <div class="panel-card">
        <div class="section-title">Registered Donors</div>
        <div id="donor-list"><div class="no-donors">&#x1F91D; No donors registered yet</div></div>
      </div>
    </div>
  </div>
  <footer>DonateNow &mdash; Voice AI Donation System &copy; 2025</footer>
</div>
<script>
var currentFilter = 'all';
var requestTimestamps = {};

function setFilter(type, btn) {
  currentFilter = type;
  document.querySelectorAll('.filter-btn').forEach(function(b){ b.classList.remove('active'); });
  btn.classList.add('active');
  renderRequests();
}

function timeAgo(timeStr) {
  if (!timeStr) return '';
  var now = new Date();
  var parts = timeStr.match(/(\d{2}):(\d{2}):(\d{2})/);
  if (!parts) return '';
  var then = new Date();
  then.setHours(parseInt(parts[1]), parseInt(parts[2]), parseInt(parts[3]), 0);
  var diff = Math.floor((now - then) / 1000);
  if (diff < 60) return 'just now';
  if (diff < 3600) return Math.floor(diff/60) + ' min ago';
  return Math.floor(diff/3600) + ' hr ago';
}

var allCards = [];

function renderRequests() {
  var filtered = allCards.filter(function(c) {
    if (currentFilter === 'all') return true;
    if (currentFilter === 'food') return c.type === 'food';
    if (currentFilter === 'clothes') return c.type === 'clothes';
    if (currentFilter === 'other') return c.type !== 'food' && c.type !== 'clothes';
    return true;
  });
  if (!filtered.length) {
    document.getElementById('requests').innerHTML = '<div class="empty"><div class="empty-icon">&#x1F4E1;</div><h3>No requests</h3><p>No ' + currentFilter + ' requests yet</p></div>';
    return;
  }
  var out = '';
  for (var i = 0; i < filtered.length; i++) {
    var c = filtered[i];
    var btns = c.status === 'pending' ? '<a href="' + c.ah + '" class="btn btn-accept">&#10003; Accept</a><a href="' + c.rh + '" class="btn btn-reject">&#10005;</a>' : '';
    out += '<div class="req-card ' + c.status + '">'
        + '<div class="req-left"><div class="req-emoji">' + c.emoji + '</div>'
        + '<div class="req-info"><h3>' + c.type_label + '</h3>'
        + '<div class="req-meta"><span class="req-time">' + c.time + '</span><span class="req-ago">' + timeAgo(c.time) + '</span></div></div></div>'
        + '<div class="req-right"><span class="status-pill ' + c.status + '">' + c.status_label + '</span>' + btns + '</div></div>';
  }
  document.getElementById('requests').innerHTML = out;
}

function loadRequests() {
  fetch("requests")
  .then(function(r){ return r.text(); })
  .then(function(html) {
    var doc = new DOMParser().parseFromString(html, 'text/html');
    var cards = doc.querySelectorAll('.card');
    if (!cards.length) return;
    var total = cards.length, accepted = 0, pending = 0;
    allCards = [];
    for (var i = 0; i < cards.length; i++) {
      var card = cards[i];
      var raw = card.innerText || card.textContent;
      var isFood = raw.indexOf('Food') >= 0 || raw.indexOf('food') >= 0;
      var isClothes = raw.indexOf('Clothes') >= 0 || raw.indexOf('clothes') >= 0;
      var type = isFood ? 'food' : (isClothes ? 'clothes' : 'other');
      var emoji = isFood ? '\u{1F35B}' : (isClothes ? '\u{1F455}' : '\u{1F91D}');
      var type_label = isFood ? 'Food Request' : (isClothes ? 'Clothes Request' : 'Help Request');
      var tm = raw.match(/\d{2}:\d{2}:\d{2}/);
      var time = tm ? tm[0] : '';
      var status = 'pending', status_label = 'Pending';
      if (raw.indexOf('accepted') >= 0) { status='accepted'; status_label='Accepted'; accepted++; }
      else if (raw.indexOf('rejected') >= 0) { status='rejected'; status_label='Rejected'; }
      else { pending++; }
      var al = card.querySelector('a[href*="accept"]');
      var rl = card.querySelector('a[href*="reject"]');
      allCards.push({ type:type, emoji:emoji, type_label:type_label, time:time, status:status, status_label:status_label, ah: al?al.href:'#', rh: rl?rl.href:'#' });
    }
    document.getElementById('stat-total').textContent = total;
    document.getElementById('stat-accepted').textContent = accepted;
    document.getElementById('stat-pending').textContent = pending;
    renderRequests();
  }).catch(function(e){ console.error(e); });
}

function loadDonors() {
  fetch("donorList")
  .then(function(r){ return r.text(); })
  .then(function(data) {
    data = data.trim();
    if (!data || data === 'none') {
      document.getElementById('donor-list').innerHTML = '<div class="no-donors">&#x1F91D; No donors registered yet</div>';
      return;
    }
    var entries = data.split('||');
    var out = '';
    for (var i = 0; i < entries.length; i++) {
      var e = entries[i].trim();
      if (!e) continue;
      var parts = e.split('|');
      var name = parts[0] ? parts[0].trim() : '?';
      var phone = parts[1] ? parts[1].trim() : '';
      var addr = parts[2] ? parts[2].trim() : '';
      var donating = '';
      for (var j = 3; j < parts.length; j++) {
        var p = parts[j].trim();
        if (p.indexOf('Donating:') >= 0) { donating = p.replace('Donating:', '').trim(); break; }
      }
      var tags = donating ? donating.split(',') : [];
      var tagHtml = '';
      for (var k = 0; k < tags.length; k++) {
        tagHtml += '<span class="type-tag">' + tags[k].trim() + '</span>';
      }
      out += '<div class="donor-entry">'
           + '<div class="donor-name">&#x1F91C; ' + name + '</div>'
           + '<div class="donor-detail">&#x1F4DE; ' + phone + '</div>'
           + '<div class="donor-detail">&#x1F4CD; ' + addr + '</div>'
           + (tagHtml ? '<div class="donor-types">' + tagHtml + '</div>' : '')
           + '</div>';
    }
    document.getElementById('donor-list').innerHTML = out || '<div class="no-donors">No donors yet</div>';
  }).catch(function(e){ console.error(e); });
}

setInterval(loadRequests, 2000);
setInterval(loadDonors, 5000);
setInterval(renderRequests, 30000);
loadRequests();
loadDonors();
</script>
</body>
</html>
