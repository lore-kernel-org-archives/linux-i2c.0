From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH 2/3 V3] i2c: mxs: Rework the PIO mode operation
Date: Mon, 30 Sep 2013 13:22:01 +0200
Message-ID: <20130930112201.GE3222@katana>
References: <1380497035-7457-1-git-send-email-marex@denx.de>
 <1380497035-7457-2-git-send-email-marex@denx.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gDGSpKKIBgtShtf+"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1380497035-7457-2-git-send-email-marex-ynQEQJNshbs@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Christoph Baumann <cb-/RsSufbtIHM@public.gmane.org>, Fabio Estevam <r49496-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Torsten Fleischer <to-fleischer-zqRNUXuvxA0b1SvskN2V4Q@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--gDGSpKKIBgtShtf+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 30, 2013 at 01:23:54AM +0200, Marek Vasut wrote:
> Analyze and rework the PIO mode operation. The PIO mode operation
> was unreliable on MX28, by analyzing the bus with LA, the checks
> for when data were available or were to be sent were wrong.
>=20
> The PIO WRITE has to be completely reworked as it multiple problems.
> The MX23 datasheet helped here, see comments in the code for details.
> The problems boil down to:
> - RUN bit in CTRL0 must be set after DATA register was written
> - The PIO transfer must be 4 bytes long tops, otherwise use
>   clock stretching.
> Both of these fixes are implemented.
>=20
> The PIO READ operation can only be done for up to four bytes as
> we are unable to read out the data from the DATA register fast
> enough.
>=20
> This patch also tries to document the investigation within the
> code.
>=20
> Signed-off-by: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>

Yay, there it is. Thanks, looks good to me. Will wait a few days so
people can donate Tested-by tags.


--gDGSpKKIBgtShtf+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJSSV7YAAoJEBQN5MwUoCm2eBYQAKc82Gnx5Y5yWPzGjc3usAY1
TDqgzU+gnyuadoXMXKPBylP0riYTpz7isY3JC9kqU7F2QxhUOTOn+ANFeIpC9TzW
KLWlmzgL5HYNW43hImD2eZ3oih9RtOePfaUMwbtVuQeYFkaZQWgNywsHsIMicLa0
fcFTopWnmcV5kaXOaNAMn+4aFbo4lpU7o1ANUHhpyI/1gOl0OH0wV8riOxFNb5ks
dOAJabE2yaqK40yp+biF0hsWchsDuELb+V3SL4EA36TbhkAlpca7I1ipRcwBD6Gj
DWBpCUf9ZkVS8NFv3GaeDmwtCtLIDZpaklPxzva65KPPJKYHhxflm0fnRMQz/hjc
TcOrCa9dnYGo3WPeg7ZbR6Kg7oQW6/YkdXuDCSK0tEDPmxgJHuV4qG7dTxhM5dWP
+IF4xKuQx9rSIPHoMF/LaIpS+MdpFh2Y9ZXB6lIRtY4Ulq+Npjbg3L+UowjKYQM7
AhLOgREMrSAcKhTKl++SSS13Wh/ptne/1CJYN4nGRAh1wOGkLYEpjGzyDXsNlB1F
I4yBlbDMW/h9W29TB9mNkesb424cSOQ/YEMKZQRv3fjgfAdPI9nicU4g2Ncy5bi1
oG6SB1R3M9XD+Y6aM37IbcgatKpFr5OLel8NF9aGZueqqR5eZ+WNGd7azdBBq/eS
tMMJERsi+GC3CamIfXBE
=rY9q
-----END PGP SIGNATURE-----

--gDGSpKKIBgtShtf+--
