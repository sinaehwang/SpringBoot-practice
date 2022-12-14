<%@ page language="java" contentType="text/html; charset=UTF-8"
  pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="게시글 상세페이지"/>
<%@ include file="../common/head.jspf" %>

 <section class="mt-5"  >
    <div class="container mx-auto px-3">
    <div class = "table-box-type-1 ">
  <table class = "table w-full">
  <colgroup>
       <col width="100">
  </colgroup>
    <tbody>
      <tr>
        <th>번호</th>
        <td>${article.id}</td>
       </tr>
      <tr> 
        <th>제목</th>
        <td>${article.title}</td>
      </tr>
      <tr>
        <th>내용</th>
        <td>${article.body}</td>
      </tr>
      <tr>
        <th>작성날짜</th>
        <td>${article.regDate}</td>
      </tr>
      <tr>
        <th>수정날짜</th>
        <td>${article.updateDate}</td>
      </tr>
      <tr>
        <th>작성자</th>
        <td>${article.extra_writerName}</td>
      </tr>
    </tbody>
  </table>
  </div>
  
  <div class="btns mt-5">
      <button class="btn btn-link" type="button" onclick="history.back();">뒤로가기</button>
      <button class="btn btn-link" type="button" onclick="location.href='../home/main' ">HOME</button>
      
      <c:if test="${article.extra__actorCanModify}">
      <a class="btn btn-link ml-2"  href= "../article/modify?id=${article.id}">수정</a>
      </c:if>
      
      <c:if test="${article.extra__actorCanDelete}">
        <a class="btn-text-link ml-2"  onclick="if ( confirm('게시물을 삭제하시겠습니까?') == false ) return false;" href="../article/doDelete?id=${article.id}" >삭제</a>
      </c:if>
  </div>
  
  </div>
 </section>
   

<%@ include file="../common/foot.jspf" %>