package vocabApp;

import javax.jdo.PersistenceManager;
import javax.jdo.Query;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Properties;
import java.util.concurrent.TimeUnit;

import static com.google.appengine.repackaged.com.google.common.collect.Lists.newArrayList;
import static com.google.appengine.repackaged.com.google.common.collect.Maps.newHashMap;


public class Mailer extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<Words> words = getWordsForMailing();
        Map<String, List<Words>> groupedWords = groupByEmailId(words);

        Map<String, String> messages = transform(groupedWords);

        for (Map.Entry<String, String> entry : messages.entrySet()) {
            sendMail(entry.getValue(), entry.getKey());
        }
    }

    private Map<String, String> transform(Map<String, List<Words>> groupedWords) {
        Map<String, String> map = newHashMap();
        for (Map.Entry<String, List<Words>> entry : groupedWords.entrySet()) {
            map.put(entry.getKey(), messageBody(entry.getValue()));
        }
        return map;
    }

    private Map<String, List<Words>> groupByEmailId(List<Words> words) {
        Map<String, List<Words>> map = newHashMap();
        for (Words word : words) {
            String email = word.getEmail();
            if (!map.containsKey(email)) {
                map.put(email, new ArrayList<Words>());
            }
            map.get(email).add(word);
        }
        return map;
    }

    private List<Words> getWordsForMailing() {

        List<Words> words = newArrayList();
        long currentTime = System.currentTimeMillis();
        getWords(words,currentTime,0,1);
        getWords(words,currentTime,2,3);
        getWords(words,currentTime,6,7);
        getWords(words,currentTime,14,15);
        return words;

    }

    private void getWords(List<Words> words, long currentTime, int lower, int upper) {
        PersistenceManager pm = PMF.get().getPersistenceManager();
        long upperLimit = currentTime - TimeUnit.MILLISECONDS.convert(lower, TimeUnit.DAYS);
        long lowerLimit = currentTime - TimeUnit.MILLISECONDS.convert(upper, TimeUnit.DAYS);
        Query query = pm.newQuery(query(lowerLimit, upperLimit));
        words.addAll((List<Words>) query.execute());
    }

    private String query(long lowerLimit, long upperLimit) {
        String queryString = "select from " + Words.class.getName()+
                " where date > " + lowerLimit + " && date < " + upperLimit;
        return queryString;
    }

    private String messageBody(List<Words> words) {
        String s = "";
        for (Words word : words) {
            s += "\n" + word.getWord();
        }
        return "Your words for today:" + s;
    }

    private void sendMail(String msgBody, String receiver) throws UnsupportedEncodingException {
        Properties props = new Properties();
        Session session = Session.getDefaultInstance(props, null);

        try {
            Message msg = new MimeMessage(session);
            msg.setFrom(new InternetAddress("admin@vocab-app.appspotmail.com", "Vocab-app Admin"));
            msg.addRecipient(Message.RecipientType.TO,
                    new InternetAddress(receiver, "Mr. User"));
            msg.setSubject("Words Reminder");
            msg.setText(msgBody);
            Transport.send(msg);

        } catch (AddressException e) {
            // ...
        } catch (MessagingException e) {
            // ...
        }
    }
}
