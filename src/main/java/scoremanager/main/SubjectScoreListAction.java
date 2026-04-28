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

        String subjectCd = request.getParameter("subject_id");
        Subject selectedSubject = null;
        List<Score> scores = null;

        if (subjectCd != null && !subjectCd.equals("0")) {
            selectedSubject = subjectDao.get(subjectCd, teacher.getSchool());
            if (selectedSubject != null) {
                scores = scoreDao.filterBySubject(selectedSubject);
            }
        }

        request.setAttribute("subject_list", subjectList);
        request.setAttribute("selected_subject", selectedSubject);
        request.setAttribute("scores", scores);
        request.getRequestDispatcher("subject_score_list.jsp").forward(request, response);
    }
}