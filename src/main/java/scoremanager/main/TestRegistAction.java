package scoremanager.main;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

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

public class TestRegistAction extends Action {

    @Override
    public void execute(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        HttpSession session = request.getSession();
        Teacher teacher = (Teacher) session.getAttribute("user");

        String f1 = request.getParameter("f1");
        String f2 = request.getParameter("f2");
        String f3 = request.getParameter("f3");
        String f4 = request.getParameter("f4");

        int year = LocalDate.now().getYear();
        List<Integer> entYearSet = new ArrayList<>();
        for (int i = year - 10; i <= year + 1; i++) entYearSet.add(i);

        ClassNumDao classNumDao = new ClassNumDao();
        SubjectDao subjectDao   = new SubjectDao();
        List<String> classNums  = classNumDao.filter(teacher.getSchool());
        List<Subject> subjects  = subjectDao.filter(teacher.getSchool());
        List<Integer> counts    = new ArrayList<>();
        for (int i = 1; i <= 5; i++) counts.add(i);

        request.setAttribute("ent_year_set", entYearSet);
        request.setAttribute("class_num_set", classNums);
        request.setAttribute("subjects", subjects);
        request.setAttribute("counts", counts);
        request.setAttribute("f1", f1);
        request.setAttribute("f2", f2);
        request.setAttribute("f3", f3);
        request.setAttribute("f4", f4);

        if (f1 != null && !f1.isEmpty() && !f1.equals("0")
                && f2 != null && !f2.isEmpty() && !f2.equals("0")
                && f3 != null && !f3.isEmpty() && !f3.equals("0")) {

            int entYear = Integer.parseInt(f1);
            int no = (f4 != null && !f4.isEmpty() && !f4.equals("0"))
                    ? Integer.parseInt(f4) : 1;

            StudentDao sDao = new StudentDao();
            TestDao testDao = new TestDao();
            List<Student> students = sDao.filter(teacher.getSchool(), entYear, f2, false);

            List<Test> tests = new ArrayList<>();
            for (Student s : students) {
                Test t = testDao.get(s.getNo(), f3, teacher.getSchool().getCd(), no);
                if (t == null) {
                    t = new Test();
                    t.setStudentNo(s.getNo());
                    t.setSubjectCd(f3);
                    t.setSchoolCd(teacher.getSchool().getCd());
                    t.setNo(no);
                    t.setClassNum(s.getClassNum());
                    t.setStudentName(s.getName());
                    t.setEntYear(s.getEntYear());
                }
                tests.add(t);
            }
            request.setAttribute("tests", tests);

            Subject subject = subjectDao.get(f3, teacher.getSchool().getCd());
            request.setAttribute("subject", subject);
        }

        request.getRequestDispatcher("test_regist.jsp").forward(request, response);
    }
}
