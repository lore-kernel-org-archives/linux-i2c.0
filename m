From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: designware: add reset interface
Date: Tue, 13 Dec 2016 21:34:57 +0100
Message-ID: <20161213203457.GB2889@katana>
References: <1479789700-19532-1-git-send-email-zhangfei.gao@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="WYTEVAkct0FjGQmd"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from www.zeus03.de ([194.117.254.33]:57876 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S964985AbcLMUfE (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Tue, 13 Dec 2016 15:35:04 -0500
Content-Disposition: inline
In-Reply-To: <1479789700-19532-1-git-send-email-zhangfei.gao@linaro.org>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Zhangfei Gao <zhangfei.gao@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>


--WYTEVAkct0FjGQmd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 22, 2016 at 12:41:40PM +0800, Zhangfei Gao wrote:
> Some platforms like hi3660 need do reset first to allow accessing registe=
rs
>=20
> Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>

Adding designware maintainers to CC...

> ---
>  drivers/i2c/busses/i2c-designware-core.h    | 1 +
>  drivers/i2c/busses/i2c-designware-platdrv.c | 5 +++++
>  2 files changed, 6 insertions(+)
>=20
> diff --git a/drivers/i2c/busses/i2c-designware-core.h b/drivers/i2c/busse=
s/i2c-designware-core.h
> index 0d44d2a..94b14fa 100644
> --- a/drivers/i2c/busses/i2c-designware-core.h
> +++ b/drivers/i2c/busses/i2c-designware-core.h
> @@ -80,6 +80,7 @@ struct dw_i2c_dev {
>  	void __iomem		*base;
>  	struct completion	cmd_complete;
>  	struct clk		*clk;
> +	struct reset_control	*rst;
>  	u32			(*get_clk_rate_khz) (struct dw_i2c_dev *dev);
>  	struct dw_pci_controller *controller;
>  	int			cmd_err;
> diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/bu=
sses/i2c-designware-platdrv.c
> index 0b42a12..fd80e58 100644
> --- a/drivers/i2c/busses/i2c-designware-platdrv.c
> +++ b/drivers/i2c/busses/i2c-designware-platdrv.c
> @@ -38,6 +38,7 @@
>  #include <linux/pm_runtime.h>
>  #include <linux/property.h>
>  #include <linux/io.h>
> +#include <linux/reset.h>
>  #include <linux/slab.h>
>  #include <linux/acpi.h>
>  #include <linux/platform_data/i2c-designware.h>
> @@ -176,6 +177,10 @@ static int dw_i2c_plat_probe(struct platform_device =
*pdev)
>  	dev->irq =3D irq;
>  	platform_set_drvdata(pdev, dev);
> =20
> +	dev->rst =3D devm_reset_control_get(&pdev->dev, NULL);
> +	if (!IS_ERR(dev->rst))
> +		reset_control_reset(dev->rst);
> +
>  	/* fast mode by default because of legacy reasons */
>  	dev->clk_freq =3D 400000;
> =20
> --=20
> 2.7.4
>=20

--WYTEVAkct0FjGQmd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJYUFtxAAoJEBQN5MwUoCm2UzcQAKasxTpPzMTl4fDpl4mPNYI/
WpVmR9xTvd5Ukf8LngwljiVpXYpnBDcxThc1Z2368uAfV/xCR/7y9WW1flwz4eYW
LszBgr5/+zh7UdglamELzLe2EZphGAqzAoBZ2WOGpNXGJgN7V0VXLPjwSAXkBTih
prUeLlimZ2OHHpUMd7XvoU1dRP3Gvuu6KN15HzjqHBRK5bK4+hAo0wDiA7e2kkmj
BRXszp0OO1X9LRZZGg7zvjc9UPjTXJ9dv2LgRjIQMdECzjSYFLUnrMQMdQ8vcEUQ
kKQuyLZAPpU9bcohM7SrY4B+W52/ELyGX4VsIEmC7I3NeKgLbx30nfc+apRqQJqt
jMjngC20+0EjkaeTu1xEDsFu6aqPz7k5+NpjD5RPpyoLWcns3WbRjD02ATh6mV/o
NOyMEzOlkqwIQWbgst5wHCPh2eJ+HaWzxThTlZ2Fmmn08TXXJiqlEEOJMQwSlHrr
aN92w6jQw8N4j2pWZdmkkERyfam3UcL2ln01j0YEUpP3deahXbrF+R1GT+5TG99W
69c2xt4r+YQ5HMabQh/bghnNMv6qUXlZNrlUkgOvV63OKY2tjlk63uzhtWNv46SC
kdO42EjOkLVsOgIz/OMVkvsOiuDU1phiQGzYCfRkXcZZgpsU4eB6SOt2g/iH+Uyd
vbBIc87oKUMq3i+Mcb5w
=13iO
-----END PGP SIGNATURE-----

--WYTEVAkct0FjGQmd--
