From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: sh_mobile: send STOP according to datasheet
Date: Mon, 27 Nov 2017 18:57:04 +0100
Message-ID: <20171127175704.47ikvrnwbd5kd632@ninjato>
References: <20171110115210.21955-1-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ikcejdxwhhb64hz7"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:47851 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753166AbdK0R5G (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 27 Nov 2017 12:57:06 -0500
Content-Disposition: inline
In-Reply-To: <20171110115210.21955-1-wsa+renesas@sang-engineering.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-i2c@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Jacopo Mondi <jacopo@jmondi.org>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>


--ikcejdxwhhb64hz7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 10, 2017 at 12:52:10PM +0100, Wolfram Sang wrote:
> We initiate STOP (or REP_START) on the second last WAIT interrupt
> currently. This works fine but is not according to the datasheet which
> says to do it on the last WAIT interrupt. This also simplifies the code
> quite a lot, so let's do it.
>=20
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Applied to for-next, thanks!


--ikcejdxwhhb64hz7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlocUfAACgkQFA3kzBSg
KbZseA/+IigVNkFB/ApQLjRHxOVd6KS16kKalQJB7lBRkW3EHxjBQjg7re/otw6N
J72A8PLa3tILXm1QoH0dVcifQo3ChCaARxc+njo23OVXNFOslx8OSau96srVngJd
5jrioHj0ksNLQnyDZrJLvfMP7lZY64jaDd6/u/2sAf+D9Nod6WcxParxJfUUtEyi
ZZ3oGGluNxugTryE2n3D5vJ2WOt1o2tLXkLg8NckfV7W4VOYmhK09QJRaSYhlAut
2jYOHJUDkGnP2iNayh2mZ3m6PXeQHk6yaqRe0+tcW72R/aOMtHk2urk/iXDjSOMH
6F2qkGD4XECV2tFxB5slVV5FV1IG84qlAsrqbJprdUmCWD7sU+C/55ZR0VwJceLK
joZjkFKyp62VyuuH6xV+9aHcrZDKdv/IquJqCTBTDu4BCxDe3Z9W/2MEw7l3calY
Z1UhiDhDfBGQGSLb6A0AwkwU5SVS/snM55qUouUXhsgcZELUCwU3GVDOC5jiAj6A
8NFt9hZNGvf7eyMjcVxK8Q8BLuv8Gp3NfrIWDEj4vaJwBuP57aN8BkDdCvP11Xj2
AH+Bmlef6MWH4ix3OmL8qiTgM1JtD3Y69/g5FFnmtRAw/P0JdEG8weE+1wM7gmuA
rms3/hTOpY+FjyRg1xSY01uJQN75rNi5cm9Ym/c8eB9gHoI4qI4=
=DCYy
-----END PGP SIGNATURE-----

--ikcejdxwhhb64hz7--
