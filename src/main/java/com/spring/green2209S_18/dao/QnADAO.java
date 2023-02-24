package com.spring.green2209S_18.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.green2209S_18.vo.QnaVO;

public interface QnADAO {

	public int setQnAInput(@Param("vo") QnaVO vo);

	public List<QnaVO> getMyQnAList(@Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize, @Param("mid") String mid);

	public int totQnAListCnt(@Param("mid") String search,@Param("searchString")  String searchString);

	public int setQnADelete(@Param("idx") int idx);

	public QnaVO getQnAInfo(@Param("idx") int idx);

	public int setQnAUpdateOk(@Param("vo") QnaVO vo);

}
