From: badguy development <badguydevelopment-PkbjNfxxIARBDgjK7y7TUQ@public.gmane.org>
Subject: Re: i2c Questions
Date: Sat, 29 Mar 2008 22:58:43 +0000
Message-ID: <BLU106-W27A7B34F7BE0CC6E2D9B94B0F80@phx.gbl>
References: <BLU106-W751DECBB6A8A8CAAE3C71B0FE0@phx.gbl>
	<20080329230927.3b9b47e5@hyperion.delvare>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4566871569248528507=="
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080329230927.3b9b47e5-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
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

--===============4566871569248528507==
Content-Type: multipart/alternative;
	boundary="_743a0bd8-9c8b-42cd-b7cb-eb38a71849c6_"

--_743a0bd8-9c8b-42cd-b7cb-eb38a71849c6_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable




> Date: Sat, 29 Mar 2008 23:09:27 +0100
> From: khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org
> To: badguydevelopment-PkbjNfxxIARBDgjK7y7TUQ@public.gmane.org
> CC: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
> Subject: Re: [i2c] i2c Questions
>=20
> On Thu, 27 Mar 2008 21:14:53 +0000, badguy development wrote:
> >=20
> > Hello,
> >=20
> >  I am creating 2 i2c drivers.
> >=20
> > I have started a driver for the LTC1760=20
> >  and that one is working and well under way.
> >=20
> > I have to now develop a driver for bus address 0x01
> >  and in the code I have located that to be an invalid address.
> >=20
> > the code tests for address < 0x03 && address > 0x77
> > then promptly fails with invalid address.
> >=20
> > I am hoping to find an understanding for this.
> > this is a programmable address, and I will have it changed if I have to=
.
>=20
> Please read the I2C specification. Address 0x01 is for CBUS
> compatibility and cannot be used by I2C devices.
>=20

 Thank you for the CBUS tip, that is what lead me to it in the spec.
 I guess I will have to continue digging to learn why 0x02 is also disallow=
ed.

> >=20
> > Also, I have 3 i2c busses on this iMX31 SOM
> >=20
> > how can I tell my device to only query / operate on a specific bus.
> > do I need to?
>=20
> The device can only operate on the one bus to which it is connected, so
> I can't see any problem here.
>=20

 I guess I did not use correct terms there.
  What I meant to ask was: how can I tell my device driver to only query a =
given bus.
but I also guess that is not necessary, and the first bus to respond on tha=
t address will be carrying my device.

> >=20
> > and finally where should a noobie to this i2c stuff be asking questions=
 like this?
>=20
> This is the right list. It would be nice if you could post under your
> real name.
>=20

  Thanks, I currently do not have an email that uses my name, its top secre=
t.
  but I can place my name at the end of my messages.

is this perhaps why I have not recieved confirmation for joining the list?
am I disallowed without an email revealing a more realistic name?

