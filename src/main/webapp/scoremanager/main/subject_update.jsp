<%-- 科目変更JSP --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:import url="/common/base.jsp">
    <c:param name="title">得点管理システム</c:param>
    <c:param name="scripts"></c:param>
    <c:param name="content">
        <section class="me-4">
            <h2 class="h3 mb-3 fw-normal bg-secondary bg-opacity-10 py-2 px-4">科目変更</h2>
            <form method="post" action="SubjectUpdateExecute.action" class="px-4">
                <input type="hidden" name="cd" value="${subject.cd}">
                <div class="mb-3" style="max-width:400px;">
                    <label class="form-label">科目コード</label>
                    <input type="text" class="form-control" value="${subject.cd}" readonly>
                </div>
                <div class="mb-3" style="max-width:400px;">
                    <label class="form-label" for="name">科目名</label>
                    <input type="text" class="form-control" id="name" name="name"
                           value="${not empty name ? name : subject.name}" maxlength="20">
                    <div class="text-warning">${errors.get("name")}</div>
                </div>
                <div class="d-flex gap-2">
                    <button type="submit" class="btn btn-primary">更新</button>
                    <a href="SubjectList.action" class="btn btn-secondary">戻る</a>
                </div>
            </form>
        </section>
    </c:param>
</c:import>
