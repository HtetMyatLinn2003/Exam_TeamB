<%-- 共通テンプレート --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html lang="ja">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- Bootstrap CSS -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65"
	crossorigin="anonymous">
<style>
:root {
    --cream:         #FBF6EE;
    --surface:       #F5ECD9;
    --taupe:         #D4B896;
    --camel:         #C49A6C;
    --earth:         #8B5E3C;
    --sage:          #8B957A;
    --brown:         #6B574A;
    --dark:          #2C1A0E;
    --primary:       #6B1E38;
    --primary-dark:  #4A1530;
    --primary-light: #8A3355;
    --secondary:     #286048;
    --secondary-dark:#1A6678;
    --accent:        #E84038;
    --accent-warm:   #CC6618;
    --accent-coral:  #E86850;
    --bs-body-bg:          #FBF6EE;
    --bs-body-color:       #2C1A0E;
    --bs-link-color:       #6B1E38;
    --bs-link-hover-color: #4A1530;
    --bs-border-color:     #C49A6C;
}
body { background-color: var(--cream); color: var(--dark); }
#wrapper { background-color: var(--cream); }

/* Header */
.site-header {
    background: linear-gradient(135deg, var(--dark) 0%, var(--primary) 100%) !important;
    border-bottom-color: var(--accent-warm) !important;
}
.site-header h1 { color: #fff; }
.site-header a { color: var(--camel); text-decoration: none; transition: color .2s; }
.site-header a:hover { color: #fff; }
.site-header span { color: rgba(255,255,255,.75); }

/* Footer */
.site-footer { background-color: var(--dark) !important; border-top-color: var(--earth) !important; }
.site-footer p, .site-footer .text-muted { color: rgba(255,255,255,.60) !important; }
.site-footer-text { color: rgba(255,255,255,.60); }

/* Sidebar */
.sidebar { padding: 1.25rem 0.5rem 0; background-color: var(--surface); height: 100%; }
.sidebar-nav { list-style: none; padding: 0; margin: 0; display: flex; flex-direction: column; gap: 2px; }
.sidebar-link {
    display: block; padding: .6rem 1rem; color: var(--primary);
    font-weight: 500; font-size: .9rem; border-radius: 8px;
    border-left: 3px solid transparent; text-decoration: none;
    transition: background-color .15s, color .15s, border-color .15s, transform .15s;
}
.sidebar-link:hover, .sidebar-link:focus {
    background-color: var(--primary); color: #fff;
    border-left-color: var(--accent-warm); transform: translateX(3px); text-decoration: none;
}
.sidebar-link--home {
    background: linear-gradient(135deg, #9B4000 0%, var(--accent-warm) 100%);
    color: #fff; border-left-color: rgba(255,255,255,.6);
    font-weight: 700; letter-spacing: .04em;
    box-shadow: 0 3px 10px rgba(204,102,24,.45);
    text-align: center;
}
.sidebar-link--home:hover {
    background: linear-gradient(135deg, var(--accent-warm) 0%, var(--accent-coral) 100%);
    color: #fff; border-left-color: #fff;
    transform: translateX(3px);
    box-shadow: 0 4px 14px rgba(204,102,24,.55);
}
.sidebar-link--sub { padding-left: 1.75rem; font-size: .855rem; font-weight: 400; color: var(--brown); }
.sidebar-link--sub::before { content: '›'; margin-right: .4rem; color: var(--camel); font-weight: 700; }
.sidebar-link--sub:hover { background-color: var(--primary-light); color: #fff; border-left-color: var(--accent-coral); }
.sidebar-group-label {
    list-style: none; padding: .6rem .5rem .2rem;
    display: flex; align-items: center; gap: .5rem;
}
.sidebar-group-label::before, .sidebar-group-label::after {
    content: ''; flex: 1; height: 1px;
}
.sidebar-group-label::before { background: linear-gradient(90deg, var(--taupe), transparent); }
.sidebar-group-label::after  { background: linear-gradient(270deg, var(--taupe), transparent); }
.sidebar-group-label span {
    font-size: .68rem; font-weight: 700; letter-spacing: .10em;
    text-transform: uppercase; color: var(--earth);
    background-color: var(--taupe); padding: .18rem .65rem;
    border-radius: 20px; white-space: nowrap; border: 1px solid var(--camel);
}
.sidebar-sep {
    list-style: none; height: 1px;
    background: linear-gradient(90deg, transparent, var(--taupe) 40%, transparent);
    margin: .35rem .75rem;
}
.border-start { border-color: var(--camel) !important; }
main { background-color: #fff; }

/* Logout button */
.logout-btn {
    display: inline-block;
    background-color: var(--accent);
    color: #fff !important;
    border: 2px solid transparent;
    border-radius: 6px;
    padding: .3rem .85rem;
    font-size: .875rem;
    font-weight: 600;
    text-decoration: none !important;
    letter-spacing: .02em;
    box-shadow: 0 2px 8px rgba(232,64,56,.40);
    transition: background-color .2s, box-shadow .2s, transform .15s;
}
.logout-btn:hover {
    background-color: #c52e27;
    color: #fff !important;
    text-decoration: none !important;
    box-shadow: 0 4px 14px rgba(232,64,56,.55);
    transform: translateY(-1px);
}

/* Section headings */
h2.bg-secondary {
    background: linear-gradient(135deg, var(--primary-dark) 0%, var(--primary) 100%) !important;
    color: #fff !important; border-left: 4px solid var(--accent-warm) !important;
    border-radius: 0 8px 8px 0; letter-spacing: .025em;
    box-shadow: 0 2px 8px rgba(107,30,56,.20);
}

/* Buttons */
.btn-primary {
    --bs-btn-color: #fff; --bs-btn-bg: var(--primary); --bs-btn-border-color: var(--primary);
    --bs-btn-hover-color: #fff; --bs-btn-hover-bg: var(--primary-dark); --bs-btn-hover-border-color: var(--primary-dark);
    --bs-btn-active-bg: var(--primary-dark); --bs-btn-focus-shadow-rgb: 107,30,56;
}
.btn-secondary {
    --bs-btn-color: #fff; --bs-btn-bg: var(--earth); --bs-btn-border-color: var(--earth);
    --bs-btn-hover-color: #fff; --bs-btn-hover-bg: var(--primary); --bs-btn-hover-border-color: var(--primary);
    --bs-btn-active-bg: var(--primary); --bs-btn-focus-shadow-rgb: 139,94,60;
}
.btn-danger {
    --bs-btn-color: #fff; --bs-btn-bg: var(--accent); --bs-btn-border-color: var(--accent);
    --bs-btn-hover-color: #fff; --bs-btn-hover-bg: var(--primary); --bs-btn-hover-border-color: var(--primary);
    --bs-btn-focus-shadow-rgb: 232,64,56;
}

/* Links */
a:not(.btn) { color: var(--primary); text-decoration: none; }
a:not(.btn):hover { color: var(--primary-dark); text-decoration: underline; }

/* Tables */
.table thead th { background-color: var(--primary) !important; color: #fff !important; border-color: var(--primary) !important; }
.table td { border-color: rgba(196,154,108,.30); color: var(--dark); }
.table-hover > tbody > tr:hover > * { background-color: rgba(196,154,108,.15); color: var(--dark); }
.table-bordered > :not(caption) > * > * { border-color: rgba(196,154,108,.40); }
.table th.bg-light { background-color: var(--surface) !important; color: var(--dark) !important; }

/* Forms */
.form-label { color: var(--primary); font-weight: 500; }
.form-control, .form-select { border-color: var(--camel); color: var(--dark); }
.form-control:focus, .form-select:focus { border-color: var(--primary); box-shadow: 0 0 0 .25rem rgba(107,30,56,.20); }
.form-control[readonly] { background-color: var(--surface); color: var(--brown); }
.form-check-input:checked { background-color: var(--primary); border-color: var(--primary); }
.form-check-input:focus { border-color: var(--primary); box-shadow: 0 0 0 .25rem rgba(107,30,56,.20); }

/* Bootstrap utility overrides */
.text-secondary { color: var(--brown) !important; }
.text-muted     { color: var(--sage)  !important; }
.text-warning   { color: var(--accent-warm) !important; }
.text-danger    { color: var(--accent) !important; }
.alert-warning  { background-color: rgba(204,102,24,.10); border-color: var(--accent-warm); color: #7A3800; }
.msg-success-bg { color: #1A4A30; background-color: rgba(40,96,72,.12); border-left: 3px solid var(--secondary); padding: .5rem 1rem; border-radius: 4px; font-weight: 500; }
.border-bottom  { border-color: var(--camel) !important; }
.border.rounded { border-color: var(--camel) !important; }
.fw-bold        { color: var(--dark); }
</style>
<title>${param.title}</title>
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
${param.scripts}
</head>
<body>
	<div id="wrapper" class="container">
		<header
			class="d-flex flex-wrap justify-content-center py-3 px-5 mb-4 border-bottom border-2 site-header">
			<c:import url="/common/header.jsp" />
		</header>

		<div class="row justify-content-center">
			<c:choose>
				<%-- ログイン済みの場合 --%>
				<c:when test="${user.isAuthenticated()}">
					<nav class="col-3" style="height:40rem;">
						<c:import url="/common/navigation.jsp" />
					</nav>
					<main class="col-9 border-start"> ${param.content} </main>
				</c:when>
				<%-- 未ログインの場合 --%>
				<c:otherwise>
					<main class="col-8"> ${param.content} </main>
				</c:otherwise>
			</c:choose>
		</div>
		<footer class="py-2 my-4 border-top border-3 align-bottom site-footer">
			<c:import url="/common/footer.jsp" />
		</footer>

	</div>
</body>
</html>
