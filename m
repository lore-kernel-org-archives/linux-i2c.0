From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [Patch v2] i2c: imx: add runtime pm support to improve the
 performance
Date: Sun, 2 Aug 2015 00:40:42 +0200
Message-ID: <20150801224042.GA1528@katana>
References: <1434619651-5720-1-git-send-email-b54642@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wRRV7LY7NUeQGEoC"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1434619651-5720-1-git-send-email-b54642-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Gao Pan <b54642-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, B20596-KZfg59tc24xl57MIdRCFDg@public.gmane.org, b38611-KZfg59tc24xl57MIdRCFDg@public.gmane.org, u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--wRRV7LY7NUeQGEoC
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 18, 2015 at 05:27:31PM +0800, Gao Pan wrote:
> In our former i2c driver, i2c clk is enabled and disabled in
> xfer function, which contributes to power saving. However,
> the clk enable process brings a busy wait delay until the core
> is stable. As a result, the performance is sacrificed.
>=20
> To weigh the power consumption and i2c bus performance, runtime
> pm is the good solution for it. The clk is enabled when a i2c
> transfer starts, and disabled after a specifically defined delay.
>=20
> Without the patch the test case (many eeprom reads) executes with approx:
> real 1m7.735s
> user 0m0.488s
> sys 0m20.040s
>=20
> With the patch the same test case (many eeprom reads) executes with appro=
x:
> real 0m54.241s
> user 0m0.440s
> sys 0m5.920s
>=20
> From the test result, the patch get better performance.

Looks OK to me. coccicheck says something, though:

drivers/i2c/busses/i2c-imx.c:1098:7-26: pm_runtime_get_sync returns < 0 as =
error. Unecessary IS_ERR_VALUE at line 1099
drivers/i2c/busses/i2c-imx.c:896:10-29: pm_runtime_get_sync returns < 0 as =
error. Unecessary IS_ERR_VALUE at line 897

Please fix that and add "kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org" to CC when resending. I know
they use the driver a lot.


> V2:
> As Uwe Kleine-K=C3=B6nig's suggestion, the version do below changes:
> - call clk_prepare_enable in probe to avoid never enabling clock
>   if CONFIG_PM is disabled
> - enable clock before request IRQ in probe
> - remove the pm staff in i2c_imx_isr

Thanks for this info. If you could put it below "---" that would be preferr=
ed by me.


--wRRV7LY7NUeQGEoC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVvUrqAAoJEBQN5MwUoCm2iQQP/iGj3HlwKFyrj39XTJ0TP2ye
1rsFGewyn4S/yuLZKI5813r4Bn6ePTqT+iy5iWKXUINtjCJ/GGxW8x9C6al7lWpK
m/3YKccpQAxgAQSMNTVlJ/rNw0nThnB8zxKq+ZJcEFMQPaQM163be5F7ZnoJWLCh
6loPYH5EcnXaGqDzBJSr+JzrNoZFoPsL2sTjnXc//O+PQGLHWz9+1wqZxr0yxxSN
5hMZ5dQPqM/18LZFselFqE9VXa/WWS5dncW1ZHxqBU8A55Qg1ZgUfT75BL5k9nK0
4EPbyirrdEgssxzutBKav2SR/PBAo4eJvJqrrbVACAu8TiFMHNedlPbvfxDpFvMn
KeHUcirG9nX7WhEaaO34WWTQMRuomm0CUAGwhYIQhOjN/kt1PAVGoESgKWJk79B9
OY4r/P3imrbU/f2PV68cnZZWY7mcPjI8tiwXuF7E9Ab39ZONneq1I5EkoxdslWi3
qvv1X/CaLgf+00ju7SLpvrJSWDIHnEPE2h20TwGCWpoCvE3dZC4FEiZMa1sFRTaR
fRVPD8/AwMruoajxIobc363BaOp375ppFk/9mSotQxEHi4eyCLfVug5Mr+mICsbc
EifYLqNm0n5SyzgVagi8+O6eCX12HRvW3iVmpJmOLZ7tvlEX/RWQL8MWqS9tZwu4
1/RPhO6S5PJvyN3tpcqW
=6rHN
-----END PGP SIGNATURE-----

--wRRV7LY7NUeQGEoC--
