From: <srinivas.ramana-uxC5H9eHYlcAvxtiuMwx3w@public.gmane.org>
Subject: Regd. i2c-dev and SMBALERT#
Date: Tue, 7 Oct 2008 17:00:58 +0530
Message-ID: <34BAE4FA891DCA498C6D46840F4F896F485754@BLR-SJP-MBX01.wipro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1840484092839526117=="
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
Content-class: urn:content-classes:message
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

This is a multi-part message in MIME format.

--===============1840484092839526117==
Content-class: urn:content-classes:message
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C92870.2B875489"

This is a multi-part message in MIME format.

------_=_NextPart_001_01C92870.2B875489
Content-Type: text/plain;
	charset="us-ascii"
content-transfer-encoding: quoted-printable

Hi All,
 
1. I would like to know the advantages and disadvantages of user space
driver for I2C using i2c-dev, compared to the kernel mode drivers.
 
2. What happens if a driver is already bind to the device and
application tries to open/use it using i2c-dev?
 
3. My understanding on SMBALERT# is that it provides the I2C/SMBus
device to interrupt the host.
        a. The driver for SMBALERT# is different from the adapter
driver?
        b. What kind of support is provided for SMBALERT# in current
kernels?
 
Request your help in understanding the above.
 
 
Thanks & Regards,
-- Srinivas R

Please do not print this email unless it is absolutely necessary. =0A=
=0A=
The information contained in this electronic message and any attachments to=
 this message are intended for the exclusive use of the addressee(s) and may=
 contain proprietary, confidential or privileged information. If you are not=
 the intended recipient, you should not disseminate, distribute or copy this=
 e-mail. Please notify the sender immediately and destroy all copies of this=
 message and any attachments. =0A=
=0A=
WARNING: Computer viruses can be transmitted via email. The recipient should=
 check this email and any attachments for the presence of viruses. The compa=
ny accepts no liability for any damage caused by any virus transmitted by th=
is email. =0A=
=0A=
www.wipro.com

------_=_NextPart_001_01C92870.2B875489
Content-Type: text/html;
	charset="us-ascii"
content-transfer-encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; charset=3Dus-ascii">
<META content=3D"MSHTML 6.00.2900.3395" name=3DGENERATOR></HEAD>
<BODY>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D656001811-07102008>Hi 
All,</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN 
class=3D656001811-07102008></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D656001811-07102008>1. I would=
 like to 
know the advantages and disadvantages of user space driver for I2C using 
i2c-dev, compared to the kernel mode drivers.</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN 
class=3D656001811-07102008></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D656001811-07102008>2. What ha=
ppens if a 
driver is already bind to the device and application tries to open/use it us=
ing 
i2c-dev?</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN 
class=3D656001811-07102008></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D656001811-07102008>3. My unde=
rstanding 
on SMBALERT# is that it provides the I2C/SMBus device to interrupt the 
host.</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN 
class=3D656001811-07102008>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; a. The=
 
driver for SMBALERT# is different from the adapter driver?</SPAN></FONT></DI=
V>
<DIV><FONT face=3DArial size=3D2><SPAN 
class=3D656001811-07102008>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; b. Wha=
t kind 
of support is provided for SMBALERT# in current kernels?</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN 
class=3D656001811-07102008></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D656001811-07102008>Request yo=
ur help in 
understanding the&nbsp;above.</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN 
class=3D656001811-07102008></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN 
class=3D656001811-07102008></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D656001811-07102008>Thanks &am=
p; 
Regards,</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D656001811-07102008>-- Sriniva=
s 
R</SPAN></FONT></DIV><P><strong><span style=3D'font-size:10.0pt;font-family:=
=0A=
"Palatino Linotype","serif";color:green'> Please do not print this email unl=
ess it is absolutely necessary. </span></strong><span style=3D'font-family:"=
Arial","sans-serif"'><o:p></o:p></span></p>=0A=
=0A=
=0A=
<p> The information contained in this electronic message and any attachments=
 to this message are intended for the exclusive use of the addressee(s) and=
 may contain proprietary, confidential or privileged information. If you are=
 not the intended recipient, you should not disseminate, distribute or copy=
 this e-mail. Please notify the sender immediately and destroy all copies of=
 this message and any attachments. </p>=0A=
=0A=
<p>WARNING: Computer viruses can be transmitted via email. The recipient sho=
uld check this email and any attachments for the presence of viruses. The co=
mpany accepts no liability for any damage caused by any virus transmitted by=
 this email. </p>=0A=
<p>=0A=
www.wipro.com=0A=
</p>
</BODY></HTML>

------_=_NextPart_001_01C92870.2B875489--


--===============1840484092839526117==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
--===============1840484092839526117==--
