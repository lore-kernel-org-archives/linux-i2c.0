From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH v4 1/2] i2c: add DMA support for freescale i2c driver
Date: Fri, 4 Apr 2014 16:40:43 +0200
Message-ID: <20140404144043.GB5529@katana>
References: <1396579272-19542-1-git-send-email-yao.yuan@freescale.com>
 <1396579272-19542-2-git-send-email-yao.yuan@freescale.com>
 <201404041628.55471.marex@denx.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6sX45UoQRIJXqkqR"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <201404041628.55471.marex-ynQEQJNshbs@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Cc: Yuan Yao <yao.yuan-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, mark.rutland-5wv7dgnIgG8@public.gmane.org, shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--6sX45UoQRIJXqkqR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 04, 2014 at 04:28:55PM +0200, Marek Vasut wrote:
> On Friday, April 04, 2014 at 04:41:11 AM, Yuan Yao wrote:
> > Add dma support for i2c. This function depend on DMA driver.
> > You can turn on it by write both the dmas and dma-name properties in dts
> > node.
> >=20
> > Signed-off-by: Yuan Yao <yao.yuan-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
>=20
> [...]
>=20
> Since you will be fixing that superfluous return 0; (I actually wonder, d=
id you=20
> really test the driver at all before submitting it?) ...

Good question. @Yuan: Next time, please state what tests you did with
the new version of the driver.


--6sX45UoQRIJXqkqR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJTPsRrAAoJEBQN5MwUoCm2BCEP/ilKKFkvC/uAWFw9eqAYH2u6
c/2oPEyNjZEpeivg2p7EhFTl7DwMS0lI7ek57sQCt/uei385fCvclvxS43ZuDJa0
gUZ8RwUmjmVCbfiu4QNMXyQwWAKpKsOI8QXDPha3TaGKXlv5EN2jESmGTUGw48+8
edqcwC0Jn5NXXD5Y7u3bIXkKJefCcjasBmMBxR9112uFd5HRAVmHtmjwT3z1coE+
3ff3dYm8Z7If7GjK8jvX7ytSuTRC+z5nLjXd4RJCAtalXxDYZycoWL/KZ/ZmEtiG
LkuZSAwt1tm4Rr7VxZuxBJSLc6zlFCGkrz7vQvVTIkqVwoQqGYNi9po+yhfMUGYO
w1wRVVQbRydsbzTw8R3iibhcz+VC5O+hsZZf1QQYjP58hA1+AnL6WzhRgSbUXe9U
4AWr+bOiv1vMqa/i+r30ifA38MMbNl0JeU21lv0p6X/olE6V++XyMZWdO302ua92
QjagJs2q8HoFJrGJaigWBWvMVZZLNWpTbzssoO231E4JsZHJ38+apnnLak+xrpQU
YlZg72i2E21NaiLwmmHN+OT5uH8COM4QgFfmEbBx6JmBTCMDlJWPJshxpQSZ9W3u
fzwVbXurogeE8LqOukrm3yARs9RGlYES4ZLP//cAmfYOcheKd5jR7LX0O1yT4va+
HQhumrI4J38OuVXyz0sx
=ruNg
-----END PGP SIGNATURE-----

--6sX45UoQRIJXqkqR--
