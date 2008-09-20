From: varun mahajan <invincible_6-/E1597aS9LQxFYw1CcD5bw@public.gmane.org>
Subject: New style I2C driver for KXSD9 accelerometer
Date: Sat, 20 Sep 2008 08:51:58 +0530 (IST)
Message-ID: <20125.80062.qm@web7902.mail.in.yahoo.com>
Reply-To: invincible_6-/E1597aS9LQxFYw1CcD5bw@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2695265474166393901=="
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

--===============2695265474166393901==
Content-Type: multipart/alternative; boundary="0-1166582833-1221880918=:80062"

--0-1166582833-1221880918=:80062
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,
=C2=A0
I m implementing a driver for accelerometer KXSD9 in linux kernel 2.6.24.7 =
for OMAP-3430. KXSD9 sensor will be connected to the i2c bus so it will be =
an i2c client.
=C2=A0
I m implementing a new style driver, so following are the steps that I m fo=
llowing:
=C2=A0
1. Putting the device info (busnum, address, irq) in the board specific ini=
tialization code. From this the i2c-core will create a client for my device=
 when the corresponding bus adapter (i2c_adapter) is registered.
=C2=A0
2. I m implementing the following i2c_driver for my device
=C2=A0
struct i2c_driver KXSD9_i2c_driver =3D
{
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .driver =
=3D {
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .name =3D "=
KXSD9_driver",
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 },
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=20
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .probe =
=3D KXSD9_probe, /* this will do the device initialization */
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .remove =
=3D KXSD9_remove,
=C2=A0
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .shutdow=
n =3D KXSD9_shutdown,
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .suspend=
 =3D KXSD9_suspend,
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .resume =
=3D KXSD9_resume,
};
=C2=A0
3. My requirement is that I need to export the file operations (specific io=
ctl commands) to the user space. I am not sure how it has to be done from t=
his driver????
=C2=A0
I thought of the following approach:
Registering a misc device to export the file operations
=C2=A0
int __init KXSD9_driver_init()
{
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*Provide /dev=
 interface to user space and export the file=C2=A0=C2=A0=20
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 op=
erations */
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 misc_register(=
&KXSD9_misc_device);
=C2=A0
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*Request the =
IRQ and install the interrupt handler*/
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 request_irq(..=
 KXSD9_IRQ . .);
=C2=A0
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*Add the i2c_=
driver*/
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 i2c_add_driver=
(&KXSD9_i2c_driver);
}
=C2=A0
Is this the correct way of doing it???????? Or the file operations should b=
e exported using some other method in case of i2c_drivers????
=C2=A0
Your reply will be highly helpful=E2=80=A6 Thanks in advance=E2=80=A6.
=C2=A0
Varun=0A=0A=0A      Download prohibited? No problem. CHAT from any browser,=
 without download. Go to http://in.webmessenger.yahoo.com/
--0-1166582833-1221880918=:80062
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<table cellspacing=3D"0" cellpadding=3D"0" border=3D"0" ><tr><td valign=3D"=
top" style=3D"font: inherit;"><P class=3DMsoNormal style=3D"MARGIN: 0in 0in=
 0pt"><FONT face=3D"Times New Roman" size=3D3>Hi,</FONT></DIV>
<P class=3DMsoNormal style=3D"MARGIN: 0in 0in 0pt"><?xml:namespace prefix =
=3D o ns =3D "urn:schemas-microsoft-com:office:office" /><o:p><FONT face=3D=
"Times New Roman" size=3D3>&nbsp;</FONT></o:p></DIV>
<P class=3DMsoNormal style=3D"MARGIN: 0in 0in 0pt"><FONT face=3D"Times New =
Roman" size=3D3>I m implementing a driver for accelerometer KXSD9 in linux =
kernel 2.6.24.7 for OMAP-3430. KXSD9 sensor will be connected to the i2c bu=
s so it will be an i2c client.</FONT></DIV>
<P class=3DMsoNormal style=3D"MARGIN: 0in 0in 0pt"><o:p><FONT face=3D"Times=
 New Roman" size=3D3>&nbsp;</FONT></o:p></DIV>
<P class=3DMsoNormal style=3D"MARGIN: 0in 0in 0pt"><FONT face=3D"Times New =
Roman" size=3D3>I m implementing a new style driver, so following are the s=
teps that I m following:</FONT></DIV>
<P class=3DMsoNormal style=3D"MARGIN: 0in 0in 0pt"><o:p><FONT face=3D"Times=
 New Roman" size=3D3>&nbsp;</FONT></o:p></DIV>
<P class=3DMsoNormal style=3D"MARGIN: 0in 0in 0pt"><FONT face=3D"Times New =
Roman" size=3D3>1. Putting the device info (busnum, address, irq) in the bo=
ard specific initialization code. From this the i2c-core will create a clie=
nt for my device when the corresponding bus adapter (i2c_adapter) is regist=
ered.</FONT></DIV>
<P class=3DMsoNormal style=3D"MARGIN: 0in 0in 0pt"><o:p><FONT face=3D"Times=
 New Roman" size=3D3>&nbsp;</FONT></o:p></DIV>
