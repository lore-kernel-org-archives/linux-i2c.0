From: "Mortha, Prakash" <pmortha-UATguYvZg3tBDgjK7y7TUQ@public.gmane.org>
Subject: Re: Question about vt82c596 SMBus driver (Via I2c Bus driver)
Date: Tue, 7 Oct 2008 11:19:46 -0400
Message-ID: <6601CF63C167F44A9A9E97E41EE4B16C903870@CLUSTEREX.corporate.local>
References: <6601CF63C167F44A9A9E97E41EE4B16C902D37@CLUSTEREX.corporate.local><20080926092846.63ac885a@hyperion.delvare><6601CF63C167F44A9A9E97E41EE4B16C90304B@CLUSTEREX.corporate.local><20080930092458.1c40edce@hyperion.delvare><6601CF63C167F44A9A9E97E41EE4B16C903402@CLUSTEREX.corporate.local>
	<20081003152123.489cd10c@hyperion.delvare>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01C92890.22157349"
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
Content-class: urn:content-classes:message
In-Reply-To: <20081003152123.489cd10c-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
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

------_=_NextPart_001_01C92890.22157349
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Jean,

Please find attached the patches I have generated using quilt. Hopefully
this should meet the requirements.  (Please bear with me if this doesn't
meet the requirements, as this is my first time to generate a official
patch).

Thank you once again for your valuable inputs/comments. I tried
implementing all your suggestions, except for the following:

1. I didn't modify the Documentation/i2c/smbus-protocol, as this
document is already talking about the new function that I have worked
on.
2. I had to implicitly have the following lines of code in i2c-viapro.c,
because for process call functionality the bus driver has to be in write
mode initially and then has to switch to Read mode. (With out these
implicit lines of code i2c-viapro bus driver is returning immediately
after write call as per the existing control flow.)
	if ( size =3D=3D VT596_PROC_CALL)
	              read_write =3D I2C_SMBUS_READ;
Please provide your suggestion if I could do it in a better way.

Thanks,
Prakash.

-----Original Message-----
From: Jean Delvare [mailto:khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org]=20
Sent: Friday, October 03, 2008 9:21 AM
To: Mortha, Prakash
Cc: Linux I2C
Subject: Re: Question about vt82c596 SMBus driver (Via I2c Bus driver)

Hi Prakash,

On Wed, 1 Oct 2008 20:09:15 -0400, Mortha, Prakash wrote:
> Hi Jean,
>=20
> Thank you very much for your corrections/advice.
>=20
> Please find attached the patch files for i2c-viapro.c and i2c-core.c
> files for supporting I2C_SMBUS_PROC_CALL.=20

For future patches, please make sure that I can apply them with patch
-p1. The header should look like:

--- linux-2.6.24.3/drivers/i2c/i2c-core.c.orig  2008-02-25
19:20:20.000000000 -0500
+++ linux-2.6.24.3/drivers/i2c/i2c-core.c       2008-10-01
19:48:25.771245369 -0400

If you're working with many patches, I can only recommend using
"quilt", so you always get the patch format right.

>=20
> Please provide your comments.

Comments on the i2c-core patch:

> --- i2c-core.c	2008-02-25 19:20:20.000000000 -0500
> +++
./../../../buildroot/build_i686/linux-2.6.24.3/drivers/i2c/i2c-core.c
2008-10-01 19:48:25.771245369 -0400
> @@ -1274,6 +1274,18 @@
>  }
>  EXPORT_SYMBOL(i2c_smbus_read_word_data);
> =20
> +s32 i2c_smbus_process_call(struct i2c_client *client, u8 command, u16
value)
> +{
> +	union i2c_smbus_data data;
> +	data.word =3D value;
> +	if
(i2c_smbus_xfer(client->adapter,client->addr,client->flags,I2C_SMBUS_WRI
TE,command, I2C_SMBUS_PROC_CALL, &data))

Line too long, you'll have to fold it, and there must be a space after
each comma. I recommend that you run scripts/checkpatch.pl on every
patch before you post them, this will catch formatting errors.

> +		return -1;

All these helper functions have been updated recently to transmit the
error code form i2c_smbus_xfer() instead of -1. Please do the same.
Please look at a recent kernel tree to use the same variable names so
that all the helper functions look the same.

> +	else
> +		return data.word;
> +}
> +EXPORT_SYMBOL(i2c_smbus_process_call);
> +

And please insert the new function _after_ i2c_smbus_write_word_data()
so that the two word functions stay next to each other.

