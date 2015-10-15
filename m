From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 0/6] i2c: designware: Code duplication removal and
 cleanups
Date: Thu, 15 Oct 2015 14:18:48 +0200
Message-ID: <20151015121848.GG1546@katana>
References: <1441031493-18938-1-git-send-email-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gm5TwAJMO0F2iVRz"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:38296 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752748AbbJOMS5 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Thu, 15 Oct 2015 08:18:57 -0400
Content-Disposition: inline
In-Reply-To: <1441031493-18938-1-git-send-email-jarkko.nikula@linux.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: linux-i2c@vger.kernel.org


--gm5TwAJMO0F2iVRz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 31, 2015 at 05:31:27PM +0300, Jarkko Nikula wrote:
> It bothered to me to see "static struct i2c_algorithm i2c_dw_algo {}"
> defined twice both in i2c-designware-pcidrv.c and
> i2c-designware-platdrv.c and so many exported i2c-designware-core
> functions.
>=20
> It turned out some of them became unused or are local and there were
> also duplicated probe code that I moved to new common i2c_dw_probe().
>=20
> Object sizes below before and after this set from CONFIG_X86_64=3Dy build.
>=20
>    text	   data	    bss	    dec	    hex	filename
>    6439	   1096	      0	   7535	   1d6f	drivers/i2c/busses/i2c-designware=
-core.ko
>    5123	   1588	     16	   6727	   1a47	drivers/i2c/busses/i2c-designware=
-pci.ko
>    5274	   1096	     16	   6386	   18f2	drivers/i2c/busses/i2c-designware=
-platform.ko
>   16836	   3780	     32	  20648	   50a8	(TOTALS)
>=20
>    text	   data	    bss	    dec	    hex	filename
>    7225	   1120	     16	   8361	   20a9	drivers/i2c/busses/i2c-designware=
-core.ko
>    4281	   1524	      0	   5805	   16ad	drivers/i2c/busses/i2c-designware=
-pci.ko
>    4337	   1072	      0	   5409	   1521	drivers/i2c/busses/i2c-designware=
-platform.ko
>   15843	   3716	     16	  19575	   4c77	(TOTALS)
>=20
> Jarkko Nikula (6):
>   i2c: designware: Remove interrupt clearing from i2c_dw_pci_probe()
>   i2c: designware: Disable interrupts before requesting PCI device
>     interrupt
>   i2c: designware: Remove unused functions
>   i2c: designware: Make dw_readl() and dw_writel() static
>   i2c: designware: Rename platform driver probe and PM functions
>   i2c: designware: Move common probe code into i2c_dw_probe()

Applied to for-next (with V2 of patch 6), thanks!

Jarkko, would you be interested in maintaining the designware driver?
For any non-trivial patch to this driver, I'd need assistance.

Thanks,

   Wolfram


--gm5TwAJMO0F2iVRz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWH5moAAoJEBQN5MwUoCm2wYcP/2WmDMux2GsKm33rkYBRUSst
R+yKNn8DVMqrqoXeA4FMLypbpAnMh5zrtRIsjoKAoZpYOVfu6ziwnNLvjSUrCKDd
6/KhHOPCNHVui8KlYgt+qr2JqQs3pLfLa0A9qUfTRK1pmkjzL10xo6fhb+ASRiqP
5yh8iRxhCcr62bRyRF9/QMtSaMJgiwRnnUSLSshJzgdeXuiqFi5D65r8m4svDZ57
XsUGxeh3/Wj3sY0N2ob68mdTs12eIdENskTt5DIQsuostYjhrzA2Jz0JaxS4zkzU
FNDbnDQInq4Ecw1EAOP6rN52kKhNSfwb0a/aP08VBe1aDD/pOdWfRm+trzZGRBJ+
a4fqI+v6t0p0BYx+Gy1FSH1K0nlKp4lYzvBWqgNG0tzeCw3ovpwDdEFqXZn5ZRYQ
tSd5XJr7fpsmatEi6A+/EXgAuBfKHbV3pn5kFcloOshFajIo8JpJGBwUWrNIZPYe
otCsWL5/ZPLTpl45GVBQy5FW91UT2+pJmfFbOfLm4fMwP4PpkG5bSJgbnF9J3U98
nZHPYtTOtxy4KbGLtoP3D2Wj0v0YvfydPfvvWH/xTa7IY2HbNvTV+258MKqW9jv/
4XvvNuuuAyePP4tz5j4bIdODAb2rpOLpbyR0/VVBVNkm7ymGGCdSzXJhifRdVBB5
sqTEenvJ9yLFfM6LdKWp
=DATZ
-----END PGP SIGNATURE-----

--gm5TwAJMO0F2iVRz--
