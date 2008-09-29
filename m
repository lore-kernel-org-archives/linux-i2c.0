From: "Mortha, Prakash" <pmortha-UATguYvZg3tBDgjK7y7TUQ@public.gmane.org>
Subject: Re: Question about vt82c596 SMBus driver (Via I2c Bus driver)
Date: Mon, 29 Sep 2008 11:49:30 -0400
Message-ID: <6601CF63C167F44A9A9E97E41EE4B16C90304B@CLUSTEREX.corporate.local>
References: <6601CF63C167F44A9A9E97E41EE4B16C902D37@CLUSTEREX.corporate.local>
	<20080926092846.63ac885a@hyperion.delvare>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01C9224A.D1E71C19"
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
Content-class: urn:content-classes:message
In-Reply-To: <20080926092846.63ac885a-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
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
Cc: Linux I2C <i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C9224A.D1E71C19
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_002_01C9224A.D1E71C19"


------_=_NextPart_002_01C9224A.D1E71C19
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

=20

Hi Jean,

=20

I found the reason why drivers/i2c/busses/i2c-viapro.c is not supporting
I2C_SMBUS_PROC_CALL. The reason I found is as per the data sheet of Via
Chip set the "SMBus Command Protocol field" should be set as bits 4-2 in
"SMBus Host Control" register. But in the function=20

      static int vt596_transaction(u8 size)

we are setting the "SMBus Command Protocol field" as bits 2-0:

outb_p(0x40 | size, SMBHSTCNT); (Line 134 in
drivers/i2c/busses/i2c-viapro.c)

=20

When I changed the statement to shift the Protocol field by 2 bits
I2C_SMBUS_PROC_CALL worked and REPEATED START is being generated as per
SMBus Process call specification.

outb_p(0x40 | (size<<2), SMBHSTCNT);

=20

Could you please confirm whether the reason I found is valid or not?=20

Please find attached the patch I wrote. The Via Motherboard I am using
is EPIA Ex 1500G. =20

=20

=20

Thank you,

Prakash

=20

=20

=20

-----Original Message-----
From: Jean Delvare [mailto:khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org]=20
Sent: Friday, September 26, 2008 3:29 AM
To: Mortha, Prakash
Cc: Linux I2C
Subject: Re: Question about vt82c596 SMBus driver (Via I2c Bus driver)

=20

Hi Prakash,

=20

Removing Kyosti and Mark, who have stepped back long ago, and adding

the i2c mailing list instead, where people may have insight about your

problem.

=20

On Thu, 25 Sep 2008 10:25:50 -0400, Mortha, Prakash wrote:

> I am working with I2c bus driver in Via Ex mother board.

>=20

> I am trying to communicate with Micronas chip (MAP5401) on SMBus.

>=20

> I need to send 1 sub command and 2 bytes of register address and then

> have to read 2 bytes of data. For this to work I am trying to
implement

> I2C_SMBUS_PROC_CALL in function vt596_access() in the file

> drivers/i2c/busses/i2c-viapro.c

>=20

> One of the requirement here is I need to send REPEATED START after

> sending 1 command byte and 2 register address bytes before reading 2

> data bytes. But when I use the logic analyzer I could see that a STOP

> being sent when I expect a REPEATED START.

>=20

> How to I implement SMBus Process Call functionality. Please guide me.

=20

Well, these VIA chips aren't I2C chips where you have full control of

the clock and data lines, but SMBus master chips with a limited set of

commands available. The SMBus Process Call is one of these commands, it

is supposed to be supported by the VIA chips (protocol =3D 0100b). =
Adding

support to the i2c-viapro driver should be trivial.

=20

However, if you did that and the logic analyzer reveals that the VIA

chip doesn't implement the command properly, then this is a hardware

bug and unfortunately there's nothing we can do. This makes me a bit

curious... did you test the other commands with your logic analyzer to

make sure they are correct?

=20

Can you show us the patch you wrote?

=20

What exact VIA chip are you using?

=20

--=20

Jean Delvare


