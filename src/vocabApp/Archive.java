package vocabApp;

import com.google.appengine.api.users.User;
import com.google.appengine.api.users.UserService;
import com.google.appengine.api.users.UserServiceFactory;

import javax.jdo.PersistenceManager;
import javax.jdo.Query;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

public class Archive extends HttpServlet {
    public void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {
        resp.setContentType("text/plain");
        String word = req.getParameter("word");
        String archive = req.getParameter("archive");
        UserService userService = UserServiceFactory.getUserService();
        User user = userService.getCurrentUser();

        PersistenceManager pm = PMF.get().getPersistenceManager();

        Query query = pm.newQuery("select from " + Words.class.getName() +
                " where email == '" + user.getEmail() + "' && word == '" + word + "'");
        List<Words> wordsList = (List<Words>) query.execute();
        Words currentWord = wordsList.get(0);
        currentWord.setArchived(archive);
        try {
            pm.makePersistent(currentWord);
        } finally {
            pm.close();
        }


    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
