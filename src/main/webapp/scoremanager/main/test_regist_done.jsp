<%-- 成績登録完了 GRMU002 --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:import url="/common/base.jsp">
    <c:param name="title">得点管理システム</c:param>
    <c:param name="scripts"></c:param>
    <c:param name="content">
        <section class="me-4 px-4">
            <h2 class="h3 mb-3 fw-normal bg-secondary bg-opacity-10 py-2 px-4">成績登録完了</h2>
            <p style="color:green;">成績情報を登録しました。</p>
            <div class="d-flex gap-3 mt-3">
                <a href="TestRegist.action">成績管理一覧へ戻る</a>
                <a href="TestList.action">成績参照へ</a>
            </div>
        </section>
    </c:param>
</c:import>
