package com.myproject.myproject;

import org.testng.Assert;
import org.testng.annotations.Test;

public class MyAppTest {

    @Test
    public void testLogin1() {
    	MyApp myApp = new MyApp();
        Assert.assertEquals(myApp.userlogin("abc", "abc1234"), 0);
    }

    @Test
    public void testLogin2() {
    	MyApp myApp = new MyApp();
        Assert.assertEquals(myApp.userlogin("abc", "abc@1234"), 1);
    }
}