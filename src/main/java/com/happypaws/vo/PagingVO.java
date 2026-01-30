package com.happypaws.vo;

public class PagingVO {
	
	//start: SQL 쿼리에 쓸 offset값
	//nowPage : 현재페이지번호, start:건너띌목록수(offset), totalListCnt: 전체목록수, onePageListCnt : 한페이지에 보여지는 목록수
	//startBtn : 시작페이지번호, endBtn : 한 주기의 마지막페이지번호, lastBtn: 총버튼수(마지막 버튼 번호)
	//viewBtnCnt : 하단에 한 타임씩 보여질 클릭할 수 있는 버튼 수
	private int nowPage, startBtn, endBtn, totalListCnt, onePageListCnt, lastBtn, start;
	private int viewBtnCnt = 5; 
	private String searchCondition;
	private String searchKeyword;
	private String category;
	
	public PagingVO() {}	
	
	public PagingVO(int totalListCnt, int nowPage, int onePageListCnt) {
		setNowPage(nowPage); 
		setTotalListCnt(totalListCnt); 
		setOnePageListCnt(onePageListCnt); 
		calclastBtn(totalListCnt, onePageListCnt); 
		calcStartendBtn(nowPage, viewBtnCnt); 
		calcStartEnd(nowPage, onePageListCnt); 
	}
	
	//총 버튼 수, 마지막 버튼 구하기
	public void calclastBtn(int totalListCnt, int onePageListCnt) { 
		if(totalListCnt % onePageListCnt > 0) {
			setLastBtn(totalListCnt /onePageListCnt+1); 
		} else {
			setLastBtn(totalListCnt /onePageListCnt);
		}
	}
	
	// 시작, 끝 버튼 계산
	public void calcStartendBtn(int nowPage, int viewBtnCnt) { 
		if(lastBtn < viewBtnCnt) {
			setStartBtn(1);
			setEndBtn(lastBtn);
		}else {
			if(viewBtnCnt % 2 == 1) {
				if(nowPage <= (viewBtnCnt/2+1)) {
					setStartBtn(1);
					setEndBtn(viewBtnCnt);
				}else if(nowPage > lastBtn-(viewBtnCnt/2)){
					setStartBtn(lastBtn-(viewBtnCnt-1));
					setEndBtn(lastBtn);
				}else {
					setStartBtn(nowPage - (viewBtnCnt/2));
					setEndBtn(nowPage + (viewBtnCnt/2));
				}
			}else {
				if(nowPage <= (viewBtnCnt/2+1)) {
					setStartBtn(1);
					setEndBtn(viewBtnCnt);
				}else if(nowPage > lastBtn-(viewBtnCnt/2)){
					setStartBtn(lastBtn-(viewBtnCnt-1));
					setEndBtn(lastBtn);
				}else {
					setStartBtn(nowPage - (viewBtnCnt/2));
					setEndBtn(nowPage + (viewBtnCnt/2-1));
				}
			}
		}
	}
	
	// DB 쿼리에서 사용할 start 값 계산
	public void calcStartEnd(int nowPage, int onePageListCnt) { 
		if(nowPage<=1) setStart(0);
		else setStart(nowPage * onePageListCnt - onePageListCnt);
	}
	
	public int getNowPage() {
		return nowPage;
	}

	public void setNowPage(int nowPage) {
		this.nowPage = nowPage;
	}

	public int getStartBtn() {
		return startBtn;
	}

	public void setStartBtn(int startBtn) {
		this.startBtn = startBtn;
	}

	public int getEndBtn() {
		return endBtn;
	}

	public void setEndBtn(int endBtn) {
		this.endBtn = endBtn;
	}

	public int getTotalListCnt() {
		return totalListCnt;
	}

	public void setTotalListCnt(int totalListCnt) {
		this.totalListCnt = totalListCnt;
	}

	public int getOnePageListCnt() {
		return onePageListCnt;
	}

	public void setOnePageListCnt(int onePageListCnt) {
		this.onePageListCnt = onePageListCnt;
	}

	public int getLastBtn() {
		return lastBtn;
	}

	public void setLastBtn(int lastBtn) {
		this.lastBtn = lastBtn;
	}

	public int getStart() {
		return start;
	}

	public void setStart(int start) {
		this.start = start;
	}

	public int getViewBtnCnt() {
		return viewBtnCnt;
	}

	public void setViewBtnCnt(int viewBtnCnt) {
		this.viewBtnCnt = viewBtnCnt;
	}

	public String getSearchCondition() {
		return searchCondition;
	}

	public void setSearchCondition(String searchCondition) {
		this.searchCondition = searchCondition;
	}

	public String getSearchKeyword() {
		return searchKeyword;
	}

	public void setSearchKeyword(String searchKeyword) {
		this.searchKeyword = searchKeyword;
	}

	
	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
	}

	@Override
	public String toString() {
		return "PagingVO [nowPage=" + nowPage + ", startBtn=" + startBtn + ", endBtn=" + endBtn + ", totalListCnt=" + totalListCnt
				+ ", onePageListCnt=" + onePageListCnt + ", lastBtn=" + lastBtn + ", start=" + start + ", viewBtnCnt=" + viewBtnCnt + "]";
	}
}