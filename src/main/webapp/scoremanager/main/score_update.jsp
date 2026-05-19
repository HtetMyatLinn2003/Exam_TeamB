<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:import url="/common/base.jsp">
    <c:param name="title">得点管理システム</c:param>
    <c:param name="scripts"></c:param>
    <c:param name="content">
        <section class="me-4">
            <h2 class="h3 mb-3 fw-normal bg-secondary bg-opacity-10 py-2 px-4">成績変更</h2>
            <form method="post" action="ScoreUpdateExecute.action">
                <input type="hidden" name="id" value="${score.id}" />
                <div class="mx-4" style="max-width: 500px;">

                    <div class="mb-3">
                        <label class="form-label">学生番号</label>
                        <input class="form-control" type="text"
                               value="${score.student.no}" readonly />
                    </div>

                    <div class="mb-3">
                        <label class="form-label">学生氏名</label>
                        <input class="form-control" type="text"
                               value="${score.student.name}" readonly />
                    </div>

                    <div class="mb-3">
                        <label class="form-label" for="subject_id">科目</label>
                        <select class="form-select" id="subject_id" name="subject_id">
                            <option value="0">--------</option>
                            <c:forEach var="subject" items="${subject_list}">
                                <option value="${subject.id}"
                                    <c:if test="${subject.id == score.subject.id}">selected</c:if>>
                                    ${subject.name}
                                </option>
                            </c:forEach>
                        </select>
                        <div class="text-danger small">${errors.get("subject_id")}</div>
                    </div>

                    <div class="mb-4">
                        <label class="form-label" for="score">得点</label>
                        <input class="form-control" type="number" id="score" name="score"
                               min="0" max="100"
                               value="${score.score}" style="max-width: 120px;" />
                        <div class="text-danger small">${errors.get("score")}</div>
                    </div>

                    <div class="d-flex gap-2">
                        <button type="submit" class="btn btn-primary">変更</button>
                        <a href="ScoreList.action" class="btn btn-secondary">キャンセル</a>
                    </div>
                </div>
            </form>
        </section>
    </c:param>
</c:import>
