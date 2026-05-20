<%-- サイドバー --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<nav class="sidebar">
    <ul class="sidebar-nav">

        <li class="sidebar-item">
            <a href="Menu.action" class="sidebar-link sidebar-link--home">メニュー</a>
        </li>

        <li class="sidebar-sep"></li>

        <li class="sidebar-item">
            <a href="StudentList.action" class="sidebar-link">学生管理</a>
        </li>

        <li class="sidebar-group-label"><span>成績管理</span></li>

        <li class="sidebar-item sidebar-item--sub">
            <a href="TestRegist.action" class="sidebar-link sidebar-link--sub">成績登録</a>
        </li>
        <li class="sidebar-item sidebar-item--sub">
            <a href="TestList.action" class="sidebar-link sidebar-link--sub">成績参照</a>
        </li>

        <li class="sidebar-sep"></li>

        <li class="sidebar-item">
            <a href="SubjectList.action" class="sidebar-link">科目管理</a>
        </li>
        <li class="sidebar-item">
            <a href="ClassList.action" class="sidebar-link">クラス管理</a>
        </li>

    </ul>
</nav>
