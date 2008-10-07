From: "Mortha, Prakash" <pmortha-UATguYvZg3tBDgjK7y7TUQ@public.gmane.org>
Subject: Re: Question about vt82c596 SMBus driver (Via I2c Bus driver)
Date: Tue, 7 Oct 2008 17:02:36 -0400
Message-ID: <6601CF63C167F44A9A9E97E41EE4B16C903934@CLUSTEREX.corporate.local>
References: <6601CF63C167F44A9A9E97E41EE4B16C902D37@CLUSTEREX.corporate.local><20080926092846.63ac885a@hyperion.delvare><6601CF63C167F44A9A9E97E41EE4B16C90304B@CLUSTEREX.corporate.local><20080930092458.1c40edce@hyperion.delvare><6601CF63C167F44A9A9E97E41EE4B16C903402@CLUSTEREX.corporate.local><20081003152123.489cd10c@hyperion.delvare><6601CF63C167F44A9A9E97E41EE4B16C903870@CLUSTEREX.corporate.local>
	<20081007220010.1ac00ad1@hyperion.delvare>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01C928C0.069EF3F9"
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
Content-class: urn:content-classes:message
In-Reply-To: <20081007220010.1ac00ad1-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
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

------_=_NextPart_001_01C928C0.069EF3F9
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Jean,

Here is my Signed-off-by line:
Signed-off-by: Prakash Mortha <pmortha-UATguYvZg3tBDgjK7y7TUQ@public.gmane.org>

I tried to include this in the patch files too, but please modify it as
needed.

(This time also I am sending the patches as attachment as quilt send is
not working for me here - needs to configure mail transfer agent and
still trying to set it right).

Thanks a lot,
Prakash

-----Original Message-----
From: Jean Delvare [mailto:khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org]=20
Sent: Tuesday, October 07, 2008 4:00 PM
To: Mortha, Prakash
Cc: Linux I2C
Subject: Re: Question about vt82c596 SMBus driver (Via I2c Bus driver)

Hi Prakash,

On Tue, 7 Oct 2008 11:19:46 -0400, Mortha, Prakash wrote:
> Please find attached the patches I have generated using quilt.
Hopefully
> this should meet the requirements.  (Please bear with me if this
doesn't
> meet the requirements, as this is my first time to generate a official
> patch).

The patches meet the technical requirements, in that I was able to
apply them. However they are missing a proper subject and description,
as well as your Signed-off-by line. Again, please see section 12 (Sign
your work) of Documentation/SubmittingPatches for what it means.

For example, the header of your first patch could be something like:

* * * * *
From: Prakash Mortha <pmortha-UATguYvZg3tBDgjK7y7TUQ@public.gmane.org>
Subject: i2c: Restore i2c_smbus_process_call function

Restore the i2c_smbus_process_call() as one driver (for the
Micronas MAP5401) will need it soon.
* * * * *

And then would come your Signed-off-by line. For your first
contribution, I want to make it easy for you and I'll be adding the
subject and description myself, but I _need_ your Signed-off-by line
before I can push both patches upstream.

> Thank you once again for your valuable inputs/comments. I tried
> implementing all your suggestions, except for the following:
>=20
> 1. I didn't modify the Documentation/i2c/smbus-protocol, as this
> document is already talking about the new function that I have worked
> on.

But it doesn't mention the name of the function implementing the
transaction. That's what I wanted you to add. But that's OK, I added it
myself. I also updated Documentation/i2c/writing-clients, which was
claiming that function i2c_smbus_process_call() had been removed from
the kernel.

> 2. I had to implicitly have the following lines of code in
i2c-viapro.c,
> because for process call functionality the bus driver has to be in
write
> mode initially and then has to switch to Read mode. (With out these
> implicit lines of code i2c-viapro bus driver is returning immediately
> after write call as per the existing control flow.)
> 	if ( size =3D=3D VT596_PROC_CALL)
> 	              read_write =3D I2C_SMBUS_READ;
> Please provide your suggestion if I could do it in a better way.

