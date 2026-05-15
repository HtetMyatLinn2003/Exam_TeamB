<%-- 成績参照検索 GRMR001 --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:import url="/common/base.jsp">
    <c:param name="title">得点管理システム</c:param>
    <c:param name="scripts"></c:param>
    <c:param name="content">
        <section class="me-4">
            <h2 class="h3 mb-3 fw-normal bg-secondary bg-opacity-10 py-2 px-4">成績参照検索</h2>
            <div class="px-4">

                <%-- 科目情報検索 --%>
                <p class="fw-bold mb-1">科目情報</p>
                <form method="get" action="TestList.action" class="mb-4">
                    <input type="hidden" name="f" value="sj">
                    <div class="row g-2 border rounded py-2 align-items-end">
                        <div class="col-3">
                            <label class="form-label">入学年度</label>
                            <select class="form-select form-select-sm" name="f1">
                                <option value="0">--------</option>
                                <c:forEach var="y" items="${ent_year_set}">
                                    <option value="${y}" <c:if test="${y == f1}">selected</c:if>>${y}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="col-2">
                            <label class="form-label">クラス</label>
                            <select class="form-select form-select-sm" name="f2">
                                <option value="0">--------</option>
                                <c:forEach var="cn" items="${class_num_set}">
                                    <option value="${cn}" <c:if test="${cn == f2}">selected</c:if>>${cn}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="col-4">
                            <label class="form-label">科目</label>
                            <select class="form-select form-select-sm" name="f3">
                                <option value="0">--------</option>
                                <c:forEach var="sub" items="${subjects}">
                                    <option value="${sub.cd}" <c:if test="${sub.cd == f3}">selected</c:if>>
                                        ${sub.cd}　${sub.name}
                                    </option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="col-2">
                            <button type="submit" class="btn btn-secondary btn-sm w-100">検索</button>
                        </div>
                    </div>
                </form>

                <%-- 学生番号検索 --%>
                <p class="fw-bold mb-1">学生情報</p>
                <form method="get" action="TestList.action">
                    <input type="hidden" name="f" value="st">
                    <div class="row g-2 border rounded py-2 align-items-end">
                        <div class="col-5">
                            <label class="form-label">学生番号</label>
                            <input type="text" class="form-control form-control-sm"
                                   name="f4" value="${f4}" maxlength="10"
                                   placeholder="学生番号を入力してください" required>
                        </div>
                        <div class="col-2">
                            <button type="submit" class="btn btn-secondary btn-sm w-100">検索</button>
                        </div>
                    </div>
                </form>

                <p class="mt-3 text-secondary" style="font-size:0.9em;">
                    科目情報または学生番号を指定して検索してください。
                </p>
            </div>
        </section>
    </c:param>
</c:import>
