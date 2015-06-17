From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH 1/2] i2c: mux: Use __i2c_transfer() instead of calling
 parent's master_xfer()
Date: Wed, 17 Jun 2015 14:36:33 +0200
Message-ID: <20150617123633.GB13393@katana>
References: <557AD345.7090806@nokia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dTy3Mrz/UPE2dbVg"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <557AD345.7090806-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alexander Sverdlin <alexander.sverdlin-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, =?utf-8?Q?=C5=81ukasz?= Gemborowski <lukasz.gemborowski-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, "Lawnick, Michael (Nokia - DE/Ulm)" <michael.lawnick-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--dTy3Mrz/UPE2dbVg
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 12, 2015 at 02:40:37PM +0200, Alexander Sverdlin wrote:
> Newly introduced quirks infrastructure doesn't work for the devices behind
> MUXes because MUX's master_xfer() calls parent's master_xfer() directly
> without checking the quirks. Instead of duplicating check code in MUX just
> call __i2c_transfer() instead. This has a side effect on tracing (messages
> will appear on both MUX bus and parent bus), but maybe that's not bad at
> the end.
>=20
> Signed-off-by: Alexander Sverdlin <alexander.sverdlin-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
> Tested-by: =C5=81ukasz Gemborowski <lukasz.gemborowski-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>

Applied to for-next with stable added, thanks!


--dTy3Mrz/UPE2dbVg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVgWnRAAoJEBQN5MwUoCm2wSUP/0UqLgrn9VSAhXVHuKiGO/IA
6/qCe1B1Mm+ss1Q8mSm9rpgHRkvPr/dpXw1oraDKhUCKp7axg4yGI3PqXHai4Jzu
3iphU18l1qyAdfPGRgH3rb7zzUWhIoJXVzciyg4j1TcIoqT38MSWbqX0I8cWkJRG
nMEsPea8PaRhIjLqWhAZKrUB03MyAfblDymEfFulwcAAgZ3ChwQMKU3uFSLQw6GB
FaR6GzFBIKut1hsATXg0jLLLvjNajMMmeuceDazqJIQx5wJn3RWNWJmeRgUPY3ub
z/ZaMRzejd3vJFIER8VWznQUKD83jA09u7p5oWi3LyiuVYwCbE7Hu3xrZAI/00pC
qq0k/LvcA4ocVZtV2pVH4eFyt6dx6TPUw6LhjxH2wYHzEvAgAhNHvMXE0gYx6XIa
L9tG0MKzgV6yJL0/870c/44kAqjfk0AhHPzktuHOyX5tu8n5++sKy+e+8CfBd9B3
bzF9xoU0/gb4nigHkGo9LWxS/MWhgHK0oC2b73ZvbeZSp55QBBxlZ4bMvRpB+RKK
NPizt+tepL+36xxxBoG7ddmI28RL6egSXUjiHdmjD1Mu1p22vv1WBaLO0E/BAvB7
g4Bndz15zDx52I+SxonnnT+iDwWKKO+1kjG/mWaKipVqsWwM06IIJ67msDwYUJ7g
GC8rRKG3WFD5mnX17GnG
=mvh9
-----END PGP SIGNATURE-----

--dTy3Mrz/UPE2dbVg--
