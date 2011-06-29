package vocabApp;

import com.google.appengine.api.users.User;
import com.google.appengine.api.users.UserService;
import com.google.appengine.api.users.UserServiceFactory;

import javax.jdo.PersistenceManager;
import javax.jdo.Query;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class Search extends HttpServlet {
    public void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {

        UserService userService = UserServiceFactory.getUserService();
        User user = userService.getCurrentUser();

        if (user != null) {
            resp.setContentType("text/plain");
            resp.getWriter().println("Hello, " + user.getNickname());
            resp.sendRedirect("/search.jsp");
        } else {
            resp.sendRedirect(userService.createLoginURL(req.getRequestURI()));
        }

//        resp.setContentType("text/plain");

    }

    public void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {
        resp.setContentType("text/plain");
        String word = req.getParameter("word");
        String shortHand = req.getParameter("shorthand");
        long date = System.currentTimeMillis();

        UserService userService = UserServiceFactory.getUserService();
        User user = userService.getCurrentUser();
        PersistenceManager pm = PMF.get().getPersistenceManager();

        Words wordObject = new Words(word, date, user.getEmail(), shortHand);
        System.out.println(date);

        try {
            pm.makePersistent(wordObject);
        } finally {
            pm.close();
        }

        System.out.println(word);
    }
}
