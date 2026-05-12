<%-- 科目別成績一覧 GRMR002 --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:import url="/common/base.jsp">
    <c:param name="title">得点管理システム</c:param>
    <c:param name="scripts"></c:param>
    <c:param name="content">
        <section class="me-4">
            <h2 class="h3 mb-3 fw-normal bg-secondary bg-opacity-10 py-2 px-4">科目別成績一覧</h2>
            <div class="px-4">

                <div class="mb-3 fw-bold">
                    科目：${subject.name}（${subject.cd}）
                </div>

                <c:choose>
                    <c:when test="${empty tests}">
                        <div class="text-warning">該当する成績情報が存在しませんでした。</div>
                    </c:when>
                    <c:otherwise>
                        <%-- 学生ごとに1回・2回の点数をまとめて表示するため、
                             サーブレット側でグルーピング済みのデータを使う。
                             ここではシンプルに全レコードを表示する --%>
                        <div class="mb-2">検索結果：${tests.size()}件</div>
                        <table class="table table-hover">
                            <thead>
                                <tr>
                                    <th>入学年度</th>
                                    <th>クラス</th>
                                    <th>学生番号</th>
                                    <th>氏名</th>
                                    <th class="text-end">第1回</th>
                                    <th class="text-end">第2回</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%-- 学生ごとにグルーピング --%>
                                <c:set var="prevNo" value="" />
                                <c:set var="p1" value="-" />
                                <c:set var="p2" value="-" />
                                <c:forEach var="test" items="${tests}" varStatus="st">
                                    <c:if test="${test.studentNo != prevNo && prevNo != ''}">
                                        <%-- 前の学生の行を出力 --%>
                                    </c:if>
                                    <c:set var="prevNo" value="${test.studentNo}" />
                                    <tr>
                                        <td>${test.entYear}</td>
                                        <td>${test.classNum}</td>
                                        <td>${test.studentNo}</td>
                                        <td>${test.studentName}</td>
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
                                                <c:otherwise>-</c:otherwise>
                                            </c:choose>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </c:otherwise>
                </c:choose>

                <div class="mt-3">
                    <a href="TestList.action">成績参照検索へ戻る</a>
                </div>
            </div>
        </section>
    </c:param>
</c:import>
