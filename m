From: Wei Liang <weiliang10-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>
Subject: I2C device driver to simutaneously support 2 devices
Date: Wed, 14 May 2008 23:18:46 -0700 (PDT)
Message-ID: <213411.97989.qm@web30304.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2756282725842624599=="
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

--===============2756282725842624599==
Content-Type: multipart/alternative; boundary="0-1960046990-1210832326=:97989"

--0-1960046990-1210832326=:97989
Content-Type: text/plain; charset=us-ascii

Hi,

I received this email address from Gregg Koah-Hartman.  I am writing to seek your advise  on writing a I2C device
driver.  

I am currently writing a device driver based on the sample code by Gregg in Linux Journal (http://www.linuxjournal.com/article/7252).  
I am new to linux device driver development and am currently attempting
to modify the code to enable it to simultaneously support 2 I2C devices
- both devices resides on different addresses.  

I have tried
adding another i2c_add_driver function in 'static int __init
tiny_init(void)' and subsequently reduplicate all functions involved in
registering a
new driver (e.g. static struct i2c_driver, i2c_detect, etc).  However,
the code didn't seem to start.   I have scoured through I2C
documentations in the Linux kernel  and also the book Linux Device Driver (O'Reilly) but have yet to come  across any reference for the above-mentioned task.  

I am hoping that you could provide a few pointers on how best to proceed.  Thanks in advance.

Cheers,
Wei Liang


      
--0-1960046990-1210832326=:97989
Content-Type: text/html; charset=us-ascii

<html><head><style type="text/css"><!-- DIV {margin:0px;} --></style></head><body><div style="font-family:verdana,helvetica,sans-serif;font-size:10pt"><div style="font-family: verdana,helvetica,sans-serif; font-size: 10pt;">Hi,<br><br>I received this email address from Gregg Koah-Hartman.&nbsp; I am writing to seek your advise&nbsp; on writing a I2C device
driver.&nbsp; <br><br>I am currently writing a device driver based on the sample code by Gregg in Linux Journal (<a target="_blank" href="http://www.linuxjournal.com/article/7252"><span class="yshortcuts" id="lw_1210824491_0">http://www.linuxjournal.com/article/7252</span></a>).&nbsp;&nbsp;
I am new to linux device driver development and am currently attempting
to modify the code to enable it to simultaneously support 2 I2C devices
- both devices resides on different addresses.&nbsp; <br><br>I have tried
adding another i2c_add_driver function in 'static int __init
tiny_init(void)' and subsequently reduplicate all functions involved in
registering a
new driver (e.g. static struct i2c_driver, i2c_detect, etc).&nbsp; However,
the code didn't seem to start.&nbsp;&nbsp; I have scoured through I2C
documentations in the Linux kernel&nbsp; and also the book <span style="border-bottom: 1px dashed rgb(0, 102, 204); background: transparent none repeat scroll 0% 50%; cursor: pointer; -moz-background-clip: -moz-initial; -moz-background-origin: -moz-initial; -moz-background-inline-policy: -moz-initial;" class="yshortcuts" id="lw_1210824491_1">Linux</span> Device Driver (O'Reilly) but have yet to come&nbsp; across any reference for the above-mentioned task.&nbsp; <br><br>I am hoping that you could provide a few pointers on how best to proceed.&nbsp; Thanks in advance.<br><br>Cheers,<br>Wei Liang</div></div><br>



      </body></html>
--0-1960046990-1210832326=:97989--


--===============2756282725842624599==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
--===============2756282725842624599==--
