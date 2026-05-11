<%-- 成績参照（科目・クラス別）JSP --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:import url="/common/base.jsp">
    <c:param name="title">得点管理システム</c:param>
    <c:param name="scripts"></c:param>
    <c:param name="content">
        <section class="me-4">
            <h2 class="h3 mb-3 fw-normal bg-secondary bg-opacity-10 py-2 px-4">
                成績参照（科目・クラス別）
            </h2>

            <%-- 絞り込みフォーム --%>
            <form method="get" class="px-4">
                <div class="row mb-3 g-2 align-items-end" style="max-width:600px;">
                    <div class="col-5">
                        <label class="form-label" for="subjectCd">科目</label>
                        <select class="form-select" id="subjectCd" name="subjectCd">
                            <option value="">-- 選択 --</option>
                            <c:forEach var="subject" items="${subjects}">
                                <option value="${subject.cd}"
                                    <c:if test="${subject.cd == subjectCd}">selected</c:if>>
                                    ${subject.cd}　${subject.name}
                                </option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="col-4">
                        <label class="form-label" for="classNum">クラス</label>
                        <select class="form-select" id="classNum" name="classNum">
                            <option value="0">-- 全クラス --</option>
                            <c:forEach var="cn" items="${classNums}">
                                <option value="${cn}"
                                    <c:if test="${cn == classNum}">selected</c:if>>
                                    ${cn}
                                </option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="col-3">
                        <button type="submit" class="btn btn-secondary w-100">絞り込み</button>
                    </div>
                </div>
            </form>

            <%-- 結果表示 --%>
            <div class="px-4">
                <c:choose>
                    <c:when test="${tests == null}">
                        <p class="text-secondary">科目を選択して絞り込んでください。</p>
                    </c:when>
                    <c:when test="${tests.size() == 0}">
                        <p>該当する成績データが存在しませんでした。</p>
                    </c:when>
                    <c:otherwise>
                        <div class="mb-2">検索結果：${tests.size()}件</div>
                        <table class="table table-hover">
                            <thead>
                                <tr>
                                    <th>学生番号</th>
                                    <th>氏名</th>
                                    <th>科目</th>
                                    <th>回数</th>
                                    <th class="text-end">得点</th>
                                    <th></th>
                                    <th></th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="test" items="${tests}">
                                    <tr>
                                        <td>${test.studentNo}</td>
                                        <td>${test.studentName}</td>
                                        <td>${test.subjectCd}　${test.subjectName}</td>
                                        <td>第${test.no}回</td>
                                        <td class="text-end">
                                            <c:choose>
                                                <c:when test="${test.point != null}">
                                                    ${test.point}点
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="text-secondary">未入力</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>
                                            <a href="TestUpdate.action?studentNo=${test.studentNo}&subjectCd=${test.subjectCd}&no=${test.no}">
                                                変更
                                            </a>
                                        </td>
                                        <td>
                                            <a href="TestDeleteExecute.action?studentNo=${test.studentNo}&subjectCd=${test.subjectCd}&no=${test.no}"
                                               onclick="return confirm('この成績を削除しますか？')">
                                                削除
                                            </a>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </c:otherwise>
                </c:choose>
            </div>
        </section>
    </c:param>
</c:import>
