From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH 02/10] i2c: designware-platdrv: Gate clk in error path
 in ->probe()
Date: Tue, 14 Jun 2016 18:22:48 +0300
Message-ID: <1465917768.30123.65.camel@linux.intel.com>
References: <1465916848-8207-1-git-send-email-ulf.hansson@linaro.org>
	 <1465916848-8207-3-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:28963 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750789AbcFNPVa (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Tue, 14 Jun 2016 11:21:30 -0400
In-Reply-To: <1465916848-8207-3-git-send-email-ulf.hansson@linaro.org>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org
Cc: Jarkko Nikula <jarkko.nikula@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, John Stultz <john.stultz@linaro.org>, Guodong Xu <guodong.xu@linaro.org>, linux-arm-kernel@lists.infradead.org

On Tue, 2016-06-14 at 17:07 +0200, Ulf Hansson wrote:
> The call to i2c_dw_probe() may fail in ->probe() in which case the
> clock
> remains ungated. Fix the error path by gating the clock before the
> error
> code is returned.
>=20
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
> =C2=A0drivers/i2c/busses/i2c-designware-platdrv.c | 10 ++++++++--
> =C2=A01 file changed, 8 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c
> b/drivers/i2c/busses/i2c-designware-platdrv.c
> index e39962b..19174e7 100644
> --- a/drivers/i2c/busses/i2c-designware-platdrv.c
> +++ b/drivers/i2c/busses/i2c-designware-platdrv.c
> @@ -235,6 +235,7 @@ static int dw_i2c_plat_probe(struct
> platform_device *pdev)
> =C2=A0	ACPI_COMPANION_SET(&adap->dev, ACPI_COMPANION(&pdev->dev));
> =C2=A0	adap->dev.of_node =3D pdev->dev.of_node;
>=20

=C2=A0
> +	pm_runtime_get_noresume(&pdev->dev);

> +	pm_runtime_put(&pdev->dev);

I don't see an explanation of these add-ons.

--=20

Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
