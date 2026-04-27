<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:import url="/common/base.jsp">
    <c:param name="title">得点管理システム</c:param>
    <c:param name="scripts"></c:param>
    <c:param name="content">
        <section class="me-4">
            <h2 class="h3 mb-3 fw-normal bg-secondary bg-opacity-10 py-2 px-4">成績削除</h2>
            <div class="mx-4" style="max-width: 500px;">
                <p class="mb-4 text-danger fw-bold">以下の成績情報を削除してもよろしいですか？</p>

                <table class="table table-bordered mb-4" style="max-width: 400px;">
                    <tr>
                        <th class="bg-light" style="width: 35%;">学生番号</th>
                        <td>${score.student.no}</td>
                    </tr>
                    <tr>
                        <th class="bg-light">学生氏名</th>
                        <td>${score.student.name}</td>
                    </tr>
                    <tr>
                        <th class="bg-light">科目</th>
                        <td>${score.subject.name}</td>
                    </tr>
                    <tr>
                        <th class="bg-light">得点</th>
                        <td>${score.score} 点</td>
                    </tr>
                </table>

                <form method="post" action="ScoreDeleteExecute.action">
                    <input type="hidden" name="id" value="${score.id}" />
                    <div class="d-flex gap-2">
                        <button type="submit" class="btn btn-danger">削除</button>
                        <a href="ScoreList.action" class="btn btn-secondary">キャンセル</a>
                    </div>
                </form>
            </div>
        </section>
    </c:param>
</c:import>