if that is the case I guess I will have to finally create an email account =
using a name :(

> >=20
> > Please forward any response to this to my email here:
> > badguydevelopment-PkbjNfxxIARBDgjK7y7TUQ@public.gmane.org
> >=20
> >  I am trying to join the list, but have not received confirmation yet.
> >=20
> > Thanks ahead of time for your wealth of knowledge.
>=20
> --=20
> Jean Delvare

     Christian Hunt


_________________________________________________________________
This Valentine's Day, get creative and show your sweetheart how much you ca=
re with flair! Find fun date ideas here!
http://g.msn.ca/ca55/224=

--_743a0bd8-9c8b-42cd-b7cb-eb38a71849c6_
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
<br><br>&gt; Date: Sat, 29 Mar 2008 23:09:27 +0100<br>&gt; From: khali@linu=
x-fr.org<br>&gt; To: badguydevelopment-PkbjNfxxIARBDgjK7y7TUQ@public.gmane.org<br>&gt; CC: i2c@lm-senso=
rs.org<br>&gt; Subject: Re: [i2c] i2c Questions<br>&gt; <br>&gt; On Thu, 27=
 Mar 2008 21:14:53 +0000, badguy development wrote:<br>&gt; &gt; <br>&gt; &=
gt; Hello,<br>&gt; &gt; <br>&gt; &gt;  I am creating 2 i2c drivers.<br>&gt;=
 &gt; <br>&gt; &gt; I have started a driver for the LTC1760 <br>&gt; &gt;  =
and that one is working and well under way.<br>&gt; &gt; <br>&gt; &gt; I ha=
ve to now develop a driver for bus address 0x01<br>&gt; &gt;  and in the co=
de I have located that to be an invalid address.<br>&gt; &gt; <br>&gt; &gt;=
 the code tests for address &lt; 0x03 &amp;&amp; address &gt; 0x77<br>&gt; =
&gt; then promptly fails with invalid address.<br>&gt; &gt; <br>&gt; &gt; I=
 am hoping to find an understanding for this.<br>&gt; &gt; this is a progra=
mmable address, and I will have it changed if I have to.<br>&gt; <br>&gt; P=
lease read the I2C specification. Address 0x01 is for CBUS<br>&gt; compatib=
ility and cannot be used by I2C devices.<br>&gt; <br><br>&nbsp;Thank you fo=
r the CBUS tip, that is what lead me to it in the spec.<br>&nbsp;I guess I =
will have to continue digging to learn why 0x02 is also disallowed.<br><br>=
&gt; &gt; <br>&gt; &gt; Also, I have 3 i2c busses on this iMX31 SOM<br>&gt;=
 &gt; <br>&gt; &gt; how can I tell my device to only query / operate on a s=
pecific bus.<br>&gt; &gt; do I need to?<br>&gt; <br>&gt; The device can onl=
y operate on the one bus to which it is connected, so<br>&gt; I can't see a=
ny problem here.<br>&gt; <br><br>&nbsp;I guess I did not use correct terms =
there.<br>&nbsp; What I meant to ask was: how can I tell my device driver t=
o only query a given bus.<br>but I also guess that is not necessary, and th=
e first bus to respond on that address will be carrying my device.<br><br>&=
gt; &gt; <br>&gt; &gt; and finally where should a noobie to this i2c stuff =
be asking questions like this?<br>&gt; <br>&gt; This is the right list. It =
would be nice if you could post under your<br>&gt; real name.<br>&gt; <br><=
br>&nbsp; Thanks, I currently do not have an email that uses my name, its t=
op secret.<br>&nbsp; but I can place my name at the end of my messages.<br>=
<br>is this perhaps why I have not recieved confirmation for joining the li=
st?<br>am I disallowed without an email revealing a more realistic name?<br=
><br>if that is the case I guess I will have to finally create an email acc=
ount using a name :(<br><br>&gt; &gt; <br>&gt; &gt; Please forward any resp=
onse to this to my email here:<br>&gt; &gt; badguydevelopment-PkbjNfxxIARBDgjK7y7TUQ@public.gmane.org<b=
r>&gt; &gt; <br>&gt; &gt;  I am trying to join the list, but have not recei=
ved confirmation yet.<br>&gt; &gt; <br>&gt; &gt; Thanks ahead of time for y=
our wealth of knowledge.<br>&gt; <br>&gt; -- <br>&gt; Jean Delvare<br><br>&=
nbsp;&nbsp;&nbsp;&nbsp; Christian Hunt<br><br><br /><hr />Is your lingo str=
ong enough to ace these new word puzzles from Live Search Games?  <a href=
=3D'http://g.msn.ca/ca55/214' target=3D'_new'>Click here to test your vocab=
!</a></body>
</html>=

--_743a0bd8-9c8b-42cd-b7cb-eb38a71849c6_--


--===============4566871569248528507==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
--===============4566871569248528507==--