------_=_NextPart_002_01C9224A.D1E71C19
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<meta http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<meta name=3DGenerator content=3D"Microsoft Word 11 (filtered medium)">
<style>
<!--
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:12.0pt;
	font-family:"Times New Roman";}
a:link, span.MsoHyperlink
	{color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{color:purple;
	text-decoration:underline;}
p.MsoPlainText, li.MsoPlainText, div.MsoPlainText
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:10.0pt;
	font-family:"Courier New";}
@page Section1
	{size:8.5in 11.0in;
	margin:1.0in 77.95pt 1.0in 77.95pt;}
div.Section1
	{page:Section1;}
-->
</style>

</head>

<body lang=3DEN-US link=3Dblue vlink=3Dpurple>

<div class=3DSection1>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>Hi Jean,<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>I found the reason why drivers/i2c/busses/i2c-viapro.c is not
supporting I2C_SMBUS_PROC_CALL. The reason I found is as per the data =
sheet of
Via Chip set the &quot;SMBus Command Protocol field&quot; should be set =
as bits
4-2 in &quot;SMBus Host Control&quot; register. But in the function =
<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <i><span =
style=3D'font-style:italic'>static
int vt596_transaction(u8 size)<o:p></o:p></span></i></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>we are setting the &quot;SMBus Command Protocol field&quot; as =
bits
2-0:<o:p></o:p></span></font></p>

<p class=3DMsoPlainText style=3D'text-indent:.5in'><i><font size=3D2
face=3D"Courier New"><span =
style=3D'font-size:10.0pt;font-style:italic'>outb_p(0x40
| size, SMBHSTCNT);</span></font></i> (Line 134 in =
drivers/i2c/busses/i2c-viapro.c)<o:p></o:p></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>When I changed the statement to shift the Protocol field by 2 =
bits I2C_SMBUS_PROC_CALL
worked and REPEATED START is being generated as per SMBus Process call
specification.<o:p></o:p></span></font></p>

<p class=3DMsoPlainText style=3D'text-indent:.5in'><i><font size=3D2
face=3D"Courier New"><span =
style=3D'font-size:10.0pt;font-style:italic'>outb_p(0x40
| (size&lt;&lt;2), SMBHSTCNT);<o:p></o:p></span></font></i></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>Could you please confirm whether the reason I found is valid or =
not? <o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>Please find attached the patch I wrote. The Via Motherboard I am =
using
is </span></font><font face=3DArial><span =
style=3D'font-family:Arial'>EPIA Ex 1500G.
&nbsp;<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>Thank you,<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>Prakash<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>-----Original Message-----<br>
From: Jean Delvare [mailto:khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org] <br>
Sent: Friday, September 26, 2008 3:29 AM<br>
To: Mortha, Prakash<br>
Cc: Linux I2C<br>
Subject: Re: Question about vt82c596 SMBus driver (Via I2c Bus =
driver)</span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>Hi Prakash,<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>Removing Kyosti and Mark, who have stepped back long ago, and =
adding<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>the i2c mailing list instead, where people may have insight =
about your<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>problem.<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>On Thu, 25 Sep 2008 10:25:50 -0400, Mortha, Prakash =
wrote:<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>&gt; I am working with I2c bus driver in Via Ex mother =
board.<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>&gt; <o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>&gt; I am trying to communicate with Micronas chip (MAP5401) on =
SMBus.<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>&gt; <o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>&gt; I need to send 1 sub command and 2 bytes of register =
address and
then<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>&gt; have to read 2 bytes of data. For this to work I am trying =
to
implement<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>&gt; I2C_SMBUS_PROC_CALL in function vt596_access() in the =
file<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>&gt; =
drivers/i2c/busses/i2c-viapro.c<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>&gt; <o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>&gt; One of the requirement here is I need to send REPEATED =
START after<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>&gt; sending 1 command byte and 2 register address bytes before =
reading
2<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>&gt; data bytes. But when I use the logic analyzer I could see =
that a
STOP<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>&gt; being sent when I expect a REPEATED =
START.<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>&gt; <o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>&gt; How to I implement SMBus Process Call functionality. Please =
guide
me.<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>Well, these VIA chips aren't I2C chips where you have full =
control of<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>the clock and data lines, but SMBus master chips with a limited =
set of<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>commands available. The SMBus Process Call is one of these =
commands, it<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>is supposed to be supported by the VIA chips (protocol =3D =
0100b). Adding<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>support to the i2c-viapro driver should be =
trivial.<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>However, if you did that and the logic analyzer reveals that the =
VIA<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>chip doesn't implement the command properly, then this is a =
hardware<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>bug and unfortunately there's nothing we can do. This makes me a =
bit<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>curious... did you test the other commands with your logic =
analyzer to<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>make sure they are correct?<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>Can you show us the patch you =
wrote?<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>What exact VIA chip are you using?<o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>-- <o:p></o:p></span></font></p>

