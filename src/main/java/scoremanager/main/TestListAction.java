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

public class TestListAction extends Action {

	@Override
	public void execute(HttpServletRequest request,
			HttpServletResponse response) throws Exception {

		HttpSession session = request.getSession();

		Teacher teacher = (Teacher) session.getAttribute("user");

		// ログイン確認
		if (teacher == null) {
			response.sendRedirect("../login.jsp");
			return;
		}

		// 検索種別
		String mode = request.getParameter("f");

		// 科目検索
		String f1 = request.getParameter("f1");
		String f2 = request.getParameter("f2");
		String f3 = request.getParameter("f3");

		// 学生検索
		String f4 = request.getParameter("f4");

		// 年度リスト
		int year = LocalDate.now().getYear();

		List<Integer> entYearSet = new ArrayList<>();

		for (int i = year - 10; i <= year + 1; i++) {
			entYearSet.add(i);
		}

		// DAO
		ClassNumDao classNumDao = new ClassNumDao();

		SubjectDao subjectDao = new SubjectDao();

		TestDao testDao = new TestDao();

		// データ取得
		List<String> classNums = classNumDao.filter(
				teacher.getSchool());

		List<Subject> subjects = subjectDao.filter(
				teacher.getSchool());

		// JSPへ渡す
		request.setAttribute(
				"ent_year_set",
				entYearSet);

		request.setAttribute(
				"class_num_set",
				classNums);

		request.setAttribute(
				"subjects",
				subjects);

		request.setAttribute("f1", f1);
		request.setAttribute("f2", f2);
		request.setAttribute("f3", f3);
		request.setAttribute("f4", f4);
		request.setAttribute("f", mode);

		// =========================
		// 科目検索
		// =========================
		if ("sj".equals(mode)
				&& f1 != null
				&& !f1.equals("0")
				&& f2 != null
				&& !f2.equals("0")
				&& f3 != null
				&& !f3.equals("0")) {

			int entYear = Integer.parseInt(f1);

			List<Test> tests = testDao.filterBySubjectAndClass(
					entYear,
					f3,
					f2,
					teacher.getSchool());

			Subject subject = subjectDao.get(
					f3,
					teacher.getSchool().getCd());

			request.setAttribute(
					"tests",
					tests);

			request.setAttribute(
					"subject",
					subject);

			request.getRequestDispatcher(
					"test_list_subject.jsp")
					.forward(request, response);

			return;
		}

		// =========================
		// 学生検索
		// =========================
		if ("st".equals(mode)
				&& f4 != null
				&& !f4.trim().isEmpty()) {

			List<Test> tests = testDao.filterByStudent(
					f4.trim(),
					teacher.getSchool());

			request.setAttribute(
					"tests",
					tests);

			request.setAttribute(
					"studentNo",
					f4.trim());

			request.getRequestDispatcher(
					"test_list_student.jsp")
					.forward(request, response);

			return;
		}

		// 初期画面
		request.getRequestDispatcher(
				"test_list.jsp")
				.forward(request, response);
	}
}