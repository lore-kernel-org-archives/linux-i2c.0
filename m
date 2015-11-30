From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: davinci: Increase module clock frequency
Date: Mon, 30 Nov 2015 14:55:04 +0100
Message-ID: <20151130135504.GE1513@katana>
References: <564DBEE3.4030508@nokia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wchHw8dVAp53YPj8"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:32785 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752962AbbK3NzK (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Mon, 30 Nov 2015 08:55:10 -0500
Content-Disposition: inline
In-Reply-To: <564DBEE3.4030508@nokia.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Alexander Sverdlin <alexander.sverdlin@nokia.com>
Cc: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, linux-i2c@vger.kernel.org, Murali Karicheri <m-karicheri2@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>


--wchHw8dVAp53YPj8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

>  	/* get minimum of 7 MHz clock, but max of 12 MHz */
> -	psc = (input_clock / 7000000) - 1;
> +	psc = (input_clock / 12000000) - 1;

Doesn't make this the above comment invalid?


--wchHw8dVAp53YPj8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWXFU4AAoJEBQN5MwUoCm2y7cP/AzgkewC4hqtLQ9voXBLommT
4/ltO2Je4SH8C2pteO/gJUjFv9CE/sI2IWUx6ky7t+q66ejCOmfs8uRl3oAYxNH3
KoNPcPJRgN5maUbP4sBRC09zV5w2IcOUxxljkcXwIay87JgPS11RWmetQ/HcVfVr
uZPAaD6OXFkwBbcw1svvk1s/4C+UgO0N7Xipaz0wPXiyar0vabbkxpt2RefHxGKA
5Pj44SzHoGZuoijABIbPkb7aEojtH0qRkiZCfRZiM7oLCUFBMkgSTIjW812Nnu+M
ZB8fVVucDOHB4DuZpTRQarAjW7BNoe0HHjJxeNq7XWKTjnhW3ugO9+mI/oodjiR7
My9R4llSz4WfIzerb2RLI1Fg7JwEQHelnGVpIGMD861nmrsoyoaezk/mKWd/MHuG
9npKbg+M1XzvM1XaqLCqqc/Gva5gWfVnAE/98ZlVkKfZ1fdBPnftFX+VcYX8qkKb
R+qdV1OQVfKnISazGbKqC0NcIqCkTGavxtCXfTijWkR35GhSjcT9/2UCw7EEA5km
1Grmh/R9NSgzkK5ZH8EItMdRYIx09mkvH3oa3C4efd9wR+ZC1YeVTgbgoKv0Z886
JUZ3e/DLrPbLz5zINM0W7w1thlhJ1Ma4t1Mptokr4enQ6L4JW7jrLUYVnj6HNJ1s
Pn5/mMeIRAEARFhuFXR8
=6VbR
-----END PGP SIGNATURE-----

--wchHw8dVAp53YPj8--
