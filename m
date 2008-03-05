From: pierre demanax <baddemanax-PkbjNfxxIARBDgjK7y7TUQ@public.gmane.org>
Subject: problem reading LM92 and AD7416
Date: Wed, 5 Mar 2008 16:34:59 +0100
Message-ID: <BAY119-W27152207CA3FDC732228BCD2110@phx.gbl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4710585131290154992=="
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
To: "i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org" <i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

--===============4710585131290154992==
Content-Type: multipart/alternative;
	boundary="_95040a7b-a57b-42c7-a91d-1816cd18b58b_"

--_95040a7b-a57b-42c7-a91d-1816cd18b58b_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


Hi all,
=20
I have some trouble in reading temperature value from LM and AD sensors.
I use different i2c bus setup and with all of them i have different results=
.
As interface i use the followings one:
=20

paralelle port ( ELV) one with pull ups of 3k3
i2c-tiny-usb from till harbaum and same pull up value
self made interface using atmega8 (TWI driver) and USB.
=20
I manage having a connection with all of the interfaces, (i2cdetect works a=
nd detect the different sensors), i can read the default register ( nl hyst=
, temp min, temp max...), but once i read the actual temperature i have wie=
rd results:
=20
i used the same sensors with same cables for all of the interfaces :=20
=20

PP : i measure 25=B0
tiny : i measure 27=B0
self made : i measure 30=B0
( my personnal thermometer is showing me 22=B0, i come always to the same v=
alue when i redo the test)
=20
I have those behaviours with all of my sensors and if i change the length o=
f the cables, the temperature also change ( actually it decreases with the =
length).
=20
So as i2c is a digital communication i can't understand why the temperature=
 is so sensitive to interfaces or cable length, as the bus has nothing to d=
o with the sensors ?.
I am stuk, and i don't see what i could do to find the problem.
=20
has someone of you ever been experimenting such a strange behaviour?
=20
what could be the cause of it ?
=20
regards
vincent
_________________________________________________________________
Emmenez vos amis avec vous, gr=E2ce =E0 Messenger sur votre GSM.
http://get.live.com=

--_95040a7b-a57b-42c7-a91d-1816cd18b58b_
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
Hi all,<BR>
&nbsp;<BR>
I have&nbsp;some trouble in reading temperature value from LM and AD sensor=
s.<BR>
I&nbsp;use different i2c bus setup and with all of them i have different re=
sults.<BR>
As interface i use the followings one:<BR>
&nbsp;<BR>
<OL>
<LI>paralelle port ( ELV) one with pull ups of 3k3</LI>
<LI>i2c-tiny-usb from till harbaum and same pull up value</LI>
<LI>self made interface using atmega8 (TWI driver) and USB.</LI></OL>
&nbsp;<BR>
I manage having a connection with all of the interfaces, (i2cdetect works a=
nd detect the different sensors), i can read the default register ( nl hyst=
, temp min, temp max...), but once i read the actual temperature i have wie=
rd results:<BR>
&nbsp;<BR>
i used the same sensors with same cables for all of the interfaces : <BR>
&nbsp;<BR>
<OL>
<LI>PP : i measure 25=B0</LI>
<LI>tiny : i measure 27=B0</LI>
<LI>self made : i measure 30=B0</LI></OL>
( my personnal thermometer is showing me 22=B0, i come always to the same v=
alue when i redo the test)<BR>
&nbsp;<BR>
I have those behaviours with all of my sensors and if i change the length o=
f the cables, the temperature also change ( actually it decreases with the =
length).<BR>
&nbsp;<BR>
So as i2c is a digital communication i can't understand why the temperature=
 is so sensitive to interfaces or cable length, as the bus has nothing to d=
o with the sensors ?.<BR>
I am stuk, and i don't see what i could do to find the problem.<BR>
&nbsp;<BR>
has someone of you ever been experimenting such a strange behaviour?<BR>
&nbsp;<BR>
what could be the cause of it ?<BR>
&nbsp;<BR>
regards<BR>
vincent<BR><br /><hr />Les partager, au lieu de les laisser au fin fond d'u=
n fichier... <a href=3D'http://get.live.com' target=3D'_new'>Qu'allez-vous =
faire de vos photos ? </a></body>
</html>=

--_95040a7b-a57b-42c7-a91d-1816cd18b58b_--


--===============4710585131290154992==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
--===============4710585131290154992==--
