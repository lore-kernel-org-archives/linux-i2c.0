From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH v2 3/3] i2c: cadence: Check for errata condition
 involving master receive
Date: Thu, 4 Dec 2014 19:34:07 +0100
Message-ID: <20141204183406.GK7944@katana>
References: <1417610126-7957-1-git-send-email-harinik@xilinx.com>
 <1417610126-7957-4-git-send-email-harinik@xilinx.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lildS9pRFgpM/xzO"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1417610126-7957-4-git-send-email-harinik-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Harini Katakam <harinik-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Cc: mark.rutland-5wv7dgnIgG8@public.gmane.org, michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org, soren.brinkmann-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, vishnum-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org, harinikatakamlinux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--lildS9pRFgpM/xzO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> +		/*
> +		 * This controller does not give completion interrupt after a
> +		 * master receive transfer if HOLD bit is set (repeated start),
> +		 * resulting in SW timeout. Hence, if a receive transfer is
> +		 * followed by any other transfer, an error is returned
> +		 * indicating that this sequence is not supported.
> +		 */
> +		for (count = 0; count < num-1; count++) {
> +			if (msgs[count].flags & I2C_M_RD)
> +				return -EOPNOTSUPP;
> +		}

Yeah, a lot better. Probably it would be good to inform the user with a
warning what went wrong?


--lildS9pRFgpM/xzO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUgKkeAAoJEBQN5MwUoCm2CCoP/jd2i91LvyW0uRWrzwl++RrB
CXmWjLHT9r1+L6J3n6h09LJvx7/sRvQkHMW2QzVOIoq8PfdGkoLUL887UV7k3iMq
QljF7yr8eO3XezO1DHCnCtaMtH7nxDS3PWX8r0pmjgPNSNNUVWAySRF2aQjnymPA
MHonRUARDfQOvaqq63fYjM+IhIIy9FY+PxMoejPeO46eQ+aoD0ecba/TaLIxdLid
ZBZBfnQFHi0nnezOm3LX9H13C0mBPMLqJKxGk2LJTA7Tur03qCvRuzl0xhP0zwkc
bJ1AjJ3SlROWGe8ze9lAgkIgskpXwLIgG3DbdrFUFa5RYYCfhfWoupUchmORs6oN
MLuw+erJEEFN446I7Vyo7ldgrjS6IZXG7E7ouPqWXyc/E6qF8nVRCMfUlT6RNLZk
KwTo1auPg/flxwUyavik4NnaIRgVxbGo/eD8pgtQEchreJEn1eaKbNY63ja0LAsH
sd99x6Zx55biByp3DTk1em0TZWyZ+tJP0I9bRbqQq5kaRdy6fqX+HOJ/DKqGOesK
rO4KDoCnGoUjJEKtqYdDdpeuwOed3XRQklAJCcbATcjeFzC6KKw8H2rglW4eUsQm
AkMoYNqWnrlHlgzsGXO56ZVUKXhCvExZJ8TGYJVW100o4cEvGZtaddY8oJ+WHGJ5
+MyQkkSj5tq+tjPXdu/q
=Xd07
-----END PGP SIGNATURE-----

--lildS9pRFgpM/xzO--
