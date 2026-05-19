<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:import url="/common/base.jsp">
    <c:param name="title">得点管理システム</c:param>
    <c:param name="scripts"></c:param>
    <c:param name="content">
        <section class="me-4">
            <h2 class="h3 mb-3 fw-normal bg-secondary bg-opacity-10 py-2 px-4">科目情報変更</h2>
            <form method="post" action="SubjectUpdateExecute.action">
                <input type="hidden" name="cd" value="${not empty subject ? subject.cd : cd}" />
                <div class="mx-4" style="max-width: 500px;">
                    <div class="mb-3">
                        <label class="form-label">科目コード</label>
                        <div class="px-1">${not empty subject ? subject.cd : cd}</div>
                    </div>
                    <c:if test="${not empty errors.get('not_found')}">
                        <div class="text-warning mb-2">${errors.get('not_found')}</div>
                    </c:if>
                    <div class="mb-3">
                        <label class="form-label" for="name">科目名</label>
                        <input class="form-control" type="text" id="name" name="name"
                               value="${not empty subject ? subject.name : name}"
                               maxlength="20" placeholder="科目名を入力してください" required />
                        <div class="text-danger small">${errors.get("name")}</div>
                    </div>
                    <div class="mb-3">
                        <button type="submit" class="btn btn-primary">変更</button>
                    </div>
                    <a href="SubjectList.action">戻る</a>
                </div>
            </form>
        </section>
    </c:param>
</c:import>
