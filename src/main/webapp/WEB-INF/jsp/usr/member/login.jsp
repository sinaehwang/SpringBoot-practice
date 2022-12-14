<%@ page language="java" contentType="text/html; charset=UTF-8"
  pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="로그인"/>
<%@ include file="../common/head.jspf" %>

 <section class="mt-5"  >
    <div class="container mx-auto px-3">
    <form class = "table-box-type-1 " method="POST" action="../member/doLogin">
  <table class = "table w-full">
  <colgroup>
       <col width="200">
  </colgroup>
    <tbody>
      <tr>
        <th>로그인 아이디</th>
        <td><input name = "loginId" class="w-96 input input-bordered" type="text" placeholder="로그인 아이디 "/></td>
       </tr>
      <tr> 
        <th>로그인 비밀번호</th>
        <td><input name = "loginPw" class="w-96 input input-bordered" type="password" placeholder="로그인 비밀번호 "/></td>
      </tr>
      <tr>
        <th>로그인</th>
        <td>
              <button type="submit" class="btn btn-outline btn-primary">로그인</button>
              <button type="button" class="btn btn-outline btn-accent"
                onclick="history.back();">뒤로가기</button>
        </td>
      </tr>
      
    </tbody>
  </table>
  </form>
  
  <div class="btns mt-5">
      <button class="btn btn-link" type="button" onclick="history.back();">뒤로가기</button>
      <button class="btn btn-link" type="button" onclick="location.href='../home/main' ">HOME</button>
      <a class="btn btn-link ml-2"  href= "../article/modify?id=${article.id}">수정</a>
      <c:if test="${article.extra__actorCanDelete}">
        <a onclick="if ( confirm('게시물을 삭제하시겠습니까?') == false ) { return false; }" href="../article/doDelete?id=${article.id}" class="btn-text-link ml-2" >삭제</a>
      </c:if>
  </div>
  
  </div>
 </section>
   

<%@ include file="../common/foot.jspf" %>