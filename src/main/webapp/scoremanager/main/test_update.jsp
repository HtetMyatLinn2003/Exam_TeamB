<%-- 成績変更JSP --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:import url="/common/base.jsp">
    <c:param name="title">得点管理システム</c:param>
    <c:param name="scripts"></c:param>
    <c:param name="content">
        <section class="me-4">
            <h2 class="h3 mb-3 fw-normal bg-secondary bg-opacity-10 py-2 px-4">成績変更</h2>
            <div class="px-4">
                <table class="table" style="max-width:420px;">
                    <tr><th>学生番号</th><td>${test.studentNo}</td></tr>
                    <tr><th>氏名</th><td>${test.studentName}</td></tr>
                    <tr><th>科目</th><td>${test.subjectCd}　${test.subjectName}</td></tr>
                    <tr><th>回数</th><td>第${test.no}回</td></tr>
                </table>
                <form method="post" action="TestUpdateExecute.action">
                    <input type="hidden" name="studentNo" value="${test.studentNo}">
                    <input type="hidden" name="subjectCd" value="${test.subjectCd}">
                    <input type="hidden" name="no"        value="${test.no}">
                    <div class="mb-3" style="max-width:200px;">
                        <label class="form-label" for="point">得点</label>
                        <input type="number" class="form-control" id="point" name="point"
                               value="${not empty point ? point : test.point}"
                               min="0" max="100" placeholder="0〜100">
                        <div class="text-warning">${errors.get("point")}</div>
                    </div>
                    <div class="d-flex gap-2 mt-3">
                        <button type="submit" class="btn btn-primary">更新</button>
                        <a href="TestStudentList.action?studentNo=${test.studentNo}"
                           class="btn btn-secondary">戻る</a>
                    </div>
                </form>
            </div>
        </section>
    </c:param>
</c:import>
