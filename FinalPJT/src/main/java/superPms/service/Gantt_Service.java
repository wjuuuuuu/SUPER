package superPms.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import superPms.dao.Gantt_Dao;
import superPms.vo.Gantt;
import superPms.vo.Link;

@Service
public class Gantt_Service {
	@Autowired(required = false)
	private Gantt_Dao dao;
	
	public List<Gantt> showGantt(Gantt g){
		if(g.getOwner()==null) g.setOwner("");
		return dao.showGantt(g);
	}
	public List<Link> showLink(int prjno){
		return dao.showLink(prjno);
	}
	public void insGantt(Gantt ins) {
		if(ins.getOwner()==null) ins.setOwner(" ");
		if(ins.getDescription()==null) ins.setDescription("");
		dao.insGantt(ins);
	}
	public void uptGantt(Gantt upt) {
		if(upt.getDescription()==null) upt.setDescription("");
		dao.uptGantt(upt);
	};
	public void insLink(Link ins) {
		dao.insLink(ins);
	}
	public void delLink(String id) {
		dao.delLink(id);
	};
	public void delGantt(String id) {
		dao.delGantt(id);
	};
	public void delLink2(String gid) {
		dao.delLink2(gid);
	};
	public Gantt getMinMaxDate(int prjno) {
		return dao.getMinMaxDate(prjno);
	};
	public Gantt ganttDetail(Gantt det) {
		return dao.ganttDetail(det);
	};
	public void uptProgress(Gantt upt) {
		 dao.uptProgress(upt);
	};
}
