From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH v9 0/3] ARM: mediatek: Add driver for Mediatek I2C
Date: Mon, 1 Jun 2015 08:34:26 +0900
Message-ID: <20150531233424.GA17308@katana>
References: <1432198410-6576-1-git-send-email-eddie.huang@mediatek.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BOKacYhQ+x31HxR3"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1432198410-6576-1-git-send-email-eddie.huang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Eddie Huang <eddie.huang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Cc: srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Xudong Chen <xudong.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Liguo Zhang <liguo.zhang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--BOKacYhQ+x31HxR3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 21, 2015 at 04:53:27PM +0800, Eddie Huang wrote:
> This series is for Mediatek SoCs I2C controller common bus driver.
>=20
> Earlier MTK SoC (for example, MT6589, MT8135) I2C HW has some limitations.
> New generation SoC like MT8173 fix following limitations:
>=20
> 1. Only support one i2c_msg number. One exception is WRRD (write then rea=
d)
> mode. WRRD can have two i2c_msg numbers.
>=20
> 2. Mediatek I2C controller support WRRD(write then read) mode, in WRRD
> mode the Repeat Start will be issued between 2 messages.
> In this driver if 2 messages is first write then read, the driver will
> combine 2 messages using Write-Read mode so the RS will be issued between
> the 2 messages.
>=20
> 3. The max transfer data length is 255 in one message. In WRRD mode, the
> max data length of second msg is 31.
>=20
> MT8135 and MT6589 can control I2C pins on PMIC(MT6397) by setting the i2c
> registers in MT8135 side. In this case, driver should set OFFSET_PATH_DIR
> bit first, the operation on other registers are still the same.
> For now MT6589/MT8135 support this, MT6577/MT6595/MT8127 do not support.
> For example, If want to use I2C4/5/6 pins on MT8135 just need to enable
> the pinmux, else if want to use I2C pins on PMIC(MT6397) need to add
> "mediatek,have-pmic" property in the .dts file of each platform.
>=20
> This driver is based on 4.1-rc1.

Applied to for-next, thanks! Especially for being an early adaptor of
the quirk framework and for keeping at this during this thorough review
=66rom all sides. Thanks to the reviewers as well!


--BOKacYhQ+x31HxR3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVa5qAAAoJEBQN5MwUoCm2LFkP/Rw1K1M0asHTFf4j/sXyQcxO
YTuzPCkAiL5pOgRevp+z0pILNvShESb/s4DqlwdzwpyQGVlp2xjiJe9VpqNl0hKw
JwxdeH/pBhkhHIk1RcKDooKW9sfmFK/18RQ+arG/HkFjNLpuCNpSE9x+PmKwZPCC
Ck7SSUHnhgtLnRy6HLfiahiN2OXJMHRB45sehEMLvmxX+6PhMLt9sQjjPEydBkAN
myBzRwSTf7jQE0NQs66O2BcSF4jk4JrGQrQB+SPxb02N9innoL/5sTnJZyInPNMM
eNozGlWwT2pw2hrJ2hlQJwXBzu2n16LaO9F3jDhJ67VWqEfV1Ovw71k28YS5SZtS
/Nlu98jG4vIf/+HidkVp83Ebt4k591A+wSk1VhjcyOQCkiciaIchZptdgpatGgW1
3M+f58MDmipKqTSF7zy0LXTnvJUmqmxLKEk9HRkhy46xT7PnNudPNTZ6S5RKJ2nD
gFN/v86CNGLAgMbVRJRNoCpvgGhcbnkwDMI3xHUFer7OHgOEJc2yBO3uNJh3uAyw
TXjL7O2QyyYQwZVqLfB3PkD+BVxpphu2J3dFmnPd87/1SzQnZgeZaTB0lb6K4DxM
/Wal4q68ixYuzVQVEgSd22qlmPJ0zBLsqDXjUvTQd5DRTpGAEG0gEViMBqWe/zwN
X8SbUrLKbnKdZlZ2Xczx
=PGuI
-----END PGP SIGNATURE-----

--BOKacYhQ+x31HxR3--
