package scoremanager.main;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

import bean.Student;
import bean.Teacher;
import dao.ClassNumDao;
import dao.StudentDao;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import tool.Action;

public class StudentUpdateAction extends Action {

    @Override
    public void execute(HttpServletRequest request, HttpServletResponse response)
    throws Exception {
        HttpSession session = request.getSession();
        Teacher teacher = (Teacher) session.getAttribute("user");
        StudentDao sDao = new StudentDao();
        ClassNumDao cNumDao = new ClassNumDao();
        int year = LocalDate.now().getYear();

        String no = request.getParameter("no");

        Student student = sDao.get(no);
        List<String> classNumSet = cNumDao.filter(teacher.getSchool());
        List<Integer> entYearSet = new ArrayList<>();
        for (int i = year - 10; i < year + 1; i++) {
            entYearSet.add(i);
        }

        request.setAttribute("student", student);
        request.setAttribute("class_num_set", classNumSet);
        request.setAttribute("ent_year_set", entYearSet);
        request.getRequestDispatcher("student_update.jsp").forward(request, response);
    }
}
