From: badguy development <badguydevelopment-PkbjNfxxIARBDgjK7y7TUQ@public.gmane.org>
Subject: i2c Questions
Date: Thu, 27 Mar 2008 21:14:53 +0000
Message-ID: <BLU106-W751DECBB6A8A8CAAE3C71B0FE0@phx.gbl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1358864218315078164=="
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

--===============1358864218315078164==
Content-Type: multipart/alternative;
	boundary="_cb13fcb3-06d5-4fa4-a948-4a69b1585a66_"

--_cb13fcb3-06d5-4fa4-a948-4a69b1585a66_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


Hello,

 I am creating 2 i2c drivers.

I have started a driver for the LTC1760=20
 and that one is working and well under way.

I have to now develop a driver for bus address 0x01
 and in the code I have located that to be an invalid address.

the code tests for address < 0x03 && address > 0x77
then promptly fails with invalid address.

I am hoping to find an understanding for this.
this is a programmable address, and I will have it changed if I have to.

Also, I have 3 i2c busses on this iMX31 SOM

how can I tell my device to only query / operate on a specific bus.
do I need to?

and finally where should a noobie to this i2c stuff be asking questions lik=
e this?

Please forward any response to this to my email here:
badguydevelopment-PkbjNfxxIARBDgjK7y7TUQ@public.gmane.org

 I am trying to join the list, but have not received confirmation yet.

Thanks ahead of time for your wealth of knowledge.




_________________________________________________________________
Sympatico/MSN Autos wants to put YOU in a 2008 Eclipse! Click here to enter=
!
http://g.msn.ca/ca55/212=

--_cb13fcb3-06d5-4fa4-a948-4a69b1585a66_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<style>
.hmmessage P
{
margin:0px;
padding:0px
}
body.hmmessage
{
FONT-SIZE: 10pt;
FONT-FAMILY:Tahoma
}
</style>
</head>
<body class=3D'hmmessage'>
Hello,<br><br>&nbsp;I am creating 2 i2c drivers.<br><br>I have started a dr=
iver for the LTC1760 <br>&nbsp;and that one is working and well under way.<=
br><br>I have to now develop a driver for bus address 0x01<br>&nbsp;and in =
the code I have located that to be an invalid address.<br><br>the code test=
s for address &lt; 0x03 &amp;&amp; address &gt; 0x77<br>then promptly fails=
 with invalid address.<br><br>I am hoping to find an understanding for this=
.<br>this is a programmable address, and I will have it changed if I have t=
o.<br><br>Also, I have 3 i2c busses on this iMX31 SOM<br><br>how can I tell=
 my device to only query / operate on a specific bus.<br>do I need to?<br><=
br>and finally where should a noobie to this i2c stuff be asking questions =
like this?<br><br>Please forward any response to this to my email here:<br>=
badguydevelopment-PkbjNfxxIARBDgjK7y7TUQ@public.gmane.org<br><br>&nbsp;I am trying to join the list, bu=
t have not received confirmation yet.<br><br>Thanks ahead of time for your =
wealth of knowledge.<br><br><br><br><br /><hr />You could win a 2008 Mitsub=
ishi Eclipse from Sympatico / MSN Autos.  <a href=3D'http://g.msn.ca/ca55/2=
10' target=3D'_new'>Hunt for the Total Eclipse NOW!</a></body>
</html>=

--_cb13fcb3-06d5-4fa4-a948-4a69b1585a66_--


--===============1358864218315078164==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
--===============1358864218315078164==--
