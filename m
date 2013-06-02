From: Martin Vogt <mvogt1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] i2c-tools: NULL in i2c-dev.h
Date: Sun, 2 Jun 2013 20:01:49 +0200
Message-ID: <CAOE8yMAkZmNmGpB7ERKYuz5smjX2MNryf4hqvxyr892kwx1bSg@mail.gmail.com>
Reply-To: mvogt1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=047d7b677358661d3004de2fa499
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

--047d7b677358661d3004de2fa499
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

Hello,

I was trying to write a CMake check for i2c-dev.h.
This did not work, because "NULL" is used in i2c-dev.h, but NULL is not
defined, during the check.

>Run Build Command:/usr/bin/gmake "cmTryCompileExec139053135/fast"
>usr/bin/c++  -DHAS_I2C_MSG  -o
>CMakeFiles/cmTryCompileExec139053135.dir/src.cxx.o -c
>In file included from src.cxx:2:0:
>/usr/include/linux/i2c-dev.h: In function =91__s32
>/i2c_smbus_write_quick(int,__u8)=92:
>/usr/include/linux/i2c-dev.h:176:55: error: =91NULL=92 was not declared in=
 this
>/scope
>/usr/include/linux/i2c-dev.h: In function =91__s32
>/i2c_smbus_write_byte(int,__u8)=92:
>/usr/include/linux/i2c-dev.h:191:41: error: =91NULL=92 was not declared in=
 this
>/scope
>gmake[1]: *** [CMakeFiles/cmTryCompileExec139053135.dir/src.cxx.o] Error 1
>Source file was:
>#include </usr/include/linux/i2c-dev.h>
>int main() {
   i2c_msg* tmp;
   tmp->buf;
  return 0;
}

The attached patch replaces NULL with 0x0, but I'm not sure
if this is a good solution.

The problem is, that on OpenSuSE 12.x i2c-dev.h is in the
package i2c-tools-3.1.0, and in ubuntu in the package linux-libc-dev.
Including i2c.h and i2c-dev.h on OpenSuSE result in a compiler error,
but is needed on ubuntu.

regards,

Martin

--047d7b677358661d3004de2fa499
Content-Type: application/octet-stream; name="dont_use_NULL.patch"
Content-Disposition: attachment; filename="dont_use_NULL.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_hhgiml6g0

ZGlmZiAtcnUgaTJjLXRvb2xzLTMuMS4wLm9yZy9pbmNsdWRlL2xpbnV4L2kyYy1kZXYuaCBpMmMt
dG9vbHMtMy4xLjAvaW5jbHVkZS9saW51eC9pMmMtZGV2LmgKLS0tIGkyYy10b29scy0zLjEuMC5v
cmcvaW5jbHVkZS9saW51eC9pMmMtZGV2LmgJMjAxMC0xMi0xMiAxNDoyMjoyOS4wMDAwMDAwMDAg
KzAxMDAKKysrIGkyYy10b29scy0zLjEuMC9pbmNsdWRlL2xpbnV4L2kyYy1kZXYuaAkyMDEzLTA2
LTAyIDE5OjE1OjE1LjQyMzQ1NzQ1NiArMDIwMApAQCAtMTczLDcgKzE3Myw3IEBACiAKIHN0YXRp
YyBpbmxpbmUgX19zMzIgaTJjX3NtYnVzX3dyaXRlX3F1aWNrKGludCBmaWxlLCBfX3U4IHZhbHVl
KQogewotCXJldHVybiBpMmNfc21idXNfYWNjZXNzKGZpbGUsdmFsdWUsMCxJMkNfU01CVVNfUVVJ
Q0ssTlVMTCk7CisJcmV0dXJuIGkyY19zbWJ1c19hY2Nlc3MoZmlsZSx2YWx1ZSwwLEkyQ19TTUJV
U19RVUlDSywweDApOwogfQogCQogc3RhdGljIGlubGluZSBfX3MzMiBpMmNfc21idXNfcmVhZF9i
eXRlKGludCBmaWxlKQpAQCAtMTg4LDcgKzE4OCw3IEBACiBzdGF0aWMgaW5saW5lIF9fczMyIGky
Y19zbWJ1c193cml0ZV9ieXRlKGludCBmaWxlLCBfX3U4IHZhbHVlKQogewogCXJldHVybiBpMmNf
c21idXNfYWNjZXNzKGZpbGUsSTJDX1NNQlVTX1dSSVRFLHZhbHVlLAotCSAgICAgICAgICAgICAg
ICAgICAgICAgIEkyQ19TTUJVU19CWVRFLE5VTEwpOworCSAgICAgICAgICAgICAgICAgICAgICAg
IEkyQ19TTUJVU19CWVRFLDB4MCk7CiB9CiAKIHN0YXRpYyBpbmxpbmUgX19zMzIgaTJjX3NtYnVz
X3JlYWRfYnl0ZV9kYXRhKGludCBmaWxlLCBfX3U4IGNvbW1hbmQpCk9ubHkgaW4gaTJjLXRvb2xz
LTMuMS4wL2luY2x1ZGUvbGludXg6IGkyYy1kZXYuaH4K
--047d7b677358661d3004de2fa499--
