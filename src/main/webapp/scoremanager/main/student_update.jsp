<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:import url="/common/base.jsp">
    <c:param name="title">得点管理システム</c:param>
    <c:param name="scripts"></c:param>
    <c:param name="content">
        <section class="me-4">
            <h2 class="h3 mb-3 fw-normal bg-secondary bg-opacity-10 py-2 px-4">学生変更</h2>
            <form method="post" action="StudentUpdateExecute.action">
                <div class="mx-4" style="max-width: 500px;">
                    <div class="mb-3">
                        <label class="form-label">学生番号</label>
                        <input class="form-control" type="text" value="${student.no}" readonly />
                        <input type="hidden" name="no" value="${student.no}" />
                    </div>
                    <div class="mb-3">
                        <label class="form-label" for="name">氏名</label>
                        <input class="form-control" type="text" id="name" name="name" value="${student.name}" maxlength="50" />
                        <div class="text-danger small">${errors.get("name")}</div>
                    </div>
                    <div class="mb-3">
                        <label class="form-label" for="ent_year">入学年度</label>
                        <select class="form-select" id="ent_year" name="ent_year">
                            <option value="0">--------</option>
                            <c:forEach var="year" items="${ent_year_set}">
                                <option value="${year}" <c:if test="${year == student.entYear}">selected</c:if>>${year}</option>
                            </c:forEach>
                        </select>
                        <div class="text-danger small">${errors.get("ent_year")}</div>
                    </div>
                    <div class="mb-3">
                        <label class="form-label" for="class_num">クラス</label>
                        <select class="form-select" id="class_num" name="class_num">
                            <option value="0">--------</option>
                            <c:forEach var="num" items="${class_num_set}">
                                <option value="${num}" <c:if test="${num == student.classNum}">selected</c:if>>${num}</option>
                            </c:forEach>
                        </select>
                        <div class="text-danger small">${errors.get("class_num")}</div>
                    </div>
                    <div class="mb-4 form-check">
                        <input class="form-check-input" type="checkbox" id="is_attend" name="is_attend" value="1"
                               <c:if test="${student.isAttend()}">checked</c:if> />
                        <label class="form-check-label" for="is_attend">在学中</label>
                    </div>
                    <div class="d-flex gap-2">
                        <button type="submit" class="btn btn-primary">変更</button>
                        <a href="StudentList.action" class="btn btn-secondary">キャンセル</a>
                    </div>
                </div>
            </form>
        </section>
    </c:param>
</c:import>
