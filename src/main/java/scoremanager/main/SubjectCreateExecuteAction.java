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

public class SubjectCreateExecuteAction extends Action {

    @Override
    public void execute(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        HttpSession session = request.getSession();
        Teacher teacher = (Teacher) session.getAttribute("user");

        String cd   = request.getParameter("cd");
        String name = request.getParameter("name");

        Map<String, String> errors = new HashMap<>();

        if (cd == null || cd.trim().isEmpty()) {
            errors.put("cd", "科目コードを入力してください");
        }
        if (name == null || name.trim().isEmpty()) {
            errors.put("name", "科目名を入力してください");
        }

        if (!errors.isEmpty()) {
            request.setAttribute("errors", errors);
            request.setAttribute("cd", cd);
            request.setAttribute("name", name);
            request.getRequestDispatcher("subject_create.jsp").forward(request, response);
            return;
        }

        SubjectDao subjectDao = new SubjectDao();

        // 重複チェック
        if (subjectDao.get(cd, teacher.getSchool()) != null) {
            errors.put("cd", "その科目コードはすでに登録されています");
            request.setAttribute("errors", errors);
            request.setAttribute("cd", cd);
            request.setAttribute("name", name);
            request.getRequestDispatcher("subject_create.jsp").forward(request, response);
            return;
        }

        Subject subject = new Subject();
        subject.setCd(cd.trim());
        subject.setName(name.trim());
        subject.setSchool(teacher.getSchool());

        subjectDao.save(subject);

        response.sendRedirect("SubjectList.action");
    }
}
