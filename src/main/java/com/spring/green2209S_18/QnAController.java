package com.spring.green2209S_18;

import java.io.File;
import java.io.FileOutputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.spring.green2209S_18.pagenation.PageProcess;
import com.spring.green2209S_18.pagenation.PageVO;
import com.spring.green2209S_18.service.OrderService;
import com.spring.green2209S_18.service.QnAService;
import com.spring.green2209S_18.vo.QnaVO;
import com.spring.green2209S_18.vo.RatingVO;

@Controller
@RequestMapping("/QnA")
public class QnAController {
	
	@Autowired
	QnAService qnaService;

	@Autowired
	OrderService orderService;
	
	@Autowired
	PageProcess pageProcess;
	
  @RequestMapping(value = "/QnAList", method = RequestMethod.GET)
  public String qnaListGet(Model model, HttpSession session,
  		@RequestParam(name="search", defaultValue = "", required = false) String search,
			@RequestParam(name="searchString", defaultValue = "", required = false) String searchString,
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name="pageSize", defaultValue = "10", required = false) int pageSize) {
  	
  	
		String mid = (String) session.getAttribute("sMid");
		
		PageVO pageVo = pageProcess.totRecCnt(pag, pageSize, "QnAList", mid, searchString);	
		
		List<QnaVO> vos = qnaService.getMyQnAList(pageVo.getStartIndexNo(), pageSize, mid);
  	
		model.addAttribute("vos", vos);
		model.addAttribute("pag", pag);
		model.addAttribute("pageSize", pageSize);
		model.addAttribute("pageVo", pageVo);
  	return "QnA/QnAList";
  }
  
  @RequestMapping(value = "/QnAInput", method = RequestMethod.GET)
  public String QnAInputGet(Model model) {
  	
  	return "QnA/QnAInput";
  }
  
//관리자 상품등록에서 상품 작성시, ckeditor에서 글올릴때 이미지와 함께 올린다면 이곳에서 서버 파일시스템에 저장시켜준다.
	@ResponseBody
	@RequestMapping("/imageUpload")
	public void imageUploadGet(HttpServletRequest request, HttpServletResponse response, @RequestParam MultipartFile upload) throws Exception {
		response.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		
		String originalFilename = upload.getOriginalFilename();
		
		Date date = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyMMddHHmmss");
		originalFilename = sdf.format(date) + "_" + originalFilename;
		
		byte[] bytes = upload.getBytes();
		
		// ckeditor에서 올린 파일을 서버 파일시스템에 저장시켜준다.
		String uploadPath = request.getSession().getServletContext().getRealPath("/resources/data/ckeditor/");
		OutputStream outStr = new FileOutputStream(new File(uploadPath + originalFilename));
		outStr.write(bytes);		// 서버에 업로드시킨 그림파일이 저장된다.
		
		// 서버 파일시스템에 저장된 파일을 화면(textarea)에 출력하기
		PrintWriter out = response.getWriter();
		String fileUrl = request.getContextPath() + "/data/ckeditor/" + originalFilename;
		out.println("{\"originalFilename\":\""+originalFilename+"\",\"uploaded\":1,\"url\":\""+fileUrl+"\"}");       /* "atom":"12.jpg","uploaded":1,"": */
		
		out.flush();
		outStr.close();
	}
	
	@Transactional
  @RequestMapping(value = "/QnAInput", method = RequestMethod.POST)
  public String QnAInputPost(QnaVO vo) {
  	
		// content에 이미지가 저장되어 있다면, 저장된 이미지만 골라서 /resources/data/board/폴더에 저장시켜준다.
  	qnaService.imgCheck(vo.getContent());
		
		// 이미지 복사작업이 끝나면, board폴더에 실제로 저장된 파일명을 DB에 저장시켜준다. [/resources/data/board/ == >>/resources/data/board/]
		
		System.out.println("vo" + vo);
		
		vo.setContent(vo.getContent().replace("/data/ckeditor/","/data/ckeditor/QnA/"));
		int res = qnaService.setQnAInput(vo); // 성공하면 1넘어옴
		
		if(res == 1) return "redirect:/msg/QnAInputOk";
		else return "redirect:/msg/QnAInputNo";
  	
  }
	
	@ResponseBody
	@RequestMapping(value = "/QnADelete", method = RequestMethod.POST)
	public String QnADeletePost(int idx) {
		
		QnaVO vo = qnaService.getQnAInfo(idx);
		if(vo.getContent().indexOf("src=\"/") != -1) qnaService.imgDelete(vo.getContent());
		
		int res = qnaService.setQnADelete(idx); // 성공하면 1넘어옴
		
		
		if(res == 1) return "1";
		else return "0";
		
	}
	
	@RequestMapping(value = "/QnAUpdate", method = RequestMethod.GET)
	public String QnAUpdateGet(int idx, Model model) {
		
		QnaVO vo = qnaService.getQnAInfo(idx);
		
		model.addAttribute("vo", vo);
		
		return "QnA/QnAUpdate";
	}
	
	@RequestMapping(value = "/QnAUpdate", method = RequestMethod.POST)
	public String QnAUpdatePost(QnaVO vo) {
		
		// 수정된 자료가 원본자료와 완전히 동일하다면 수정할 필요가 없기에, DB에 저장된 원본 자료를 불러와서 비교해준다.
		QnaVO nVo = qnaService.getQnAInfo(vo.getIdx());
		
		// content의 내용이 조금이라도 변경된것이 있다면 아래 내용을 수행처리시킨다.
			if(!nVo.getContent().equals(vo.getContent())) {
				// 실제로 수정하기버튼을 클릭하게되면 기존의 board폴더에 저장된 현재 content의 그림파일 모두를 삭제 시킨다.
				if(nVo.getContent().indexOf("src=\"/") != -1) qnaService.imgDelete(nVo.getContent());
				
				// vo.GetContent()에 들어있는 파일의 경로는 'ckeditor/board'경로를 'ckeditor'변경시켜줘야한다.
				vo.setContent(vo.getContent().replace("/data/ckeditor/QnA/", "/data/ckeditor/"));
				
				// 앞의 모든준비가 끝나면, 파일을 처음 업로드한것과 같은 작업을 처리한다.
				// 이 작업은 처음 게시글을 올릴때의 파일복사 작업과 동일한 작업이다.
				qnaService.imgCheck(vo.getContent());
				
				// 파일 업로드가 끝나면 다시 경로를 수정한다.'ckeditor'경로를 'ckeditor/board'변경시켜줘야한다.(즉, 변경된 vo.getContent()를 vo.setContent() 처리한다.)
				vo.setContent(vo.getContent().replace("/data/ckeditor/", "/data/ckeditor/QnA/"));
			}
		
		// 잘 정비된 vo를 DB에 Update시켜준다.
			int res = qnaService.setQnAUpdateOk(vo);
			
			if(res == 1) return "redirect:/msg/QnAUpdateOk";
			
			else return "redirect:/msg/QnAUpdateNo";
		
	}
	
	
  
}