> +
>  s32 i2c_smbus_write_word_data(struct i2c_client *client, u8 command,
u16 value)
>  {
>  	union i2c_smbus_data data;

Documentation/i2c/smbus-protocol will also have to be updated to
mention this new function.

Comments on the i2c-viapro patch:

> --- i2c-viapro.c	2008-10-01 12:19:39.578169020 -0400
> +++
./../../../../buildroot/build_i686/linux-2.6.24.3/drivers/i2c/busses/i2c
-viapro.c	2008-10-01 19:49:02.460538263 -0400
> @@ -82,6 +82,7 @@
>  #define VT596_BYTE		0x04
>  #define VT596_BYTE_DATA		0x08
>  #define VT596_WORD_DATA		0x0C
> +#define VT596_PROC_CALL         0x10

Please use a tabulation instead of spaces.

>  #define VT596_BLOCK_DATA	0x14
>  #define VT596_I2C_BLOCK_DATA	0x34
> =20
> @@ -231,6 +232,12 @@
>  		}
>  		size =3D VT596_WORD_DATA;
>  		break;
> +	case I2C_SMBUS_PROC_CALL:
> +		outb_p(command, SMBHSTCMD);
> +		outb_p((data->word & 0xff00) >> 8, SMBHSTDAT0);
> +		outb_p(data->word & 0xff, SMBHSTDAT1);

As already discussed, the bytes are in the wrong order. The SMBus
specification says that the LSB is always first.

> +		size =3D VT596_PROC_CALL;

I would add:

		read_write =3D I2C_SMBUS_READ;

This way...

> +		break;
>  	case I2C_SMBUS_I2C_BLOCK_DATA:
>  		if (!(vt596_features & FEATURE_I2CBLOCK))
>  			goto exit_unsupported;
> @@ -260,7 +267,7 @@
>  	if (vt596_transaction(size)) /* Error in transaction */
>  		return -1;
> =20
> -	if ((read_write =3D=3D I2C_SMBUS_WRITE) || (size =3D=3D =
VT596_QUICK))
> +	if (((size !=3D VT596_PROC_CALL) && (read_write =3D=3D
I2C_SMBUS_WRITE)) || (size =3D=3D VT596_QUICK))

... you no longer have to change this. This is what i2c-core does for
the software emulation of SMBus over I2C, and some i2c bus drivers as
well.

