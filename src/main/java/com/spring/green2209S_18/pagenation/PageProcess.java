package com.spring.green2209S_18.pagenation;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.green2209S_18.dao.AdminDAO;
import com.spring.green2209S_18.dao.MemberDAO;
import com.spring.green2209S_18.dao.OrderDAO;
import com.spring.green2209S_18.dao.QnADAO;
import com.spring.green2209S_18.dao.RiderDAO;
import com.spring.green2209S_18.dao.StoreDAO;

@Service
public class PageProcess {
	@Autowired
	OrderDAO orderDAO;
	
	@Autowired
	StoreDAO storeDAO;
	
	@Autowired
	MemberDAO memberDAO;
	
	@Autowired
	RiderDAO riderDAO;
	
	@Autowired
	AdminDAO adminDAO;
	
	@Autowired
	QnADAO qnADAO;
	
	
	public PageVO totRecCnt(int pag, int pageSize, String section, String search, String searchString) {
		
		PageVO pageVO = new PageVO();
		int totRecCnt = 0;
		
		if(section.equals("rating")) {
		 	totRecCnt = orderDAO.totRatingCnt(search);			
		}
		else if(section.equals("store")) {
			totRecCnt = storeDAO.totRatingCnt(search);			
		}
		else if(section.equals("storeMenu")) {
			totRecCnt = storeDAO.totStoreMenuCnt(search, searchString);			
		}
		else if(section.equals("qrCode")) {
			totRecCnt = memberDAO.totCouponCnt(search);			
		}
		else if(section.equals("memberOderList")) {
			totRecCnt = memberDAO.totOderListCnt(search);			
		}
		else if(section.equals("riderOrderList")) {
			totRecCnt = riderDAO.totOderListCnt(search);			
		}
		else if(section.equals("adminMemberList")) {
			totRecCnt = adminDAO.totMemberListCnt(search,searchString);			
		}
		else if(section.equals("adminMemberDeleteList")) {
			totRecCnt = adminDAO.totMemberDeleteListCnt(search,searchString);			
		}
		else if(section.equals("adminMemberBanList")) {
			totRecCnt = adminDAO.totMemberBanListCnt(search,searchString);			
		}
		else if(section.equals("adminRiderList")) {
			totRecCnt = adminDAO.totAdminRiderListCnt(search,searchString);			
		}
		else if(section.equals("adminRiderDeleteList")) {
			totRecCnt = adminDAO.totRiderDeleteListCnt(search,searchString);			
		}
		else if(section.equals("adminStoreList")) {
			totRecCnt = adminDAO.totAdminStoreListCnt(search,searchString);			
		}
		else if(section.equals("adminStoreDeleteList")) {
			totRecCnt = adminDAO.totStoreDeleteListCnt(search,searchString);			
		}
		else if(section.equals("adminRatingList")) {
			totRecCnt = adminDAO.totRatingListCnt(search,searchString);			
		}
		else if(section.equals("ratingReportList")) {
			totRecCnt = adminDAO.totRatingReportListCnt(search,searchString);			
		}
		else if(section.equals("ratingReplyList")) {
			totRecCnt = adminDAO.totRatingReplyListCnt(search,searchString);			
		}
		else if(section.equals("ratingReplyReportList")) {
			totRecCnt = adminDAO.totRatingReplyReportListCnt(search,searchString);			
		}
		else if(section.equals("QnAList")) {
			totRecCnt = qnADAO.totQnAListCnt(search,searchString);			
		}
		else if(section.equals("adminQnAList")) {
			totRecCnt = qnADAO.totAdminQnAListCnt(search,searchString);			
		}
		else if(section.equals("adminQnAListYet")) {
			totRecCnt = qnADAO.totAdminQnAListYetCnt(search,searchString);			
		}
		else if(section.equals("QnAListDone")) {
			totRecCnt = qnADAO.totAdminQnAListDoneCnt(search,searchString);			
		}
		else if(section.equals("storeOrderList")) {
			totRecCnt = storeDAO.totStoreOrderListCnt(search,searchString);			
		}
		
//		else if(section.equals("webMessage")) {
//			String mid = search;
//			int mSw = Integer.parseInt(searchString);
//			totRecCnt = webMessageDAO.totRecCnt(mid,mSw);
//		}

		int totPage = (totRecCnt % pageSize) ==0 ? totRecCnt / pageSize : (totRecCnt / pageSize) +1;	//4. 총 페이지 건수를 구한다.
		int startIndexNo = (pag-1) * pageSize; //5. 현재페이지의 시작 인덱스번호를 구한다.
		int curScrStartNo = totRecCnt - startIndexNo;		//6. 현재 화면에 보여주는 시작번호를 구한다.
		
		int blockSize = 3;  // 1. 블록의 크기를 결정한다.(여기선 3으로 지정)		
		int curBlock = (pag - 1) / blockSize;
		int lastBlock = (totPage - 1) / blockSize;	// 3. 마지막블록을 구한다.
		
		pageVO.setPag(pag);
		pageVO.setPageSize(pageSize);
		pageVO.setTotRecCnt(totRecCnt);
		pageVO.setTotPage(totPage);
		pageVO.setStartIndexNo(startIndexNo);
		pageVO.setCurScrStartNo(curScrStartNo);
		pageVO.setBlockSize(blockSize);
		pageVO.setCurBlock(curBlock);
		pageVO.setLastBlock(lastBlock);
		
		pageVO.setPart(search);
		
		System.out.println(curScrStartNo);
		
		return pageVO;
	}

	
	
	
	public PageVO totRecCnt2(int pag, int pageSize, String section, String search, String searchString, String brandName) {
		
		PageVO pageVO = new PageVO();
		int totRecCnt = 0;
		
		if(section.equals("adminMenuList")) {
			totRecCnt = adminDAO.totAdminMenuListCnt(search,searchString,brandName);			
		}
	
		
//		else if(section.equals("webMessage")) {
//			String mid = search;
//			int mSw = Integer.parseInt(searchString);
//			totRecCnt = webMessageDAO.totRecCnt(mid,mSw);
//		}

		int totPage = (totRecCnt % pageSize) ==0 ? totRecCnt / pageSize : (totRecCnt / pageSize) +1;	//4. 총 페이지 건수를 구한다.
		int startIndexNo = (pag-1) * pageSize; //5. 현재페이지의 시작 인덱스번호를 구한다.
		int curScrStartNo = totRecCnt - startIndexNo;		//6. 현재 화면에 보여주는 시작번호를 구한다.
		
		int blockSize = 3;  // 1. 블록의 크기를 결정한다.(여기선 3으로 지정)		
		int curBlock = (pag - 1) / blockSize;
		int lastBlock = (totPage - 1) / blockSize;	// 3. 마지막블록을 구한다.
		
		pageVO.setPag(pag);
		pageVO.setPageSize(pageSize);
		pageVO.setTotRecCnt(totRecCnt);
		pageVO.setTotPage(totPage);
		pageVO.setStartIndexNo(startIndexNo);
		pageVO.setCurScrStartNo(curScrStartNo);
		pageVO.setBlockSize(blockSize);
		pageVO.setCurBlock(curBlock);
		pageVO.setLastBlock(lastBlock);
		
		pageVO.setPart(search);
		
		System.out.println(curScrStartNo);
		
		return pageVO;
	}
	
	
	
	
	
	
	
