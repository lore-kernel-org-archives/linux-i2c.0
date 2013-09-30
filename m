From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH 1/4] driver core: introduce helper macro initcall_driver()
Date: Mon, 30 Sep 2013 12:15:00 +0200
Message-ID: <20130930101500.GA3222@katana>
References: <1380518035-5319-1-git-send-email-hanjun.guo@linaro.org>
 <1380518035-5319-2-git-send-email-hanjun.guo@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EVF5PPMfhYS0aIcm"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1380518035-5319-2-git-send-email-hanjun.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Hanjun Guo <hanjun.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "Rafael J. Wysocki" <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Fabio Porcedda <fabio.porcedda-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Libo Chen <libo.chen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, patches-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linaro-kernel-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, linaro-acpi-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--EVF5PPMfhYS0aIcm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 30, 2013 at 01:13:52PM +0800, Hanjun Guo wrote:
> For some devices especially on platform/I2C/SPI bus, they want to
> be initialized earlier than other devices, so the driver use initcall
> such as subsys_initcall to make this device initialize earlier.

And this is something we want to get rid of in favor of deferred
probing.

>=20
> But for those drivers, lots of them just do nothing special in
> xxx_initcall/exit, so introduce a helper macro initcall_driver() to
> eliminate lots of boilerplate just like module_driver() did.
>=20
> Signed-off-by: Hanjun Guo <hanjun.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

So, NACK because using some *_initcall in drivers should not be
encouraged.

Thanks,

   Wolfram


--EVF5PPMfhYS0aIcm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJSSU8kAAoJEBQN5MwUoCm22lYP/1yp8oyuansz0qy9vW/oUeHa
dBr2w1JH66nXyVx46p3kfnMaYfLvw7WxmiMQLm5lse1uObAKH+xXC9dZCG2VCdLu
MTokQFYi0ueejnAr61FrDX5hUGx6hfkbSN5XO5ftHeOnNiSuCNwBRf5gekx4wABC
kR9+DyB41dxy7dRI046aNYY4dXsMwyAlU0lsAOeVJniNWFqftmpx91ETmvqMIUsn
/V7D0qRV+EwIllnc4t4p5CXxvW2saQVEcT3wag8LCM/ylk3QcOPODMtKtaUa9Hms
LB9VHEIAxsezzgbTP//xrkcksHX9KvkSG/4H0D4FmhjgvzrbGFSRLltGkdkieiv/
Uh9/mmv+3CDjsQwiyjMqtapugZWfyfQ667cwUTbLepSdvb22WfvRVrBGBi9JnAgQ
368WlzedAF7+x12zoT/ZRF9F2LDIu05JaYOZpL+hoQpX7zZ7U7nrM3u14tXPnf5V
M1it6tKbymxI9+OZEV7zjJpKPXkagVSn9I4z9bJidtwj415aQ3Q30d8CS6OAnMvv
6a6+YOztmhNj2JX9IWq2K6n6kgdp9n46aOrbBcaFIGGYg+1vj1YAivJ6uHWjEo70
0Vo0m4EzAPNblDAmp12ZAhG0BdKbZrudA0IyBhq8UvInJ9Jgp6zLJNn87tgAZq6Y
XDXXVodMXz+STDPOl3xb
=FBar
-----END PGP SIGNATURE-----

--EVF5PPMfhYS0aIcm--
