From: "Zancada Gonzalez, Jose" <jzancada-JRLKtyB2FXw@public.gmane.org>
Subject: mpc5200B i2c problem
Date: Wed, 26 Mar 2008 09:51:24 +0100
Message-ID: <A669FF5F9E30C8409D252F245ABD8D0A19C4AA@MADARRMAIL2.indra.es>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7946574886427636447=="
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

--===============7946574886427636447==
Content-class: urn:content-classes:message
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C88F1E.927113ED"

This is a multi-part message in MIME format.

------_=_NextPart_001_01C88F1E.927113ED
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hello
We are using I2C to communicate some devices as slaves.=20
We are having errors when doing read/writes, from time to time.
We do not know what is happening. We have attached an osciloscope to the =
hardware lines and have detected some strange things: or the slave =
address was not correct (as if a missing bit ) or the complete sequences =
was not right. It seems that if there is a hardware problem related with =
set-up / hold / rise times, noise signals, etc., but they look ok. We =
have had a look to the file in kernel
/eldk40/usr/src/linux-2.6.16.11/drivers/i2c/busses/i2c-mpc.c
and see some comments into the code related with this problem _SCLCLKFIX
We are new in this kind of linux development and we do not know what to =
do next. This is my first time in mailing list, so I do not know how it =
works, how to consult information related to this problem, or more =
people with the same problem and solved.

The linux enviroment is:
Linux 2.6.16.11 (DENX ELDK 4.1 4.0.0)
mpc5200B
ARCH=3Dppc

Please, if you can help send me any comment. I can send you more details =
if needed.

Thanks in advance,
/jose zancada


------_=_NextPart_001_01C88F1E.927113ED
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Diso-8859-1">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.5.7652.24">
<TITLE>mpc5200B i2c problem</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/plain format -->

<P><FONT SIZE=3D2>Hello<BR>
We are using I2C to communicate some devices as slaves.<BR>
We are having errors when doing read/writes, from time to time.<BR>
We do not know what is happening. We have attached an osciloscope to the =
hardware lines and have detected some strange things: or the slave =
address was not correct (as if a missing bit ) or the complete sequences =
was not right. It seems that if there is a hardware problem related with =
set-up / hold / rise times, noise signals, etc., but they look ok. We =
have had a look to the file in kernel<BR>
/eldk40/usr/src/linux-2.6.16.11/drivers/i2c/busses/i2c-mpc.c<BR>
and see some comments into the code related with this problem =
_SCLCLKFIX<BR>
We are new in this kind of linux development and we do not know what to =
do next. This is my first time in mailing list, so I do not know how it =
works, how to consult information related to this problem, or more =
people with the same problem and solved.<BR>
<BR>
The linux enviroment is:<BR>
Linux 2.6.16.11 (DENX ELDK 4.1 4.0.0)<BR>
mpc5200B<BR>
ARCH=3Dppc<BR>
<BR>
Please, if you can help send me any comment. I can send you more details =
if needed.<BR>
<BR>
Thanks in advance,<BR>
/jose zancada<BR>
<BR>
</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C88F1E.927113ED--


--===============7946574886427636447==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
--===============7946574886427636447==--
