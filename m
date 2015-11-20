From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 2/3] i2c: xiic: Prevent concurrent running of the IRQ
 handler and __xiic_start_xfer()
Date: Fri, 20 Nov 2015 16:16:16 +0100
Message-ID: <20151120151616.GD1752@katana>
References: <1447681325-30914-1-git-send-email-lars@metafoo.de>
 <1447681325-30914-2-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="fOHHtNG4YXGJ0yqR"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:59796 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1162859AbbKTPQU (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Fri, 20 Nov 2015 10:16:20 -0500
Content-Disposition: inline
In-Reply-To: <1447681325-30914-2-git-send-email-lars@metafoo.de>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Shubhrajyoti Datta <shubhraj@xilinx.com>, linux-i2c@vger.kernel.org


--fOHHtNG4YXGJ0yqR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 16, 2015 at 02:42:04PM +0100, Lars-Peter Clausen wrote:
> Prior to commit e6c9a037bc8a ("i2c: xiic: Remove the disabling of
> interrupts") IRQs where disabled when the initial __xiic_start_xfer() was
> called. After the commit the interrupt is enabled while the function is
> running, this means it is possible for the interrupt to be triggered while
> the function is still running. When this happens the internal data
> structures get corrupted and undefined behavior can occur like the
> following crash:
>=20
> 	Internal error: Oops: 17 [#1] PREEMPT SMP ARM
> 	Modules linked in:
> 	CPU: 0 PID: 2040 Comm: i2cdetect Not tainted 4.0.0-02856-g047a308 #10956
> 	Hardware name: Xilinx Zynq Platform
> 	task: ee0c9500 ti: e99a2000 task.ti: e99a2000
> 	PC is at __xiic_start_xfer+0x6c4/0x7c8
> 	LR is at __xiic_start_xfer+0x690/0x7c8
> 	pc : [<c02bbffc>]    lr : [<c02bbfc8>]    psr: 800f0013
> 	sp : e99a3da8  ip : 00000000  fp : 00000000
> 	r10: 00000001  r9 : 600f0013  r8 : f0180000
> 	r7 : f0180000  r6 : c064e444  r5 : 00000017  r4 : ee031010
> 	r3 : 00000000  r2 : 00000000  r1 : 600f0013  r0 : 0000000f
> 	Flags: Nzcv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
> 	Control: 18c5387d  Table: 29a5404a  DAC: 00000015
> 	Process i2cdetect (pid: 2040, stack limit =3D 0xe99a2210)
> 	Stack: (0xe99a3da8 to 0xe99a4000)
> 	3da0:                   ee031010 00000000 00000001 ee031020 ee031224 c02=
bc5ec
> 	3dc0: ee34c604 00000000 ee0c9500 e99a3dcc e99a3dd0 e99a3dd0 e99a3dd8 c06=
9f0e8
> 	3de0: 00000000 ee031020 c064e100 ffff90bb e99a3e48 c02b6590 ee031020 000=
00001
> 	3e00: e99a3e48 ee031020 00000000 e99a3e63 00000001 c02b6ec4 00000000 000=
00000
> 	3e20: 00000000 c02b7320 e99a3ef0 00000000 00000000 e99e3df0 00000000 000=
00000
> 	3e40: 00000103 2814575f 0000003e c00a0000 e99a3e85 0001003e ee0c0000 e99=
a3e63
> 	3e60: eefd3578 c064e61c ee0c9500 c0041e04 0000056c e9a56db8 00006e5a b6f=
5c000
> 	3e80: ee0c9548 eefd0040 00000001 eefd3540 ee0c9500 eefd39a0 c064b540 ee0=
c9500
> 	3ea0: 00000000 ee92b000 00000000 bef4862c ee34c600 e99ecdc0 00000720 000=
00003
> 	3ec0: e99a2000 00000000 00000000 c02b8b30 00000000 00000000 00000000 e99=
a3f24
> 	3ee0: b6e80000 00000000 00000000 c04257e8 00000000 e99a3f24 c02b8f08 000=
00703
> 	3f00: 00000003 c02116bc ee935300 00000000 bef4862c ee34c600 e99ecdc0 c02=
b91f0
> 	3f20: e99ecdc0 00000720 bef4862c eeb725f8 e99ecdc0 c00c9e2c 00000003 000=
00003
> 	3f40: ee248dc0 00000000 ee248dc8 00000002 eeb7c1a8 00000000 00000000 c00=
bb360
> 	3f60: 00000000 00000000 00000003 ee248dc0 bef4862c e99ecdc0 e99ecdc0 000=
00720
> 	3f80: 00000003 e99a2000 00000000 c00c9f68 00000000 00000000 b6f22000 000=
00036
> 	3fa0: c000dfa4 c000de20 00000000 00000000 00000003 00000720 bef4862c bef=
4862c
> 	3fc0: 00000000 00000000 b6f22000 00000036 00000000 00000000 b6f60000 000=
00000
> 	3fe0: 00013040 bef48614 00008cab b6ecdbe6 400f0030 00000003 2f7fd821 2f7=
fdc21
> 	[<c02bbffc>] (__xiic_start_xfer) from [<c02bc5ec>] (xiic_xfer+0x94/0x168)
> 	[<c02bc5ec>] (xiic_xfer) from [<c02b6590>] (__i2c_transfer+0x4c/0x7c)
> 	[<c02b6590>] (__i2c_transfer) from [<c02b6ec4>] (i2c_transfer+0x9c/0xc4)
> 	[<c02b6ec4>] (i2c_transfer) from [<c02b7320>] (i2c_smbus_xfer+0x3a0/0x4e=
c)
> 	[<c02b7320>] (i2c_smbus_xfer) from [<c02b8b30>] (i2cdev_ioctl_smbus+0xb0=
/0x214)
> 	[<c02b8b30>] (i2cdev_ioctl_smbus) from [<c02b91f0>] (i2cdev_ioctl+0xa0/0=
x1d4)
> 	[<c02b91f0>] (i2cdev_ioctl) from [<c00c9e2c>] (do_vfs_ioctl+0x4b0/0x5b8)
> 	[<c00c9e2c>] (do_vfs_ioctl) from [<c00c9f68>] (SyS_ioctl+0x34/0x5c)
> 	[<c00c9f68>] (SyS_ioctl) from [<c000de20>] (ret_fast_syscall+0x0/0x34)
> 	Code: e283300c e5843210 eafffe64 e5943210 (e1d320b4)
>=20
> The issue can easily be reproduced by performing I2C access under high
> system load or IO load.
>=20
> To fix the issue protect the invocation to __xiic_start_xfer() form
> xiic_start_xfer() with the same lock that is used to protect the interrupt
> handler.
>=20
> Fixes: e6c9a037bc8a ("i2c: xiic: Remove the disabling of interrupts")
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>

Applied to for-current, thanks!


--fOHHtNG4YXGJ0yqR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWTzlAAAoJEBQN5MwUoCm20+YP+waFoaJnlr2TbzQP8//QcIDx
gYMcHDg7WC0wRhfzbvQGltr1LnuKrGwpMM+fKZxsS7Aiz9P1FZJzriQiiK8axex/
xlJ8KVKbfe+jtjni6YcHFdatSHKxMgjNQRBbzyBPcY7ZFHb/eHtV9xjlc+XlYTP3
XsQ0+jWtsg6QqHbe9YQ6HL+g9Pa5d48p3nafGKv/OwtDVyJTkLJxfx8EWaN7VZrh
mYr7ET4iycLXRkSMLLMABercz14hU9DFz7cVqWIOsF8YeAJLQDgSVESGZFIzvVBM
Bxm9svY9BLkJ2kPBGG9rYF7M/j0LxrDtirsCWghgERV3hCZ4bSmmM+PXT6t8TkQB
uTcBg20GZnYJ31e6W35kAjd9MZ8+S6kpkQ22VW2f9MM1xXolwRV3KyMOtuUWbE+b
MW0NQCxmtX60UAx/u67qvNEIV7e7Z0eYzW22Js0SdYvQ83/P2EKw0EiTOUVK9no6
k9v4YBDtMcdh6GAYM5k/ZrH86GmMDfFHD0LAc9Nu/oMAEQAyv7N/D2+tJc8S/JQk
aGaR1tzK3bmvC6KvFBy5rlzv7Lnvbk3N8l5kcM3SJ9k48mLjoY1Hrj/3dSwHGAJB
AK3jgd3MuSpIIp/t6UPNYTt69V8sXpeM9572pAC8k9bGqK+zH0xOx0iO2WCtyQNw
NS0IqzOq+5Mhk3td6ppk
=a7Bw
-----END PGP SIGNATURE-----

--fOHHtNG4YXGJ0yqR--
