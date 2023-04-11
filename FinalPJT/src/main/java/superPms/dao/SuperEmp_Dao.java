package superPms.dao;

import java.util.List;

import superPms.vo.DeptCode;
import superPms.vo.DeptSch;
import superPms.vo.SuperEmpDept;
import superPms.vo.SuperEmpDeptSch;


public interface SuperEmp_Dao {
	public List<SuperEmpDept> getEmpList(SuperEmpDept sch);
	public SuperEmpDept idChk(String id); // 이메일 중복체크
	public SuperEmpDept cellChk(String cell); // 핸드폰번호 중복체크
	public void insertEmp(SuperEmpDept ins);
	public void deleteEmp(String id);
	public List<DeptCode> getParentDeptComb();
	public SuperEmpDept getAuthSetting(String id);
	public List<String> getJobCom(); // 직책 콤보박스
	public List<String> getAuthCom(); // 권한 콤보박스
	public void uptEmp(SuperEmpDept upt);
	public SuperEmpDept login(SuperEmpDept se); //로그인 
	public void updateMyInfo(SuperEmpDept upt);
	public List<SuperEmpDept> getEmpListPage(SuperEmpDeptSch sch);
	public int empTot(SuperEmpDeptSch sch);


}
