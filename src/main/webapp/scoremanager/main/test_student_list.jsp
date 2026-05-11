<%-- 成績参照（学生別）JSP --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:import url="/common/base.jsp">
    <c:param name="title">得点管理システム</c:param>
    <c:param name="scripts"></c:param>
    <c:param name="content">
        <section class="me-4">
            <h2 class="h3 mb-3 fw-normal bg-secondary bg-opacity-10 py-2 px-4">
                成績参照（学生別）
            </h2>

            <%-- 学生選択フォーム --%>
            <form method="get" class="px-4">
                <div class="row mb-3 g-2 align-items-end" style="max-width:500px;">
                    <div class="col-8">
                        <label class="form-label" for="studentNo">学生</label>
                        <select class="form-select" id="studentNo" name="studentNo">
                            <option value="">-- 選択してください --</option>
                            <c:forEach var="student" items="${students}">
                                <option value="${student.no}"
                                    <c:if test="${student.no == studentNo}">selected</c:if>>
                                    ${student.no}　${student.name}
                                </option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="col-4">
                        <button type="submit" class="btn btn-secondary w-100">表示</button>
                    </div>
                </div>
            </form>

            <%-- 選択中の学生情報 --%>
            <c:if test="${selected != null}">
                <div class="px-4 mb-3">
                    <div class="border rounded p-2" style="max-width:400px;background:var(--bs-light);">
                        <span class="fw-bold">${selected.no}</span>　${selected.name}
                        　クラス：${selected.classNum}　入学：${selected.entYear}年度
                    </div>
                </div>
            </c:if>

            <%-- 成績一覧 --%>
            <div class="px-4">
                <c:choose>
                    <c:when test="${tests == null}">
                        <p class="text-secondary">学生を選択してください。</p>
                    </c:when>
                    <c:when test="${tests.size() == 0}">
                        <p>成績データが登録されていません。</p>
                    </c:when>
                    <c:otherwise>
                        <div class="mb-2">成績件数：${tests.size()}件</div>
                        <table class="table table-hover">
                            <thead>
                                <tr>
                                    <th>科目コード</th>
                                    <th>科目名</th>
                                    <th>回数</th>
                                    <th class="text-end">得点</th>
                                    <th></th>
                                    <th></th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="test" items="${tests}">
                                    <tr>
                                        <td>${test.subjectCd}</td>
                                        <td>${test.subjectName}</td>
                                        <td>第${test.no}回</td>
                                        <td class="text-end">
                                            <c:choose>
                                                <c:when test="${test.point != null}">
                                                    ${test.point}点
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="text-secondary">未入力</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>
                                            <a href="TestUpdate.action?studentNo=${test.studentNo}&subjectCd=${test.subjectCd}&no=${test.no}">
                                                変更
                                            </a>
                                        </td>
                                        <td>
                                            <a href="TestDeleteExecute.action?studentNo=${test.studentNo}&subjectCd=${test.subjectCd}&no=${test.no}"
                                               onclick="return confirm('この成績（${test.subjectName} 第${test.no}回）を削除しますか？')">
                                                削除
                                            </a>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </c:otherwise>
                </c:choose>
            </div>

            <div class="px-4 mt-3">
                <a href="TestRegist.action" class="btn btn-primary btn-sm">成績を登録する</a>
            </div>
        </section>
    </c:param>
</c:import>
