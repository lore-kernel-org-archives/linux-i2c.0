From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [patch] i2c: xgene-slimpro: dma_mapping_error() doesn't return
 an error code
Date: Mon, 24 Aug 2015 14:21:58 +0200
Message-ID: <20150824122158.GD3608@katana>
References: <20150818091219.GB3965@mwanda>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DrWhICOqskFTAXiy"
Return-path: <kernel-janitors-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150818091219.GB3965@mwanda>
Sender: kernel-janitors-owner@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Feng Kan <fkan@apm.com>, Hieu Le <hnle@apm.com>, Axel Lin <axel.lin@ingics.com>, linux-i2c@vger.kernel.org, kernel-janitors@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--DrWhICOqskFTAXiy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 18, 2015 at 12:12:19PM +0300, Dan Carpenter wrote:
> The dma_mapping_error() function returns true if there is an error, it
> doesn't return an error code.  We should return -ENOMEM.
>=20
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Applied to for-next, thanks!


--DrWhICOqskFTAXiy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJV2wxmAAoJEBQN5MwUoCm2sv4QAIuk/R0Tf0YJ3F5EtFgHCPdZ
UkRYR6MCLW7fruM+cxvZqfRYNjdbloDPlp6/yaDK4xUNlnw9G0IAFoofDkKUEaZp
sdA1D/3iTKApU6r/l+3haDi6Ya6X0BJlODhjB577m8Uei1cFCWcSgarRiHX6RXjq
b2srfqntSZi1ZQEpFLiNTfGkxfyrPqqPk/TwWV+Y1Wm1B+BBt0lag8uTNlD+hejb
+oCNMTdEvsM9GIX9O2VytlLwMqWt7vn5vP5B1GfRT6ZsoqHQpEOJA730gtSVe9ft
Wv0dh+8x0GGHZA6AaofxEuMCdBJa209VXgd0POfuwcxLbmWtRSZwIMjdYmu01jG1
3olO5pmEO3Q0j3oULL2G6zsE6o5nK+YXxo4htoiMxiaf2o7TQeaITZYTN15SkkD3
Yd6wLplVdPuYvACOsyn+224ZeXqLzcZNzQ9vE86nhoB5wyzTIB0e5EwFzq+7ed9z
AO1YcJgjOzeITmhTPO9WxKw8Rt1DxTmioTzRVEBI1aTnb3YrW8s+65A8ZgpVVkoa
ZgwnvaMywOwo2UJUkfJDJlTdkA2JRrev7dL6f4wSEE1NNvF3WKaJJ/fi0e6Kyi5J
l92s8C/Woaiq93Ewnoh/rvrLyJQ+ZEBg+tyn0FT3p5/OT8T15QoOUpsT0lCOdmS8
5Wh+iCbeggfNv54IFNHk
=09AK
-----END PGP SIGNATURE-----

--DrWhICOqskFTAXiy--
