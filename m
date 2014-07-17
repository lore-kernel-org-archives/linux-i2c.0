From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH v2] i2c: efm32: correct namespacing of location property
Date: Thu, 17 Jul 2014 15:40:00 +0200
Message-ID: <20140717134000.GK2740@katana>
References: <1405066940-12919-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <1405068614-14279-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Ah40dssYA/cDqAW1"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1405068614-14279-1-git-send-email-u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--Ah40dssYA/cDqAW1
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 11, 2014 at 10:50:14AM +0200, Uwe Kleine-K=C3=B6nig wrote:
> Olof Johansson pointed out that usually the company name is picked as
> namespace prefix to specific properties. So expect "energymicro,location"
> but fall back to the previously introduced name "efm32,location".
>=20
> Cc: Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>

Applied to for-next, thanks! If you think this is better suited in
for-current, let me know.


--Ah40dssYA/cDqAW1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTx9IwAAoJEBQN5MwUoCm26vYP/2Bp7QzcJiZpEpfNwhNGOjW8
xZB8+B9m2e75F+XJRcnZTNrPOXRTVZ43VB63mTGDXCGZKYD3g/rCfOsErK4dQwY9
vzdVVeCXAKA7+X5qxP/0uOycSF3NGzFXHSUabP7BHvAg68I2exnE47OrKXSsGr87
DQyMXKFJIpXhJIkA50gzNo+x3rx7ceg3oe1RR2axKOOixRIGIQV7m/Zt8qpYxmkx
PvMWX74l59jlbg5lqYy7dPXPKjoKyywDhnoq/w6J0Y6LuGsdIijw7AWsSvHO2pLY
Pq6pmK1Lqf27ugqabcfU+UbIQRbj2sXHG6Mv314BwuMXlGuEgWOg5U1VZYSkHbPo
QEBlhdLewu0+EUXVwhCvdNWgHvYTj6pcXTkWhSNk0jarEJbWwtJrPmZQZyZcUXF1
wprF5CNGvvrfqNw1IrTJT02RxwJsO6GJC3BzZTH95YQgJDxPChBNwSywaM4Qnxmc
xHvTEfbojCTt4i+Xr03W3Rs4U36KnbN0xwuRKOTQt1oHjdhl6fAYxQILAELK5Bbq
O6If3zaLqS1NualuZaZlZKXMF3w1NKeEhOajZm3Qt0nSx6AKKXV2ZBpI772ooAjy
CzeAQDj9xEIgNuKPOCiUfej6musAfsw+0DTUhIGy+CAyprwqA7GL7A6TUH0zcEzK
WGdU6N8SmT32aB/X8yxl
=VSPe
-----END PGP SIGNATURE-----

--Ah40dssYA/cDqAW1--
