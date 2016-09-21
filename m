From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 5/5] i2c: octeon,thunderx: Limit register access retries
Date: Wed, 21 Sep 2016 23:03:35 +0200
Message-ID: <20160921210335.GG1513@katana>
References: <cover.1474439371.git.jglauber@cavium.com>
 <a52c3157fd27c939185163d2df23e39174cabc60.1474439371.git.jglauber@cavium.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="+sHJum3is6Tsg7/J"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <a52c3157fd27c939185163d2df23e39174cabc60.1474439371.git.jglauber@cavium.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jan Glauber <jglauber@cavium.com>
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--+sHJum3is6Tsg7/J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 21, 2016 at 08:51:06AM +0200, Jan Glauber wrote:
> Do not infinitely retry register readq and writeq operations
> in order to not lock up the CPU in case the TWSI gets stuck.
>=20
> Return -EIO in case of a failed data read. For all other
> cases just return so subsequent operations will fail
> and trigger the recovery.
>=20
> Signed-off-by: Jan Glauber <jglauber@cavium.com>

I didn't really check, but have you considered using
readq_poll_timeout() from iopoll.h?


--+sHJum3is6Tsg7/J
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJX4vWnAAoJEBQN5MwUoCm2sA0P/iAS29xtjlehE+t+9mCOQFO5
ujYBBIKfY52j59dLcztElaEfBcUInuUs3QXp4FQ9Xm/vu2lE/tVYW7vD/tWs+dnx
ZO/3dPg3jQ4Bfok++njXfW+OlhGsoy/vlJaW4jry/ZBs++4dOhWQcIEObzbHrb2i
bDpjcO5CWQx42iZUssKPGPmmcz3wI1zeDFSmvKj+48hBYkINp2QfsO2Zk7j8NLJm
af0l/rcn6ucizGnCEvBZSkUKFEJH8XfW1sr6rDpIy+iakqKt1sFTxyublAGXpWWI
nafVhEwD7JE+pjY4SD3ioEW6ZheLLDwWwEFf4gNa9BReq5+IxGgZEralcD3Ej000
zdZ2/PZvEp3/g5s5uPeehKkaaGICG+UCsvdkwobb2OVc3xfvWUBtWBAyatskvgEr
RVWNoNg1KMVnyWguyP9NbmtCWGph3vW7uNuCZy1HWhifLwa8dLKwtq9alMVjBxTJ
+rC7QrERR9AwEefZ7t8hVA6aR0enE1txRb5CGMlhHXQfB+kCYFqHtZ0xPouH16a3
WdT8/ns+h5FyZRTAV4+N8AZYpDuhmadmZoRKrwbWx8MDmA2aCNn8/EgMvl04mZvf
ap5ArJ5s9bQvPQqqPEbTN5LIf/RCsrZp0T/Z5LvBzGDRpJaJc91V+stMU2x6Mcft
K9TvzcwI1iiqvrkPH9ys
=J/KM
-----END PGP SIGNATURE-----

--+sHJum3is6Tsg7/J--
