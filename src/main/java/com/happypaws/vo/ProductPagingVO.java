package com.happypaws.vo;

public class ProductPagingVO {
	private int btnCur = 1; 
	private int btnFirst; 
	private int btnLast; 
	private int btnTotalCount; 
	private int btnCurTotal = 5;  
	private int rowTotalCount; 
	private int rowSizePerPage = 6; 
	private int rowFirst; 
	private int rowLast;

	public ProductPagingVO() {}
	
    public ProductPagingVO(ProductPagingVO pv) {
        // 기본값 설정
        this.btnCur = Math.max(1, pv.getBtnCur());  // 현재 페이지는 최소 1
        this.btnCurTotal = pv.getBtnCurTotal();
        this.rowTotalCount = Math.max(0, pv.getRowTotalCount());  // 전체 데이터 수는 최소 0
        this.rowSizePerPage = Math.max(1, pv.getRowSizePerPage());  // 페이지당 데이터 수는 최소 1
        
        // 전체 페이지 수 계산
        this.btnTotalCount = (int) Math.ceil((double) this.rowTotalCount / this.rowSizePerPage);
        
        // 현재 페이지가 전체 페이지 수를 초과하지 않도록 보정
        this.btnCur = Math.min(this.btnCur, this.btnTotalCount);

        // 화면에 표시할 페이지 번호 범위 계산
        int offset = (this.btnCurTotal - 1) / 2;
        this.btnFirst = Math.max(1, this.btnCur - offset);
        this.btnLast = Math.min(this.btnTotalCount, this.btnFirst + this.btnCurTotal - 1);

        // btnFirst 재조정 (btnLast - btnFirst = btnCurTotal - 1 유지)
        this.btnFirst = Math.max(1, this.btnLast - this.btnCurTotal + 1);

        // 데이터 인덱스 계산
        this.rowFirst = Math.max(0, (this.btnCur - 1) * this.rowSizePerPage);
        this.rowLast = Math.min(this.rowFirst + this.rowSizePerPage - 1, this.rowTotalCount - 1);
    }

	public int getBtnCur() {
		return btnCur;
	}

	public void setBtnCur(int btnCur) {
		this.btnCur = btnCur;
	}

	public int getBtnFirst() {
		return btnFirst;
	}

	public void setBtnFirst(int btnFirst) {
		this.btnFirst = btnFirst;
	}

	public int getBtnLast() {
		return btnLast;
	}

	public void setBtnLast(int btnLast) {
		this.btnLast = btnLast;
	}

	public int getBtnTotalCount() {
		return btnTotalCount;
	}

	public void setBtnTotalCount(int btnTotalCount) {
		this.btnTotalCount = btnTotalCount;
	}

	public int getBtnCurTotal() {
		return btnCurTotal;
	}

	public void setBtnCurTotal(int btnCurTotal) {
		this.btnCurTotal = btnCurTotal;
	}

	public int getRowTotalCount() {
		return rowTotalCount;
	}

	public void setRowTotalCount(int rowTotalCount) {
		this.rowTotalCount = rowTotalCount;
	}

	public int getRowSizePerPage() {
		return rowSizePerPage;
	}

	public void setRowSizePerPage(int rowSizePerPage) {
		this.rowSizePerPage = rowSizePerPage;
	}

	public int getRowFirst() {
		return rowFirst;
	}

	public void setRowFirst(int rowFirst) {
		this.rowFirst = rowFirst;
	}

	public int getRowLast() {
		return rowLast;
	}

	public void setRowLast(int rowLast) {
		this.rowLast = rowLast;
	}
}