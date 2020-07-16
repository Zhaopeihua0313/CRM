<div style="text-align: center;">
    <ul id="pagination" class="pagination"></ul>
</div>
<script>
    //分页
    $(function(){
        $("#pagination").twbsPagination({
            totalPages : ${result.pages}||1, //总页数
            startPage : ${result.pageNum}||1, //起始页数
            visiblePages : 5, //显示的页数
            first : "首页",
            prev : "上页",
            next : "下页",
            last : "尾页",
            initiateStartPageClick : false,
            onPageClick : function(event,page){ //点击页码执行的操作
            $("#currentPage").val(page);
            $("#searchForm").submit();
        }
    });
    })
</script>