From: badguy development <badguydevelopment-PkbjNfxxIARBDgjK7y7TUQ@public.gmane.org>
Subject: Re: i2c Questions
Date: Thu, 3 Apr 2008 22:39:59 +0000
Message-ID: <BLU106-W43B41606462A4205B13FF0B0F70@phx.gbl>
References: <BLU106-W751DECBB6A8A8CAAE3C71B0FE0@phx.gbl>
	<20080329230927.3b9b47e5@hyperion.delvare>
	<BLU106-W27A7B34F7BE0CC6E2D9B94B0F80@phx.gbl>
	<20080330135409.06f8fd09@hyperion.delvare>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4632141798383613127=="
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080330135409.06f8fd09-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

--===============4632141798383613127==
Content-Type: multipart/alternative;
	boundary="_e7e0fb9f-5326-4026-a311-502bab571097_"

--_e7e0fb9f-5326-4026-a311-502bab571097_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable




> Date: Sun, 30 Mar 2008 13:54:09 +0200
> From: khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org
> To: badguydevelopment-PkbjNfxxIARBDgjK7y7TUQ@public.gmane.org
> CC: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
> Subject: Re: [i2c] i2c Questions
>=20
> Hi Christian,
>=20
> On Sat, 29 Mar 2008 22:58:43 +0000, badguy development wrote:
> > > On Thu, 27 Mar 2008 21:14:53 +0000, badguy development wrote:
> > > > I have to now develop a driver for bus address 0x01
> > > >  and in the code I have located that to be an invalid address.
> > > >=20
> > > > the code tests for address < 0x03 && address > 0x77
> > > > then promptly fails with invalid address.
> > > >=20
> > > > I am hoping to find an understanding for this.
> > > > this is a programmable address, and I will have it changed if I hav=
e to..
> > >=20
> > > Please read the I2C specification. Address 0x01 is for CBUS
> > > compatibility and cannot be used by I2C devices.
> >=20
> >  Thank you for the CBUS tip, that is what lead me to it in the spec.
> >  I guess I will have to continue digging to learn why 0x02 is also disa=
llowed.
>=20
> 0x02 is a bit of mystery to me as well, the specification doesn't
> prohibit its use completely, but you can only use it for devices that
> are compatible with "other protocols" but they don't say which ones.
> 0x03 is mysterious as well, it's reserved for "future purposes" since
> I2C was defined (two dozen years ago.) 0x04-0x07 is for "HS-mode master
> code", whatever it is. 0x08 is used frequently as the SMBus slave
> address, 0x09-0x0b for battery stuff, and 0x0c for SMBus alert
> response. So my advice would be to stay away of the whole 0x00 row. If
> you can program the address, 0x10 would be a sane choice I think, if no
> other device on your system needs it.
>=20

Ok Thanks for the knowledge here.

> > > > Also, I have 3 i2c busses on this iMX31 SOM
> > > >=20
> > > > how can I tell my device to only query / operate on a specific bus.
> > > > do I need to?
> > >=20
> > > The device can only operate on the one bus to which it is connected, =
so
> > > I can't see any problem here.
> > >=20
> >=20
> >  I guess I did not use correct terms there.
> >   What I meant to ask was: how can I tell my device driver to only quer=
y a given bus.
> > but I also guess that is not necessary, and the first bus to respond on=
 that address will be carrying my device.
>=20
> Depends on whether you write a legacy i2c driver (with attach_adapter
> and detach_client methods) or a new-style one (with probe and remove
> methods.)
>=20
> If you write a legacy i2c driver (discouraged), you'll call i2c_probe()
> in your attach_adapter method, and it will call you back only if a
> device is found at the specified address(es). If your device can only
> live at one address and only one bus has a device responding at this
> address, then the driver will only attach to this device on that bus.
> If you are unlucky and you have other devices using the same address on
> the other buses, you have to add some detection code in your i2c_probe
> callback, otherwise your driver will incorrectly attach to the other
> devices. This can be very tricky if the devices don't have
> identification registers.
>=20
> If you write a new-style i2c driver (encouraged), you first number your
> i2c buses, then you explicitly instantiate the i2c devices on the bus
> you know they are connected to. There is no probing or guessing
> involved, you just tell "I have device X on I2C bus N at address A" and
> you're done. Much cleaner, and faster too.
>=20

