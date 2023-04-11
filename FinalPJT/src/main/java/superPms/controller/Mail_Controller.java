package superPms.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import superPms.service.Alert_Service;
import superPms.service.Mail_Service;
import superPms.vo.Mail;
import superPms.vo.MailFile;
import superPms.vo.MailSch;
import superPms.vo.SuperEmpDept;
   
@Controller
public class Mail_Controller {

	@Autowired
	private Mail_Service service;
	@Autowired
	private Alert_Service alert_service;
	@Value("${mail.upload}") 
	private String upload;
	
	// http://localhost:7080/FinalPJT/PMSLogin.do
	// http://49.238.187.241:7080/FinalPJT/PMSLogin.do
	
	//http://localhost:7080/FinalPJT/sendMail.do
	
	@GetMapping("/sendMail.do")
	public String sendMail(HttpSession session,Model d) {   
		SuperEmpDept sObj = (SuperEmpDept)session.getAttribute("emp");
		d.addAttribute("alertList", alert_service.alertList(sObj.getId()));
	   // d.addAttribute("alertCount", alert_service.alertCount(sObj.getId()));
		return "WEB-INF\\suminView\\sendMail.jsp";
	}
	  
	
	@RequestMapping("/sendMail.do")
	public String sendMail(Mail ins,Model d,HttpSession session) {
		service.insSender(ins);
		service.insReceiver(ins);
		SuperEmpDept sObj = (SuperEmpDept)session.getAttribute("emp");
		d.addAttribute("alertList", alert_service.alertList(sObj.getId()));
		d.addAttribute("msg", "메일 전송이 완료되었습니다.");
		
		return "WEB-INF\\suminView\\completeMail.jsp";
	}

	@RequestMapping("/mySendMail.do")
	public String mySendMail(Model d,HttpSession session, @ModelAttribute("sch") MailSch sch) {
		SuperEmpDept sObj = (SuperEmpDept)session.getAttribute("emp");
		sch.setSender(sObj.getId());
		d.addAttribute("mySendMail", service.mySendMail(sch));
		d.addAttribute("alertList", alert_service.alertList(sObj.getId()));
		return "WEB-INF\\suminView\\mySendMail.jsp";
	}
	@RequestMapping("/sendSch.do")
	public String sendSch(Model d,HttpSession session, @ModelAttribute("sch") MailSch sch) {
		SuperEmpDept sObj = (SuperEmpDept)session.getAttribute("emp");
		sch.setSender(sObj.getId());
		d.addAttribute("mySendMail", service.mySendMail(sch));
		d.addAttribute("alertList", alert_service.alertList(sObj.getId()));
		return "WEB-INF\\suminView\\mySendMail.jsp";
	}
	// 전달,답장 메일 보내기
	@RequestMapping("/reMail.do")
	public String reMail(Mail ins,MailFile f,Model d,HttpSession session) {
		service.reMail(ins,f);
		d.addAttribute("msg", "메일 전송이 완료되었습니다.");
		SuperEmpDept sObj = (SuperEmpDept)session.getAttribute("emp");
		d.addAttribute("alertList", alert_service.alertList(sObj.getId()));
		return "WEB-INF\\suminView\\completeMail.jsp";
	}
	@RequestMapping("/sendDetail.do")
	public String sendDetail(@RequestParam("mailno")int mailno,Model d,HttpSession session) {
		SuperEmpDept sObj = (SuperEmpDept)session.getAttribute("emp");
		d.addAttribute("alertList", alert_service.alertList(sObj.getId()));
		d.addAttribute("sendDetail", service.sendDetail(mailno));
		return "WEB-INF\\suminView\\sendDetail.jsp";
	}
	
	@GetMapping("/downloadMail.do")
	public String download(@RequestParam("fname")String fname,Model d) {
		d.addAttribute("downloadFile", fname);
		d.addAttribute("path", upload);
		return "downloadViewer";
	}
	
	@RequestMapping("/myReceiveMail.do")
	public String myReceiveMail(HttpSession session,Model d,@ModelAttribute("sch") MailSch sch) {
		SuperEmpDept sObj = (SuperEmpDept)session.getAttribute("emp");
		d.addAttribute("alertList", alert_service.alertList(sObj.getId()));
		sch.setReceiver(sObj.getId());
		d.addAttribute("myReceiveMail", service.myReceiveMail(sch));
		return "WEB-INF\\suminView\\myReceiveMail.jsp";
	}
	
	@RequestMapping("/receiveDetail.do")
	public String receiveDetail(@RequestParam("mailno")int mailno,Model d,HttpSession session) {
		SuperEmpDept sObj = (SuperEmpDept)session.getAttribute("emp");
		d.addAttribute("alertList", alert_service.alertList(sObj.getId()));
		service.uptSendStateDetail(mailno);
		service.uptReceiveStateDetail(mailno);
		d.addAttribute("receiveDetail", service.receiveDetail(mailno));
		return "WEB-INF\\suminView\\receiveDetail.jsp";
	}
	
	@RequestMapping("/delSendMail.do")
	public String delSendMail(@RequestParam("mailno")String mailno) {

		service.delSendMail(mailno);
		return "redirect:/mySendMail.do";
	}
	
	@RequestMapping("/delReceiveMail.do")
	public String delReceiveMail(@RequestParam("mailno")String  mailno) {
		
		service.delReceiveMail(mailno);
		return "redirect:/myReceiveMail.do";
	}
	@RequestMapping("/uptSendState.do")
	public String uptSendState(@RequestParam("mailno")String mailno) {
		service.uptSendState(mailno);
		service.uptReceiveState(mailno);
		return "redirect:/myReceiveMail.do";
	}
	
	@RequestMapping("/reSendMail.do")
	public String reSendMail(@RequestParam("mailno")int mailno,Model d,HttpSession session) {
		SuperEmpDept sObj = (SuperEmpDept)session.getAttribute("emp");
		d.addAttribute("alertList", alert_service.alertList(sObj.getId()));
		d.addAttribute("reMail", service.sendDetail(mailno));
		d.addAttribute("fname", service.getMailFile(mailno));
		return "WEB-INF\\suminView\\reSendMail.jsp";
	}
	
	@RequestMapping("/replyMail.do")
	public String replyMail(@RequestParam("mailno")int mailno,Model d,HttpSession session) {
		SuperEmpDept sObj = (SuperEmpDept)session.getAttribute("emp");
		d.addAttribute("alertList", alert_service.alertList(sObj.getId()));
		d.addAttribute("reMail", service.receiveDetail(mailno));
		return "WEB-INF\\suminView\\replyMail.jsp";
	}
	
	@RequestMapping("/receiverChkAjax.do")
	public String receiverChkAjax(@RequestParam("receiver")String receiver,Model d,HttpSession session) {
		SuperEmpDept sObj = (SuperEmpDept)session.getAttribute("emp");
		d.addAttribute("alertList", alert_service.alertList(sObj.getId()));
		if(service.receiverChk(receiver)!=null) {
			d.addAttribute("msg", "수신자 확인이 완료되었습니다.");
			d.addAttribute("result", "0");
		}else {
			d.addAttribute("msg", "없는 수신자입니다.");
			d.addAttribute("result", "1");
		}
		
		return "pageJsonReport";
	}
	
}
