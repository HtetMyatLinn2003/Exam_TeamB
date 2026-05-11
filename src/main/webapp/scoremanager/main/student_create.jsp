<%-- 学生登録 STDM002 --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:import url="/common/base.jsp">
    <c:param name="title">得点管理システム</c:param>
    <c:param name="scripts"></c:param>
    <c:param name="content">
        <section class="me-4">
            <h2 class="h3 mb-3 fw-normal bg-secondary bg-opacity-10 py-2 px-4">学生情報登録</h2>
            <form method="post" action="StudentCreateExecute.action" class="px-4" style="max-width:480px;">

                <%-- エラーメッセージ --%>
                <c:if test="${not empty errors}">
                    <div class="alert alert-warning mb-3">
                        <c:forEach var="e" items="${errors}">
                            <div>${e.value}</div>
                        </c:forEach>
                    </div>
                </c:if>

                <div class="mb-3">
                    <label class="form-label" for="ent_year">入学年度</label>
                    <select class="form-select" id="ent_year" name="ent_year">
                        <option value="0">--------</option>
                        <c:forEach var="y" items="${ent_year_set}">
                            <option value="${y}" <c:if test="${y == ent_year}">selected</c:if>>${y}</option>
                        </c:forEach>
                    </select>
                </div>

                <div class="mb-3">
                    <label class="form-label" for="no">学生番号</label>
                    <input type="text" class="form-control" id="no" name="no"
                           value="${no}" maxlength="10"
                           placeholder="学生番号を入力してください" required>
                </div>

                <div class="mb-3">
                    <label class="form-label" for="name">氏名</label>
                    <input type="text" class="form-control" id="name" name="name"
                           value="${name}" maxlength="30"
                           placeholder="氏名を入力してください" required>
                </div>

                <div class="mb-3">
                    <label class="form-label" for="class_num">クラス</label>
                    <select class="form-select" id="class_num" name="class_num">
                        <option value="">--------</option>
                        <c:forEach var="cn" items="${class_num_set}">
                            <option value="${cn}" <c:if test="${cn == class_num}">selected</c:if>>${cn}</option>
                        </c:forEach>
                    </select>
                </div>

                <div class="d-flex gap-2 mt-4">
                    <button type="submit" name="end" class="btn btn-primary">登録して終了</button>
                </div> <br>
                <a href="StudentList.action" class="btn btn-secondary">戻る</a>
            </form>
        </section>
    </c:param>
</c:import>
