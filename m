From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: Fix error print when address is invalid
Date: Tue, 24 Jan 2017 08:54:58 +0100
Message-ID: <20170124075458.GA1432@katana>
References: <20170124022424.18212-1-stephen.boyd@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="x+6KMIRAuhnl3hBn"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from www.zeus03.de ([194.117.254.33]:57984 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750704AbdAXHzC (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Tue, 24 Jan 2017 02:55:02 -0500
Content-Disposition: inline
In-Reply-To: <20170124022424.18212-1-stephen.boyd@linaro.org>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Stephen Boyd <stephen.boyd@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org


--x+6KMIRAuhnl3hBn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 23, 2017 at 06:24:24PM -0800, Stephen Boyd wrote:
> When the address is invalid, we print out the address that's
> in info.addr, but that member of info hasn't been assigned yet.
> It's assigned in the line after we check the address. This causes
> the print to show something like
>=20
>      i2c i2c-1: of_i2c: invalid addr=3D0 on ...
>=20
> when we want something like
>=20
>      i2c i2c-1: of_i2c: invalid addr=3D0xaf on ...
>=20
> Just pass addr here, and update the print format to indicate hex
> as well.
>=20
> Signed-off-by: Stephen Boyd <stephen.boyd@linaro.org>

Thanks, yet already fixed since v4.10-rc4 with 6f724fb3039522 ("i2c:
print correct device invalid address").


--x+6KMIRAuhnl3hBn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJYhwhSAAoJEBQN5MwUoCm22z8P/3mMpmF0zevtLPotQ2AdRlzK
G13ZjLRJrVapWxtaz5cGMmxZWKYSOBZcozCjLDWS1s/WQX85r+7rz/1a85Ngonia
4cY3pLNR+EkxNyeSI5vJUMHSQw2r4GX6xtNKKew3dD11UXUg4l4zyismwqeiYMmL
+kldm3JyxbVvpCoKlxD5+XWV3SwY/FBAIEoKLHDT52yvZ6Qg/TsZptLf1iLtMQrW
/mP7lXr8wDoUS0SvvEIgA4HDIOb094SiGreFOP9oaf15yDAURW3DQ33BMe6BayxZ
aGjYZUwtKGFumqYhE+PuVMR15OAITPME2KYA/PMzx2R0iDRWI0bBAiizQ5hkxQgV
Svrt+YL7HQW6YaqcGzi7cjhXiGJfMHoGHSwb2W9ANwrMflfaF83qGrlpZWwnWG6F
rw73NZEuZqpzIcw1IV7zLJvEFh3USdUWL+/V0lbg9CqHogxahnDRUrjCfvX5Dc6J
p/uvzAN7Yqj8Q+RezlABJwREh43tDOCL1MIbxM39veknqWcKqX2kmX/KUO9F4Rv1
yWE90wMH0ePwFwQqYI0sS8K7q7EcZTfH0ze7c4+CJc5eJcYvxYHTYkeVhesq+gWj
QBnCMCSd1gIc61KywUe30eZdWk7oeRGkM2voOa/N+jcj4pxHBfdvhkwUtSPlbugV
ZihuTXiIqhQDhu2mhuE/
=WCr1
-----END PGP SIGNATURE-----

--x+6KMIRAuhnl3hBn--
