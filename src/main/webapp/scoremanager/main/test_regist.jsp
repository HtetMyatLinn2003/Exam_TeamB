<%-- 成績管理一覧 GRMU001 --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:import url="/common/base.jsp">
    <c:param name="title">得点管理システム</c:param>
    <c:param name="scripts"></c:param>
    <c:param name="content">
        <section class="me-4">
            <h2 class="h3 mb-3 fw-normal bg-secondary bg-opacity-10 py-2 px-4">成績管理一覧</h2>

            <%-- エラーメッセージ --%>
            <c:if test="${not empty errors}">
                <div class="alert alert-warning mx-4">
                    <c:forEach var="e" items="${errors}">
                        <div>${e.value}</div>
                    </c:forEach>
                </div>
            </c:if>

            <%-- 検索フォーム --%>
            <form method="get" action="TestRegist.action" class="px-4 mb-3">
                <div class="row g-2 border rounded py-3 mx-0 mb-3 align-items-end">
                    <div class="col-auto">
                        <label class="form-label">入学年度</label>
                        <select class="form-select form-select-sm" name="f1">
                            <option value="0">--------</option>
                            <c:forEach var="y" items="${ent_year_set}">
                                <option value="${y}" <c:if test="${y == f1}">selected</c:if>>${y}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="col-auto">
                        <label class="form-label">クラス</label>
                        <select class="form-select form-select-sm" name="f2">
                            <option value="0">--------</option>
                            <c:forEach var="cn" items="${class_num_set}">
                                <option value="${cn}" <c:if test="${cn == f2}">selected</c:if>>${cn}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="col-auto">
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
                    <div class="col-auto">
                        <label class="form-label">回数</label>
                        <select class="form-select form-select-sm" name="f4">
                            <option value="0">--------</option>
                            <c:forEach var="cnt" items="${counts}">
                                <option value="${cnt}" <c:if test="${cnt == f4}">selected</c:if>>${cnt}回目</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="col-auto">
                        <button type="submit" class="btn btn-secondary btn-sm">検索</button>
                    </div>
                </div>
            </form>

            <%-- 検索結果 --%>
            <c:if test="${not empty tests}">
                <form method="post" action="TestRegistExecute.action" class="px-4">
                    <input type="hidden" name="subject" value="${f3}">
                    <input type="hidden" name="count"   value="${f4}">

                    <div class="mb-2 fw-bold">
                        科目：${subject.name}（${subject.cd}）
                        <c:if test="${not empty f4 and f4 != '0'}">　第${f4}回</c:if>
                    </div>

                    <table class="table table-hover">
                        <thead>
                            <tr>
                                <th>入学年度</th>
                                <th>クラス</th>
                                <th>学生番号</th>
                                <th>氏名</th>
                                <th>点数</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="test" items="${tests}">
                                <tr>
                                    <td>${test.entYear}</td>
                                    <td>${test.classNum}</td>
                                    <td>${test.studentNo}</td>
                                    <td>${test.studentName}</td>
                                    <td>
                                        <input type="number" class="form-control form-control-sm"
                                               style="width:90px;"
                                               name="point_${test.studentNo}"
                                               value="${test.point}"
                                               min="0" max="100" placeholder="0〜100">
                                        <input type="hidden" name="regist" value="${test.studentNo}">
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                    <div class="mt-3">
                        <input type="submit" class="btn btn-primary" value="登録して終了">
                    </div>
                </form>
            </c:if>
        </section>
    </c:param>
</c:import>