	// 댓글 페이징
	
//	public PageVO totReplyRecCnt(int replyPag, int replyPageSize, String section, String search, String searchString, int idx) {
//		PageVO pageVO = new PageVO();
//		int totRecCnt = 0;
//		
//		if(section.equals("boardReply")) {
//			totRecCnt = boardDAO.totboardReplyCnt(search,searchString, idx);	
//		  System.out.println("댓글 숫자" + totRecCnt);
//		}
//		int totPage = (totRecCnt % replyPageSize) ==0 ? totRecCnt / replyPageSize : (totRecCnt / replyPageSize) +1;	//4. 총 페이지 건수를 구한다.
//		int startIndexNo = (replyPag-1) * replyPageSize; //5. 현재페이지의 시작 인덱스번호를 구한다.
//		int curScrStartNo = totRecCnt - startIndexNo;		//6. 현재 화면에 보여주는 시작번호를 구한다.
//		
//		int blockSize = 3;  // 1. 블록의 크기를 결정한다.(여기선 3으로 지정)		
//		int curBlock = (replyPag - 1) / blockSize;
//		int lastBlock = (totPage - 1) / blockSize;	// 3. 마지막블록을 구한다.
//		
//		pageVO.setPag(replyPag);
//		pageVO.setPageSize(replyPageSize);
//		pageVO.setTotRecCnt(totRecCnt);
//		pageVO.setTotPage(totPage);
//		pageVO.setStartIndexNo(startIndexNo);
//		pageVO.setCurScrStartNo(curScrStartNo);
//		pageVO.setBlockSize(blockSize);
//		pageVO.setCurBlock(curBlock);
//		pageVO.setLastBlock(lastBlock);
//		return pageVO;
//	}
	
}
