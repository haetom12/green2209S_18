package com.spring.green2209S_18.service;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import com.google.zxing.BarcodeFormat;
import com.google.zxing.WriterException;
import com.google.zxing.client.j2se.MatrixToImageConfig;
import com.google.zxing.client.j2se.MatrixToImageWriter;
import com.google.zxing.common.BitMatrix;
import com.google.zxing.qrcode.QRCodeWriter;
import com.spring.green2209S_18.common.JavaspringProvide;
import com.spring.green2209S_18.dao.OrderDAO;
import com.spring.green2209S_18.vo.CartVO;
import com.spring.green2209S_18.vo.CouponVO;
import com.spring.green2209S_18.vo.FoodMenuVO;
import com.spring.green2209S_18.vo.RatingVO;
import com.spring.green2209S_18.vo.StoreVO;
import com.spring.green2209S_18.vo.WebSocketDbVO;
import com.spring.green2209S_18.vo.wishListVO;

@Service
public class OrderServiceImpl implements OrderService {
	
	@Autowired
	OrderDAO orderDAO;

	@Override
	public int setWishListInput(String storeName, int menuIdx, String mid) {
		return orderDAO.setWishListInput(storeName, menuIdx, mid);
	}

	@Override
	public wishListVO getCheckWishList(String storeName, int menuIdx, String mid) {
		return orderDAO.getCheckWishList(storeName, menuIdx, mid);
	}

	@Override
	public List<wishListVO> getMyWishList(String mid) {
		return orderDAO.getMyWishList(mid);
	}

	@Override
	public FoodMenuVO getWishListInfo(int menuIdx) {
		return orderDAO.getWishListInfo(menuIdx);
	}

	@Override
	public void setDeleteWishList(int menuIdx) {
		orderDAO.setDeleteWishList(menuIdx);
	}

	@Override
	public void setAddCartInput(CartVO vo) {
		orderDAO.setAddCartInput(vo);
	}

	@Override
	public void myCartDelete(int idx) {
		orderDAO.myCartDelete(idx);
	}

	@Override
	public CartVO getOrderMaxIdx() {
		return orderDAO.getOrderMaxIdx();
	}

	@Override
	public CartVO getCartIdx(int idx) {
		return orderDAO.getCartIdx(idx);
	}

	@Override
	public void setFoodOrderOK(CartVO vo) {
		String imgFile = vo.getThumbImg();
		
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
		String uploadPath = request.getSession().getServletContext().getRealPath("/resources/data/");
		
		String origFilePath = uploadPath + "storeFoodPhoto/" +imgFile;
		String copyFilePath = uploadPath + "orderFoodPhoto/" + imgFile;
		
		JavaspringProvide ps = new JavaspringProvide();
		
		ps.fileCopyCheck(origFilePath,copyFilePath); // board ????????? ????????? ??????????????? ??????.
		
		orderDAO.setFoodOrderOK(vo);
	}

	@Override
	public CartVO getCheckOrderIdx(String orderIdx) {
		return orderDAO.getCheckOrderIdx(orderIdx);
	}

	@Override
	public void setFoodOrderOk2(CartVO vo) {
		
		String imgFile = vo.getThumbImg();
		
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
		String uploadPath = request.getSession().getServletContext().getRealPath("/resources/data/");
		
		String origFilePath = uploadPath + "storeFoodPhoto/" +imgFile;
		String copyFilePath = uploadPath + "orderFoodPhoto/" + imgFile;
		
		JavaspringProvide ps = new JavaspringProvide();
		
		ps.fileCopyCheck(origFilePath,copyFilePath); // board ????????? ????????? ??????????????? ??????.
		
		orderDAO.setFoodOrderOk2(vo);
	}

	@Override
	public List<CartVO> getMyOrderList(String mid, int startIndexNo, int pageSize) {
		return orderDAO.getMyOrderList(mid, startIndexNo, pageSize);
	}

	@Override
	public void setRiderOrder(WebSocketDbVO orderVo) {
		orderDAO.setRiderOrder(orderVo);
	}