I was wondering about this. The "process call" is special in that it
doesn't have a read variant and a write variant. Instead, it is a
transaction combining write and read. So I was wondering if the
direction bit had any effect on the VIA chip. According to your tests,
it must be handled as a write operation at the device level. So, your
implementation is correct.

I had to fix a number of whitespace issues in the second patch. Next
time, I suggest that you run scripts/checkpatch.pl on your patch, it
will tell you about that kind of minor problems so that you can fix
them before sending the patch.

Thanks,
--=20
Jean Delvare

------_=_NextPart_001_01C928C0.069EF3F9
Content-Type: application/octet-stream;
	name="series"
Content-Transfer-Encoding: base64
Content-Description: series
Content-Disposition: attachment;
	filename="series"

cGF0Y2gxCnBhdGNoMgo=

------_=_NextPart_001_01C928C0.069EF3F9
Content-Type: application/octet-stream;
	name="patch1"
Content-Transfer-Encoding: base64
Content-Description: patch1
Content-Disposition: attachment;
	filename="patch1"

KiAqICogKiAqCkZyb206IFByYWthc2ggTW9ydGhhIDxwbW9ydGhhQGVzY2llbnQuY29tPgpTdWJq
ZWN0OiBpMmM6IFJlc3RvcmUgaTJjX3NtYnVzX3Byb2Nlc3NfY2FsbCBmdW5jdGlvbgoKUmVzdG9y
ZSB0aGUgaTJjX3NtYnVzX3Byb2Nlc3NfY2FsbCgpIGFzIG9uZSBkcml2ZXIgKGZvciB0aGUKTWlj
cm9uYXMgTUFQNTQwMSkgd2lsbCBuZWVkIGl0IHNvb24uCgpTaWduZWQtb2ZmLWJ5OiBQcmFrYXNo
IE1vcnRoYSA8cG1vcnRoYUBlc2NpZW50LmNvbT4KKiAqICogKiAqCkluZGV4OiBsaW51eC0yLjYu
MjYvZHJpdmVycy9pMmMvaTJjLWNvcmUuYwo9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09Ci0tLSBsaW51eC0yLjYuMjYub3Jp
Zy9kcml2ZXJzL2kyYy9pMmMtY29yZS5jCTIwMDgtMTAtMDcgMTA6NDE6MjIuOTg4MjA4ODc0IC0w
NDAwCisrKyBsaW51eC0yLjYuMjYvZHJpdmVycy9pMmMvaTJjLWNvcmUuYwkyMDA4LTEwLTA3IDEw
OjQxOjQ0Ljc4MTQ2NDU1OCAtMDQwMApAQCAtMTY3Nyw2ICsxNjc3LDI4IEBACiBFWFBPUlRfU1lN
Qk9MKGkyY19zbWJ1c193cml0ZV93b3JkX2RhdGEpOwogCiAvKioKKyAqIGkyY19zbWJ1c19wcm9j
ZXNzX2NhbGwgLSBTTUJ1cyAicHJvY2VzcyBjYWxsIiBwcm90b2NvbAorICogQGNsaWVudDogSGFu
ZGxlIHRvIHNsYXZlIGRldmljZQorICogQGNvbW1hbmQ6IEJ5dGUgaW50ZXJwcmV0ZWQgYnkgc2xh
dmUKKyAqIEB2YWx1ZTogMTYtYml0ICJ3b3JkIiBiZWluZyB3cml0dGVuCisgKgorICogVGhpcyBl
eGVjdXRlcyB0aGUgU01CdXMgInByb2Nlc3MgY2FsbCIgcHJvdG9jb2wsIHJldHVybmluZyBuZWdh
dGl2ZSBlcnJubworICogZWxzZSBhIDE2LWJpdCB1bnNpZ25lZCAid29yZCIgcmVjZWl2ZWQgZnJv
bSB0aGUgZGV2aWNlLgorICovCitzMzIgaTJjX3NtYnVzX3Byb2Nlc3NfY2FsbChzdHJ1Y3QgaTJj
X2NsaWVudCAqY2xpZW50LCB1OCBjb21tYW5kLCB1MTYgdmFsdWUpCit7CisJdW5pb24gaTJjX3Nt
YnVzX2RhdGEgZGF0YTsKKwlpbnQgc3RhdHVzOworCWRhdGEud29yZCA9IHZhbHVlOworCisJc3Rh
dHVzID0gaTJjX3NtYnVzX3hmZXIoY2xpZW50LT5hZGFwdGVyLCBjbGllbnQtPmFkZHIsIGNsaWVu
dC0+ZmxhZ3MsCisJCQkJSTJDX1NNQlVTX1dSSVRFLCBjb21tYW5kLAorCQkJCUkyQ19TTUJVU19Q
Uk9DX0NBTEwsICZkYXRhKTsKKwlyZXR1cm4gKHN0YXR1cyA8IDApID8gc3RhdHVzIDogZGF0YS53
b3JkOworfQorRVhQT1JUX1NZTUJPTChpMmNfc21idXNfcHJvY2Vzc19jYWxsKTsKKworLyoqCiAg
KiBpMmNfc21idXNfcmVhZF9ibG9ja19kYXRhIC0gU01CdXMgImJsb2NrIHJlYWQiIHByb3RvY29s
CiAgKiBAY2xpZW50OiBIYW5kbGUgdG8gc2xhdmUgZGV2aWNlCiAgKiBAY29tbWFuZDogQnl0ZSBp
bnRlcnByZXRlZCBieSBzbGF2ZQo=

