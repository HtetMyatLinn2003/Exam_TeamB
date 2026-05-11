<%-- 科目登録JSP --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:import url="/common/base.jsp">
    <c:param name="title">得点管理システム</c:param>
    <c:param name="scripts"></c:param>
    <c:param name="content">
        <section class="me-4">
            <h2 class="h3 mb-3 fw-normal bg-secondary bg-opacity-10 py-2 px-4">科目登録</h2>
            <form method="post" action="SubjectCreateExecute.action" class="px-4">
                <div class="mb-3" style="max-width:400px;">
                    <label class="form-label" for="cd">科目コード</label>
                    <input type="text" class="form-control" id="cd" name="cd"
                           value="${cd}" maxlength="3" placeholder="例：A01">
                    <div class="text-warning">${errors.get("cd")}</div>
                </div>
                <div class="mb-3" style="max-width:400px;">
                    <label class="form-label" for="name">科目名</label>
                    <input type="text" class="form-control" id="name" name="name"
                           value="${name}" maxlength="20" placeholder="例：数学">
                    <div class="text-warning">${errors.get("name")}</div>
                </div>
                <div class="d-flex gap-2">
                    <button type="submit" class="btn btn-primary">登録</button>
                    <a href="SubjectList.action" class="btn btn-secondary">戻る</a>
                </div>
            </form>
        </section>
    </c:param>
</c:import>
