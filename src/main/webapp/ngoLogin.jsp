<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="true"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>DonateNow — NGO Login</title>
<link href="https://fonts.googleapis.com/css2?family=Syne:wght@700;800&family=DM+Sans:wght@300;400;500&display=swap" rel="stylesheet">
<style>
*,*::before,*::after{box-sizing:border-box;margin:0;padding:0}
:root{--bg:#0a0a0f;--surface:#13131a;--surface2:#1c1c26;--border:rgba(255,255,255,0.07);--accent:#f97316;--text:#f1f0ee;--muted:#6b6a72;--red:#ef4444}
body{background:var(--bg);color:var(--text);font-family:'DM Sans',sans-serif;min-height:100vh;display:flex;align-items:center;justify-content:center}
body::before{content:'';position:fixed;inset:0;background-image:linear-gradient(rgba(249,115,22,0.03) 1px,transparent 1px),linear-gradient(90deg,rgba(249,115,22,0.03) 1px,transparent 1px);background-size:40px 40px;pointer-events:none}
body::after{content:'';position:fixed;top:-200px;right:-200px;width:500px;height:500px;background:radial-gradient(circle,rgba(249,115,22,0.10) 0%,transparent 70%);pointer-events:none}
.wrap{position:relative;z-index:1;width:100%;max-width:420px;padding:24px}
.back{display:inline-flex;align-items:center;gap:6px;color:var(--muted);font-size:13px;text-decoration:none;margin-bottom:32px;transition:color 0.2s}
.back:hover{color:var(--text)}
.card{background:var(--surface);border:1px solid var(--border);border-radius:20px;padding:40px 36px}
.icon{width:56px;height:56px;background:rgba(249,115,22,0.12);border:1px solid rgba(249,115,22,0.2);border-radius:14px;display:flex;align-items:center;justify-content:center;font-size:26px;margin-bottom:24px}
h1{font-family:'Syne',sans-serif;font-size:26px;font-weight:800;letter-spacing:-1px;margin-bottom:6px}
.sub{color:var(--muted);font-size:14px;font-weight:300;margin-bottom:32px}
label{display:block;font-size:12px;font-weight:500;color:var(--muted);text-transform:uppercase;letter-spacing:1px;margin-bottom:8px}
input[type=text],input[type=password]{width:100%;background:var(--surface2);border:1px solid var(--border);border-radius:10px;padding:12px 16px;color:var(--text);font-family:'DM Sans',sans-serif;font-size:14px;outline:none;transition:border-color 0.2s;margin-bottom:20px}
input:focus{border-color:rgba(249,115,22,0.5)}
.btn{width:100%;padding:13px;background:var(--accent);color:#fff;border:none;border-radius:10px;font-family:'DM Sans',sans-serif;font-size:15px;font-weight:500;cursor:pointer;transition:all 0.2s;margin-top:4px}
.btn:hover{filter:brightness(1.1);transform:translateY(-1px)}
.error{background:rgba(239,68,68,0.1);border:1px solid rgba(239,68,68,0.25);color:var(--red);font-size:13px;padding:10px 14px;border-radius:8px;margin-bottom:16px}
.hint{color:var(--muted);font-size:12px;text-align:center;margin-top:16px}
.hint span{color:var(--accent)}
</style>
</head>
<body>
<div class="wrap">
  <a href="index.jsp" class="back">&#8592; Back to home</a>
  <div class="card">
    <div class="icon">&#x1F3E2;</div>
    <h1>NGO Login</h1>
    <p class="sub">Access the live donation dashboard</p>

    <%
      String error = (String) request.getAttribute("error");
      if (error != null) {
    %>
    <div class="error">&#9888; <%= error %></div>
    <% } %>

    <form method="post" action="ngoLoginAction">
      <label>Username</label>
      <input type="text" name="username" placeholder="Enter NGO username" required/>
      <label>Password</label>
      <input type="password" name="password" placeholder="Enter password" required/>
      <button type="submit" class="btn">Login to Dashboard &rarr;</button>
    </form>
    <p class="hint">Default: username <span>ngo</span> &nbsp;/&nbsp; password <span>ngo123</span></p>
  </div>
</div>
</body>
</html>
