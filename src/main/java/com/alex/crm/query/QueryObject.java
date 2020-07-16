package com.alex.crm.query;

import lombok.Getter;
import lombok.Setter;

//用来封装用户传递过来的参数
//通用的查询对象
@Getter
@Setter
public class QueryObject {

	private int currentPage = 1; //当前页
	private int pageSize = 3; //每页显示条数

}
