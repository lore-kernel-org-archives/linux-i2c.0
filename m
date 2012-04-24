From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH V2] i2c: Add generic I2C multiplexer using pinctrl API
Date: Tue, 24 Apr 2012 22:09:29 +0200
Message-ID: <20120424200929.GC30172@pengutronix.de>
References: <1335289664-21383-1-git-send-email-swarren@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="m51xatjYGsM+13rf"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1335289664-21383-1-git-send-email-swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Cc: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--m51xatjYGsM+13rf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> --- /dev/null
> +++ b/Documentation/devicetree/bindings/i2c/pinctrl-i2cmux.txt
> @@ -0,0 +1,79 @@
> +Pinctrl-based I2C Bus Mux
> +
> +This binding describes an I2C bus multiplexer that uses pin multiplexing=
 to
> +route the I2C signals, and represents the pin multiplexing configuration
> +using the pinctrl device tree bindings.
> +
> +Required properties:
> +- compatible: pinctrl-i2cmux

=46rom what I know, compatible-properties should not be linux-specific
since devicetrees are OS independent. pinctrl-i2cmux sounds
linux-specific to me.

So, is such a binding acceptable meanwhile?

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--m51xatjYGsM+13rf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAk+XCHkACgkQD27XaX1/VRvwqQCgiaU80bU3P6v8Ba4mhyrQyN/Z
8Z0AoLNQTuSCKcfGTfA+m4qcFAQNdvLR
=iKNu
-----END PGP SIGNATURE-----

--m51xatjYGsM+13rf--
