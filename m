From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: riic: remove clock and frequency restrictions
Date: Wed, 18 Oct 2017 18:37:25 +0200
Message-ID: <20171018163725.ik6ieofpd6ehilbo@ninjato>
References: <20171018140459.104351-1-chris.brandt@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="wr4eryw4isbeuvcc"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171018140459.104351-1-chris.brandt@renesas.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Chris Brandt <chris.brandt@renesas.com>
Cc: linux-i2c@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Simon Horman <horms+renesas@verge.net.au>, Geert Uytterhoeven <geert@linux-m68k.org>
List-Id: linux-i2c@vger.kernel.org


--wr4eryw4isbeuvcc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> +	brl -= t->scl_fall_ns / (1000000000/rate);
> +	brh -= t->scl_rise_ns / (1000000000/rate);

However you solve the precision issue, please take care about the "space
around operators" rule afterwards. checkpatch should help you there.


--wr4eryw4isbeuvcc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlnng0EACgkQFA3kzBSg
KbZbaBAAqra9PU01Q6YLCN7W5BJNXRAIMgzv25EsvYQ8k/a4lsAEUzZRewBUqA2J
3pZW9iUnk12kHJwjsFRk3gahJKiPitT3t7oUYE0hhIKl3JFRbkJm4ukaYnjapPVX
Wa+f1Uuu3wzmiOR8wmb9q0+/2c8TFKcu2waACATI065RLSEibsRj+KeSsF2byr99
IiCNE/e85JsF1bLb/z9GPyftehPhDwW1fPNJLtUc2AkjXWLB2WUXZr29UmRsy4mI
vnpX4bZ4YPt8gjGGHVqtmyf48j2yOtTKumhdTpDrQJvoITy4mXauz+KWr6rJ3Ktc
/o+U4AQ1dv6PMy35y24IBrLEOaNoAvVT9+M7x7Jilj5SEzCWNZkwlNc2Q0/KdXfk
lOJmtkHwJvSUE+/rMmNYqouuWtamS3xLEMGIYMKaj/N7+eSZH5nk9P8lOS5DNyXt
9I73o0AV2/6bUb5qj9+Mzyvd4QOLwfhjOvfwt/7datNQu2cbCc4dnwtMkCWsxxLw
U9rADbi2ioUXgvA95YX+7UAB1i5ws3XbOqjkQgNEu71YDf9GRHFOZGGfirxIp3r/
Wcrm5fDks3EkUYpwETZ0xhltRKRQrtR9NdQ0Za5zbDhZgNfcFZjbK/IbgG8Jml8D
hmHdEq430A9JgrnPZ5w63NblZ0Ioet8v2/n7+Z7YNbi4/lBf0xo=
=Ba9q
-----END PGP SIGNATURE-----

--wr4eryw4isbeuvcc--
