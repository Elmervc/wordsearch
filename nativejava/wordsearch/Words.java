package wordsearch;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.List;



public class Words {
        public static List<String> get(int letter){
          System.out.println("reading " + "/EOWL-wordlist/" + letter + ".tbl");
          InputStream in = utils.EmailServlet.class.getResourceAsStream("/" + letter + ".tbl");
          InputStreamReader i=null;
          BufferedReader r=null;
          try {
            r = new BufferedReader(i=new InputStreamReader(in,"UTF-8"));
          } catch (UnsupportedEncodingException e1) {
            e1.printStackTrace();
          }
          List<String> list = new ArrayList<String>();
          String s = null;
          try {
            while ((s=r.readLine())!=null) {
              list.add(s);//new String(s.getBytes("ISO-8859-1"), "UTF-8"));
            }
          }
          catch (IOException e) { e.printStackTrace(); }
          try { r.close(); } catch (IOException e) { e.printStackTrace(); }
          try { i.close(); } catch (IOException e) { e.printStackTrace(); }
          try { in.close(); } catch (IOException e) { e.printStackTrace(); }
          return list;
        }
        public static void main(String[] args){
          System.out.println(get(1));
        }
}

