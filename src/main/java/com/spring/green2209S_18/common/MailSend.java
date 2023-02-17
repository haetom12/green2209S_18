package com.spring.green2209S_18.common;

import java.util.Random;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;

import com.spring.green2209S_18.vo.MailVO;

public class MailSend {
	
	@Autowired
	static JavaMailSender mailSender;

	
	// 메일 인증
	public static String mailFormPost(MailVO vo, HttpServletRequest request, HttpSession session) {
		
		Random random = new Random();
    StringBuffer buffer = new StringBuffer();
    int num = 0;

    while(buffer.length() < 10) {
        num = random.nextInt(10);
        buffer.append(num);
    }
    String msg = buffer.toString();
    
    System.out.println("msg : " + msg);
    
    String toMail = vo.getToMail();
    String title = "[저기요] 메일 인증";
    String content = "";
    content += "<br><hr><h3>메일 인증번호입니다</h3><hr><br/>";
    content += "인증번호 : " + msg;
    content += "<p>===============================</p>";
    content += "<hr>";
		
		try {
			
			
			// 메일을 전송하기 위한 객체 : MimeMessage() , MimeMessageHelper()
			MimeMessage message = mailSender.createMimeMessage(); // 타입변환
			MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "UTF-8"); //보관함에 저장하는곳
			
			// 메일보관함에 회원이 보내온 메세지들을 모두 저장시킨다.
			messageHelper.setTo(toMail);
			messageHelper.setSubject(title);
			messageHelper.setText(content);
			
			
//			// 메세지 보관함의 내용(content)에 필요한 정보를 추가로 담아서 전송시킬수 있도록 한다.
//			content = content.replace("\n", "<br/>");
//			content += "<br><hr><h3>메일 인증번호입니다</h3>";
//			content += "<p><img src=\"cid:main.jpg\"  width='500px'></p>";
//			content += "<p>방문하기 : <a href='http://49.142.157.251:9090/green2209J_18/homepage.pro'>HJ현준약품</a></p>";
//			content += "<hr>";
//			messageHelper.setText(content, true);
			
			/*
			// 본문에 기재된 그림파일의 경로를 따로 표시시켜 준다. 그리고, 보관함에 다시 저장시켜준다.
			FileSystemResource file = new FileSystemResource("D:\\JavaWorkspace\\springframework\\works\\javawspring\\src\\main\\webapp\\resources\\images\\main.jpg");
			messageHelper.addInline("main.jpg", file); //일반그림은 inline
			
			 //첨부차일 보내기(서버 파일시스템에 있는 파일)
			file = new FileSystemResource("D:\\JavaWorkspace\\springframework\\works\\javawspring\\src\\main\\webapp\\resources\\images\\고양이.jpg");
			messageHelper.addAttachment("고양이.jpg", file); // 첨부파일은 attach
			
			file = new FileSystemResource("D:\\JavaWorkspace\\springframework\\works\\javawspring\\src\\main\\webapp\\resources\\images\\연습.zip");
			messageHelper.addAttachment("연습.zip", file); // 첨부파일은 attach
			
			//	file = new FileSystemResource(request.getRealPath("/resources/images/고양이2.jpg"));
			file = new FileSystemResource(request.getSession().getServletContext().getRealPath("/resources/images/고양이3.jpg"));
			messageHelper.addAttachment("고양이3.jpg", file); // 첨부파일은 attach
			*/
			
			// 메일 전송하기
			mailSender.send(message);
			
		} catch (MessagingException e) {
			e.printStackTrace();
		}
		
		return "1";
	}
	
}