<p class=3DMsoPlainText><font size=3D2 face=3D"Courier New"><span =
style=3D'font-size:
10.0pt'>Jean Delvare<o:p></o:p></span></font></p>

</div>

</body>

</html>

------_=_NextPart_002_01C9224A.D1E71C19--

------_=_NextPart_001_01C9224A.D1E71C19
Content-Type: application/octet-stream;
	name="i2c-viapro.patch"
Content-Transfer-Encoding: base64
Content-Description: i2c-viapro.patch
Content-Disposition: attachment;
	filename="i2c-viapro.patch"

KioqIC4vLi4vLi4vLi4vLi4vLi4vLi4vT3JpZ2luYWxfTGludXhWaWV3L2RyaXZlcnMvaTJjL2J1
c3Nlcy9pMmMtdmlhcHJvLmMJMjAwOC0wMi0yNSAxOToyMDoyMC4wMDAwMDAwMDAgLTA1MDAKLS0t
IGkyYy12aWFwcm8uYwkyMDA4LTA5LTI5IDExOjQwOjMxLjY0Mzg2OTE2NyAtMDQwMAoqKioqKioq
KioqKioqKioKKioqIDE1NiwxNjIgKioqKgogIAl9CiAgCiAgCS8qIFN0YXJ0IHRoZSB0cmFuc2Fj
dGlvbiBieSBzZXR0aW5nIGJpdCA2ICovCiEgCW91dGJfcCgweDQwIHwgc2l6ZSwgU01CSFNUQ05U
KTsKICAKICAJLyogV2Ugd2lsbCBhbHdheXMgd2FpdCBmb3IgYSBmcmFjdGlvbiBvZiBhIHNlY29u
ZCAqLwogIAlkbyB7Ci0tLSAxNTYsMTYyIC0tLS0KICAJfQogIAogIAkvKiBTdGFydCB0aGUgdHJh
bnNhY3Rpb24gYnkgc2V0dGluZyBiaXQgNiAqLwohIAlvdXRiX3AoMHg0MCB8IChzaXplPDwyKSwg
U01CSFNUQ05UKTsKICAKICAJLyogV2Ugd2lsbCBhbHdheXMgd2FpdCBmb3IgYSBmcmFjdGlvbiBv
ZiBhIHNlY29uZCAqLwogIAlkbyB7CioqKioqKioqKioqKioqKgoqKiogMjA3LDIxMyAqKioqCiAg
CQlpbnQgc2l6ZSwgdW5pb24gaTJjX3NtYnVzX2RhdGEgKmRhdGEpCiAgewogIAlpbnQgaTsKISAK
ICAJc3dpdGNoIChzaXplKSB7CiAgCWNhc2UgSTJDX1NNQlVTX1FVSUNLOgogIAkJc2l6ZSA9IFZU
NTk2X1FVSUNLOwotLS0gMjA3LDIxMyAtLS0tCiAgCQlpbnQgc2l6ZSwgdW5pb24gaTJjX3NtYnVz
X2RhdGEgKmRhdGEpCiAgewogIAlpbnQgaTsKISAJCiAgCXN3aXRjaCAoc2l6ZSkgewogIAljYXNl
IEkyQ19TTUJVU19RVUlDSzoKICAJCXNpemUgPSBWVDU5Nl9RVUlDSzsKKioqKioqKioqKioqKioq
CioqKiAyMjMsMjI4ICoqKioKLS0tIDIyMywyMzQgLS0tLQogIAkJCW91dGJfcChkYXRhLT5ieXRl
LCBTTUJIU1REQVQwKTsKICAJCXNpemUgPSBWVDU5Nl9CWVRFX0RBVEE7CiAgCQlicmVhazsKKyAJ
Y2FzZSBJMkNfU01CVVNfUFJPQ19DQUxMOgorIAkJb3V0Yl9wKGNvbW1hbmQsIFNNQkhTVENNRCk7
CisgCQlvdXRiX3AoKGRhdGEtPndvcmQgJiAweGZmMDApID4+IDgsIFNNQkhTVERBVDApOworIAkJ
b3V0Yl9wKGRhdGEtPndvcmQgJiAweGZmLCBTTUJIU1REQVQxKTsKKyAJCXJlYWRfd3JpdGUgPSBJ
MkNfU01CVVNfV1JJVEU7CisgCQlicmVhazsKICAJY2FzZSBJMkNfU01CVVNfV09SRF9EQVRBOgog
IAkJb3V0Yl9wKGNvbW1hbmQsIFNNQkhTVENNRCk7CiAgCQlpZiAocmVhZF93cml0ZSA9PSBJMkNf
U01CVVNfV1JJVEUpIHsKKioqKioqKioqKioqKioqCioqKiAyNjAsMjY1ICoqKioKLS0tIDI2Niwy
NzYgLS0tLQogIAlpZiAodnQ1OTZfdHJhbnNhY3Rpb24oc2l6ZSkpIC8qIEVycm9yIGluIHRyYW5z
YWN0aW9uICovCiAgCQlyZXR1cm4gLTE7CiAgCisgCWlmKHNpemUgPT0gSTJDX1NNQlVTX1BST0Nf
Q0FMTCl7CisgCQlyZWFkX3dyaXRlID0gSTJDX1NNQlVTX1JFQUQ7CisgCQlzaXplID0gVlQ1OTZf
V09SRF9EQVRBOworIAkJfQorIAogIAlpZiAoKHJlYWRfd3JpdGUgPT0gSTJDX1NNQlVTX1dSSVRF
KSB8fCAoc2l6ZSA9PSBWVDU5Nl9RVUlDSykpCiAgCQlyZXR1cm4gMDsKICAKKioqKioqKioqKioq
KioqCioqKiAyNjksMjc1ICoqKioKICAJCWRhdGEtPmJ5dGUgPSBpbmJfcChTTUJIU1REQVQwKTsK
ICAJCWJyZWFrOwogIAljYXNlIFZUNTk2X1dPUkRfREFUQToKISAJCWRhdGEtPndvcmQgPSBpbmJf
cChTTUJIU1REQVQwKSArIChpbmJfcChTTUJIU1REQVQxKSA8PCA4KTsKICAJCWJyZWFrOwogIAlj
YXNlIFZUNTk2X0kyQ19CTE9DS19EQVRBOgogIAljYXNlIFZUNTk2X0JMT0NLX0RBVEE6Ci0tLSAy
ODAsMjg4IC0tLS0KICAJCWRhdGEtPmJ5dGUgPSBpbmJfcChTTUJIU1REQVQwKTsKICAJCWJyZWFr
OwogIAljYXNlIFZUNTk2X1dPUkRfREFUQToKISAJCWRhdGEtPndvcmQgPSBpbmJfcChTTUJIU1RE
QVQwKTsKISAJCWRhdGEtPndvcmQgPSAoZGF0YS0+d29yZCkgPDwgODsKISAJCWRhdGEtPndvcmQg
PSBkYXRhLT53b3JkICsgaW5iX3AoU01CSFNUREFUMSk7CiAgCQlicmVhazsKICAJY2FzZSBWVDU5
Nl9JMkNfQkxPQ0tfREFUQToKICAJY2FzZSBWVDU5Nl9CTE9DS19EQVRBOgo=

------_=_NextPart_001_01C9224A.D1E71C19
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
------_=_NextPart_001_01C9224A.D1E71C19--
