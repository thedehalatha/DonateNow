<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="true"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>DonateNow — Welcome</title>
<link href="https://fonts.googleapis.com/css2?family=Syne:wght@700;800&family=DM+Sans:wght@300;400;500&display=swap" rel="stylesheet">
<style>
*,*::before,*::after{box-sizing:border-box;margin:0;padding:0}
:root{
  --bg:#0a0a0f;--surface:#13131a;--surface2:#1c1c26;
  --border:rgba(255,255,255,0.07);
  --accent:#f97316;--green:#22c55e;
  --text:#f1f0ee;--muted:#6b6a72;
}
body{background:var(--bg);color:var(--text);font-family:'DM Sans',sans-serif;min-height:100vh;display:flex;flex-direction:column;align-items:center;justify-content:center;overflow:hidden}
body::before{content:'';position:fixed;inset:0;background-image:linear-gradient(rgba(249,115,22,0.03) 1px,transparent 1px),linear-gradient(90deg,rgba(249,115,22,0.03) 1px,transparent 1px);background-size:40px 40px;pointer-events:none}
body::after{content:'';position:fixed;top:-200px;left:50%;transform:translateX(-50%);width:600px;height:600px;background:radial-gradient(circle,rgba(249,115,22,0.10) 0%,transparent 70%);pointer-events:none}
.wrap{position:relative;z-index:1;text-align:center;padding:40px 24px;max-width:600px;width:100%}
.logo{display:inline-flex;align-items:center;gap:10px;margin-bottom:48px}
.logo-icon{width:44px;height:44px;background:var(--accent);border-radius:12px;display:flex;align-items:center;justify-content:center;font-size:22px}
.logo-text{font-family:'Syne',sans-serif;font-size:24px;font-weight:800}
.logo-text span{color:var(--accent)}
h1{font-family:'Syne',sans-serif;font-size:clamp(32px,6vw,52px);font-weight:800;letter-spacing:-2px;line-height:1.05;margin-bottom:14px}
h1 em{font-style:normal;color:var(--accent)}
p{color:var(--muted);font-size:16px;font-weight:300;margin-bottom:52px;line-height:1.6}
.cards{display:grid;grid-template-columns:1fr 1fr;gap:20px}
.card{background:var(--surface);border:1px solid var(--border);border-radius:20px;padding:36px 28px;text-decoration:none;color:var(--text);transition:all 0.25s;display:flex;flex-direction:column;align-items:center;gap:16px}
.card:hover{transform:translateY(-4px);border-color:rgba(249,115,22,0.35);background:var(--surface2)}
.card-icon{width:64px;height:64px;border-radius:16px;display:flex;align-items:center;justify-content:center;font-size:30px}
.card.ngo .card-icon{background:rgba(249,115,22,0.12);border:1px solid rgba(249,115,22,0.2)}
.card.donor .card-icon{background:rgba(34,197,94,0.12);border:1px solid rgba(34,197,94,0.2)}
.card h2{font-family:'Syne',sans-serif;font-size:20px;font-weight:700}
.card.ngo h2{color:var(--accent)}
.card.donor h2{color:var(--green)}
.card p{color:var(--muted);font-size:13px;margin:0;text-align:center;line-height:1.5}
.card .btn{margin-top:8px;padding:10px 28px;border-radius:10px;font-size:13px;font-weight:500;font-family:'DM Sans',sans-serif;border:none;cursor:pointer;transition:all 0.2s}
.card.ngo .btn{background:rgba(249,115,22,0.15);color:var(--accent);border:1px solid rgba(249,115,22,0.3)}
.card.donor .btn{background:rgba(34,197,94,0.15);color:var(--green);border:1px solid rgba(34,197,94,0.3)}
.card:hover .btn{filter:brightness(1.2)}
@media(max-width:500px){.cards{grid-template-columns:1fr}}
</style>
</head>
<body>
<div class="wrap">
  <div class="logo">
    <div class="logo-icon">&#x1F91D;</div>
    <div class="logo-text">Donate<span>Now</span></div>
  </div>
  <h1>Give help.<br><em>Get help.</em></h1>
  <p>A voice-powered platform connecting people in need with generous donors in real time.</p>
  <div class="cards">
    <a href="ngoLogin.jsp" class="card ngo">
      <div class="card-icon">&#x1F3E2;</div>
      <h2>NGO Login</h2>
      <p>Manage live help requests and connect needy people with donors</p>
      <div class="btn">Login as NGO &rarr;</div>
    </a>
    <a href="donorLogin.jsp" class="card donor">
      <div class="card-icon">&#x1F91C;</div>
      <h2>Donor Login</h2>
      <p>Register your details and offer food, clothes or other help</p>
      <div class="btn">Login as Donor &rarr;</div>
    </a>
  </div>
</div>
</body>
</html>