Well I now plan to write a new style as soon as my test spike code written =
using legacy code is working :)
heh, I am using Kernel 2.6.19.2 is the new style available here?
and if so can you recommend some code I can use for an example?

> > > This is the right list. It would be nice if you could post under your
> > > real name.
> >=20
> >   Thanks, I currently do not have an email that uses my name, its top s=
ecret.
> >   but I can place my name at the end of my messages.
> >=20
> > is this perhaps why I have not recieved confirmation for joining the li=
st?
> > am I disallowed without an email revealing a more realistic name?
>=20
> No, mailman isn't smart enough to check this, and even if it was, there
> would be no point in doing this... Everyone can read the list archive,
> so putting restrictions on who can subscribe to the list would be silly.
>=20
> I have no idea why your subscription did not work. Please try again.
>=20
> > if that is the case I guess I will have to finally create an email acco=
unt using a name :(
>=20
> As far as I am concerned, it's just a matter of politeness. When I
> spend time helping people, I think it's fair that I know their name.
> Not to mention that you won't be able to contribute anything to the
> kernel without a real name.
>=20
> --=20
> Jean Delvare

Thanks for the help.

      -Christian Hunt

_________________________________________________________________
Turn every day into $1000. Learn more at SignInAndWIN.ca
http://g.msn.ca/ca55/213=

--_e7e0fb9f-5326-4026-a311-502bab571097_
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
<br><br>&gt; Date: Sun, 30 Mar 2008 13:54:09 +0200<br>&gt; From: khali@linu=
x-fr.org<br>&gt; To: badguydevelopment-PkbjNfxxIARBDgjK7y7TUQ@public.gmane.org<br>&gt; CC: i2c@lm-senso=
rs.org<br>&gt; Subject: Re: [i2c] i2c Questions<br>&gt; <br>&gt; Hi Christi=
an,<br>&gt; <br>&gt; On Sat, 29 Mar 2008 22:58:43 +0000, badguy development=
 wrote:<br>&gt; &gt; &gt; On Thu, 27 Mar 2008 21:14:53 +0000, badguy develo=
pment wrote:<br>&gt; &gt; &gt; &gt; I have to now develop a driver for bus =
address 0x01<br>&gt; &gt; &gt; &gt;  and in the code I have located that to=
 be an invalid address.<br>&gt; &gt; &gt; &gt; <br>&gt; &gt; &gt; &gt; the =
code tests for address &lt; 0x03 &amp;&amp; address &gt; 0x77<br>&gt; &gt; =
&gt; &gt; then promptly fails with invalid address.<br>&gt; &gt; &gt; &gt; =
<br>&gt; &gt; &gt; &gt; I am hoping to find an understanding for this.<br>&=
gt; &gt; &gt; &gt; this is a programmable address, and I will have it chang=
ed if I have to..<br>&gt; &gt; &gt; <br>&gt; &gt; &gt; Please read the I2C =
specification. Address 0x01 is for CBUS<br>&gt; &gt; &gt; compatibility and=
 cannot be used by I2C devices.<br>&gt; &gt; <br>&gt; &gt;  Thank you for t=
he CBUS tip, that is what lead me to it in the spec.<br>&gt; &gt;  I guess =
I will have to continue digging to learn why 0x02 is also disallowed.<br>&g=
t; <br>&gt; 0x02 is a bit of mystery to me as well, the specification doesn=
't<br>&gt; prohibit its use completely, but you can only use it for devices=
 that<br>&gt; are compatible with "other protocols" but they don't say whic=
h ones.<br>&gt; 0x03 is mysterious as well, it's reserved for "future purpo=
ses" since<br>&gt; I2C was defined (two dozen years ago.) 0x04-0x07 is for =
"HS-mode master<br>&gt; code", whatever it is. 0x08 is used frequently as t=
he SMBus slave<br>&gt; address, 0x09-0x0b for battery stuff, and 0x0c for S=
MBus alert<br>&gt; response. So my advice would be to stay away of the whol=
e 0x00 row. If<br>&gt; you can program the address, 0x10 would be a sane ch=
oice I think, if no<br>&gt; other device on your system needs it.<br>&gt; <=
br><br>Ok Thanks for the knowledge here.<br><br>&gt; &gt; &gt; &gt; Also, I=
 have 3 i2c busses on this iMX31 SOM<br>&gt; &gt; &gt; &gt; <br>&gt; &gt; &=
gt; &gt; how can I tell my device to only query / operate on a specific bus=
.<br>&gt; &gt; &gt; &gt; do I need to?<br>&gt; &gt; &gt; <br>&gt; &gt; &gt;=
 The device can only operate on the one bus to which it is connected, so<br=
>&gt; &gt; &gt; I can't see any problem here.<br>&gt; &gt; &gt; <br>&gt; &g=
t; <br>&gt; &gt;  I guess I did not use correct terms there.<br>&gt; &gt;  =
 What I meant to ask was: how can I tell my device driver to only query a g=
iven bus.<br>&gt; &gt; but I also guess that is not necessary, and the firs=
t bus to respond on that address will be carrying my device.<br>&gt; <br>&g=
t; Depends on whether you write a legacy i2c driver (with attach_adapter<br=
>&gt; and detach_client methods) or a new-style one (with probe and remove<=
br>&gt; methods.)<br>&gt; <br>&gt; If you write a legacy i2c driver (discou=
raged), you'll call i2c_probe()<br>&gt; in your attach_adapter method, and =
it will call you back only if a<br>&gt; device is found at the specified ad=
dress(es). If your device can only<br>&gt; live at one address and only one=
 bus has a device responding at this<br>&gt; address, then the driver will =
only attach to this device on that bus.<br>&gt; If you are unlucky and you =
have other devices using the same address on<br>&gt; the other buses, you h=
ave to add some detection code in your i2c_probe<br>&gt; callback, otherwis=
e your driver will incorrectly attach to the other<br>&gt; devices. This ca=
n be very tricky if the devices don't have<br>&gt; identification registers=
.<br>&gt; <br>&gt; If you write a new-style i2c driver (encouraged), you fi=
rst number your<br>&gt; i2c buses, then you explicitly instantiate the i2c =
devices on the bus<br>&gt; you know they are connected to. There is no prob=
ing or guessing<br>&gt; involved, you just tell "I have device X on I2C bus=
 N at address A" and<br>&gt; you're done. Much cleaner, and faster too.<br>=
&gt; <br><br>Well I now plan to write a new style as soon as my test spike =
code written using legacy code is working :)<br>heh, I am using Kernel 2.6.=
19.2 is the new style available here?<br>and if so can you recommend some c=
ode I can use for an example?<br><br>&gt; &gt; &gt; This is the right list.=
 It would be nice if you could post under your<br>&gt; &gt; &gt; real name.=
