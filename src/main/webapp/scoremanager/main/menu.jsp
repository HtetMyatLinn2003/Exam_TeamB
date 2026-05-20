<%-- メニューJSP --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<c:import url="/common/base.jsp">
	<c:param name="title">
		得点管理システム
	</c:param>

	<c:param name="scripts"></c:param>

	<c:param name="content">
		<section class="me-4">
			<h2 class="h3 mb-3 fw-norma bg-secondary bg-opacity-10 py-2 px-4">メニュー</h2>
			<div class="row text-center px-4 fs-3 my-5">
				<div class="col d-flex align-items-center justify-content-center mx-2 rounded shadow"
					style="height: 10rem; background-color: #F5ECD9; border: 1px solid #C49A6C;">
					<a href="StudentList.action">学生管理</a>
				</div>
				<div class="col d-flex align-items-center justify-content-center mx-2 rounded shadow"
					style="height: 10rem; background-color: #EDE0CE; border: 1px solid #C49A6C;">
					<div>
						<div class="">成績管理</div>
						<div class="">
							<a href="TestRegist.action">成績登録</a>
						</div>
						<div class="">
							<a href="TestList.action">成績参照</a>
						</div>
					</div>
				</div>
				<div class="col d-flex align-items-center justify-content-center mx-2 rounded shadow"
					style="height: 10rem; background-color: #E5D4B8; border: 1px solid #8B5E3C;">
					<a href="SubjectList.action">科目管理</a>
				</div>
				<div class="col d-flex align-items-center justify-content-center mx-2 rounded shadow"
					style="height: 10rem; background-color: #D4B896; border: 1px solid #8B5E3C;">
					<a href="ClassList.action">クラス管理</a>
				</div>
			</div>
		</section>
	</c:param>
</c:import>