<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:import url="/common/base.jsp">
    <c:param name="title">得点管理システム</c:param>
    <c:param name="scripts"></c:param>
    <c:param name="content">
        <section class="me-4">
            <h2 class="h3 mb-3 fw-normal bg-secondary bg-opacity-10 py-2 px-4">科目別成績一覧</h2>

            <%-- 科目フィルター --%>
            <form method="get" class="mx-3 mb-4">
                <div class="row border py-2 align-items-center rounded" id="filter">
                    <div class="col-6">
                        <label class="form-label" for="subject_id">科目</label>
                        <select class="form-select" id="subject_id" name="subject_id">
                            <option value="0">--------</option>
                            <c:forEach var="subject" items="${subject_list}">
                                <option value="${subject.id}"
                                    <c:if test="${subject.id == selected_subject.id}">selected</c:if>>
                                    ${subject.name}
                                </option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="col-3 align-self-end">
                        <button class="btn btn-secondary" id="filter-button">絞込み</button>
                    </div>
                </div>
            </form>

            <%-- 結果テーブル --%>
            <c:choose>
                <c:when test="${selected_subject == null}">
                    <div class="mx-3 text-muted">科目を選択して絞り込んでください。</div>
                </c:when>
                <c:when test="${scores == null || scores.size() == 0}">
                    <div class="mx-3">「${selected_subject.name}」の成績情報が存在しませんでした。</div>
                </c:when>
                <c:otherwise>
                    <div class="mx-3 mb-2">
                        科目：<strong>${selected_subject.name}</strong>　
                        検索結果：${scores.size()} 件
                    </div>
                    <table class="table table-hover mx-3" style="max-width: 700px;">
                        <thead>
                            <tr>
                                <th>クラス</th>
                                <th>学生番号</th>
                                <th>氏名</th>
                                <th class="text-end">得点</th>
                                <th></th>
                                <th></th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="s" items="${scores}">
                                <tr>
                                    <td>${s.student.classNum}</td>
                                    <td>${s.student.no}</td>
                                    <td>${s.student.name}</td>
                                    <td class="text-end">${s.score} 点</td>
                                    <td><a href="ScoreUpdate.action?id=${s.id}">変更</a></td>
                                    <td><a href="ScoreDelete.action?id=${s.id}"
                                           class="text-danger">削除</a></td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </c:otherwise>
            </c:choose>
        </section>
    </c:param>
</c:import>
