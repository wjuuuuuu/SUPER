package superPms.vo;

import org.springframework.web.multipart.MultipartFile;

public class Work {
	// 기본
	private int workno;	
	private String regdte;
	private String enddte;
	private String subject;
	private String cont;
	private String id;	
	private int prjno;	
	private String fno;	
	private int hisno;	
	private int Field;	
	private String state;
	// 파일업로드
	private MultipartFile report;
	private String fname;
	// 페이징
	private int cnt;
	
	public Work() {
		super();
		// TODO Auto-generated constructor stub
	}
	public int getWorkno() {
		return workno;
	}
	public void setWorkno(int workno) {
		this.workno = workno;
	}
	public String getRegdte() {
		return regdte;
	}
	public void setRegdte(String regdte) {
		this.regdte = regdte;
	}
	public String getenddte() {
		return enddte;
	}
	public void setenddte(String enddte) {
		this.enddte = enddte;
	}
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public String getCont() {
		return cont;
	}
	public void setCont(String cont) {
		this.cont = cont;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public int getPrjno() {
		return prjno;
	}
	public void setPrjno(int prjno) {
		this.prjno = prjno;
	}
	public String getFno() {
		return fno;
	}
	public void setFno(String fno) {
		this.fno = fno;
	}
	public int getHisno() {
		return hisno;
	}
	public void setHisno(int hisno) {
		this.hisno = hisno;
	}
	public int getField() {
		return Field;
	}
	public void setField(int field) {
		Field = field;
	}
	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
	}
	public String getEnddte() {
		return enddte;
	}
	public void setEnddte(String enddte) {
		this.enddte = enddte;
	}
	public String getFname() {
		return fname;
	}
	public void setFname(String fname) {
		this.fname = fname;
	}
	public MultipartFile getReport() {
		return report;
	}
	public void setReport(MultipartFile report) {
		this.report = report;
	}
	public int getCnt() {
		return cnt;
	}
	public void setCnt(int cnt) {
		this.cnt = cnt;
	}
	
}
