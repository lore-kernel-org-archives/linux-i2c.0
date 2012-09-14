From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH 1/2] i2c: (algo-pca) Fix chip reset function for PCA9665
Date: Fri, 14 Sep 2012 14:12:44 +0200
Message-ID: <20120914121244.GE2630@pengutronix.de>
References: <20120913134128.GA1343@roeck-us.net>
 <CC77B638.1126D%tkavanagh@juniper.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ILuaRSyQpoVaJ1HG"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CC77B638.1126D%tkavanagh-3r7Miqu9kMnR7s880joybQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Thomas Kavanagh <tkavanagh-3r7Miqu9kMnR7s880joybQ@public.gmane.org>
Cc: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Guenter Roeck <groeck-3r7Miqu9kMnR7s880joybQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--ILuaRSyQpoVaJ1HG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Thomas,

>   Hopefully the information below explains the problem with the current p=
ca9665_reset() function.

Yes, it does :)

> Let's say mod1 has the following

This was the first needed information. You seem to not use
i2c-pca-platform but a custom driver using the pca-algo, right? May I
ask why the custom one is needed?

> Now with the pca9665_reset() function, the i2c-algo-pca module sets
> the mod1's reset_chip function pointer to pca9665_reset.  When
> pca_reset(adap) is called, the input parameter is of type
> i2c_algo_pca_data as expected.  Then pca_reset() calls
> adap->reset_chip (pca9665_reset) with the first parameter being
> adap->data.  This parameter is of type mod1_pca_data_t * in this
> example.  The problem comes from the fact that pca9665_reset(void *pd)
> is expecting the parameter to be of type i2c_algp_pca_data:

To put in other words: All other wrappers from the algo call back to the
bus driver which knows to handle its custom data. Only the pca9665 reset
is staying inside the algo and facing a custom data structure it
doesn't know. Okay, understood now.

Thanks,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--ILuaRSyQpoVaJ1HG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAlBTHzwACgkQD27XaX1/VRsNVACgh6mx8IX9rglVfuK/7if/iTZh
D/QAoK8ZgxGvBvAYx4gc2+8CMLDJ4GWs
=XhqO
-----END PGP SIGNATURE-----

--ILuaRSyQpoVaJ1HG--