------_=_NextPart_001_01C928C0.069EF3F9
Content-Type: application/octet-stream;
	name="patch2"
Content-Transfer-Encoding: base64
Content-Description: patch2
Content-Disposition: attachment;
	filename="patch2"

KiAqICogKiAqCkZyb206IFByYWthc2ggTW9ydGhhIDxwbW9ydGhhQGVzY2llbnQuY29tPgpTdWJq
ZWN0OiBpMmM6IFJlc3RvcmUgaTJjX3NtYnVzX3Byb2Nlc3NfY2FsbCBmdW5jdGlvbgoKUmVzdG9y
ZSB0aGUgSTJDX1NNQlVTX1BST0NfQ0FMTCBhcyBvbmUgZHJpdmVyIChmb3IgdGhlCk1pY3JvbmFz
IE1BUDU0MDEpIHdpbGwgbmVlZCBpdCBzb29uLgoKU2lnbmVkLW9mZi1ieTogUHJha2FzaCBNb3J0
aGEgPHBtb3J0aGFAZXNjaWVudC5jb20+CiogKiAqICogKgpJbmRleDogbGludXgtMi42LjI2L2Ry
aXZlcnMvaTJjL2J1c3Nlcy9pMmMtdmlhcHJvLmMKPT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQotLS0gbGludXgtMi42LjI2
Lm9yaWcvZHJpdmVycy9pMmMvYnVzc2VzL2kyYy12aWFwcm8uYwkyMDA4LTEwLTA3IDEwOjQyOjI4
LjgwODAwMTI4MCAtMDQwMAorKysgbGludXgtMi42LjI2L2RyaXZlcnMvaTJjL2J1c3Nlcy9pMmMt
dmlhcHJvLmMJMjAwOC0xMC0wNyAxMDo0Mjo0Ni42NTMwMjk0NzUgLTA0MDAKQEAgLTgyLDYgKzgy
LDcgQEAKICNkZWZpbmUgVlQ1OTZfQllURQkJMHgwNAogI2RlZmluZSBWVDU5Nl9CWVRFX0RBVEEJ
CTB4MDgKICNkZWZpbmUgVlQ1OTZfV09SRF9EQVRBCQkweDBDCisjZGVmaW5lIFZUNTk2X1BST0Nf
Q0FMTAkJMHgxMAogI2RlZmluZSBWVDU5Nl9CTE9DS19EQVRBCTB4MTQKICNkZWZpbmUgVlQ1OTZf
STJDX0JMT0NLX0RBVEEJMHgzNAogCkBAIC0yMzIsNiArMjMzLDEyIEBACiAJCX0KIAkJc2l6ZSA9
IFZUNTk2X1dPUkRfREFUQTsKIAkJYnJlYWs7CisgCWNhc2UgSTJDX1NNQlVTX1BST0NfQ0FMTDoK
KyAJCW91dGJfcChjb21tYW5kLCBTTUJIU1RDTUQpOworIAkJb3V0Yl9wKGRhdGEtPndvcmQgJiAw
eGZmLCBTTUJIU1REQVQwKTsKKyAJCW91dGJfcCgoZGF0YS0+d29yZCAmIDB4ZmYwMCkgPj4gOCwg
U01CSFNUREFUMSk7CisgCQlzaXplID0gVlQ1OTZfUFJPQ19DQUxMOworIAkJYnJlYWs7CiAJY2Fz
ZSBJMkNfU01CVVNfSTJDX0JMT0NLX0RBVEE6CiAJCWlmICghKHZ0NTk2X2ZlYXR1cmVzICYgRkVB
VFVSRV9JMkNCTE9DSykpCiAJCQlnb3RvIGV4aXRfdW5zdXBwb3J0ZWQ7CkBAIC0yNjIsNiArMjY5
LDkgQEAKIAlpZiAoc3RhdHVzKQogCQlyZXR1cm4gc3RhdHVzOwogCisgCWlmICggc2l6ZSA9PSBW
VDU5Nl9QUk9DX0NBTEwpCisgCQlyZWFkX3dyaXRlID0gSTJDX1NNQlVTX1JFQUQ7CisKIAlpZiAo
KHJlYWRfd3JpdGUgPT0gSTJDX1NNQlVTX1dSSVRFKSB8fCAoc2l6ZSA9PSBWVDU5Nl9RVUlDSykp
CiAJCXJldHVybiAwOwogCkBAIC0yNzEsNiArMjgxLDcgQEAKIAkJZGF0YS0+Ynl0ZSA9IGluYl9w
KFNNQkhTVERBVDApOwogCQlicmVhazsKIAljYXNlIFZUNTk2X1dPUkRfREFUQToKKwljYXNlIFZU
NTk2X1BST0NfQ0FMTDoKIAkJZGF0YS0+d29yZCA9IGluYl9wKFNNQkhTVERBVDApICsgKGluYl9w
KFNNQkhTVERBVDEpIDw8IDgpOwogCQlicmVhazsKIAljYXNlIFZUNTk2X0kyQ19CTE9DS19EQVRB
OgpAQCAtMjk1LDcgKzMwNiw3IEBACiB7CiAJdTMyIGZ1bmMgPSBJMkNfRlVOQ19TTUJVU19RVUlD
SyB8IEkyQ19GVU5DX1NNQlVTX0JZVEUgfAogCSAgICBJMkNfRlVOQ19TTUJVU19CWVRFX0RBVEEg
fCBJMkNfRlVOQ19TTUJVU19XT1JEX0RBVEEgfAotCSAgICBJMkNfRlVOQ19TTUJVU19CTE9DS19E
QVRBOworCSAgICBJMkNfU01CVVNfUFJPQ19DQUxMIHwgSTJDX0ZVTkNfU01CVVNfQkxPQ0tfREFU
QTsKIAogCWlmICh2dDU5Nl9mZWF0dXJlcyAmIEZFQVRVUkVfSTJDQkxPQ0spCiAJCWZ1bmMgfD0g
STJDX0ZVTkNfU01CVVNfSTJDX0JMT0NLOwo=

------_=_NextPart_001_01C928C0.069EF3F9
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
------_=_NextPart_001_01C928C0.069EF3F9--
