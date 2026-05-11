package scoremanager.main;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import bean.Student;
import bean.Subject;
import bean.Teacher;
import bean.Test;
import dao.StudentDao;
import dao.SubjectDao;
import dao.TestDao;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import tool.Action;

public class TestRegistExecuteAction extends Action {

    @Override
    public void execute(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        HttpSession session = request.getSession();
        Teacher teacher = (Teacher) session.getAttribute("user");

        String studentNo = request.getParameter("studentNo");
        String subjectCd = request.getParameter("subjectCd");
        String pointStr  = request.getParameter("point");

        Map<String, String> errors = new HashMap<>();

        if (studentNo == null || studentNo.trim().isEmpty()) {
            errors.put("studentNo", "学生を選択してください");
        }
        if (subjectCd == null || subjectCd.trim().isEmpty()) {
            errors.put("subjectCd", "科目を選択してください");
        }

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
            StudentDao sDao = new StudentDao();
            SubjectDao subDao = new SubjectDao();
            List<Student> students = sDao.filter(teacher.getSchool(), true);
            List<Subject> subjects = subDao.filter(teacher.getSchool());
            request.setAttribute("errors", errors);
            request.setAttribute("students", students);
            request.setAttribute("subjects", subjects);
            request.setAttribute("studentNo", studentNo);
            request.setAttribute("subjectCd", subjectCd);
            request.setAttribute("point", pointStr);
            request.getRequestDispatcher("test_regist.jsp").forward(request, response);
            return;
        }

        // 学生のクラス番号を取得
        StudentDao sDao = new StudentDao();
        Student student = sDao.get(studentNo);

        Test test = new Test();
        test.setStudentNo(studentNo);
        test.setSubjectCd(subjectCd);
        test.setSchoolCd(teacher.getSchool().getCd());
        test.setPoint(point);
        test.setClassNum(student != null ? student.getClassNum() : null);

        TestDao testDao = new TestDao();
        testDao.save(test);

        response.sendRedirect("TestRegist.action");
    }
}
