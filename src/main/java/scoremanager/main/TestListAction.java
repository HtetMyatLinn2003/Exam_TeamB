package scoremanager.main;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

import bean.Subject;
import bean.Teacher;
import bean.Test;
import dao.ClassNumDao;
import dao.SubjectDao;
import dao.TestDao;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import tool.Action;

/**
 * 成績参照検索画面アクション (GRMR001)
 * 科目情報検索(f=sj) と 学生番号検索(f=st) の2系統
 */
public class TestListAction extends Action {

    @Override
    public void execute(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        HttpSession session = request.getSession();
        Teacher teacher = (Teacher) session.getAttribute("user");

        // 検索種別: sj=科目検索, st=学生検索
        String mode = request.getParameter("f");

        // 科目検索パラメータ
        String f1 = request.getParameter("f1"); // 入学年度
        String f2 = request.getParameter("f2"); // クラス
        String f3 = request.getParameter("f3"); // 科目
        // 学生検索パラメータ
        String f4 = request.getParameter("f4"); // 学生番号

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

        // 科目別検索 → test_list_subject.jsp へ
        if ("sj".equals(mode) && f3 != null && !f3.isEmpty() && !f3.equals("0")) {
            TestDao testDao = new TestDao();
            List<Test> tests = testDao.filterBySubjectAndClass(f3, f2, teacher.getSchool());
            Subject subject = subjectDao.get(f3, teacher.getSchool().getCd());
            request.setAttribute("tests", tests);
            request.setAttribute("subject", subject);
            request.getRequestDispatcher("test_list_subject.jsp").forward(request, response);
            return;
        }

        // 学生別検索 → test_list_student.jsp へ
        if ("st".equals(mode) && f4 != null && !f4.trim().isEmpty()) {
            TestDao testDao = new TestDao();
            List<Test> tests = testDao.filterByStudent(f4.trim(), teacher.getSchool());
            request.setAttribute("tests", tests);
            request.setAttribute("studentNo", f4.trim());
            request.getRequestDispatcher("test_list_student.jsp").forward(request, response);
            return;
        }

        // 初期表示 or 条件なし → 検索画面
        request.getRequestDispatcher("test_list.jsp").forward(request, response);
    }
}
