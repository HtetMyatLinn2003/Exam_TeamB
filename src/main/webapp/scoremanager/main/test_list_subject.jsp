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
                <div class="mb-3 fw-bold">科目：${subject.name}（${subject.cd}）</div>
                <c:choose>
                    <c:when test="${empty grouped}">
                        <div class="text-warning">該当する成績情報が存在しませんでした。</div>
                    </c:when>
                    <c:otherwise>
                        <table class="table table-hover">
                            <thead>
                                <tr>
                                    <th>入学年度</th>
                                    <th>クラス</th>
                                    <th>学生番号</th>
                                    <th>氏名</th>
                                    <th class="text-end">1回</th>
                                    <th class="text-end">2回</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="entry" items="${grouped}">
                                    <c:set var="t1" value="${entry.value[0]}" />
                                    <c:set var="t2" value="${entry.value[1]}" />
                                    <c:set var="base" value="${not empty t1 ? t1 : t2}" />
                                    <tr>
                                        <td>${base.entYear}</td>
                                        <td>${base.classNum}</td>
                                        <td>${entry.key}</td>
                                        <td>${base.studentName}</td>
                                        <td class="text-end">
                                            <c:choose>
                                                <c:when test="${not empty t1 and t1.point != null}">${t1.point}</c:when>
                                                <c:otherwise>-</c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td class="text-end">
                                            <c:choose>
                                                <c:when test="${not empty t2 and t2.point != null}">${t2.point}</c:when>
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
                    <a href="TestList.action">戻る</a>
                </div>
            </div>
        </section>
    </c:param>
</c:import>
