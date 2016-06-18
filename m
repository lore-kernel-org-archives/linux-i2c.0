From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v4 1/2] i2c: qup: add ACPI support
Date: Sat, 18 Jun 2016 16:10:34 +0200
Message-ID: <20160618141034.GB1430@tetsubishi>
References: <1465409985-17113-1-git-send-email-austinwc@codeaurora.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TakKZr9L6Hm6aLOc"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:53981 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751254AbcFROKm (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Sat, 18 Jun 2016 10:10:42 -0400
Content-Disposition: inline
In-Reply-To: <1465409985-17113-1-git-send-email-austinwc@codeaurora.org>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Austin Christ <austinwc@codeaurora.org>, Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, rruigrok@codeaurora.org, timur@codeaurora.org, cov@codeaurora.org, nkaje@codeaurora.org, linux-arm-kernel@lists.infradead.org


--TakKZr9L6Hm6aLOc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 08, 2016 at 12:19:44PM -0600, Austin Christ wrote:
> From: Naveen Kaje <nkaje@codeaurora.org>
>=20
> Add support to get the device parameters from ACPI. Assume
> that the clocks are managed by firmware.

Adding Mika to CC: Can you have a look at the ACPI binding? Looks ok to
me...

>=20
> Signed-off-by: Naveen Kaje <nkaje@codeaurora.org>
> Signed-off-by: Austin Christ <austinwc@codeaurora.org>
> Reviewed-by: sricharan@codeaurora.org

Please add a name before the email address

> ---
>  drivers/i2c/busses/i2c-qup.c | 59 ++++++++++++++++++++++++++++++++------=
------
>  1 file changed, 43 insertions(+), 16 deletions(-)
>=20
> Changes:
> - v4:
>  - remove warning for fall back to default clock frequency
> - v3:
>  - clean up unused variable
> - v2:
>  - clean up redundant checks and variables
>=20
> diff --git a/drivers/i2c/busses/i2c-qup.c b/drivers/i2c/busses/i2c-qup.c
> index dddd4da..0f23d58 100644
> --- a/drivers/i2c/busses/i2c-qup.c
> +++ b/drivers/i2c/busses/i2c-qup.c
> @@ -29,6 +29,7 @@
>  #include <linux/platform_device.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/scatterlist.h>
> +#include <linux/acpi.h>

Keep includes sorted.

