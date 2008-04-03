From: badguy development <badguydevelopment-PkbjNfxxIARBDgjK7y7TUQ@public.gmane.org>
Subject: (no subject)
Date: Thu, 3 Apr 2008 22:53:56 +0000
Message-ID: <BLU106-W40FD644DBCDD885A8EAAEFB0F70@phx.gbl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2928147127218244425=="
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

--===============2928147127218244425==
Content-Type: multipart/alternative;
	boundary="_5ba43880-3bab-44bc-99a9-e7a6797ff88e_"

--_5ba43880-3bab-44bc-99a9-e7a6797ff88e_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


Hello,

I am developing a driver for the LTC1760 dual battery charger.

 I have an interrupt occur and I get notification of that.

however I cannot seem to clear the interrupt from inside the ISR and thus I=
 am ruined.



I have learned from the research and looking around I have done, that I can=
not call just any code in an ISR.

the code I want to call will read the AlertResponse register of my LTC1760 =
chip and that will clear the interrupt.



but I get angry kernel response when I do, below is a brief dump of what I =
get:

BUG: scheduling while atomic: swapper/0x00010002/0
bad: scheduling from the idle thread!
Unable to handle kernel NULL pointer dereference at virtual address 0000000=
0
pgd =3D c0004000
[00000000] *pgd=3D00000000
Internal error: Oops: 17 [#1]
Modules linked in: i2c_battery swcamera(PF) clcdc(PF) pvr(PF) gecko_devices
CPU: 0
PC is at dequeue_task+0xc/0xa8
LR is at deactivate_task+0x38/0x44
pc : [<c009b070>]    lr : [<c009b218>]    Tainted: PF
sp : c0331c6c  ip : c0331c80  fp : c0331c7c
r10: 00000000  r9 : 00989642  r8 : b0e7aa00
r7 : c0335f98  r6 : c0331cd8  r5 : 00000001  r4 : c0335f98
r3 : 00000080  r2 : 00000000  r1 : 00000000  r0 : c0335f98
Flags: Nzcv  IRQs off  FIQs on  Mode SVC_32  Segment kernel
Control: C5387F
Table: 868E8000  DAC: 00000017
Process swapper (pid: 0, stack limit =3D 0xc0330250)

All the example code I can find regarding ISR, have access to register offs=
ets and can simply clear the interrupt that way.
I am new to this and am having a hard time finding direction with regards t=
o how to handle linux interrupts.

I need to send a request command out i2c to this device to clear this inter=
rupt.
I am not 100% sure about this, but it is what the data sheet has led me to =
believe.

I would appreciate any help on this, and perhaps even a reference to what m=
aterial I should look at to find this answer.

Thanks ahead of time.

       -Christian Hunt

_________________________________________________________________
Try Chicktionary, a game that tests how many words you can form from the le=
tters given. Find this and more puzzles at Live Search Games!
http://g.msn.ca/ca55/207=

--_5ba43880-3bab-44bc-99a9-e7a6797ff88e_
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
Hello,<br><br>I am developing a driver for the LTC1760 dual battery charger=
.<br><br>&nbsp;I have an interrupt occur and I get notification of that.<br=
>
however I cannot seem to clear the interrupt from inside the ISR and thus I=
 am ruined.<br>
<br>
I have learned from the research and looking around I have done, that I can=
not call just any code in an ISR.<br>
the code I want to call will read the AlertResponse register of my LTC1760 =
chip and that will clear the interrupt.<br>
<br>
but I get angry kernel response when I do, below is a brief dump of what I =
get:<br><br>BUG: scheduling while atomic: swapper/0x00010002/0<br>bad: sche=
duling from the idle thread!<br>Unable to handle kernel NULL pointer derefe=
rence at virtual address 00000000<br>pgd =3D c0004000<br>[00000000] *pgd=3D=
00000000<br>Internal error: Oops: 17 [#1]<br>Modules linked in: i2c_battery=
 swcamera(PF) clcdc(PF) pvr(PF) gecko_devices<br>CPU: 0<br>PC is at dequeue=
_task+0xc/0xa8<br>LR is at deactivate_task+0x38/0x44<br>pc : [&lt;c009b070&=
gt;]&nbsp;&nbsp;&nbsp; lr : [&lt;c009b218&gt;]&nbsp;&nbsp;&nbsp; Tainted: P=
F<br>sp : c0331c6c&nbsp; ip : c0331c80&nbsp; fp : c0331c7c<br>r10: 00000000=
&nbsp; r9 : 00989642&nbsp; r8 : b0e7aa00<br>r7 : c0335f98&nbsp; r6 : c0331c=
d8&nbsp; r5 : 00000001&nbsp; r4 : c0335f98<br>r3 : 00000080&nbsp; r2 : 0000=
0000&nbsp; r1 : 00000000&nbsp; r0 : c0335f98<br>Flags: Nzcv&nbsp; IRQs off&=
nbsp; FIQs on&nbsp; Mode SVC_32&nbsp; Segment kernel<br>Control: C5387F<br>=
Table: 868E8000&nbsp; DAC: 00000017<br>Process swapper (pid: 0, stack limit=
 =3D 0xc0330250)<br><br>All the example code I can find regarding ISR, have=
 access to register offsets and can simply clear the interrupt that way.<br=
>I am new to this and am having a hard time finding direction with regards =
to how to handle linux interrupts.<br><br>I need to send a request command =
out i2c to this device to clear this interrupt.<br>I am not 100% sure about=
 this, but it is what the data sheet has led me to believe.<br><br>I would =
appreciate any help on this, and perhaps even a reference to what material =
I should look at to find this answer.<br><br>Thanks ahead of time.<br><br>&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -Christian Hunt<br><br /><hr />Sign in =
today. When you sign in to Windows Live Messenger you could win $1000 a day=
 until May 12th. <a href=3D'http://g.msn.ca/ca55/209' target=3D'_new'>Learn=
 more at SignInAndWIN.ca</a></body>
</html>=

--_5ba43880-3bab-44bc-99a9-e7a6797ff88e_--


--===============2928147127218244425==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
--===============2928147127218244425==--