>  		return 0;
> =20
>  	switch (size) {
> @@ -269,6 +276,7 @@
>  		data->byte =3D inb_p(SMBHSTDAT0);
>  		break;
>  	case VT596_WORD_DATA:
> +	case VT596_PROC_CALL:
>  		data->word =3D inb_p(SMBHSTDAT0) + (inb_p(SMBHSTDAT1) <<
8);
>  		break;
>  	case VT596_I2C_BLOCK_DATA:
> @@ -293,7 +301,7 @@
>  {
>  	u32 func =3D I2C_FUNC_SMBUS_QUICK | I2C_FUNC_SMBUS_BYTE |
>  	    I2C_FUNC_SMBUS_BYTE_DATA | I2C_FUNC_SMBUS_WORD_DATA |
> -	    I2C_FUNC_SMBUS_BLOCK_DATA;
> +	    I2C_FUNC_SMBUS_BLOCK_DATA | I2C_SMBUS_PROC_CALL;

Nitpicking: I'd add I2C_SMBUS_PROC_CALL before
I2C_FUNC_SMBUS_BLOCK_DATA, because this is where readers will expect it.

> =20
>  	if (vt596_features & FEATURE_I2CBLOCK)
>  		func |=3D I2C_FUNC_SMBUS_I2C_BLOCK;

Also note that, in order to apply your patches upstream, I will need
a proper summary, a description of what the patch is doing and why it
is needed, and your Signed-off-by line. See section 12 (Sign your work)
of Documentation/SubmittingPatches for details.

Thanks,
--=20
Jean Delvare

------_=_NextPart_001_01C92890.22157349
Content-Type: application/octet-stream;
	name="series"
Content-Transfer-Encoding: base64
Content-Description: series
Content-Disposition: attachment;
	filename="series"

cGF0Y2gxCnBhdGNoMgo=

------_=_NextPart_001_01C92890.22157349
Content-Type: application/octet-stream;
	name="patch1"
Content-Transfer-Encoding: base64
Content-Description: patch1
Content-Disposition: attachment;
	filename="patch1"

SW5kZXg6IGxpbnV4LTIuNi4yNi9kcml2ZXJzL2kyYy9pMmMtY29yZS5jCj09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KLS0t
IGxpbnV4LTIuNi4yNi5vcmlnL2RyaXZlcnMvaTJjL2kyYy1jb3JlLmMJMjAwOC0xMC0wNyAxMDo0
MToyMi45ODgyMDg4NzQgLTA0MDAKKysrIGxpbnV4LTIuNi4yNi9kcml2ZXJzL2kyYy9pMmMtY29y
ZS5jCTIwMDgtMTAtMDcgMTA6NDE6NDQuNzgxNDY0NTU4IC0wNDAwCkBAIC0xNjc3LDYgKzE2Nzcs
MjggQEAKIEVYUE9SVF9TWU1CT0woaTJjX3NtYnVzX3dyaXRlX3dvcmRfZGF0YSk7CiAKIC8qKgor
ICogaTJjX3NtYnVzX3Byb2Nlc3NfY2FsbCAtIFNNQnVzICJwcm9jZXNzIGNhbGwiIHByb3RvY29s
CisgKiBAY2xpZW50OiBIYW5kbGUgdG8gc2xhdmUgZGV2aWNlCisgKiBAY29tbWFuZDogQnl0ZSBp
bnRlcnByZXRlZCBieSBzbGF2ZQorICogQHZhbHVlOiAxNi1iaXQgIndvcmQiIGJlaW5nIHdyaXR0
ZW4KKyAqCisgKiBUaGlzIGV4ZWN1dGVzIHRoZSBTTUJ1cyAicHJvY2VzcyBjYWxsIiBwcm90b2Nv
bCwgcmV0dXJuaW5nIG5lZ2F0aXZlIGVycm5vCisgKiBlbHNlIGEgMTYtYml0IHVuc2lnbmVkICJ3
b3JkIiByZWNlaXZlZCBmcm9tIHRoZSBkZXZpY2UuCisgKi8KK3MzMiBpMmNfc21idXNfcHJvY2Vz
c19jYWxsKHN0cnVjdCBpMmNfY2xpZW50ICpjbGllbnQsIHU4IGNvbW1hbmQsIHUxNiB2YWx1ZSkK
K3sKKwl1bmlvbiBpMmNfc21idXNfZGF0YSBkYXRhOworCWludCBzdGF0dXM7CisJZGF0YS53b3Jk
ID0gdmFsdWU7CisKKwlzdGF0dXMgPSBpMmNfc21idXNfeGZlcihjbGllbnQtPmFkYXB0ZXIsIGNs
aWVudC0+YWRkciwgY2xpZW50LT5mbGFncywKKwkJCQlJMkNfU01CVVNfV1JJVEUsIGNvbW1hbmQs
CisJCQkJSTJDX1NNQlVTX1BST0NfQ0FMTCwgJmRhdGEpOworCXJldHVybiAoc3RhdHVzIDwgMCkg
PyBzdGF0dXMgOiBkYXRhLndvcmQ7Cit9CitFWFBPUlRfU1lNQk9MKGkyY19zbWJ1c19wcm9jZXNz
X2NhbGwpOworCisvKioKICAqIGkyY19zbWJ1c19yZWFkX2Jsb2NrX2RhdGEgLSBTTUJ1cyAiYmxv
Y2sgcmVhZCIgcHJvdG9jb2wKICAqIEBjbGllbnQ6IEhhbmRsZSB0byBzbGF2ZSBkZXZpY2UKICAq
IEBjb21tYW5kOiBCeXRlIGludGVycHJldGVkIGJ5IHNsYXZlCgogICMgVGhpcyBwYXRjaCBpbXBs
ZW1lbnRzIFNNQnVzIFByb2Nlc3MgQ2FsbCBmdW5jdGlvbmFsaXR5IGluIGkyYy1jb3JlIG1vZHVs
ZS4gCiAgIyBTaWduZWQtb2ZmLWJ5OiBQcmFrYXNoIE1vcnRoYSA8cG1vcnRoYUBlc2NpZW50LmNv
bT4gCgo=

------_=_NextPart_001_01C92890.22157349
Content-Type: application/octet-stream;
	name="patch2"
Content-Transfer-Encoding: base64
Content-Description: patch2
Content-Disposition: attachment;
	filename="patch2"

SW5kZXg6IGxpbnV4LTIuNi4yNi9kcml2ZXJzL2kyYy9idXNzZXMvaTJjLXZpYXByby5jCj09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT0KLS0tIGxpbnV4LTIuNi4yNi5vcmlnL2RyaXZlcnMvaTJjL2J1c3Nlcy9pMmMtdmlhcHJv
LmMJMjAwOC0xMC0wNyAxMDo0MjoyOC44MDgwMDEyODAgLTA0MDAKKysrIGxpbnV4LTIuNi4yNi9k
cml2ZXJzL2kyYy9idXNzZXMvaTJjLXZpYXByby5jCTIwMDgtMTAtMDcgMTA6NDI6NDYuNjUzMDI5
NDc1IC0wNDAwCkBAIC04Miw2ICs4Miw3IEBACiAjZGVmaW5lIFZUNTk2X0JZVEUJCTB4MDQKICNk
ZWZpbmUgVlQ1OTZfQllURV9EQVRBCQkweDA4CiAjZGVmaW5lIFZUNTk2X1dPUkRfREFUQQkJMHgw
QworI2RlZmluZSBWVDU5Nl9QUk9DX0NBTEwJCTB4MTAKICNkZWZpbmUgVlQ1OTZfQkxPQ0tfREFU
QQkweDE0CiAjZGVmaW5lIFZUNTk2X0kyQ19CTE9DS19EQVRBCTB4MzQKIApAQCAtMjMyLDYgKzIz
MywxMiBAQAogCQl9CiAJCXNpemUgPSBWVDU5Nl9XT1JEX0RBVEE7CiAJCWJyZWFrOworIAljYXNl
IEkyQ19TTUJVU19QUk9DX0NBTEw6CisgCQlvdXRiX3AoY29tbWFuZCwgU01CSFNUQ01EKTsKKyAJ
CW91dGJfcChkYXRhLT53b3JkICYgMHhmZiwgU01CSFNUREFUMCk7CisgCQlvdXRiX3AoKGRhdGEt
PndvcmQgJiAweGZmMDApID4+IDgsIFNNQkhTVERBVDEpOworIAkJc2l6ZSA9IFZUNTk2X1BST0Nf
Q0FMTDsKKyAJCWJyZWFrOwogCWNhc2UgSTJDX1NNQlVTX0kyQ19CTE9DS19EQVRBOgogCQlpZiAo
ISh2dDU5Nl9mZWF0dXJlcyAmIEZFQVRVUkVfSTJDQkxPQ0spKQogCQkJZ290byBleGl0X3Vuc3Vw
cG9ydGVkOwpAQCAtMjYyLDYgKzI2OSw5IEBACiAJaWYgKHN0YXR1cykKIAkJcmV0dXJuIHN0YXR1
czsKIAorIAlpZiAoIHNpemUgPT0gVlQ1OTZfUFJPQ19DQUxMKQorIAkJcmVhZF93cml0ZSA9IEky
Q19TTUJVU19SRUFEOworCiAJaWYgKChyZWFkX3dyaXRlID09IEkyQ19TTUJVU19XUklURSkgfHwg
KHNpemUgPT0gVlQ1OTZfUVVJQ0spKQogCQlyZXR1cm4gMDsKIApAQCAtMjcxLDYgKzI4MSw3IEBA
CiAJCWRhdGEtPmJ5dGUgPSBpbmJfcChTTUJIU1REQVQwKTsKIAkJYnJlYWs7CiAJY2FzZSBWVDU5
Nl9XT1JEX0RBVEE6CisJY2FzZSBWVDU5Nl9QUk9DX0NBTEw6CiAJCWRhdGEtPndvcmQgPSBpbmJf
cChTTUJIU1REQVQwKSArIChpbmJfcChTTUJIU1REQVQxKSA8PCA4KTsKIAkJYnJlYWs7CiAJY2Fz
ZSBWVDU5Nl9JMkNfQkxPQ0tfREFUQToKQEAgLTI5NSw3ICszMDYsNyBAQAogewogCXUzMiBmdW5j
ID0gSTJDX0ZVTkNfU01CVVNfUVVJQ0sgfCBJMkNfRlVOQ19TTUJVU19CWVRFIHwKIAkgICAgSTJD
X0ZVTkNfU01CVVNfQllURV9EQVRBIHwgSTJDX0ZVTkNfU01CVVNfV09SRF9EQVRBIHwKLQkgICAg
STJDX0ZVTkNfU01CVVNfQkxPQ0tfREFUQTsKKwkgICAgSTJDX1NNQlVTX1BST0NfQ0FMTCB8IEky
Q19GVU5DX1NNQlVTX0JMT0NLX0RBVEE7CiAKIAlpZiAodnQ1OTZfZmVhdHVyZXMgJiBGRUFUVVJF
X0kyQ0JMT0NLKQogCQlmdW5jIHw9IEkyQ19GVU5DX1NNQlVTX0kyQ19CTE9DSzsKICAjIFRoaXMg
cGF0Y2ggaW1wbGVtZW50cyBTTUJ1cyBQcm9jZXNzIENhbGwgZnVuY3Rpb25hbGl0eSBmb3IgVklB
IGkyYyBidXMgZHJpdmVyLiAgCiAgIyBTaWduZWQtb2ZmLWJ5OiBQcmFrYXNoIE1vcnRoYSA8cG1v
cnRoYUBlc2NpZW50LmNvbT4gCg==

------_=_NextPart_001_01C92890.22157349
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
------_=_NextPart_001_01C92890.22157349--