> =20
>  /* QUP Registers */
>  #define QUP_CONFIG		0x000
> @@ -132,6 +133,10 @@
>  /* Max timeout in ms for 32k bytes */
>  #define TOUT_MAX			300
> =20
> +/* Default values. Use these if FW query fails */
> +#define DEFAULT_CLK_FREQ 100000
> +#define DEFAULT_SRC_CLK 20000000
> +
>  struct qup_i2c_block {
>  	int	count;
>  	int	pos;
> @@ -1354,14 +1359,13 @@ static void qup_i2c_disable_clocks(struct qup_i2c=
_dev *qup)
>  static int qup_i2c_probe(struct platform_device *pdev)
>  {
>  	static const int blk_sizes[] =3D {4, 16, 32};
> -	struct device_node *node =3D pdev->dev.of_node;
>  	struct qup_i2c_dev *qup;
>  	unsigned long one_bit_t;
>  	struct resource *res;
>  	u32 io_mode, hw_ver, size;
>  	int ret, fs_div, hs_div;
> -	int src_clk_freq;
> -	u32 clk_freq =3D 100000;
> +	u32 src_clk_freq =3D 0;
> +	u32 clk_freq =3D DEFAULT_CLK_FREQ;
>  	int blocks;
> =20
>  	qup =3D devm_kzalloc(&pdev->dev, sizeof(*qup), GFP_KERNEL);
> @@ -1372,7 +1376,11 @@ static int qup_i2c_probe(struct platform_device *p=
dev)
>  	init_completion(&qup->xfer);
>  	platform_set_drvdata(pdev, qup);
> =20
> -	of_property_read_u32(node, "clock-frequency", &clk_freq);
> +	ret =3D device_property_read_u32(qup->dev, "clock-frequency", &clk_freq=
);
> +	if (ret) {
> +		dev_notice(qup->dev, "using default clock-frequency %d",
> +			DEFAULT_CLK_FREQ);
> +	}
> =20
>  	if (of_device_is_compatible(pdev->dev.of_node, "qcom,i2c-qup-v1.1.1")) {
>  		qup->adap.algo =3D &qup_i2c_algo;
> @@ -1454,20 +1462,31 @@ nodma:
>  		return qup->irq;
>  	}
> =20
> -	qup->clk =3D devm_clk_get(qup->dev, "core");
> -	if (IS_ERR(qup->clk)) {
> -		dev_err(qup->dev, "Could not get core clock\n");
> -		return PTR_ERR(qup->clk);
> -	}
> +	if (ACPI_HANDLE(qup->dev)) {
> +		ret =3D device_property_read_u32(qup->dev,
> +				"src-clock-hz", &src_clk_freq);
> +		if (ret) {
> +			dev_warn(qup->dev, "using default src-clock-hz %d",
> +				DEFAULT_SRC_CLK);
> +			src_clk_freq =3D DEFAULT_SRC_CLK;
> +		}
> +		ACPI_COMPANION_SET(&qup->adap.dev, ACPI_COMPANION(qup->dev));
> +	} else {
> +		qup->clk =3D devm_clk_get(qup->dev, "core");
> +		if (IS_ERR(qup->clk)) {
> +			dev_err(qup->dev, "Could not get core clock\n");
> +			return PTR_ERR(qup->clk);
> +		}
> =20
> -	qup->pclk =3D devm_clk_get(qup->dev, "iface");
> -	if (IS_ERR(qup->pclk)) {
> -		dev_err(qup->dev, "Could not get iface clock\n");
> -		return PTR_ERR(qup->pclk);
> +		qup->pclk =3D devm_clk_get(qup->dev, "iface");
> +		if (IS_ERR(qup->pclk)) {
> +			dev_err(qup->dev, "Could not get iface clock\n");
> +			return PTR_ERR(qup->pclk);
> +		}
> +		qup_i2c_enable_clocks(qup);
> +		src_clk_freq =3D clk_get_rate(qup->clk);
>  	}
> =20
> -	qup_i2c_enable_clocks(qup);
> -
>  	/*
>  	 * Bootloaders might leave a pending interrupt on certain QUP's,
>  	 * so we reset the core before registering for interrupts.
> @@ -1514,7 +1533,6 @@ nodma:
>  	size =3D QUP_INPUT_FIFO_SIZE(io_mode);
>  	qup->in_fifo_sz =3D qup->in_blk_sz * (2 << size);
> =20
> -	src_clk_freq =3D clk_get_rate(qup->clk);
>  	fs_div =3D ((src_clk_freq / clk_freq) / 2) - 3;
>  	hs_div =3D 3;
>  	qup->clk_ctl =3D (hs_div << 8) | (fs_div & 0xff);
> @@ -1639,6 +1657,14 @@ static const struct of_device_id qup_i2c_dt_match[=
] =3D {
>  };
>  MODULE_DEVICE_TABLE(of, qup_i2c_dt_match);
> =20
> +#if IS_ENABLED(CONFIG_ACPI)
> +static const struct acpi_device_id qup_i2c_acpi_match[] =3D {
> +	{ "QCOM8010"},
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(acpi, qup_i2c_acpi_ids);
> +#endif
> +
>  static struct platform_driver qup_i2c_driver =3D {
>  	.probe  =3D qup_i2c_probe,
>  	.remove =3D qup_i2c_remove,
> @@ -1646,6 +1672,7 @@ static struct platform_driver qup_i2c_driver =3D {
>  		.name =3D "i2c_qup",
>  		.pm =3D &qup_i2c_qup_pm_ops,
>  		.of_match_table =3D qup_i2c_dt_match,
> +		.acpi_match_table =3D ACPI_PTR(qup_i2c_acpi_match),
>  	},
>  };
> =20
> --=20
> Qualcomm Innovation Center, Inc.
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project.
>=20

--TakKZr9L6Hm6aLOc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXZVZZAAoJEBQN5MwUoCm2TkgQAJ37UWZzyI0Z45hUR+ZpqFEt
aP7itHUs0P7bXhdjsvFe2gOeDGotF9y6+GXhYrRroU8Vu2KhQyVKhXG0rUDnjyXv
wbNGv+ZaLC7gj8KZd6/4p+NiNxgTBxy7ZJjzcKyGksGvjCWjCEFN4G7mXBrah5zd
wJFO2e/9ZjJj6R0mLPmx/crM3gTKQENb8bxKqE0+2vfi5IGvBKB2beRndvW6iKYs
uqCHuTj22/+zgIqYEurOdQc4Cg/ZMhjobHH1XDkSkoQIPKnACpuakeOBmnzKwAnu
R6AyuiwfJgiSUdXEquj/Hocw3WcwfWBribUxQ7inWYW1fUCaXDOpM55RhmdiKas9
RlvmtMk34MQqiqP3QWAQew+q3YhNcWujV+GVSk2tTkEfjHK/ao2L6Q2rM8ZBkkwL
8bK7QsHqSRUkmsoQYSuB4URQEw4zXMkFGFLMhaM63mhhdyv1/rk6xiIuE+5VPGCv
2vk58L1Hx2L3+QCNA/4LFyGgI1boRT+749uxgng5d53gtQSIH17tAqhr1UnA7G9s
ZZMe8KrVa5lcQki/OF+mGghvzyYnLcfhqz8Iwdm9gbPwRcGJgWhuFHx30a/ACx+U
vCnrYX06CzrlCmvPOWOVVq4MOExxK/3KlqmKXL8k+KP6ng7ZaVJNQikNXHjlV51o
iRUNsoR/NGW86QkzhBbg
=di2z
-----END PGP SIGNATURE-----

--TakKZr9L6Hm6aLOc--
