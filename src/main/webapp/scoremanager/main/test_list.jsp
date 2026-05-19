<%-- 成績参照 GRMR001 --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:import url="/common/base.jsp">
    <c:param name="title">得点管理システム</c:param>
    <c:param name="scripts"></c:param>
    <c:param name="content">
        <section class="me-4">
            <h2 class="h3 mb-3 fw-normal bg-secondary bg-opacity-10 py-2 px-4">成績参照</h2>
            <div class="px-4">
                <div class="border rounded mb-2">
                    <%-- 科目情報 row --%>
                    <div class="d-flex align-items-center border-bottom px-3 py-3">
                        <div class="fw-bold flex-shrink-0 me-3" style="width:80px;">科目情報</div>
                        <form method="get" action="TestList.action" class="d-flex gap-2 align-items-end flex-wrap">
                            <input type="hidden" name="f" value="sj">
                            <div>
                                <label class="form-label small mb-1">入学年度</label>
                                <select class="form-select form-select-sm" name="f1">
                                    <option value="0">--------</option>
                                    <c:forEach var="y" items="${ent_year_set}"><option value="${y}" <c:if test="${y == f1}">selected</c:if>>${y}</option></c:forEach>
                                </select>
                            </div>
                            <div>
                                <label class="form-label small mb-1">クラス</label>
                                <select class="form-select form-select-sm" name="f2">
                                    <option value="0">--------</option>
                                    <c:forEach var="cn" items="${class_num_set}"><option value="${cn}" <c:if test="${cn == f2}">selected</c:if>>${cn}</option></c:forEach>
                                </select>
                            </div>
                            <div>
                                <label class="form-label small mb-1">科目</label>
                                <select class="form-select form-select-sm" name="f3" required>
                                    <option value="">--------</option>
                                    <c:forEach var="sub" items="${subjects}"><option value="${sub.cd}" <c:if test="${sub.cd == f3}">selected</c:if>>${sub.cd}　${sub.name}</option></c:forEach>
                                </select>
                            </div>
                            <button type="submit" class="btn btn-secondary btn-sm">検索</button>
                        </form>
                    </div>
                    <%-- 学生情報 row --%>
                    <div class="d-flex align-items-center px-3 py-3">
                        <div class="fw-bold flex-shrink-0 me-3" style="width:80px;">学生情報</div>
                        <form method="get" action="TestList.action" class="d-flex gap-2 align-items-end">
                            <input type="hidden" name="f" value="st">
                            <div>
                                <label class="form-label small mb-1">学生番号</label>
                                <input type="text" class="form-control form-control-sm" name="f4" value="${f4}"
                                       maxlength="10" placeholder="学生番号を入力してください" required>
                            </div>
                            <button type="submit" class="btn btn-secondary btn-sm">検索</button>
                        </form>
                    </div>
                </div>
                <p class="mb-4" style="color: #17a2b8; font-size: 0.9em;">科目情報を選択または学生情報を入力して検索ボタンをクリックしてください</p>

                <%-- 学生検索結果 --%>
                <c:if test="${f == 'st' and studentNo != null}">
                    <div class="mt-2">
                        <c:choose>
                            <c:when test="${empty tests}">
                                <div class="mb-2">氏名：${student.name}（${studentNo}）</div>
                                <div class="text-warning">該当する成績情報が存在しませんでした。</div>
                            </c:when>
                            <c:otherwise>
                                <div class="mb-2">氏名：${tests[0].studentName}（${studentNo}）</div>
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
                                                        <c:when test="${test.point != null}">${test.point}</c:when>
                                                        <c:otherwise>-</c:otherwise>
                                                    </c:choose>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </c:if>

                <%-- 科目検索結果 --%>
                <c:if test="${f == 'sj' and grouped != null}">
                    <div class="mt-2">
                        <div class="mb-2">科目：${subject.name}（${subject.cd}）</div>
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
                    </div>
                </c:if>
            </div>
        </section>
    </c:param>
</c:import>
