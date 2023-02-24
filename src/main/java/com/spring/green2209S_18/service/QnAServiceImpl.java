package com.spring.green2209S_18.service;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import com.spring.green2209S_18.dao.QnADAO;
import com.spring.green2209S_18.vo.QnaVO;

@Service
public class QnAServiceImpl implements QnAService {
	@Autowired
	QnADAO qnaDAO;
	
	@Override
	public void imgCheck(String content) {
			//	 0         1         2         3         4         5         6         7         8         
		//     012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789
		//<img src="/green2209S_18/data/ckeditor/230111121412_4.jpg" style="height:183px; width:275px" />
		
		// content안에 그림파일이 존재할때만 작업을 수행 할 수 있도록 한다.
		if(content.indexOf("src=\"/") == -1) return;
		
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
		String uploadPath = request.getSession().getServletContext().getRealPath("/resources/data/ckeditor/");
		
		int position = 34;
		String nextImg = content.substring(content.indexOf("src=\"/") + position);
		boolean sw =true;
		
		while(sw) {
			String imgFile = nextImg.substring(0,nextImg.indexOf("\""));
			
			System.out.println("사진이름 : " + imgFile);
			
			String origFilePath = uploadPath + imgFile;
			System.out.println("오리지날 : " + origFilePath);
			String copyFilePath = uploadPath + "QnA/" + imgFile;
			
			fileCopyCheck(origFilePath,copyFilePath); // board 폴더에 파일을 복사하고자 한다.
			
			if(nextImg.indexOf("src=\"/") == -1) {
				sw = false;
			}
			else {
				nextImg = nextImg.substring(nextImg.indexOf("src=\"/") + position);
			}
		}
	}
	
	private void fileCopyCheck(String originalFilePath, String copyFilePath) {
		File origFile = new File(originalFilePath);
		File copyFile = new File(copyFilePath);
		
		try {
			FileInputStream fis = new FileInputStream(origFile);
			FileOutputStream fos = new FileOutputStream(copyFile);
			
			byte[] buffer = new byte[2048];
			int cnt = 0;
			while((cnt = fis.read(buffer)) != -1) {
				fos.write(buffer, 0, cnt);
			}
			fos.flush();
			fos.close();
			fis.close();
			
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		
	}

	@Override
	public int setQnAInput(QnaVO vo) {
		return qnaDAO.setQnAInput(vo);
	}

	@Override
	public List<QnaVO> getMyQnAList(int startIndexNo, int pageSize, String mid) {
		return qnaDAO.getMyQnAList(startIndexNo,pageSize,mid);
	}

	@Override
	public int setQnADelete(int idx) {
		return qnaDAO.setQnADelete(idx);
	}

	@Override
	public QnaVO getQnAInfo(int idx) {
		return qnaDAO.getQnAInfo(idx);
	}

	@Override
	public void imgDelete(String content) {
				//  0         1         2         3         4         5         6
		//      01234567890123456789012345678901234567890123456789012345678901234567890
		// <img src="/green2209S_18/data/ckeditor/QnA/230111121324_green2209J_06.jpg" style="height:967px; width:1337px" /></p>
		// content안에 그림파일이 존재할때만 작업을 수행 할수 있도록 한다.(src="/_____~~)
		if(content.indexOf("src=\"/") == -1) return;
		
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
		String uploadPath = request.getSession().getServletContext().getRealPath("/resources/data/ckeditor/QnA/");
		
		int position = 38;
		String nextImg = content.substring(content.indexOf("src=\"/") + position);
		boolean sw = true;
		
		while(sw) {
			String imgFile = nextImg.substring(0, nextImg.indexOf("\""));	// 그림파일명 꺼내오기
			
			String origFilePath = uploadPath + imgFile;
			
			fileDelete(origFilePath);  // board폴더에 파일을 삭제하고자 한다.
			
			if(nextImg.indexOf("src=\"/") == -1) {
				sw = false;
			}
			else {
				nextImg = nextImg.substring(nextImg.indexOf("src=\"/") + position);
			}
		}
	}
		
	private void fileDelete(String origFilePath) {
		File delFile = new File(origFilePath);
		if(delFile.exists()) delFile.delete();
		
	}

	@Override
	public int setQnAUpdateOk(QnaVO vo) {
		return qnaDAO.setQnAUpdateOk(vo);
	}	
	
	
	
}
