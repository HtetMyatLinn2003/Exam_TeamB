package scoremanager.main;

import java.util.HashMap;
import java.util.Map;

import bean.Subject;
import bean.Teacher;
import dao.SubjectDao;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import tool.Action;

public class SubjectUpdateExecuteAction extends Action {

    @Override
    public void execute(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        HttpSession session = request.getSession();
        Teacher teacher = (Teacher) session.getAttribute("user");

        String cd   = request.getParameter("cd");
        String name = request.getParameter("name");

        Map<String, String> errors = new HashMap<>();

        if (name == null || name.trim().isEmpty()) {
            errors.put("name", "科目名を入力してください");
        }

        if (!errors.isEmpty()) {
            SubjectDao subjectDao = new SubjectDao();
            Subject subject = subjectDao.get(cd, teacher.getSchool());
            request.setAttribute("errors", errors);
            request.setAttribute("subject", subject);
            request.setAttribute("name", name);
            request.getRequestDispatcher("subject_update.jsp").forward(request, response);
            return;
        }

        Subject subject = new Subject();
        subject.setCd(cd);
        subject.setName(name.trim());
        subject.setSchool(teacher.getSchool());

        SubjectDao subjectDao = new SubjectDao();
        subjectDao.save(subject);

        response.sendRedirect("SubjectList.action");
    }
}
