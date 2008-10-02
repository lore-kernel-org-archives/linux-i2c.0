From: "Mortha, Prakash" <pmortha-UATguYvZg3tBDgjK7y7TUQ@public.gmane.org>
Subject: Re: Question about vt82c596 SMBus driver (Via I2c Bus driver)
Date: Wed, 1 Oct 2008 20:09:15 -0400
Message-ID: <6601CF63C167F44A9A9E97E41EE4B16C903402@CLUSTEREX.corporate.local>
References: <6601CF63C167F44A9A9E97E41EE4B16C902D37@CLUSTEREX.corporate.local><20080926092846.63ac885a@hyperion.delvare><6601CF63C167F44A9A9E97E41EE4B16C90304B@CLUSTEREX.corporate.local>
	<20080930092458.1c40edce@hyperion.delvare>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01C92423.028EBBD1"
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
Content-class: urn:content-classes:message
In-Reply-To: <20080930092458.1c40edce-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
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

------_=_NextPart_001_01C92423.028EBBD1
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable


Hi Jean,

Thank you very much for your corrections/advice.

Please find attached the patch files for i2c-viapro.c and i2c-core.c
files for supporting I2C_SMBUS_PROC_CALL.=20

Please provide your comments.

(FYI, in my test environment I had to swap MSB and LSB bytes while
dealing with I2C_SMBUS_WORD_DATA, I2C_SMBUS_PROC_CALL and
VT596_WORD_DATA/VT596_PROC_CALL, but I didn't do the swap while
generating the patch file to keep the earlier design in-tact.)

Thank you,
Prakash



-----Original Message-----
From: Jean Delvare [mailto:khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org]=20
Sent: Tuesday, September 30, 2008 3:25 AM
To: Mortha, Prakash
Cc: Linux I2C
Subject: Re: Question about vt82c596 SMBus driver (Via I2c Bus driver)

Hi Prakash,

On Mon, 29 Sep 2008 11:49:30 -0400, Mortha, Prakash wrote:
> I found the reason why drivers/i2c/busses/i2c-viapro.c is not
supporting
> I2C_SMBUS_PROC_CALL. The reason I found is as per the data sheet of
Via
> Chip set the "SMBus Command Protocol field" should be set as bits 4-2
in
> "SMBus Host Control" register. But in the function=20
>=20
>       static int vt596_transaction(u8 size)
>=20
> we are setting the "SMBus Command Protocol field" as bits 2-0:
>=20
> outb_p(0x40 | size, SMBHSTCNT); (Line 134 in
> drivers/i2c/busses/i2c-viapro.c)

"size" is supposed to be already shifted at this point. If you look at
the constants:

#define VT596_QUICK		0x00
#define VT596_BYTE		0x04
#define VT596_BYTE_DATA		0x08
#define VT596_WORD_DATA		0x0C
#define VT596_BLOCK_DATA	0x14
#define VT596_I2C_BLOCK_DATA	0x34

They really are (0x0 << 2), (0x1 << 2), (0x2 <<2) etc. Maybe we should
write them that way to make it clearer.

> When I changed the statement to shift the Protocol field by 2 bits
> I2C_SMBUS_PROC_CALL worked and REPEATED START is being generated as
per
> SMBus Process call specification.
>=20
> outb_p(0x40 | (size<<2), SMBHSTCNT);
>=20
> =20
>=20
> Could you please confirm whether the reason I found is valid or not?

No, it's not. Your change just happens to work by accident in your
specific case. But the original code is correct as it is. Please
remember that this driver has been used by thousands of people for many
years now, so it's rather unlikely that the common code paths have such
a huge bug.

> Please find attached the patch I wrote. The Via Motherboard I am using
> is EPIA Ex 1500G. =20

Please use "diff -u" to generate the patch, otherwise it's rather
difficult to read. But your current patch doesn't look correct anyway.
The first thing to do is to introduce a new constant for process call
transactions:

#define VT596_PROC_CALL		0x10

Then in vt596_access() you must set size =3D VT596_PROC_CALL for the
I2C_SMBUS_PROC_CALL case. This is currently missing in your code (you
do not set "size" at all!) and that's the reason why it didn't work.

