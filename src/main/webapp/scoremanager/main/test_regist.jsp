<%-- 成績登録JSP --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:import url="/common/base.jsp">
    <c:param name="title">得点管理システム</c:param>
    <c:param name="scripts"></c:param>
    <c:param name="content">
        <section class="me-4">
            <h2 class="h3 mb-3 fw-normal bg-secondary bg-opacity-10 py-2 px-4">成績登録</h2>
            <form method="post" action="TestRegistExecute.action" class="px-4">
                <div class="mb-3" style="max-width:400px;">
                    <label class="form-label" for="studentNo">学生</label>
                    <select class="form-select" id="studentNo" name="studentNo">
                        <option value="">-- 選択してください --</option>
                        <c:forEach var="student" items="${students}">
                            <option value="${student.no}"
                                <c:if test="${student.no == studentNo}">selected</c:if>>
                                ${student.no} ${student.name}
                            </option>
                        </c:forEach>
                    </select>
                    <div class="text-warning">${errors.get("studentNo")}</div>
                </div>
                <div class="mb-3" style="max-width:400px;">
                    <label class="form-label" for="subjectCd">科目</label>
                    <select class="form-select" id="subjectCd" name="subjectCd">
                        <option value="">-- 選択してください --</option>
                        <c:forEach var="subject" items="${subjects}">
                            <option value="${subject.cd}"
                                <c:if test="${subject.cd == subjectCd}">selected</c:if>>
                                ${subject.cd} ${subject.name}
                            </option>
                        </c:forEach>
                    </select>
                    <div class="text-warning">${errors.get("subjectCd")}</div>
                </div>
                <div class="mb-3" style="max-width:200px;">
                    <label class="form-label" for="point">得点</label>
                    <input type="number" class="form-control" id="point" name="point"
                           value="${point}" min="0" max="100" placeholder="0〜100">
                    <div class="text-warning">${errors.get("point")}</div>
                </div>
                <div class="d-flex gap-2 mt-3">
                    <button type="submit" class="btn btn-primary">登録</button>
                    <a href="Menu.action" class="btn btn-secondary">戻る</a>
                </div>
            </form>
        </section>
    </c:param>
</c:import>
