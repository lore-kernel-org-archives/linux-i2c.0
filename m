From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [RFC] i2c-tools: allow linker and compile flags from command line
Date: Thu, 9 Jul 2015 18:50:48 +0200
Message-ID: <20150709165047.GA4744@katana>
References: <1434705872-2866-1-git-send-email-wsa@the-dreams.de>
 <20150707210828.0e5caf05@endymion.delvare>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="nFreZHaLTZJo0R7j"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150707210828.0e5caf05-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--nFreZHaLTZJo0R7j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> You can already overwrite CFLAGS and LDFLAGS on the command line, and
> this works for the whole package. Do you really need to set different
> CFLAGS (or LDFLAGS) for different parts of i2c-tools? Seems overkill to
> me.

I agree, not really needed now. Let's skip this one.

Thanks,

   Wolfram

--nFreZHaLTZJo0R7j
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVnqZnAAoJEBQN5MwUoCm25D4P/RKNhpSO6UbMZ6MfsHvTnICx
732dj2SdyY29jOuGtBI0NtUL8uDslUdx3KUy6ss/HJPw0wE5PC8mPVLl1tNOce3v
jExOcmaAaCtXOEucfJ3mkBNYaA3WNUwQH0KO2o1GI0IYV137ijKnPARQr0pF1Mkp
1Do9eKec8FGtj5IIzVgHT1aIv7d2FtmOy2FQcm1qfVXZPCjC0RaOUFH4h1lTmI9l
K0tIN1p8M6GICJiBabQPA68LPc6QQhQLCZLaTAthm8+/eoHxCb7ewPjKRPVaVCUf
4HHR7C/7/nd5uup06adMO1koD5py7Smq4G/TxdpplxEnLXOra1OPmWnrNKkI+W5G
A0EN6nSs3qukBc2vP+Gh3ze/MvwMORJePoJnayYnvjAgAuSoMWwxpza71mdxUrrp
OWMTFJ6hVU1L4dvW3E39LZnJElZ7c+0axj+KK67HCUV9eoiCW0cqxWSP/ii4xeJW
wwNyc8T0X5WUj1dbGYLO9pywVPQ2gJSvDV9kOpyddagXEkRw67xalyGUrqTCA7I0
yJMXb65mvJMcXxYt63TIvVmj75Jcrk0tjI0LM7S0U2mKEqKd6swW1gLvmOnNZUth
AoSlEmUfRDtf1fdWIFk7lzJiZ5mwX0Rw2ZBMzIQr3Ty6JSNwgQULS4CRHjzqvKrF
WFV6zVWH3jUY3ymkXtk+
=kp/f
-----END PGP SIGNATURE-----

--nFreZHaLTZJo0R7j--
