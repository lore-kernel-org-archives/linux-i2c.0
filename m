From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] i2c: simplify boilerplate code for attribute groups
Date: Thu, 22 Jan 2015 15:27:37 +0100
Message-ID: <20150122142737.GD3413@katana>
References: <1421694744-19528-1-git-send-email-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WChQLJJJfbwij+9x"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1421694744-19528-1-git-send-email-wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--WChQLJJJfbwij+9x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 19, 2015 at 08:12:24PM +0100, Wolfram Sang wrote:
> Declaring attribute groups can be done with macros these days, let's use
> them for consistency and readability reasons. Also, put the ATTR macros
> directly below the referenced functions while we are here.
>=20
> Signed-off-by: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>

Applied to for-next, thanks!


--WChQLJJJfbwij+9x
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUwQjZAAoJEBQN5MwUoCm2FDMP/3/U3KuQbpErVFznPXE2/Z8x
wdOeDRueQecvLWy7m+HEnAOLGN34UsHgfQeu+yLCqxm9GqqgHbPWDQtR+RS04RVk
figYmOM9Z1/33Avg0xLTlFI0jonxIJM+lUnyiEYYssnsuXuTOHvE8bLB1ApF1i/I
nI2DmPpKyBOZ4k0KhSELAlRDg10GZmvDqMDZfU/Ibw/NE8Aq6SwZbXXBn7D0iL7Q
nDvsBk2PT7adEghFAQawTMgrs3avspTK5CYljN1KT5bM0ZdxxJoI2JthDKDXly5M
dw92ngYVWJK+4eJHLjNKacMK9Dq1TrcgnKauo8320kXGq4bSPXgiraeUP1c7llRn
jJ53BkfHQ8iGUiO2eO9NGJxR428wWVtA39RLGyYyCcWJ02eb/o2WNV5MTSa1uEhO
ML7n0wcFWMT2Y14n2MvHFVFILc3Dk4ne88UIxS+gUUr2wsaDLDQtWvCBCvy8Q0/5
9HZomAFKgRbRM6PyX0yVzsxFXG2NSFGufhwP+NF/WYfcbU+XJPIpMPcPwSxsiDk1
EKYwvVeWsVLPd6eFLgRvU7ucVFu9TxxekPKy8OEKyfTsE02Z/Lzb77GR66XEQCe/
+ALLGJhiGaFWMODM/oa13HiZeQLieG2KjzGijanGAaip1Giivq0kf5BT/Vfp+RLV
niGMDqKBlnUgasRtBFTn
=7xsF
-----END PGP SIGNATURE-----

--WChQLJJJfbwij+9x--