<P class=3DMsoNormal style=3D"MARGIN: 0in 0in 0pt"><FONT face=3D"Times New =
Roman" size=3D3>2. I m implementing the following i2c_driver for my device<=
/FONT></DIV>
<P class=3DMsoNormal style=3D"MARGIN: 0in 0in 0pt"><o:p><FONT face=3D"Times=
 New Roman" size=3D3>&nbsp;</FONT></o:p></DIV>
<P class=3DMsoNormal style=3D"MARGIN: 0in 0in 0pt"><FONT face=3D"Times New =
Roman" size=3D3>struct i2c_driver KXSD9_i2c_driver =3D</FONT></DIV>
<P class=3DMsoNormal style=3D"MARGIN: 0in 0in 0pt"><FONT face=3D"Times New =
Roman" size=3D3>{</FONT></DIV>
<P class=3DMsoNormal style=3D"MARGIN: 0in 0in 0pt"><FONT size=3D3><FONT fac=
e=3D"Times New Roman"><SPAN style=3D"mso-tab-count: 1">&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </SPAN>.driver =3D {</FONT><=
/FONT></DIV>
<P class=3DMsoNormal style=3D"MARGIN: 0in 0in 0pt"><FONT size=3D3><FONT fac=
e=3D"Times New Roman"><SPAN style=3D"mso-tab-count: 2">&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </SPAN>.name =3D "KXSD9_driver"=
,</FONT></FONT></DIV>
<P class=3DMsoNormal style=3D"MARGIN: 0in 0in 0pt"><FONT size=3D3><FONT fac=
e=3D"Times New Roman"><SPAN style=3D"mso-tab-count: 1">&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </SPAN>},</FONT></FONT></DIV=
>
<P class=3DMsoNormal style=3D"MARGIN: 0in 0in 0pt"><SPAN style=3D"mso-tab-c=
ount: 1"><FONT face=3D"Times New Roman" size=3D3>&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </FONT></SPAN></DIV>
<P class=3DMsoNormal style=3D"MARGIN: 0in 0in 0pt"><FONT size=3D3><FONT fac=
e=3D"Times New Roman"><SPAN style=3D"mso-tab-count: 1">&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </SPAN>.probe =3D KXSD9_prob=
e, /* this will do the device initialization */</FONT></FONT></DIV>
<P class=3DMsoNormal style=3D"MARGIN: 0in 0in 0pt"><FONT size=3D3><FONT fac=
e=3D"Times New Roman"><SPAN style=3D"mso-tab-count: 1">&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </SPAN>.remove =3D KXSD9_rem=
ove,</FONT></FONT></DIV>
<P class=3DMsoNormal style=3D"MARGIN: 0in 0in 0pt"><o:p><FONT face=3D"Times=
 New Roman" size=3D3>&nbsp;</FONT></o:p></DIV>
<P class=3DMsoNormal style=3D"MARGIN: 0in 0in 0pt"><FONT size=3D3><FONT fac=
e=3D"Times New Roman"><SPAN style=3D"mso-tab-count: 1">&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </SPAN>.shutdown =3D KXSD9_s=
hutdown,</FONT></FONT></DIV>
<P class=3DMsoNormal style=3D"MARGIN: 0in 0in 0pt"><FONT size=3D3><FONT fac=
e=3D"Times New Roman"><SPAN style=3D"mso-tab-count: 1">&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </SPAN>.suspend =3D KXSD9_su=
spend,</FONT></FONT></DIV>
<P class=3DMsoNormal style=3D"MARGIN: 0in 0in 0pt"><FONT size=3D3><FONT fac=
e=3D"Times New Roman"><SPAN style=3D"mso-tab-count: 1">&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </SPAN>.resume =3D KXSD9_res=
ume,</FONT></FONT></DIV>
<P class=3DMsoNormal style=3D"MARGIN: 0in 0in 0pt"><FONT face=3D"Times New =
Roman" size=3D3>};</FONT></DIV>
<P class=3DMsoNormal style=3D"MARGIN: 0in 0in 0pt"><o:p><FONT face=3D"Times=
 New Roman" size=3D3>&nbsp;</FONT></o:p></DIV>
<P class=3DMsoNormal style=3D"MARGIN: 0in 0in 0pt"><FONT face=3D"Times New =
Roman" size=3D3>3. My requirement is that I need to export the file operati=
ons (specific ioctl commands) to the user space. I am not sure how it has t=
o be done from this driver????</FONT></DIV>
<P class=3DMsoNormal style=3D"MARGIN: 0in 0in 0pt"><o:p><FONT face=3D"Times=
 New Roman" size=3D3>&nbsp;</FONT></o:p></DIV>
<P class=3DMsoNormal style=3D"MARGIN: 0in 0in 0pt"><FONT face=3D"Times New =
Roman" size=3D3>I thought of the following approach:</FONT></DIV>
<P class=3DMsoNormal style=3D"MARGIN: 0in 0in 0pt"><FONT face=3D"Times New =
Roman" size=3D3>Registering a misc device to export the file operations</FO=
NT></DIV>
<P class=3DMsoNormal style=3D"MARGIN: 0in 0in 0pt"><o:p><FONT face=3D"Times=
 New Roman" size=3D3>&nbsp;</FONT></o:p></DIV>
