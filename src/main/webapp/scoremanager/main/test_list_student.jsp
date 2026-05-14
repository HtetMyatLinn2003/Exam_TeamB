<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:import url="/common/base.jsp">
    <c:param name="title">得点管理システム</c:param>
    <c:param name="scripts"></c:param>
    <c:param name="content">
        <section class="me-4">
            <h2 class="h3 mb-3 fw-normal bg-secondary bg-opacity-10 py-2 px-4">学生別成績一覧</h2>

            <form method="get" action="TestStudentList.action" class="mx-4 mb-4 d-flex gap-2 align-items-center">
                <select name="studentNo" class="form-select" style="max-width:300px;">
                    <option value="">学生を選択してください</option>
                    <c:forEach var="s" items="${students}">
                        <option value="${s.no}"
                            <c:if test="${s.no == studentNo}">selected</c:if>>
                            ${s.no} - ${s.name}
                        </option>
                    </c:forEach>
                </select>
                <button type="submit" class="btn btn-primary">表示</button>
            </form>

            <c:if test="${selected != null}">
                <div class="mx-4 mb-2">
                    <strong>${selected.no} ${selected.name}</strong>
                </div>
                <c:choose>
                    <c:when test="${empty tests}">
                        <div class="mx-4">成績データがありません。</div>
                    </c:when>
                    <c:otherwise>
                        <table class="table table-bordered mx-4" style="max-width:700px;">
                            <tr>
                                <th>科目名</th>
                                <th>回数</th>
                                <th>得点</th>
                                <th>変更</th>
                                <th>削除</th>
                            </tr>
                            <c:forEach var="test" items="${tests}">
                                <tr>
                                    <td>${test.subjectName}</td>
                                    <td>${test.no}</td>
                                    <td>${test.point}</td>
                                    <td>
                                        <a href="TestUpdate.action?studentNo=${test.studentNo}&subjectCd=${test.subjectCd}&no=${test.no}">変更</a>
                                    </td>
                                    <td>
                                        <a href="TestDeleteExecute.action?studentNo=${test.studentNo}&subjectCd=${test.subjectCd}&no=${test.no}"
                                           onclick="return confirm('削除しますか？')">削除</a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </table>
                    </c:otherwise>
                </c:choose>
            </c:if>
        </section>
    </c:param>
</c:import>