Also, you must add I2C_SMBUS_PROC_CALL to vt596_func(), otherwise users
do not know that this protocol is supported.

--=20
Jean Delvare

------_=_NextPart_001_01C92423.028EBBD1
Content-Type: application/octet-stream;
	name="i2c-core.patch"
Content-Transfer-Encoding: base64
Content-Description: i2c-core.patch
Content-Disposition: attachment;
	filename="i2c-core.patch"

LS0tIGkyYy1jb3JlLmMJMjAwOC0wMi0yNSAxOToyMDoyMC4wMDAwMDAwMDAgLTA1MDAKKysrIC4v
Li4vLi4vLi4vYnVpbGRyb290L2J1aWxkX2k2ODYvbGludXgtMi42LjI0LjMvZHJpdmVycy9pMmMv
aTJjLWNvcmUuYwkyMDA4LTEwLTAxIDE5OjQ4OjI1Ljc3MTI0NTM2OSAtMDQwMApAQCAtMTI3NCw2
ICsxMjc0LDE4IEBACiB9CiBFWFBPUlRfU1lNQk9MKGkyY19zbWJ1c19yZWFkX3dvcmRfZGF0YSk7
CiAKK3MzMiBpMmNfc21idXNfcHJvY2Vzc19jYWxsKHN0cnVjdCBpMmNfY2xpZW50ICpjbGllbnQs
IHU4IGNvbW1hbmQsIHUxNiB2YWx1ZSkKK3sKKwl1bmlvbiBpMmNfc21idXNfZGF0YSBkYXRhOwor
CWRhdGEud29yZCA9IHZhbHVlOworCWlmIChpMmNfc21idXNfeGZlcihjbGllbnQtPmFkYXB0ZXIs
Y2xpZW50LT5hZGRyLGNsaWVudC0+ZmxhZ3MsSTJDX1NNQlVTX1dSSVRFLGNvbW1hbmQsIEkyQ19T
TUJVU19QUk9DX0NBTEwsICZkYXRhKSkKKwkJcmV0dXJuIC0xOworCWVsc2UKKwkJcmV0dXJuIGRh
dGEud29yZDsKK30KK0VYUE9SVF9TWU1CT0woaTJjX3NtYnVzX3Byb2Nlc3NfY2FsbCk7CisKKwog
czMyIGkyY19zbWJ1c193cml0ZV93b3JkX2RhdGEoc3RydWN0IGkyY19jbGllbnQgKmNsaWVudCwg
dTggY29tbWFuZCwgdTE2IHZhbHVlKQogewogCXVuaW9uIGkyY19zbWJ1c19kYXRhIGRhdGE7Cg==

------_=_NextPart_001_01C92423.028EBBD1
Content-Type: application/octet-stream;
	name="i2c-viapro.patch"
Content-Transfer-Encoding: base64
Content-Description: i2c-viapro.patch
Content-Disposition: attachment;
	filename="i2c-viapro.patch"

