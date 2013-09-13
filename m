From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 1/9] i2c: prepare runtime PM support for I2C client
 devices
Date: Fri, 13 Sep 2013 11:02:02 +0100
Message-ID: <20130913100202.GB29403@sirena.org.uk>
References: <1378913560-2752-1-git-send-email-mika.westerberg@linux.intel.com>
 <1378913560-2752-2-git-send-email-mika.westerberg@linux.intel.com>
 <52323AC8.30403@gmail.com>
 <523266EC.1060501@intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OMnfC9oq5hdMsh0V"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <523266EC.1060501-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Aaron Lu <aaron.lu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Sylwester Nawrocki <sylvester.nawrocki-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, "Rafael J. Wysocki" <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Lv Zheng <lv.zheng-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mauro Carvalho Chehab <m.chehab-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Kyungmin Park <kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--OMnfC9oq5hdMsh0V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 13, 2013 at 09:14:20AM +0800, Aaron Lu wrote:
> On 09/13/2013 06:06 AM, Sylwester Nawrocki wrote:

> > So there is currently no way to avoid this behaviour, i.e. to have the=
=20
> > adapter
> > not activated before any of its client devices is probed, but only late=
r on,
> > after explicit call to pm_runtime_get*(&client->dev) in the client driv=
er ?

> The above pm_runtime_get_sync is used to make sure when the client I2C
> device is going to be probed, its host adapter device is turned on(or we
> will fail the probe). It doesn't affect the adapter's status before the
> probe of I2C client device.

The expecation is that if the adaptor needs to do anything to transfer
it'll do that when asked to transfer - that way it can sit in a low
power state when the bus is idle.

--OMnfC9oq5hdMsh0V
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.21 (GNU/Linux)

iQIcBAEBAgAGBQJSMuKWAAoJELSic+t+oim9pnEP/01pgNIbFRloFV0EFiAZ9e80
LBHLuQDPvL8wCsk+VcF5TnQ/AsaECoM3a2w4BGqRTAqiUQC/nQe9tEyc8VwAFy7k
e9DeroLlsVajQTGiFSZ0JlPYiFpNwWM2b7YMu9eDZHDKzHPe5KzZQtcECmNOXLLy
PIf6hamhX453X822h1JMPDLZ9diiaw5ujYha1a4MLQMcAQ0nUptUjEyoajvD29hV
jyTBzDS0q6DJK4f17D/ArEPsmuHoLrbN9q489WOfhoHydShwF2jRtme+m0b+hqcC
0yfa7dF36X+/ZEuggEpxNbRSPT8OJx79qELAMNzkktH9zw+18pkuefJcUEs0a+se
4wQVLnxWZv2UKReykscIN2WHwQ0umNVDQiu+4TtLJlmtDm9+amKJaNffXUj4l7t8
yNOOgoB/2vUGtfg3IHFS3GwJrw7F43bm/kzRsdj36diXescR9xLay7wVbzUIXOLR
TPV5uE4DvA7z5oul3in4R0Y1Htpj6PBvMcCC+maqUGP/oR6K/uS8afTQMulTe1sC
fU5cSBfP7xyMHfDwD0NHkyvtIWi5xdIhc9HM33D1yK/vWbPOHL6SUX0Vf5tf+Mtx
ZIrGGIZnEDxTDOXnxCS0A7fNeSGiyoRSYmUHJefqfCy+2cZESbVmnAgUV6P/T65F
mODwsA/83Yo1jFtaVqTD
=3xDW
-----END PGP SIGNATURE-----

--OMnfC9oq5hdMsh0V--
