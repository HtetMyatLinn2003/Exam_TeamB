package scoremanager.main;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import bean.Student;
import bean.Subject;
import bean.Teacher;
import bean.Test;
import dao.ClassNumDao;
import dao.StudentDao;
import dao.SubjectDao;
import dao.TestDao;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import tool.Action;

public class TestListAction extends Action {

    @Override
    public void execute(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        HttpSession session = request.getSession();
        Teacher teacher = (Teacher) session.getAttribute("user");

        String mode = request.getParameter("f");
        String f1 = request.getParameter("f1");
        String f2 = request.getParameter("f2");
        String f3 = request.getParameter("f3") != null ? request.getParameter("f3").trim() : null;
        String f4 = request.getParameter("f4");

        int year = LocalDate.now().getYear();
        List<Integer> entYearSet = new ArrayList<>();
        for (int i = year - 10; i <= year + 1; i++) entYearSet.add(i);

        ClassNumDao classNumDao = new ClassNumDao();
        SubjectDao subjectDao   = new SubjectDao();
        List<String> classNums  = classNumDao.filter(teacher.getSchool());
        List<Subject> subjects  = subjectDao.filter(teacher.getSchool());

        request.setAttribute("ent_year_set", entYearSet);
        request.setAttribute("class_num_set", classNums);
        request.setAttribute("subjects", subjects);
        request.setAttribute("f1", f1);
        request.setAttribute("f2", f2);
        request.setAttribute("f3", f3);
        request.setAttribute("f4", f4);
        request.setAttribute("f", mode);

        // 科目別検索
        if ("sj".equals(mode) && f3 != null && !f3.isEmpty()) {
            TestDao testDao = new TestDao();
            List<Test> allTests = testDao.filterBySubjectAndClass(f3, f2, teacher.getSchool());
            Subject subject = subjectDao.get(f3, teacher.getSchool().getCd());

            Map<String, Test[]> grouped = new LinkedHashMap<>();
            for (Test t : allTests) {
                grouped.putIfAbsent(t.getStudentNo(), new Test[2]);
                int idx = t.getNo() - 1;
                if (idx >= 0 && idx < 2) {
                    grouped.get(t.getStudentNo())[idx] = t;
                }
            }

            request.setAttribute("grouped", grouped);
            request.setAttribute("subject", subject);
            request.getRequestDispatcher("test_list.jsp").forward(request, response);
            return;
        }

        // 学生別検索
        if ("st".equals(mode) && f4 != null && !f4.trim().isEmpty()) {
            TestDao testDao = new TestDao();
            List<Test> tests = testDao.filterByStudent(f4.trim(), teacher.getSchool());
            StudentDao studentDao = new StudentDao();
            Student student = studentDao.get(f4.trim());
            request.setAttribute("tests", tests);
            request.setAttribute("studentNo", f4.trim());
            request.setAttribute("student", student);
            request.getRequestDispatcher("test_list.jsp").forward(request, response);
            return;
        }

        request.getRequestDispatcher("test_list.jsp").forward(request, response);
    }
}
