From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH v2] i2c: core: make it possible to match a pure device
 tree driver
Date: Fri, 7 Jun 2013 23:32:42 +0200
Message-ID: <20130607213241.GB3047@katana>
References: <1368476301-10495-1-git-send-email-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XF85m9dhOBO43t/C"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1368476301-10495-1-git-send-email-linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--XF85m9dhOBO43t/C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

...
> I2C devices probed from device tree should subsequently be
> fixed to handle the case where of_match_table() is
> used (I think none of them do that today), and platforms should
> fix their device trees to use compatible strings for I2C devices
> instead of setting the name to Linux device driver names as is
> done in multiple cases today.

I guess your solution is the least intrusive one. Still, it could happen
that of_match_table is scanned three times (by driver core, i2c layer,
and i2c driver) which is IMO an indication to look for a more elegant
solution tp find out what really matched?


--XF85m9dhOBO43t/C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRslF5AAoJEBQN5MwUoCm2xCwP/304DMmpz8mhczpruALsrPDO
LH799vE0eiZPeH8Zj6gj+6lzYiFedbZZqm1MwQBUzdrQGFO8+XouIXxPFJKAqOPC
vVt2VOxp3IVtGQDB4Ceh0/ZP8Dh11J+/Fs86k/gwo6mQo1nAzw2I6aUbZ6E7d77X
qGtY6ESfCFJGib55FJTQZH/dQ4XgoBgXMEPhgPhU0KxyTI4ktHsV91lHJRj6ln/r
2SC1wVG+/ad+eofPD5aTSli+4JNs6VQyHSXIm6mhkvHaHIygA6JNe7+EmGyjhEiA
+4z1zvbebuuchOSRl+b1sEzpUo2BqEXuY9SU1/UXxi6saY+g2/BXaLUlvmuYo5zf
Lhi0oLd4mqAc+9+ENDZ3I+/OjggHZG/CPwaBwq7tpsmowx2qNZVO0ST75GGb/w2Z
7k1E02TyInhN0mnFNCHaZ1t4wOL4JzvaOlJF5I0ZaP38u2CjzWVu3I856d+Cem34
1ZSUQYjWd6V26w1BTM5yhjv64Cugd2sg4pOjyMWnEWzcjwuF3UcusETZt63Dk6vr
xMcvRru1gN+PqUuVJVotSGwCHP5SVatO+mbyDx6fz+qd3WxspH7JxSHplofX5841
K1ZK+GAfVixD88tliZhFNRZhhsJ1S9Rq/xIDzaG8Odl+TlI8JQAUMNDoXgCuEp5O
c5G5u2BHVTRucH+xiSnH
=VNEL
-----END PGP SIGNATURE-----

--XF85m9dhOBO43t/C--