LS0tIGkyYy12aWFwcm8uYwkyMDA4LTEwLTAxIDEyOjE5OjM5LjU3ODE2OTAyMCAtMDQwMAorKysg
Li8uLi8uLi8uLi8uLi9idWlsZHJvb3QvYnVpbGRfaTY4Ni9saW51eC0yLjYuMjQuMy9kcml2ZXJz
L2kyYy9idXNzZXMvaTJjLXZpYXByby5jCTIwMDgtMTAtMDEgMTk6NDk6MDIuNDYwNTM4MjYzIC0w
NDAwCkBAIC04Miw2ICs4Miw3IEBACiAjZGVmaW5lIFZUNTk2X0JZVEUJCTB4MDQKICNkZWZpbmUg
VlQ1OTZfQllURV9EQVRBCQkweDA4CiAjZGVmaW5lIFZUNTk2X1dPUkRfREFUQQkJMHgwQworI2Rl
ZmluZSBWVDU5Nl9QUk9DX0NBTEwgICAgICAgICAweDEwCiAjZGVmaW5lIFZUNTk2X0JMT0NLX0RB
VEEJMHgxNAogI2RlZmluZSBWVDU5Nl9JMkNfQkxPQ0tfREFUQQkweDM0CiAKQEAgLTIzMSw2ICsy
MzIsMTIgQEAKIAkJfQogCQlzaXplID0gVlQ1OTZfV09SRF9EQVRBOwogCQlicmVhazsKKwljYXNl
IEkyQ19TTUJVU19QUk9DX0NBTEw6CisJCW91dGJfcChjb21tYW5kLCBTTUJIU1RDTUQpOworCQlv
dXRiX3AoKGRhdGEtPndvcmQgJiAweGZmMDApID4+IDgsIFNNQkhTVERBVDApOworCQlvdXRiX3Ao
ZGF0YS0+d29yZCAmIDB4ZmYsIFNNQkhTVERBVDEpOworCQlzaXplID0gVlQ1OTZfUFJPQ19DQUxM
OworCQlicmVhazsKIAljYXNlIEkyQ19TTUJVU19JMkNfQkxPQ0tfREFUQToKIAkJaWYgKCEodnQ1
OTZfZmVhdHVyZXMgJiBGRUFUVVJFX0kyQ0JMT0NLKSkKIAkJCWdvdG8gZXhpdF91bnN1cHBvcnRl
ZDsKQEAgLTI2MCw3ICsyNjcsNyBAQAogCWlmICh2dDU5Nl90cmFuc2FjdGlvbihzaXplKSkgLyog
RXJyb3IgaW4gdHJhbnNhY3Rpb24gKi8KIAkJcmV0dXJuIC0xOwogCi0JaWYgKChyZWFkX3dyaXRl
ID09IEkyQ19TTUJVU19XUklURSkgfHwgKHNpemUgPT0gVlQ1OTZfUVVJQ0spKQorCWlmICgoKHNp
emUgIT0gVlQ1OTZfUFJPQ19DQUxMKSAmJiAocmVhZF93cml0ZSA9PSBJMkNfU01CVVNfV1JJVEUp
KSB8fCAoc2l6ZSA9PSBWVDU5Nl9RVUlDSykpCiAJCXJldHVybiAwOwogCiAJc3dpdGNoIChzaXpl
KSB7CkBAIC0yNjksNiArMjc2LDcgQEAKIAkJZGF0YS0+Ynl0ZSA9IGluYl9wKFNNQkhTVERBVDAp
OwogCQlicmVhazsKIAljYXNlIFZUNTk2X1dPUkRfREFUQToKKwljYXNlIFZUNTk2X1BST0NfQ0FM
TDoKIAkJZGF0YS0+d29yZCA9IGluYl9wKFNNQkhTVERBVDApICsgKGluYl9wKFNNQkhTVERBVDEp
IDw8IDgpOwogCQlicmVhazsKIAljYXNlIFZUNTk2X0kyQ19CTE9DS19EQVRBOgpAQCAtMjkzLDcg
KzMwMSw3IEBACiB7CiAJdTMyIGZ1bmMgPSBJMkNfRlVOQ19TTUJVU19RVUlDSyB8IEkyQ19GVU5D
X1NNQlVTX0JZVEUgfAogCSAgICBJMkNfRlVOQ19TTUJVU19CWVRFX0RBVEEgfCBJMkNfRlVOQ19T
TUJVU19XT1JEX0RBVEEgfAotCSAgICBJMkNfRlVOQ19TTUJVU19CTE9DS19EQVRBOworCSAgICBJ
MkNfRlVOQ19TTUJVU19CTE9DS19EQVRBIHwgSTJDX1NNQlVTX1BST0NfQ0FMTDsKIAogCWlmICh2
dDU5Nl9mZWF0dXJlcyAmIEZFQVRVUkVfSTJDQkxPQ0spCiAJCWZ1bmMgfD0gSTJDX0ZVTkNfU01C
VVNfSTJDX0JMT0NLOwo=

------_=_NextPart_001_01C92423.028EBBD1
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
------_=_NextPart_001_01C92423.028EBBD1--
