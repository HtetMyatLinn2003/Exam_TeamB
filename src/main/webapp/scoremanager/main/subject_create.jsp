<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:import url="/common/base.jsp">
    <c:param name="title">得点管理システム</c:param>
    <c:param name="scripts"></c:param>
    <c:param name="content">
        <section class="me-4">
            <h2 class="h3 mb-3 fw-normal bg-secondary bg-opacity-10 py-2 px-4">科目登録</h2>
            <form method="post" action="SubjectCreateExecute.action">
                <div class="mx-4" style="max-width: 500px;">
                    <div class="mb-3">
                        <label class="form-label" for="cd">科目コード</label>
                        <input class="form-control" type="text" id="cd" name="cd" value="${cd}" maxlength="3" />
                        <div class="text-danger small">${errors.get("cd")}</div>
                    </div>
                    <div class="mb-3">
                        <label class="form-label" for="name">科目名</label>
                        <input class="form-control" type="text" id="name" name="name" value="${name}" maxlength="50" />
                        <div class="text-danger small">${errors.get("name")}</div>
                    </div>
                    <div class="d-flex gap-2">
                        <button type="submit" class="btn btn-primary">登録</button>
                        <a href="SubjectList.action" class="btn btn-secondary">キャンセル</a>
                    </div>
                </div>
            </form>
        </section>
    </c:param>
</c:import>
