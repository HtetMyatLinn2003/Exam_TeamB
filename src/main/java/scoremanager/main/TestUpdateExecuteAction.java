package scoremanager.main;

import java.util.HashMap;
import java.util.Map;

import bean.Teacher;
import bean.Test;
import dao.TestDao;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import tool.Action;

public class TestUpdateExecuteAction extends Action {

    @Override
    public void execute(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        HttpSession session = request.getSession();
        Teacher teacher = (Teacher) session.getAttribute("user");

        String studentNo = request.getParameter("studentNo");
        String subjectCd = request.getParameter("subjectCd");
        String noStr     = request.getParameter("no");
        String pointStr  = request.getParameter("point");
        int no = Integer.parseInt(noStr);

        Map<String, String> errors = new HashMap<>();
        Integer point = null;

        if (pointStr != null && !pointStr.trim().isEmpty()) {
            try {
                point = Integer.parseInt(pointStr.trim());
                if (point < 0 || point > 100) {
                    errors.put("point", "得点は0〜100で入力してください");
                }
            } catch (NumberFormatException e) {
                errors.put("point", "得点は数値で入力してください");
            }
        }

        if (!errors.isEmpty()) {
            TestDao testDao = new TestDao();
            Test test = testDao.get(studentNo, subjectCd, teacher.getSchool().getCd(), no);
            request.setAttribute("errors", errors);
            request.setAttribute("test", test);
            request.setAttribute("point", pointStr);
            request.getRequestDispatcher("test_update.jsp").forward(request, response);
            return;
        }

        Test test = new Test();
        test.setStudentNo(studentNo);
        test.setSubjectCd(subjectCd);
        test.setSchoolCd(teacher.getSchool().getCd());
        test.setNo(no);
        test.setPoint(point);

        TestDao testDao = new TestDao();
        testDao.update(test);

        // 変更後は学生別成績参照へ戻る
        response.sendRedirect("TestStudentList.action?studentNo=" + studentNo);
    }
}