<br>&gt; &gt; <br>&gt; &gt;   Thanks, I currently do not have an email that=
 uses my name, its top secret.<br>&gt; &gt;   but I can place my name at th=
e end of my messages.<br>&gt; &gt; <br>&gt; &gt; is this perhaps why I have=
 not recieved confirmation for joining the list?<br>&gt; &gt; am I disallow=
ed without an email revealing a more realistic name?<br>&gt; <br>&gt; No, m=
ailman isn't smart enough to check this, and even if it was, there<br>&gt; =
would be no point in doing this... Everyone can read the list archive,<br>&=
gt; so putting restrictions on who can subscribe to the list would be silly=
.<br>&gt; <br>&gt; I have no idea why your subscription did not work. Pleas=
e try again.<br>&gt; <br>&gt; &gt; if that is the case I guess I will have =
to finally create an email account using a name :(<br>&gt; <br>&gt; As far =
as I am concerned, it's just a matter of politeness. When I<br>&gt; spend t=
ime helping people, I think it's fair that I know their name.<br>&gt; Not t=
o mention that you won't be able to contribute anything to the<br>&gt; kern=
el without a real name.<br>&gt; <br>&gt; -- <br>&gt; Jean Delvare<br><br>Th=
anks for the help.<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -Christian Hunt<br=
><br /><hr />Sign in and you could WIN! Enter for your chance to win $1000 =
every day.  <a href=3D'http://g.msn.ca/ca55/216' target=3D'_new'>Visit Sign=
InAndWIN.ca today to learn more!</a></body>
</html>=

--_e7e0fb9f-5326-4026-a311-502bab571097_--


--===============4632141798383613127==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
--===============4632141798383613127==--