	@Override
	public void imgCheck(String content) {
			//	 0         1         2         3         4         5         6         7         8         
		//     012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789
		//<img src="/green2209S_18/data/ckeditor/230111121412_4.jpg" style="height:183px; width:275px" />
		
		// content?????? ??????????????? ??????????????? ????????? ?????? ??? ??? ????????? ??????.
		if(content.indexOf("src=\"/") == -1) return;
		
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
		String uploadPath = request.getSession().getServletContext().getRealPath("/resources/data/ckeditor/");
		
		int position = 34;
		String nextImg = content.substring(content.indexOf("src=\"/") + position);
		boolean sw =true;
		
		while(sw) {
			String imgFile = nextImg.substring(0,nextImg.indexOf("\""));
			
			System.out.println("???????????? : " + imgFile);
			
			String origFilePath = uploadPath + imgFile;
			System.out.println("???????????? : " + origFilePath);
			String copyFilePath = uploadPath + "rating/" + imgFile;
			
			fileCopyCheck(origFilePath,copyFilePath); // board ????????? ????????? ??????????????? ??????.
			
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
	public void imgDelete(String content) {
		//      0         1         2         3         4         5         6
		//      01234567890123456789012345678901234567890123456789012345678901234567890
		// <img src="/green2209S_18/data/ckeditor/rating/230111121324_green2209J_06.jpg" style="height:967px; width:1337px" /></p>
		// content?????? ??????????????? ??????????????? ????????? ?????? ?????? ????????? ??????.(src="/_____~~)
		if(content.indexOf("src=\"/") == -1) return;
		
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
		String uploadPath = request.getSession().getServletContext().getRealPath("/resources/data/ckeditor/rating/");
		
		int position = 41;
		String nextImg = content.substring(content.indexOf("src=\"/") + position);
		boolean sw = true;
		
		while(sw) {
			String imgFile = nextImg.substring(0, nextImg.indexOf("\""));	// ??????????????? ????????????
			
			String origFilePath = uploadPath + imgFile;
			
			fileDelete(origFilePath);  // board????????? ????????? ??????????????? ??????.
			
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
	public int setRatingInput(RatingVO vo) {
		return orderDAO.setRatingInput(vo);
	}

	@Override
	public void setRaingInputOk(String orderIdx) {
		orderDAO.setRaingInputOk(orderIdx);
	}

	@Override
	public String qrCreate(String memberNickName, String couponName, int discount, String expiration, String realPath) {
		String qrCodeName = "";
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddhhmmss"); 
		UUID uid = UUID.randomUUID(); // ?????? 32??????
		
		String strUid =  "??????????????? : ?????????\n???????????? : " + couponName + "\n" + "????????? : " + memberNickName + "\n" + "???????????? : " + discount + "\n" + "???????????? : " + expiration;
		
//		qrCodeName = sdf.format(new Date()) + "_" + couponName + "_" + memberNickName + "_" + discount + "_" + expiration  + "_"  + strUid;
		qrCodeName = sdf.format(new Date())  + uid.toString().substring(0,8) + ".png";
		
		try {
			File file = new File(realPath);
			if(!file.exists()) file.mkdirs(); // ????????? ????????? ????????? ???????????? ???????????????
			
			String codeFlag  = new String(strUid.getBytes("UTF-8"), "ISO-8859-1");
			
			//qr?????? ?????????
			int qrCodeColor = 0xFF000000; 		// qr ?????? ?????????(?????????)
			int qrCodeBackColor = 0xFFFFFFFF; // qr?????? ?????????
			
			// qe?????? ?????? ??????
		  QRCodeWriter qrCodeWriter = new QRCodeWriter(); // qr?????? ?????? ??????
		  //BitMatrix bitMatrix = qrCodeWriter.encode(codeFlag, BarcodeFormat.QR_CODE, qrCodeColor, qrCodeBackColor);
		  BitMatrix bitMatrix = qrCodeWriter.encode(codeFlag,BarcodeFormat.QR_CODE, 200 , 200);
		  
		  // .??? ??????????????? (?????? ??????)
		  MatrixToImageConfig matrixToImageConfig = new MatrixToImageConfig(qrCodeColor,qrCodeBackColor);
		  
		  // ????????? ????????? qr??????
		  BufferedImage bufferedImage = MatrixToImageWriter.toBufferedImage(bitMatrix,matrixToImageConfig);
		  
		  ImageIO.write(bufferedImage, "png", new File(realPath + qrCodeName));
		} catch (IOException e) {
			e.printStackTrace();
		} catch (WriterException e) {
			e.printStackTrace();
		}
		
		return qrCodeName;
	}

	@Override
	public void setCouponInput(CouponVO pVo) {
		orderDAO.setCouponInput(pVo);
	}

	@Override
	public CouponVO getCheckCoupon(String couponName, String mid) {
		return orderDAO.getCheckCoupon(couponName, mid);
	}

	@Override
	public void setCouponUsed(String sCouponName, String mid) {
		orderDAO.setCouponUsed(sCouponName, mid);
	}

	@Override
	public List<StoreVO> getMostSellStore() {
		return orderDAO.getMostSellStore();
	}

	@Override
	public int setDeleteMember(String mid) {
		return orderDAO.setDeleteMember(mid);
	}

	@Override
	public List<CartVO> getMostSellFood(String foodTag) {
		return orderDAO.getMostSellFood(foodTag);
	}

	@Override
	public List<CartVO> getThisMonthOrderList(String now_date) {
		return orderDAO.getThisMonthOrderList(now_date);
	}

	@Override
	public List<CartVO> getMostOrderStore(String foodTag) {
		return orderDAO.getMostOrderStore(foodTag);
	}

	@Override
	public void setDeleteUpdateMenu(int menuIdx) {
		orderDAO.setDeleteUpdateMenu(menuIdx);
	}

	@Override
	public List<StoreVO> getkategoryCnt() {
		return orderDAO.getkategoryCnt();
	}


	
}
