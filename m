From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH V10 Resend] i2c/designware: Provide i2c bus recovery
 support
Date: Sun, 8 Sep 2013 19:25:44 +0200
Message-ID: <20130908172544.GB3154@katana>
References: <70c7ee79478cc2b89ad876d814207c6433e26a59.1371474881.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CdrF4e02JqNVZeln"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <70c7ee79478cc2b89ad876d814207c6433e26a59.1371474881.git.viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, spear-devel-nkJGhpqTU55BDgjK7y7TUQ@public.gmane.org, u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, Vincenzo Frascino <vincenzo.frascino-qxv4g6HH51o@public.gmane.org>, Shiraz Hashim <shiraz.hashim-qxv4g6HH51o@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--CdrF4e02JqNVZeln
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 17, 2013 at 06:46:45PM +0530, Viresh Kumar wrote:
> Add bus recovery support for designware_i2c controller. It uses generic g=
pio
> based i2c_gpio_recover_bus() routine. Platforms need to pass struct
> i2c_bus_recovery_info as platform data to designware I2C controller.
>=20
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino-qxv4g6HH51o@public.gmane.org>
> Signed-off-by: Shiraz Hashim <shiraz.hashim-qxv4g6HH51o@public.gmane.org>
> Signed-off-by: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> ---

I come back thinking about it every once in a while but I can't convince
myself to let masters reset the bus after a timeout in the driver. I am
all open for suggestions here...


--CdrF4e02JqNVZeln
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJSLLMYAAoJEBQN5MwUoCm27/AP/01dGYrSgiV0DIMKAzjf5YRu
tMZJakcNuLODMshfYWpBYELARxHXSKOHVIUPxiyjNCmWUN0/dUt23BoTLQi0fbtd
x/GUuFq/wUZxQGRV1n9+McrL9i0SAj7/U1T+S8AuEvD0fo0jU1HfYWk0iG2VEirp
RI18fePxl83aIiTxM+rVZvrRVpZ4a83wLFkKQpIJSYGSZkeP39VCadIndIObKeBX
8Y1Qe6rurdqN1WutvfxW87AkFF/zs5Znrf/1hArlv5nrA1J96Nj+0tT1+S/M2sDj
DuEWpsy+USOY0itiLz17s22qEYJEun70WlDvxpivTcw9GoTi6PubHLLbvQbcybjN
FdV7e+EBlHISJ4XSW9Ktho3PB7dT7bKNbudkSMKaDiGps3EYR47ol3xX4V5Kr76L
suGVDpvIxvhno33ofQfGxqhfJkKXvVZG15P7/FTmWDdHAt3KaTG/tNxY1ia8JDdO
qrnK/t3xlJuAckXnuyEDDpA8/lOLLffXWC8HCz/y0Zm5ZV6vFAByr7ZrJc7KfheB
0u8v665ixgFCigbV7j/qJh9fGuygseDarldR68a+D4Cos9/92ApiRUH+uPNXjPCG
Zgtis+TGPPOpAWaSH/Sy0DyfNn4HBFiLYOHt7CFCqv7Qp/UDpiuBifSYRsx42EMb
tfjyHPBCIaQcAKchgm9c
=rEQT
-----END PGP SIGNATURE-----

--CdrF4e02JqNVZeln--