<P class=3DMsoNormal style=3D"MARGIN: 0in 0in 0pt"><FONT face=3D"Times New =
Roman" size=3D3>int __init KXSD9_driver_init()</FONT></DIV>
<P class=3DMsoNormal style=3D"MARGIN: 0in 0in 0pt"><FONT face=3D"Times New =
Roman" size=3D3>{</FONT></DIV>
<P class=3DMsoNormal style=3D"MARGIN: 0in 0in 0pt"><FONT size=3D3><FONT fac=
e=3D"Times New Roman"><SPAN style=3D"mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </SPAN>/*Provide /dev interface t=
o user space and export the file<SPAN style=3D"mso-spacerun: yes">&nbsp;&nb=
sp; </SPAN></FONT></FONT></DIV>
<P class=3DMsoNormal style=3D"MARGIN: 0in 0in 0pt"><FONT size=3D3><FONT fac=
e=3D"Times New Roman"><SPAN style=3D"mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </SPAN>operations */<=
/FONT></FONT></DIV>
<P class=3DMsoNormal style=3D"MARGIN: 0in 0in 0pt"><FONT size=3D3><FONT fac=
e=3D"Times New Roman"><SPAN style=3D"mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </SPAN>misc_register(&amp;KXSD9_m=
isc_device);</FONT></FONT></DIV>
<P class=3DMsoNormal style=3D"MARGIN: 0in 0in 0pt"><o:p><FONT face=3D"Times=
 New Roman" size=3D3>&nbsp;</FONT></o:p></DIV>
<P class=3DMsoNormal style=3D"MARGIN: 0in 0in 0pt"><FONT size=3D3><FONT fac=
e=3D"Times New Roman"><SPAN style=3D"mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </SPAN>/*Request the IRQ and inst=
all the interrupt handler*/</FONT></FONT></DIV>
<P class=3DMsoNormal style=3D"MARGIN: 0in 0in 0pt"><FONT size=3D3><FONT fac=
e=3D"Times New Roman"><SPAN style=3D"mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </SPAN>request_irq(.. KXSD9_IRQ .=
 .);</FONT></FONT></DIV>
<P class=3DMsoNormal style=3D"MARGIN: 0in 0in 0pt"><o:p><FONT face=3D"Times=
 New Roman" size=3D3>&nbsp;</FONT></o:p></DIV>
<P class=3DMsoNormal style=3D"MARGIN: 0in 0in 0pt"><FONT size=3D3><FONT fac=
e=3D"Times New Roman"><SPAN style=3D"mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </SPAN>/*Add the i2c_driver*/</FO=
NT></FONT></DIV>
<P class=3DMsoNormal style=3D"MARGIN: 0in 0in 0pt"><FONT size=3D3><FONT fac=
e=3D"Times New Roman"><SPAN style=3D"mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </SPAN>i2c_add_driver(&amp;KXSD9_=
i2c_driver);</FONT></FONT></DIV>
<P class=3DMsoNormal style=3D"MARGIN: 0in 0in 0pt"><FONT face=3D"Times New =
Roman" size=3D3>}</FONT></DIV>
<P class=3DMsoNormal style=3D"MARGIN: 0in 0in 0pt"><o:p><FONT face=3D"Times=
 New Roman" size=3D3>&nbsp;</FONT></o:p></DIV>
<P class=3DMsoNormal style=3D"MARGIN: 0in 0in 0pt"><FONT face=3D"Times New =
Roman" size=3D3>Is this the correct way of doing it???????? Or the file ope=
rations should be exported using some other method in case of i2c_drivers??=
??</FONT></DIV>
<P class=3DMsoNormal style=3D"MARGIN: 0in 0in 0pt"><o:p><FONT face=3D"Times=
 New Roman" size=3D3>&nbsp;</FONT></o:p></DIV>
<P class=3DMsoNormal style=3D"MARGIN: 0in 0in 0pt"><FONT face=3D"Times New =
Roman" size=3D3>Your reply will be highly helpful=E2=80=A6 Thanks in advanc=
e=E2=80=A6.</FONT></DIV>
<P class=3DMsoNormal style=3D"MARGIN: 0in 0in 0pt"><o:p><FONT face=3D"Times=
 New Roman" size=3D3>&nbsp;</FONT></o:p></DIV>
<P class=3DMsoNormal style=3D"MARGIN: 0in 0in 0pt"><FONT face=3D"Times New =
Roman" size=3D3>Varun</FONT></DIV></td></tr></table><br>=0A=0A=0A=0A      <=
!--2--><hr size=3D1></hr> Unlimited freedom, unlimited storage. <a href=3D"=
http://in.rd.yahoo.com/tagline_mail_2/*http://help.yahoo.com/l/in/yahoo/mai=
l/yahoomail/tools/tools-08.html/">Get it now</a>
--0-1166582833-1221880918=:80062--


--===============2695265474166393901==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
--===============2695265474166393901==--
