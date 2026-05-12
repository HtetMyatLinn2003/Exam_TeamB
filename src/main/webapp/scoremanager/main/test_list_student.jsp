<%-- 学生別成績一覧 GRMR003 --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:import url="/common/base.jsp">
    <c:param name="title">得点管理システム</c:param>
    <c:param name="scripts"></c:param>
    <c:param name="content">
        <section class="me-4">
            <h2 class="h3 mb-3 fw-normal bg-secondary bg-opacity-10 py-2 px-4">学生別成績一覧</h2>
            <div class="px-4">

                <c:choose>
                    <c:when test="${empty tests && not empty studentNo}">
                        <div class="mb-2">
                            氏名：（学生番号：${studentNo}）
                        </div>
                        <div class="text-warning">該当する成績情報が存在しませんでした。</div>
                    </c:when>
                    <c:otherwise>
                        <c:if test="${not empty tests}">
                            <div class="mb-3 fw-bold">
                                氏名：${tests[0].studentName}（${studentNo}）
                            </div>
                            <table class="table table-hover">
                                <thead>
                                    <tr>
                                        <th>科目名</th>
                                        <th>科目コード</th>
                                        <th>回数</th>
                                        <th class="text-end">点数</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="test" items="${tests}">
                                        <tr>
                                            <td>${test.subjectName}</td>
                                            <td>${test.subjectCd}</td>
                                            <td>第${test.no}回</td>
                                            <td class="text-end">
                                                <c:choose>
                                                    <c:when test="${test.point != null}">${test.point}点</c:when>
                                                    <c:otherwise>-</c:otherwise>
                                                </c:choose>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </c:if>
                    </c:otherwise>
                </c:choose>

                <div class="mt-3">
                    <a href="TestList.action">成績参照検索へ戻る</a>
                </div>
            </div>
        </section>
    </c:param>
</c:import>
