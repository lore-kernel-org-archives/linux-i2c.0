From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: i2c-imx: Use correct function to write to register
Date: Thu, 22 Jun 2017 10:54:38 +0200
Message-ID: <20170622085438.y3xgfml3pgxaylhr@ninjato>
References: <681500CE65202E47A192754B01DAB4671B16747E36@SDE12.beckipc.net>
 <20170619144601.vhswaa27f5mcxcxs@ninjato>
 <681500CE65202E47A192754B01DAB4671B1674818F@SDE12.beckipc.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="speaoyraaoqcgned"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:36485 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752621AbdFVIyk (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 22 Jun 2017 04:54:40 -0400
Content-Disposition: inline
In-Reply-To: <681500CE65202E47A192754B01DAB4671B1674818F@SDE12.beckipc.net>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Michail Georgios Etairidis <m.etairidis@beck-ipc.com>
Cc: "l.stach@pengutronix.de" <l.stach@pengutronix.de>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "kernel@pengutronix.de" <kernel@pengutronix.de>


--speaoyraaoqcgned
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 20, 2017 at 10:20:42AM +0200, Michail Georgios Etairidis wrote:
>=20
> The i2c-imx driver incorrectly uses readb()/writeb() to read and=20
> write to the appropriate registers when performing a repeated start.=20
> The appropriate imx_i2c_read_reg()/imx_i2c_write_reg() functions=20
> should be used instead. Performing a repeated start results in=20
> a kernel panic. The platform is imx.
>=20
> Signed-off-by: Michail G Etairidis <m.etairidis@beck-ipc.com>
>=20

Applied to for-current with the acks and fixes tags added, thanks!


--speaoyraaoqcgned
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAllLhc4ACgkQFA3kzBSg
KbapsA/9GvtPaX0U2EC7SGy7i7UWTFawz1ObegBNxe4OOcwO+ZcH4HmTavv6VoRj
rlnuruHOgdLxrGCMN5bSRhB5I1EnQEl7mM4mPuRoVg4Sdx0zC83DaTnEg1sGflOR
uvC8mAT9epQy8DinuN04vPBVkSpHT0fUrSe3eKujrrLHLgFcIiCrjqJWm2uw5WfL
6bqmqS6NqpPvpf0dk9A00EjSHjCbmpS3bB8wqCitXLz2yiAHTv0yEFR1LON3qrhe
jxMp3440ghHI8PgKibNjo0b/WDeG3tdH5NQ1mSg1Fww1r+geKfunMXFvjYinY5Va
O6HjrofD0F8aGp7JmjGubDIg4Yj9SD9MjZ0WGaTQs31NngjkTHqyyAWL/kAngRAi
5jEKZtMBAOgWTHeFYvNFmYHJBj4wOu0dpOubsBj3K3ZDk7kiFB6kjXkJmu+yyZy6
L5+afZSdrtdEZIs8LovRQM/aHl5EVT7veQix8Q1eRditGEB3Mpfwyz4eh8GTJBbF
2r1D5/qWMcUfYxMuQJ5pZxN94GRJKP0fY3Zsn74Lo2m0YKreSJXf87xXFs42wfXo
BVHG4Gow01Lr6uXZFIEmtjrR55F65B9hdFq+ts6u71mAh+/nu768j+GEMeb11Ptx
MxsUY1cmAt7yjOlt18V6/F46b0HlmkDu0W9wjDiVY9hosv9pIpY=
=pYVi
-----END PGP SIGNATURE-----

--speaoyraaoqcgned--
