From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] i2c: wmt: match return type of
 wait_for_completion_timeout
Date: Sun, 15 Mar 2015 10:30:07 +0100
Message-ID: <20150315093007.GG3393@katana>
References: <1423392232-12937-1-git-send-email-hofrat@osadl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FwyhczKCDPOVeYh6"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1423392232-12937-1-git-send-email-hofrat-Q945KHDl0DbYtjvyW6yDsg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Nicholas Mc Guire <hofrat-Q945KHDl0DbYtjvyW6yDsg@public.gmane.org>
Cc: Tony Prisk <linux-ci5G2KO2hbZ+pU9mqzGVBQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--FwyhczKCDPOVeYh6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 08, 2015 at 05:43:52AM -0500, Nicholas Mc Guire wrote:
> return type of wait_for_completion_timeout is unsigned long not int. as=
=20
> wait_result is only used for wait_for_completion_timeout here the type=20
> is simply changed to unsigned long.
>=20
> Signed-off-by: Nicholas Mc Guire <hofrat-Q945KHDl0DbYtjvyW6yDsg@public.gmane.org>

Applied to for-next, thanks!


--FwyhczKCDPOVeYh6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVBVEeAAoJEBQN5MwUoCm2L1UP/jd59whkBOV01eQ5jfMURLQJ
ucrNSekC7KliBTAruZkAtvPYlTawOQALXpWpu8FrkpO7UnlHl9Fb3eDPBa/akBcc
/DwwiV69KD0OThZRiUNl9NN+XH3+LZapeFwmzYyZTQ6LnKZPkvOHwpghHFydYrG1
NK/75SWRYpF6bpeoA84vc/eatLHFo0BDvpxc/4q+igtQnzf1/raplE7mA8nw/brg
SdqFEtsOb+pYEwb7Slmnixkpoa2V2Id+Jed6RXirAArDmUw2AW/dQAI6skfHBCWF
s3sL0DY1dVtrdQvaufmAF8rUM38rwq30FhQP13lVQbxtcxM8zgVcKaQkQENrkIwJ
OXnanUe4pnA1UG4ry5glNhtlv3BWwzwne+jMgm3Zjwo8fSSt9SzzAQKHb1iitl2n
hNUIxOkcJ0rAPAMGTcFFaJlU10u1EOJYqHj68h94k3TKRuf26vfyK+qMJtc124Tj
tZEi4LQ33/tNgycQ4aWvSk5mcXZW3CnsPZaUkZ9RBcXH0+i5daMmeHk6coeOMXX5
ehCSYeIhXj5ZH9ILcxXGTc5ZdLO56e9E2wQTq3+L+1tYPuiOcXPsweZa//Ra/Fzi
teAqO3pl5KXTsB209PeCnrx8OwsZcmQfFJKXFG0dlAqpBJ87Rs+jMnupzddVvvEb
UnmApIXJfhl5sktVxEYZ
=YEWh
-----END PGP SIGNATURE-----

--FwyhczKCDPOVeYh6--
