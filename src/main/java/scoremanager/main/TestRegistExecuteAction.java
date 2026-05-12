package scoremanager.main;

import java.util.HashMap;
import java.util.Map;

import bean.Teacher;
import bean.Test;
import dao.StudentDao;
import dao.TestDao;
import bean.Student;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import tool.Action;

/**
 * 成績登録実行アクション
 * 成績管理一覧画面から送信された複数学生分の得点をまとめて保存する
 */
public class TestRegistExecuteAction extends Action {

    @Override
    public void execute(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        HttpSession session = request.getSession();
        Teacher teacher = (Teacher) session.getAttribute("user");

        String subjectCd = request.getParameter("subject");
        String countStr  = request.getParameter("count");
        int no = (countStr != null && !countStr.isEmpty()) ? Integer.parseInt(countStr) : 1;

        Map<String, String> errors = new HashMap<>();

        // regist パラメータに学生番号リストが入ってくる（複数）
        String[] studentNos = request.getParameterValues("regist");
        if (studentNos != null) {
            StudentDao sDao = new StudentDao();
            TestDao testDao = new TestDao();
            for (String studentNo : studentNos) {
                String pointStr = request.getParameter("point_" + studentNo);
                if (pointStr == null || pointStr.trim().isEmpty()) continue;

                try {
                    int point = Integer.parseInt(pointStr.trim());
                    if (point < 0 || point > 100) {
                        errors.put("point_" + studentNo, "0〜100で入力してください");
                        continue;
                    }
                    Student student = sDao.get(studentNo);
                    Test test = new Test();
                    test.setStudentNo(studentNo);
                    test.setSubjectCd(subjectCd);
                    test.setSchoolCd(teacher.getSchool().getCd());
                    test.setNo(no);
                    test.setPoint(point);
                    test.setClassNum(student != null ? student.getClassNum() : null);

                    // 既存があればupdate、なければinsert
                    Test existing = testDao.get(studentNo, subjectCd, teacher.getSchool().getCd(), no);
                    if (existing != null) {
                        testDao.update(test);
                    } else {
                        testDao.saveWithNo(test);
                    }
                } catch (NumberFormatException e) {
                    errors.put("point_" + studentNo, "数値で入力してください");
                }
            }
        }

        if (!errors.isEmpty()) {
            request.setAttribute("errors", errors);
            // 元画面にリダイレクトするかフォワードするか検討
            response.sendRedirect("TestRegist.action?f3=" + subjectCd + "&f4=" + countStr);
            return;
        }

        request.getRequestDispatcher("test_regist_done.jsp").forward(request, response);
    }
}
