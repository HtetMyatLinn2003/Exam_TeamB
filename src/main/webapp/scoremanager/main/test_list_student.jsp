<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:import url="/common/base.jsp">
    <c:param name="title">得点管理システム</c:param>
    <c:param name="scripts"></c:param>
    <c:param name="content">
        <section class="me-4">
            <h2 class="h3 mb-3 fw-normal bg-secondary bg-opacity-10 py-2 px-4">学生別成績一覧</h2>
            <div class="px-4">
<<<<<<< HEAD
=======
                <div class="mb-3 fw-bold">
                    学生番号：${studentNo}
                </div>
>>>>>>> branch 'master' of https://github.com/HtetMyatLinn2003/Exam_TeamB.git
                <c:choose>
<<<<<<< HEAD
                    <c:when test="${empty tests and not empty studentNo}">
                        <div class="mb-3 fw-bold">氏名：（学生番号：${studentNo}）</div>
=======
                    <c:when test="${empty tests}">
>>>>>>> branch 'master' of https://github.com/HtetMyatLinn2003/Exam_TeamB.git
                        <div class="text-warning">該当する成績情報が存在しませんでした。</div>
                    </c:when>
<<<<<<< HEAD
                    <c:when test="${not empty tests}">
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
=======
                    <c:otherwise>
                        <div class="mb-2">検索結果：${tests.size()}件</div>
                        <table class="table table-hover">
                            <thead>
                                <tr>
                                    <th>科目コード</th>
                                    <th>科目名</th>
                                    <th class="text-end">第1回</th>
                                    <th class="text-end">第2回</th>
>>>>>>> branch 'master' of https://github.com/HtetMyatLinn2003/Exam_TeamB.git
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="test" items="${tests}">
                                    <tr>
<<<<<<< HEAD
                                        <td>${test.subjectName}</td>
                                        <td>${test.subjectCd}</td>
                                        <td>第${test.no}回</td>
                                        <td class="text-end">
                                            <c:choose>
                                                <c:when test="${test.point != null}">${test.point}</c:when>
=======
                                        <td>${test.subjectCd}</td>
                                        <td>${test.subjectName}</td>
                                        <td class="text-end">
                                            <c:choose>
                                                <c:when test="${test.no == 1}">
                                                    <c:choose>
                                                        <c:when test="${test.point != null}">${test.point}点</c:when>
                                                        <c:otherwise>-</c:otherwise>
                                                    </c:choose>
                                                </c:when>
                                                <c:otherwise>-</c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td class="text-end">
                                            <c:choose>
                                                <c:when test="${test.no == 2}">
                                                    <c:choose>
                                                        <c:when test="${test.point != null}">${test.point}点</c:when>
                                                        <c:otherwise>-</c:otherwise>
                                                    </c:choose>
                                                </c:when>
>>>>>>> branch 'master' of https://github.com/HtetMyatLinn2003/Exam_TeamB.git
                                                <c:otherwise>-</c:otherwise>
                                            </c:choose>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
<<<<<<< HEAD
                    </c:when>
=======
                    </c:otherwise>
>>>>>>> branch 'master' of https://github.com/HtetMyatLinn2003/Exam_TeamB.git
                </c:choose>
                <div class="mt-3">
                    <a href="TestList.action">成績参照検索へ戻る</a>
                </div>
            </div>
        </section>
    </c:param>
</c:import>