package vocabApp;

import javax.jdo.PersistenceManager;
import javax.jdo.Query;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class DeleteAll extends HttpServlet {
    public void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {
        resp.setContentType("text/plain");
        String password = req.getParameter("password");

        PersistenceManager pm = PMF.get().getPersistenceManager();

        Query query = pm.newQuery(Words.class);
        if ("qwedsa".equals(password)) {
            query.deletePersistentAll();
        }
        resp.sendRedirect("/listall.jsp");

    }
}
