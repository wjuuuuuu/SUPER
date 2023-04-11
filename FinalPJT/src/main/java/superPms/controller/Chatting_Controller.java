package superPms.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import superPms.service.Alert_Service;
import superPms.service.ChatHandler;
import superPms.vo.SuperEmpDept;


@Controller
public class Chatting_Controller {
	@Autowired
	private Alert_Service alert_service;
	
	
	@Autowired
	private ChatHandler chHandl;
	// http://localhost:2030/FinalPJT/chatting.do
	@RequestMapping("chatting.do")
	public String chatting(Model d, HttpSession session) {
		// a07_chattingForm.jsp
		SuperEmpDept sObj = (SuperEmpDept)session.getAttribute("emp");
		d.addAttribute("alertList", alert_service.alertList(sObj.getId()));
		return "WEB-INF\\minwooView\\chatting.jsp";
	}
	
	// /chGroup.do
	@GetMapping("chGroup.do")
	public String chGroup(Model d) {
		d.addAttribute("group", chHandl.getIdx());
		return "pageJsonReport";
	}
}
