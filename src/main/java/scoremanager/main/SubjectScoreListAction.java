package scoremanager.main;

import java.util.List;

import bean.Score;
import bean.Subject;
import bean.Teacher;
import dao.ScoreDao;
import dao.SubjectDao;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import tool.Action;

public class SubjectScoreListAction extends Action {

    @Override
    public void execute(HttpServletRequest request, HttpServletResponse response)
            throws Exception {

        HttpSession session = request.getSession();
        Teacher teacher = (Teacher) session.getAttribute("user");

        SubjectDao subjectDao = new SubjectDao();
        ScoreDao scoreDao     = new ScoreDao();

        List<Subject> subjectList = subjectDao.filter(teacher.getSchool());

        String subjectIdStr = request.getParameter("subject_id");
        Subject selectedSubject = null;
        List<Score> scores = null;

        if (subjectIdStr != null && !subjectIdStr.equals("0")) {
            int subjectId = Integer.parseInt(subjectIdStr);
            selectedSubject = subjectDao.get(subjectId);
            if (selectedSubject != null) {
            	scores = scoreDao.filterBySubject(selectedSubject.getId());
            }
        }

        request.setAttribute("subject_list", subjectList);
        request.setAttribute("selected_subject", selectedSubject);
        request.setAttribute("scores", scores);
        request.getRequestDispatcher("subject_score_list.jsp").forward(request, response);
    }
}
