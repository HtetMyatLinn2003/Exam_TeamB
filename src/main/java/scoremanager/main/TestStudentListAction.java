package scoremanager.main;

import java.util.List;

import bean.Student;
import bean.Teacher;
import bean.Test;
import dao.StudentDao;
import dao.TestDao;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import tool.Action;

public class TestStudentListAction extends Action {

    @Override
    public void execute(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        HttpSession session = request.getSession();
        Teacher teacher = (Teacher) session.getAttribute("user");

        String studentNo = request.getParameter("studentNo");

        StudentDao studentDao = new StudentDao();
        List<Student> students = studentDao.filter(teacher.getSchool(), true);

        List<Test> tests = null;
        Student selected = null;

        if (studentNo != null && !studentNo.isEmpty()) {
            TestDao testDao = new TestDao();
            tests   = testDao.filterByStudent(studentNo, teacher.getSchool());
            selected = studentDao.get(studentNo);
        }

        request.setAttribute("students",   students);
        request.setAttribute("tests",      tests);
        request.setAttribute("selected",   selected);
        request.setAttribute("studentNo",  studentNo);
        request.getRequestDispatcher("test_student_list.jsp").forward(request, response);
    }
}
