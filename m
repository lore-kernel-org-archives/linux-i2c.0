From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [patch] i2c: qup: off by ones in qup_i2c_probe()
Date: Thu, 3 Apr 2014 10:35:32 +0200
Message-ID: <20140403083532.GB4388@katana>
References: <20140403072254.GB14286@mwanda>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FkmkrVfFsRoUs1wW"
Return-path: <kernel-janitors-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20140403072254.GB14286@mwanda>
Sender: kernel-janitors-owner@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Grant Likely <grant.likely@linaro.org>, Rob Herring <robh+dt@kernel.org>, Bjorn Andersson <bjorn.andersson@sonymobile.com>, Andy Gross <agross@codeaurora.org>, "Ivan T. Ivanov" <iivanov@mm-sol.com>, linux-i2c@vger.kernel.org, kernel-janitors@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--FkmkrVfFsRoUs1wW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 03, 2014 at 10:22:54AM +0300, Dan Carpenter wrote:
> These should ">=3D ARRAY_SIZE()" instead of "> ARRAY_SIZE()".
>=20
> Fixes: 10c5a8425968 ('i2c: qup: New bus driver for the Qualcomm QUP I2C c=
ontroller')
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Ah, right. I misinterpreted the smatch message, thought it was a false
positive :(

Applied to for-next, thanks!


--FkmkrVfFsRoUs1wW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJTPR1TAAoJEBQN5MwUoCm2KfYQALSbbnsg0/TtbZQ4KCzPwfgE
mV+XtnpPkQfZT+reqPLTka9GspyDTMw1qNJgFfP8xmHD2g5f+Rms+ghIqHW8XUk8
ESdRXD1J8gO3G8hbdKOJeUQaBU9DG35XRAlyP14Ec6m9tAfQ7EPAGfBU5hm/pjAc
NE2+QInk50MtzKOYPpLXtVJA8lR+V5ZYwKHxfFK9B3lawTobuvoJ2biB4WGdPtSj
DcTb59u7tURvOHUoBL5gIoavZmGESK88eGAPcJpG9yXGp3pTyJ3M49PYjwvlN4pR
VbiHaRcFytt/NNYJMRxHabBq0wL7OPDcMzwnnL21vWlHgwTvyp1/l/UsiKE6pQ9P
Pj2P4tzTL6KYlZkVsMaoOxTm2xg1Gcsr1kw2FBz58mj9OEUNz2KBJLClw4MAgQQr
nq6hxeKbOGzWkSTpEryURwnIRt9c8srgQwa52AiaT/IjNSZXPGR4j1lDJvfu23ia
YpS7GItCzWu+9qdFzBDz8bekvaQumDuWL7VF9tg0XPJ3+ghdCUo3+AxAvG+KJANB
v4zpah8TFRGmBgD0luRypg2eLD7Kzun14b2AzABDUcE4X6xnVQnXIBMev3Lx0sp7
YjxyAYfqLia0md3stCX9UmFIY0hOCqJdJI9G3ODv6wjb0Z3rtCKfPlDxkrjKMkt1
NdKEKybz0hp8sgpq2oWz
=LN0q
-----END PGP SIGNATURE-----

--FkmkrVfFsRoUs1wW--
