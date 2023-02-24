package com.spring.green2209S_18.service;

import java.util.List;

import com.spring.green2209S_18.vo.QnaVO;

public interface QnAService {

	public void imgCheck(String content);

	public int setQnAInput(QnaVO vo);

	public List<QnaVO> getMyQnAList(int startIndexNo, int pageSize, String mid);

	public int setQnADelete(int idx);

	public QnaVO getQnAInfo(int idx);

	public void imgDelete(String content);

	public int setQnAUpdateOk(QnaVO vo);

}
