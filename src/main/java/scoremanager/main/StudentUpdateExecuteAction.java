package scoremanager.main;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import bean.Student;
import bean.Teacher;
import dao.ClassNumDao;
import dao.StudentDao;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import tool.Action;

public class StudentUpdateExecuteAction extends Action {

    @Override
    public void execute(HttpServletRequest request, HttpServletResponse response)
    throws Exception {
        HttpSession session = request.getSession();
        Teacher teacher = (Teacher) session.getAttribute("user");
        StudentDao sDao = new StudentDao();
        ClassNumDao cNumDao = new ClassNumDao();
        Map<String, String> errors = new HashMap<>();
        int year = LocalDate.now().getYear();

        String no          = request.getParameter("no");
        String name        = request.getParameter("name");
        String entYearStr  = request.getParameter("ent_year");
        String classNum    = request.getParameter("class_num");
        String isAttendStr = request.getParameter("is_attend");

        Student student = sDao.get(no);
        List<String> classNumSet = cNumDao.filter(teacher.getSchool());
        List<Integer> entYearSet = new ArrayList<>();
        for (int i = year - 10; i < year + 1; i++) {
            entYearSet.add(i);
        }

        if (name == null || name.trim().isEmpty()) {
            errors.put("name", "氏名を入力してください");
        }
        if (entYearStr == null || entYearStr.equals("0")) {
            errors.put("ent_year", "入学年度を選択してください");
        }
        if (classNum == null || classNum.equals("0")) {
            errors.put("class_num", "クラスを選択してください");
        }

        if (!errors.isEmpty()) {
            if (student != null) {
                student.setName(name != null ? name : "");
                if (entYearStr != null && !entYearStr.equals("0")) {
                    student.setEntYear(Integer.parseInt(entYearStr));
                }
                if (classNum != null) student.setClassNum(classNum);
                student.setAttend(isAttendStr != null && isAttendStr.equals("1"));
            }
            request.setAttribute("errors", errors);
            request.setAttribute("student", student);
            request.setAttribute("class_num_set", classNumSet);
            request.setAttribute("ent_year_set", entYearSet);
            request.getRequestDispatcher("student_update.jsp").forward(request, response);
            return;
        }

        student.setName(name.trim());
        student.setEntYear(Integer.parseInt(entYearStr));
        student.setClassNum(classNum);
        student.setAttend(isAttendStr != null && isAttendStr.equals("1"));
        student.setSchool(teacher.getSchool());

        sDao.save(student);
        response.sendRedirect("StudentList.action");
    }
}
