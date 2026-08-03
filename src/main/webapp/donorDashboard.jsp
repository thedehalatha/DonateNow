<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="true"%>
<%
  String donorUser = (String) session.getAttribute("donorUser");
  if (donorUser == null) { response.sendRedirect("donorLogin.jsp"); return; }
  String success = (String) session.getAttribute("donorSuccess");
  if (success != null) session.removeAttribute("donorSuccess");
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>DonateNow — Donor Dashboard</title>
<link href="https://fonts.googleapis.com/css2?family=Syne:wght@700;800&family=DM+Sans:wght@300;400;500&display=swap" rel="stylesheet">
<style>
*,*::before,*::after{box-sizing:border-box;margin:0;padding:0}
:root{--bg:#0a0a0f;--surface:#13131a;--surface2:#1c1c26;--border:rgba(255,255,255,0.07);--green:#22c55e;--accent:#f97316;--blue:#3b82f6;--text:#f1f0ee;--muted:#6b6a72;--red:#ef4444}
body{background:var(--bg);color:var(--text);font-family:'DM Sans',sans-serif;min-height:100vh}
body::before{content:'';position:fixed;inset:0;background-image:linear-gradient(rgba(34,197,94,0.03) 1px,transparent 1px),linear-gradient(90deg,rgba(34,197,94,0.03) 1px,transparent 1px);background-size:40px 40px;pointer-events:none;z-index:0}
header{position:relative;z-index:2;background:var(--surface);border-bottom:1px solid var(--border);padding:0 32px;height:64px;display:flex;align-items:center;justify-content:space-between}
.logo{display:flex;align-items:center;gap:10px}
.logo-icon{width:36px;height:36px;background:var(--green);border-radius:9px;display:flex;align-items:center;justify-content:center;font-size:18px}
.logo-text{font-family:'Syne',sans-serif;font-size:20px;font-weight:800}
.logo-text span{color:var(--accent)}
.header-right{display:flex;align-items:center;gap:14px}
.user-name{font-size:13px;color:var(--muted)}
.logout{font-size:12px;color:var(--red);text-decoration:none;padding:5px 12px;border:1px solid rgba(239,68,68,0.25);border-radius:8px;transition:all 0.2s}
.logout:hover{background:rgba(239,68,68,0.1)}
.wrap{position:relative;z-index:1;max-width:900px;margin:0 auto;padding:40px 24px 80px}
.hero{margin-bottom:36px}
.hero h1{font-family:'Syne',sans-serif;font-size:clamp(26px,5vw,40px);font-weight:800;letter-spacing:-1.5px;margin-bottom:8px}
.hero h1 em{font-style:normal;color:var(--green)}
.hero p{color:var(--muted);font-size:14px;font-weight:300}
.success-banner{background:rgba(34,197,94,0.1);border:1px solid rgba(34,197,94,0.25);color:var(--green);padding:12px 16px;border-radius:12px;margin-bottom:24px;font-size:13px;display:flex;align-items:center;gap:8px}
.section-title{font-family:'Syne',sans-serif;font-size:11px;font-weight:600;color:var(--muted);text-transform:uppercase;letter-spacing:2px;margin-bottom:16px;display:flex;align-items:center;gap:10px}
.section-title::after{content:'';flex:1;height:1px;background:var(--border)}
.form-card{background:var(--surface);border:1px solid var(--border);border-radius:20px;padding:32px;margin-bottom:32px}
.row{display:grid;grid-template-columns:1fr 1fr;gap:18px;margin-bottom:18px}
.field{display:flex;flex-direction:column;gap:7px;margin-bottom:18px}
.field label{font-size:11px;font-weight:500;color:var(--muted);text-transform:uppercase;letter-spacing:1px}
.field input,.field textarea,.field select{background:var(--surface2);border:1px solid var(--border);border-radius:10px;padding:11px 14px;color:var(--text);font-family:'DM Sans',sans-serif;font-size:13px;outline:none;transition:border-color 0.2s;width:100%}
.field input:focus,.field textarea:focus{border-color:rgba(34,197,94,0.5)}
.field textarea{resize:vertical;min-height:72px}
.donate-grid{display:grid;grid-template-columns:repeat(3,1fr);gap:10px;margin-bottom:18px}
.donate-opt{position:relative}
.donate-opt input[type=checkbox]{position:absolute;opacity:0;width:0;height:0}
.donate-opt label{display:flex;flex-direction:column;align-items:center;gap:6px;padding:14px 10px;background:var(--surface2);border:1px solid var(--border);border-radius:12px;cursor:pointer;transition:all 0.2s;font-size:12px;color:var(--muted)}
.donate-opt label .emoji{font-size:22px}
.donate-opt input:checked + label{border-color:rgba(34,197,94,0.5);background:rgba(34,197,94,0.08);color:var(--green)}
.donate-opt label:hover{border-color:rgba(34,197,94,0.3)}
.divider{height:1px;background:var(--border);margin:24px 0}
.btn-row{display:flex;gap:10px;margin-top:6px}
.btn-submit{flex:1;padding:12px;background:var(--green);color:#000;border:none;border-radius:10px;font-family:'DM Sans',sans-serif;font-size:14px;font-weight:500;cursor:pointer;transition:all 0.2s}
.btn-submit:hover{filter:brightness(1.1);transform:translateY(-1px)}
.btn-clear{padding:12px 18px;background:transparent;color:var(--muted);border:1px solid var(--border);border-radius:10px;font-family:'DM Sans',sans-serif;font-size:13px;cursor:pointer;transition:all 0.2s}
.btn-clear:hover{border-color:rgba(255,255,255,0.2);color:var(--text)}
.pending-card{background:var(--surface);border:1px solid var(--border);border-radius:16px;padding:18px 22px;display:flex;align-items:center;justify-content:space-between;gap:16px;margin-bottom:12px;transition:all 0.2s;animation:slideIn 0.3s ease forwards}
.pending-card:hover{border-color:rgba(249,115,22,0.25);background:var(--surface2)}
@keyframes slideIn{from{opacity:0;transform:translateY(8px)}to{opacity:1;transform:translateY(0)}}
.pending-left{display:flex;align-items:center;gap:12px;flex:1}
.p-emoji{width:40px;height:40px;background:var(--surface2);border-radius:10px;display:flex;align-items:center;justify-content:center;font-size:20px;flex-shrink:0}
.p-info h3{font-family:'Syne',sans-serif;font-size:14px;font-weight:700;margin-bottom:3px}
.p-time{font-size:11px;color:var(--muted)}
.btn-take{font-family:'DM Sans',sans-serif;font-size:12px;font-weight:500;padding:8px 18px;border-radius:8px;background:rgba(34,197,94,0.15);color:var(--green);border:1px solid rgba(34,197,94,0.3);cursor:pointer;text-decoration:none;transition:all 0.2s;white-space:nowrap}
.btn-take:hover{background:rgba(34,197,94,0.25);transform:scale(1.03)}
.my-donation{padding:12px 0;border-bottom:1px solid var(--border)}
.my-donation:last-child{border-bottom:none;padding-bottom:0}
.my-donation:first-child{padding-top:0}
.my-don-title{font-family:'Syne',sans-serif;font-size:13px;font-weight:700;margin-bottom:4px}
.my-don-detail{font-size:11px;color:var(--muted)}
.my-don-tags{display:flex;gap:4px;flex-wrap:wrap;margin-top:5px}
.don-tag{font-size:10px;padding:2px 8px;border-radius:100px;background:rgba(34,197,94,0.1);color:var(--green);border:1px solid rgba(34,197,94,0.2)}
.empty-sm{text-align:center;padding:24px;color:var(--muted);font-size:13px}
footer{margin-top:60px;padding-top:20px;border-top:1px solid var(--border);text-align:center;color:var(--muted);font-size:12px}
@media(max-width:500px){.row{grid-template-columns:1fr}.donate-grid{grid-template-columns:1fr 1fr}.pending-card{flex-direction:column;align-items:flex-start}}
</style>
</head>
<body>
<header>
  <div class="logo">
    <div class="logo-icon">&#x1F91D;</div>
    <div class="logo-text">Donate<span>Now</span></div>
  </div>
  <div class="header-right">
    <span class="user-name">Welcome, <%= donorUser %></span>
    <a href="donorLogout" class="logout">Logout</a>
  </div>
</header>
<div class="wrap">
  <div class="hero">
    <h1>Make a <em>difference</em> today.</h1>
    <p>Register your offer or directly accept a pending request below.</p>
  </div>
  <% if (success != null) { %>
  <div class="success-banner">&#10003; Donation offer submitted! We will match you with someone in need shortly.</div>
  <% } %>

  <div class="section-title">Register Donation Offer</div>
  <div class="form-card">
    <form method="post" action="donorSubmit">
      <div class="row">
        <div class="field"><label>Full Name</label><input type="text" name="donorName" placeholder="e.g. Ravi Kumar" required/></div>
        <div class="field"><label>Phone Number</label><input type="text" name="donorPhone" placeholder="e.g. 9876543210" required/></div>
      </div>
      <div class="field"><label>Address</label><textarea name="donorAddress" placeholder="Enter your full address..." required></textarea></div>
      <div class="divider"></div>
      <div class="section-title" style="margin-bottom:12px">What would you like to donate?</div>
      <div class="donate-grid">
        <div class="donate-opt"><input type="checkbox" name="donateType" value="food" id="d-food"/><label for="d-food"><span class="emoji">&#x1F35B;</span>Food</label></div>
        <div class="donate-opt"><input type="checkbox" name="donateType" value="clothes" id="d-clothes"/><label for="d-clothes"><span class="emoji">&#x1F455;</span>Clothes</label></div>
        <div class="donate-opt"><input type="checkbox" name="donateType" value="medicines" id="d-medicine"/><label for="d-medicine"><span class="emoji">&#x1F48A;</span>Medicines</label></div>
        <div class="donate-opt"><input type="checkbox" name="donateType" value="books" id="d-books"/><label for="d-books"><span class="emoji">&#x1F4DA;</span>Books</label></div>
        <div class="donate-opt"><input type="checkbox" name="donateType" value="money" id="d-money"/><label for="d-money"><span class="emoji">&#x1F4B0;</span>Money</label></div>
        <div class="donate-opt"><input type="checkbox" name="donateType" value="other" id="d-other"/><label for="d-other"><span class="emoji">&#x2795;</span>Other</label></div>
      </div>
      <div class="field"><label>Additional Notes (optional)</label><textarea name="donorNotes" placeholder="Any extra details..."></textarea></div>
      <div class="btn-row">
        <button type="reset" class="btn-clear">Clear</button>
        <button type="submit" class="btn-submit">&#10003; Submit Donation Offer</button>
      </div>
    </form>
  </div>

  <div class="section-title">Pending Requests — Pick One to Help</div>
  <div id="pending-requests"><div class="empty-sm">&#x1F4E1; Loading pending requests...</div></div>

  <br/>
  <div class="section-title">My Past Donations</div>
  <div id="my-donations" style="background:var(--surface);border:1px solid var(--border);border-radius:16px;padding:20px">
    <div class="empty-sm">Loading...</div>
  </div>

  <footer>DonateNow &mdash; Voice AI Donation System &copy; 2025</footer>
</div>
<script>
function loadPending() {
  fetch("requests")
  .then(function(r){ return r.text(); })
  .then(function(html) {
    var doc = new DOMParser().parseFromString(html, 'text/html');
    var cards = doc.querySelectorAll('.card');
    var out = '';
    var count = 0;
    for (var i = 0; i < cards.length; i++) {
      var card = cards[i];
      var raw = card.innerText || card.textContent;
      if (raw.indexOf('accepted') >= 0 || raw.indexOf('rejected') >= 0) continue;
      var isFood = raw.indexOf('Food') >= 0 || raw.indexOf('food') >= 0;
      var isClothes = raw.indexOf('Clothes') >= 0 || raw.indexOf('clothes') >= 0;
      var emoji = isFood ? '\u{1F35B}' : (isClothes ? '\u{1F455}' : '\u{1F91D}');
      var label = isFood ? 'Food Request' : (isClothes ? 'Clothes Request' : 'Help Request');
      var tm = raw.match(/\d{2}:\d{2}:\d{2}/);
      var time = tm ? 'Requested at ' + tm[0] : '';
      var al = card.querySelector('a[href*="accept"]');
      var ah = al ? al.href : '#';
      out += '<div class="pending-card">'
           + '<div class="pending-left"><div class="p-emoji">' + emoji + '</div>'
           + '<div class="p-info"><h3>' + label + '</h3><div class="p-time">' + time + '</div></div></div>'
           + '<a href="' + ah + '" class="btn-take">&#x1F91D; I will help</a></div>';
      count++;
    }
    if (!count) out = '<div class="empty-sm">&#x2705; No pending requests right now!</div>';
    document.getElementById('pending-requests').innerHTML = out;
  }).catch(function(e){ console.error(e); });
}

function loadMyDonations() {
  fetch("myDonations")
  .then(function(r){ return r.text(); })
  .then(function(data) {
    data = data.trim();
    if (!data || data === 'none') {
      document.getElementById('my-donations').innerHTML = '<div class="empty-sm">&#x1F4CB; No donations submitted yet</div>';
      return;
    }
    var entries = data.split('||');
    var out = '';
    for (var i = 0; i < entries.length; i++) {
      var e = entries[i].trim();
      if (!e) continue;
      var parts = e.split('|');
      var name = parts[0] ? parts[0].trim() : '';
      var phone = parts[1] ? parts[1].trim() : '';
      var addr = parts[2] ? parts[2].trim() : '';
      var donating = '';
      for (var j = 3; j < parts.length; j++) {
        var p = parts[j].trim();
        if (p.indexOf('Donating:') >= 0) { donating = p.replace('Donating:','').trim(); break; }
      }
      var tm = e.match(/at (\d{2}:\d{2}:\d{2})/);
      var time = tm ? tm[1] : '';
      var tags = donating ? donating.split(',') : [];
      var tagHtml = '';
      for (var k = 0; k < tags.length; k++) tagHtml += '<span class="don-tag">' + tags[k].trim() + '</span>';
      out += '<div class="my-donation">'
           + '<div class="my-don-title">&#x1F91C; ' + name + ' &nbsp;<span style="font-weight:400;color:var(--muted);font-size:11px">' + time + '</span></div>'
           + '<div class="my-don-detail">&#x1F4DE; ' + phone + ' &nbsp;|&nbsp; &#x1F4CD; ' + addr + '</div>'
           + (tagHtml ? '<div class="my-don-tags">' + tagHtml + '</div>' : '')
           + '</div>';
    }
    document.getElementById('my-donations').innerHTML = out || '<div class="empty-sm">No donations yet</div>';
  }).catch(function(e){ console.error(e); });
}

setInterval(loadPending, 3000);
setInterval(loadMyDonations, 5000);
loadPending();
loadMyDonations();
</script>
</body>
</html>
