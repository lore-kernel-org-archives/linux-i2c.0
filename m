From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] I2C/ACPI: Fix possible ZERO_SIZE_PTR pointer
 dereferencing error.
Date: Tue, 19 Aug 2014 10:38:08 -0500
Message-ID: <20140819153808.GE15371@katana>
References: <1407810818-33672-1-git-send-email-Li.Xiubo@freescale.com>
 <20140819150355.GD15371@katana>
 <20140819151604.GU1660@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3XA6nns4nE4KvaS/"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140819151604.GU1660-3PARRvDOhMZrdx17CPfAsdBPR1lH4CV8@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: Xiubo Li <Li.Xiubo-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Lan Tianyu <tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--3XA6nns4nE4KvaS/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 19, 2014 at 06:16:49PM +0300, Mika Westerberg wrote:
> On Tue, Aug 19, 2014 at 10:03:55AM -0500, Wolfram Sang wrote:
> > On Tue, Aug 12, 2014 at 10:33:38AM +0800, Xiubo Li wrote:
> > > Since we cannot make sure the 'data_len' will always be none zero her=
e,
> > > and then if 'data_len' equals to zero, the kzalloc() will return ZERO=
_SIZE_PTR,
> > > which equals to ((void *)16).
> >=20
> > I assume the read request with length =3D=3D 0 comes from a broken BIOS?
>=20
> I'm also interested. Does this trigger in a real system?

Even if not now, we should consider potentially broken BIOSes, or? Which
extends the question to: Do we need even more sanity checks when taking
broken BIOSes into account?


--3XA6nns4nE4KvaS/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJT829fAAoJEBQN5MwUoCm25KQP/1s2KUPUFsi6aCum2DGaX7jY
jXf+bklesWip/oLE2s1s2Bynwxz+D+1JTwV3+qXk7hEI+Mxi2bazvzwg7hkFHbYz
zMykq9FTmrb7effzQYFhxkOt6TQJAa/5PQtl0DV2QCOOvMcWx7NUQ1uHylO2ydAj
3p8n7r+tShFv5uILHjcikOVXYClteWPbQd9du8GCcSCCBfTGyrtZjRPd8pUAAKlp
kiMwuDfeN1nTbgp/zUu8krGH8+XYdbyNGdjrZHdT7lRHDoW2lSNF+itym+mjra6a
jIdXQ4eXzzSWwgCej/j6sLdhBoSt6GnoMWaSgyuVWqM1cJ7SDn0aTRBQKKXRufmJ
tj3Bicpd8Oal5Y2S4KlGvhJsQUmD2DgvkCe4CRZO1KKIO6WRKFaDW2j3NddzP3g8
wGo5XV0TFyGEq1+viNAG7dwap5mHMKcLiazqfjdB5DD0A+WjAYT5IdPGoHZP+j3b
Sb3CFZqCC1JDo0a0qs5LyQv3wpAhigKtU/Bx4kBtFxGiw2H1ZOAHxsdbpiHz8w8H
cCf/nercl3BEcIkdentYACGvfhfrSWUsgpjXphRooQe7B0mcUQ6kctW7PPIolP+X
0M/hgBBh40Pi3gZ7wSzO+2/l0/7EPozxW0uSgHh01l2G+ePH2IkQ0yMGfyCYJ6OB
1mrr3SgVDic0lyl1ONF3
=AXXh
-----END PGP SIGNATURE-----

--3XA6nns4nE4KvaS/--
