From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH RESEND v2] i2c: i2c-mt65xx: fix NULL ptr dereference
Date: Mon, 21 Oct 2019 14:12:38 +0200
Message-ID: <20191021121238.GD1145@ninjato>
References: <20191018173213.13282-1-fparent@baylibre.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5162781053311543480=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20191018173213.13282-1-fparent@baylibre.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Fabien Parent <fparent@baylibre.com>
Cc: Ulrich Hecht <uli@fpond.eu>, drinkcat@chromium.org, qii.wang@mediatek.com, linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org, linux-i2c@vger.kernel.org, hsinyi@chromium.org, matthias.bgg@gmail.com, Cengiz Can <cengiz@kernel.wtf>, tglx@linutronix.de, linux-arm-kernel@lists.infradead.org
List-Id: linux-i2c@vger.kernel.org


--===============5162781053311543480==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Ycz6tD7Th1CMF4v7"
Content-Disposition: inline


--Ycz6tD7Th1CMF4v7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 18, 2019 at 07:32:13PM +0200, Fabien Parent wrote:
> Since commit abf4923e97c3 ("i2c: mediatek: disable zero-length transfers
> for mt8183"), there is a NULL pointer dereference for all the SoCs
> that don't have any quirk. mtk_i2c_functionality is not checking that
> the quirks pointer is not NULL before starting to use it.
>=20
> This commit add a call to i2c_check_quirks which will check whether
> the quirks pointer is set, and if so will check if the IP has the
> NO_ZERO_LEN quirk.
>=20
> Fixes: abf4923e97c3 ("i2c: mediatek: disable zero-length transfers for mt=
8183")
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> Reviewed-by: Cengiz Can <cengiz@kernel.wtf>
> Reviewed-by: Hsin-Yi Wang <hsinyi@chromium.org>
> Tested-by: Ulrich Hecht <uli@fpond.eu>
>=20

Applied to for-current, thanks!


--Ycz6tD7Th1CMF4v7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAl2toLYACgkQFA3kzBSg
KbZHYhAAl8PJLRm3n1nm+VexzkwL5Vr5flPI4eZvMIG+4oHfei8QC90cd7qAMaid
FLmD34xBk+wvW4QUp4VH/UoKm058/2xXE8xPEvVAZdxSVfhpU9tqkOsL4exxvv9A
ERB4uZvYNbirHWOEv4XgxMSKucnFU+HwcDKqR0JjVWcYfl7jRKoq8lWgiQ0lPSc2
y87dyYhM6Kp5XU3lGd8WqJbArlxT0h+4IzshXhg7Jh/nbqPIeu+R5jX1ilt1bj/A
Sk7UCssar8LQ9Xj8kYXWhm7YJZ4mD3DaQ5yvl086mI2QOuAd65MYsU8IiW1/Bq1f
JzBNSL0nms9CSZwnGL84qa4BC/3PT+MWMTDQYlsKAJAmhz4zkw8JMp2F4uI3KaZd
p4uX+T5ecjdljvDga5HEsJ9zumJl/U+Hy3jxY+rxLDF+3ZiTVrQa68Hft8S97OI/
83Q2LikqYYsbUJBXl/6asEdcpitFQwP545w/sSa5wa1kXBwCeCoAbFCxC+s4Sp7H
aXZQDALTnUeYSLi12K2LYzZ3JZcjr9rPBg5EDNssm3U+SZBC+YESlNIEhGM6HMzX
ZqHdhYmKM4FRI8F5fQ5ck7NQjq6GKckVIdUQM9q9eb/HdTw2ChgvetaVFO4JcdD+
WhaIBzgT2gL6ESoLO5gvFya2cV8faV+zrg+SzykofwM99hR4DtU=
=hHgJ
-----END PGP SIGNATURE-----

--Ycz6tD7Th1CMF4v7--


--===============5162781053311543480==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============5162781053311543480==--
