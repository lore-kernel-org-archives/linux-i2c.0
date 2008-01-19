From: Adam Turk <bofh1234-PkbjNfxxIARBDgjK7y7TUQ@public.gmane.org>
Subject: I2C_PARPORT_LIGHT dependence problem
Date: Sat, 19 Jan 2008 13:37:05 -0500
Message-ID: <BAY101-W29C4113A3B79204F64B0DCC8430@phx.gbl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7621530663535856930=="
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
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

--===============7621530663535856930==
Content-Type: multipart/alternative;
	boundary="_df71bdfe-f173-46cf-9117-bcb9b09c06d5_"

--_df71bdfe-f173-46cf-9117-bcb9b09c06d5_
Content-Type: text/plain; charset="koi8-r"
Content-Transfer-Encoding: quoted-printable


Hello,

I am updating an old config to run on 2.6.23.14 and noticed I am still prom=
pted for I2C_PARPORT_LIGHT even though I don't have the parallel port drive=
r enabled.  Shouldn't I2C_PARPORT_LIGHT depend on the parallel port being s=
elected?  Please email me as I am not subscribed to either list.

Thanks,

Symbol: I2C_PARPORT_LIGHT [=3Dn]
  =81 Prompt: Parallel port adapter (light)
  =81   Defined at drivers/i2c/busses/Kconfig:348
  =81   Depends on: I2C
  =81   Location:
  =81     -> Device Drivers
  =81       -> I2C support (I2C [=3Dm])
  =81         -> I2C Hardware Bus support
  =81   Selects: I2C_ALGOBIT

_________________________________________________________________
Climb to the top of the charts!=9APlay the word scramble challenge with sta=
r power.
http://club.live.com/star_shuffle.aspx?icid=3Dstarshuffle_wlmailtextlink_ja=
n=

--_df71bdfe-f173-46cf-9117-bcb9b09c06d5_
Content-Type: text/html; charset="koi8-r"
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
Hello,<br><br>I am updating an old config to run on 2.6.23.14 and noticed I=
 am still prompted for I2C_PARPORT_LIGHT even though I don't have the paral=
lel port driver enabled.&nbsp; Shouldn't I2C_PARPORT_LIGHT depend on the pa=
rallel port being selected?&nbsp; Please email me as I am not subscribed to=
 either list.<br><br>Thanks,<br><br>Symbol: I2C_PARPORT_LIGHT [=3Dn]<br>&nb=
sp; =81 Prompt: Parallel port adapter (light)<br>&nbsp; =81&nbsp;&nbsp; Def=
ined at drivers/i2c/busses/Kconfig:348<br>&nbsp; =81&nbsp;&nbsp; Depends on=
: I2C<br>&nbsp; =81&nbsp;&nbsp; Location:<br>&nbsp; =81&nbsp;&nbsp;&nbsp;&n=
bsp; -&gt; Device Drivers<br>&nbsp; =81&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 -&gt; I2C support (I2C [=3Dm])<br>&nbsp; =81&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; -&gt; I2C Hardware Bus support<br>&nbsp; =81&nbsp;&nbsp;=
 Selects: I2C_ALGOBIT<br><br /><hr />Climb to the top of the charts!=9APlay=
 the word scramble challenge with star power. <a href=3D'http://club.live.c=
om/star_shuffle.aspx?icid=3Dstarshuffle_wlmailtextlink_jan' target=3D'_new'=
>Play now!</a></body>
</html>=

--_df71bdfe-f173-46cf-9117-bcb9b09c06d5_--


--===============7621530663535856930==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
--===============7621530663535856930==--
