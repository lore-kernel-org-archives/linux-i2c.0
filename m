From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v5 6/8] i2c: demux: Use changeset helpers for clarity
Date: Thu, 22 Feb 2018 12:07:54 +0100
Message-ID: <20180222110754.snkn7sgy4cyj7kq4@ninjato>
References: <20180222000531.19448-1-laurent.pinchart+renesas@ideasonboard.com>
 <20180222000531.19448-7-laurent.pinchart+renesas@ideasonboard.com>
 <CAMuHMdVy9=e5eZZTdV6E=apvHxL3n5Qqob2JE+FsON3RG-JWWg@mail.gmail.com>
 <2195898.2J8Qfnu3DQ@avalon>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1275134410=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <2195898.2J8Qfnu3DQ@avalon>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Marek Vasut <marex@denx.de>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, Koen Kooi <koen@dominion.thruhere.net>, Pantelis Antoniou <pantelis.antoniou@konsulko.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, DRI Development <dri-devel@lists.freedesktop.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Linux I2C <linux-i2c@vger.kernel.org>, Matt Porter <mporter@konsulko.com>, Frank Rowand <frowand.list@gmail.com>, Guenter Roeck <linux@roeck-us.net>
List-Id: linux-i2c@vger.kernel.org


--===============1275134410==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="zchw23fcb7jg5anu"
Content-Disposition: inline


--zchw23fcb7jg5anu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > Why? ePAPR says "okay", "disabled", "fail", or "fail-sss".
> >=20
> > Sorry for missing this in the previous round.
>=20
> That was per Wolfram's request, and because the existing code uses "ok". =
I'm=20
> personally fine with any.

I did? Well, today I don't have a strong preference. Any is fine with
me, too.


--zchw23fcb7jg5anu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlqOpIcACgkQFA3kzBSg
KbY/Lw//Wu6/UUii+3Pppq877QvjFQWj7sOO8l/Qpko2IH5z7CriP+6V8A9NMBeL
CnSfbosoDBCiASIK4HUu+NU4XxtWc2kC3dap8nKfY+mUg+hcLYjkPQyJedkDS/IC
5LsYayvWr6P5rkDBF3fpSfOdkI55T30u5k4N4bZfNjQ8y6kHVFnLJXISQ6HB/feO
nKhWnL9A3Fc4TA9/iibB/qFOb7aQn4SRJy/KyZAIlUAxi3UQPlkRQVzrVXy/l8DM
vdvbonQkJtgJs173LtDmXfGKDf1PKsUD5YkBvM3oAbyn+BjnJqUKjJxHR4xk3V4j
CKaMHisEUPjJJgun3MUwd8+lF6j5z29OcZTqVz6ez6VQC5yXyyGP8BFbOxGsl2wZ
5+u4H52x2ZXlhoT0WlyPSZb0MH+k6Rem7Dkt1FExyiILPZ2QFbp71ypfRFoRsWRc
nZRyXFDsD/AZdOepedxyUihI2fzLCHDcscEGUptAuFBhMkJmp0C6CsebABFsK0ib
rmlNrwhqXnWcTqYSP7XsKboKy3GVG3ph9BoPye+kUyZ/K4taTitAUxoqWcOKkFG/
4poPQKZiifP5DraddGVLSMI+Bcj4Ly2/0eVvz89HDzHPgZHwmX8lxtqjmYYM20d/
uiGf72jB4Cl0eeqL+NMbmegS1LjE4iivcMRAxEO5d9rv204azpU=
=qf5c
-----END PGP SIGNATURE-----

--zchw23fcb7jg5anu--

--===============1275134410==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==

--===============1275134410==--
