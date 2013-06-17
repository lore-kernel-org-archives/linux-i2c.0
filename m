From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] i2c-piix4 - Add support for secondary SMBus on AMD SB800
 and AMD FCH chipsets
Date: Mon, 17 Jun 2013 09:16:15 +0200
Message-ID: <20130617071615.GB2957@katana>
References: <5196B32D.7060501@assembler.cz>
 <1369294522.12648.11.camel@mattotaupa>
 <20130611193539.GG3376@katana>
 <51B77EC0.2020204@assembler.cz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5I6of5zJg18YgZEa"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <51B77EC0.2020204-/xGekIyIa4Ap1Coe8Ar9gA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rudolf Marek <r.marek-/xGekIyIa4Ap1Coe8Ar9gA@public.gmane.org>
Cc: Paul Menzel <paulepanter-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--5I6of5zJg18YgZEa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 11, 2013 at 09:47:12PM +0200, Rudolf Marek wrote:
> >Do you know if there should be something connected?
>=20
> In Paul case, most likely not. In my case there is a voltage
> controller for the DDR3 voltage regulator. I asked Paul test it on
> his SB800 system, I have the Hudson successor..
>=20
> >>Rudolf, it looks like your patch could also update the i2c files under
> >>`Documentation`. At least there are some patches doing that.
> >
> >Do you mean 'busses/i2c-piix4'?
>=20
> Yes he means that. I will add documentation to the patch.

OK, so I will wait for V2. Thanks!


--5I6of5zJg18YgZEa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRvre/AAoJEBQN5MwUoCm2k0YP/RiYvHIpRwVKsF0aN9IplhZR
OiPc/22zfQGr9CGMs2u1PkNVhy+Zil6aHCb4aXRjqK5+qr6mAOLVAXT+1RhFWO+e
dexlgMdX62iMAQYPwVvDOkzCLPaQkrAsFIqfHnMs4nWqsrOHOO2hc+TPp00NaepN
M7xQY2ARxHTHE9xaLPpOCZL4C8y1ESD17d+uWf7BCwu3xFLfWuCG1mdx/RqIixsT
r9Rswn9g2T75yww75itN2Ob5smXCkmzI6UH/A5KYQRTzl4pbfZGJ0+teDIjxnjPh
q7RRF1DmzkQY1ZAiCKrbxEU3YGHBXQEZDztNIRv23Kt4Tz8EEUtHn4fxt6juXHCP
aJ3PnS6zmU5mBtSbbRW7DcNjGv8GDdLLEb8Q1f3H5jJECJ89u0BCIYwCGN3yeghf
MdycoNx+6FTKmD4gxUOt+/vtjUBGv/x7J7uy/aUDXLzoQu9QkNG226SrLwKJmekv
8dObv2JDDAZik7xIxzaCziESJDrmM9t+feJ6KCImhJFkGczAG/XWYirW/PMxYt+B
lF0uOLJDw6oJ12oq+fxxBs7vo17A3xRWdaP20g/GbOpDah8IvUwvJMa6pwZpy3Ko
eTIYV10oiN5MRVMgKkOZqz2cSNRynQPj5lk6g230OaVGBDEyahNMgkGMAhS+OVia
15xmms1B1pbCwpqp5XdG
=MdRS
-----END PGP SIGNATURE-----

--5I6of5zJg18YgZEa--
