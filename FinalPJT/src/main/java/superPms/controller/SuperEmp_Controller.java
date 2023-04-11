package superPms.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import superPms.service.Alert_Service;
import superPms.service.SuperEmp_Service;
import superPms.vo.DeptCode;
import superPms.vo.PassMail;
import superPms.vo.SuperEmpDept;
import superPms.vo.SuperEmpDeptSch;

@Controller
public class SuperEmp_Controller {
	@Autowired(required=false)
	private SuperEmp_Service service;
	@Autowired
	private Alert_Service alert_service;
	
	// http://localhost:5080/FinalPJT/getEmpList.do
	@RequestMapping("/getEmpList.do")
	public String getEmpList(@ModelAttribute("sch") SuperEmpDept sch,Model d) {
		d.addAttribute("elist2", service.getEmpList(sch));
		return "WEB-INF\\eunbeenView\\empManage.jsp";
	}
	@RequestMapping("/getEmpListPage.do")
	public String getEmpListPage(@ModelAttribute("sch") SuperEmpDeptSch sch, Model d,HttpSession session) {
		SuperEmpDept sObj = (SuperEmpDept)session.getAttribute("emp");
		d.addAttribute("alertList", alert_service.alertList(sObj.getId()));
		d.addAttribute("elist", service.getEmpListPage(sch));
		return "WEB-INF\\eunbeenView\\empManage.jsp";
	}
	
	// 아이디 중복체크 
	// http://localhost:5080/FinalPJT/idChk.do?id=t711txt@gmail.com
	@RequestMapping("/idChk.do")
	public String idChk(@RequestParam("id") String id, Model d) {
		d.addAttribute("idCheck", service.idChk(id));
		return "pageJsonReport";
	}
	@RequestMapping("/cellChk.do")
	public String cellChk(@RequestParam("cell") String cell, Model d) {
		d.addAttribute("cellCheck", service.cellChk(cell));
		return "pageJsonReport";
	}
	@ModelAttribute("getParentDeptCom")
	public List<DeptCode> getParentDeptComb(){
		return service.getParentDeptComb();
	}
	@RequestMapping("insertEmp.do")
	public String insertEmp(SuperEmpDept ins, Model d){
		service.insertEmp(ins);
		d.addAttribute("msg","계정생성 완료!");
	 	return "WEB-INF\\eunbeenView\\empManage.jsp";
	}	
	@GetMapping("/deleteEmp.do")
	public String deleteEmp(@RequestParam("id") String id, Model d) {
		service.deleteEmp(id);
		d.addAttribute("msg", "사원삭제 완료!");
		return "redirect:/getEmpListPage.do";
	}
	@GetMapping("/authSetting.do")
	public String getAuthSetting(@RequestParam("id") String id, Model d,HttpSession session) {
		SuperEmpDept sObj = (SuperEmpDept)session.getAttribute("emp");
		d.addAttribute("alertList", alert_service.alertList(sObj.getId()));
		d.addAttribute("authSet", service.getAuthSetting(id));
		return "WEB-INF\\eunbeenView\\authSetting.jsp";
	}
	
	@ModelAttribute("jobCom")
	public List<String> getJobCom(){
		return service.getJobCom();
	}
	@ModelAttribute("authCom")
	public List<String> getAuthCom(){
		return service.getAuthCom();
	}
	@RequestMapping("/updateEmp.do")
	public String uptEmp(SuperEmpDept upt, Model d,HttpSession session) {
		SuperEmpDept sObj = (SuperEmpDept)session.getAttribute("emp");
		d.addAttribute("alertList", alert_service.alertList(sObj.getId()));
		service.uptEmp(upt);
		// 수정된 이후에 데이터를 로딩 처리
		d.addAttribute("authSet", service.getAuthSetting(upt.getId()));
		return "redirect:/getEmpListPage.do";
	} 
	// 로그인
	// http://localhost:5080/FinalPJT/PMSLogin.do
	// http://49.238.187.241:7080/FinalPJT/PMSLogin.do
	@RequestMapping("/PMSLogin.do")
	public String login(SuperEmpDept e, HttpSession session, Model d) {
		if(session.getAttribute("emp")!=null) {
			session.removeAttribute("emp");
		}
		if(e.getId()==null) {
			return "WEB-INF\\eunbeenView\\login.jsp";
		}else if(service.login(e)==null) {
			d.addAttribute("msg", "아이디와 비밀번호를 확인하세요");
			return "WEB-INF\\eunbeenView\\login.jsp";
		}else {
			d.addAttribute("msg", "로그인 성공");
			// DB에 데이터가 있을 때, 세션 설정
			session.setAttribute("emp", service.login(e));
			return "redirect:/PMSMain.do";
		}
	}
	
	// 로그아웃시 session 종료
//	@RequestMapping("/logout.do")
//	public String logout(HttpSession session) {
//		if(session.getAttribute("emp")!=null) {
//			session.removeAttribute("emp");
//		}
//		return "forward:/PMSLogin.do";
//	}
	@RequestMapping("/userGetEmpList.do")
	public String userGetEmpList(@ModelAttribute("sch") SuperEmpDeptSch sch, Model d,HttpSession session) {
		SuperEmpDept sObj = (SuperEmpDept)session.getAttribute("emp");
		d.addAttribute("alertList", alert_service.alertList(sObj.getId()));
		d.addAttribute("elist", service.getEmpListPage(sch));
		return "WEB-INF\\eunbeenView\\userOrganization.jsp";
	}
	@GetMapping("/myPage.do")
	public String getMyPage(@RequestParam("id") String id, Model d) {
		d.addAttribute("my", service.getAuthSetting(id));
		return "WEB-INF\\eunbeenView\\myInfoUpt.jsp";
	}
	@RequestMapping("/updateMyInfo.do")
	public String updateMyInfo(SuperEmpDept upt, Model d) {
		service.updateMyInfo(upt);
		d.addAttribute("my", service.getAuthSetting(upt.getId()));
		d.addAttribute("msg", "비밀번호 변경 완료");
		return "redirect:/PMSLogin.do";
	} 
	@GetMapping("/forgetPassword.do")
	public String forgetPassword() {
		return "WEB-INF\\eunbeenView\\forgetPassword.jsp";
	}
	@PostMapping("/mailSender.do")
	public String mailSender(PassMail mail, Model d) {
		d.addAttribute("msg",service.sendMail(mail));
		return "WEB-INF\\eunbeenView\\forgetPassword.jsp";
	}
	@PostMapping("/mailSenderNewEmp.do")
	public String mailSenderNewEmp(PassMail mail, Model d) {
		d.addAttribute("msg",service.sendMailNewEmp(mail));
		return "redirect:/getEmpListPage.do";
	}
}
