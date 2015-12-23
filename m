From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v3] i2c: designware: Do not require clock when SSCN and
 FFCN are provided
Date: Wed, 23 Dec 2015 20:27:01 +0200
Message-ID: <1450895221.30729.322.camel@linux.intel.com>
References: <1450820141-1720-1-git-send-email-Suravee.Suthikulpanit@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:6493 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754536AbbLWS2w (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Wed, 23 Dec 2015 13:28:52 -0500
In-Reply-To: <1450820141-1720-1-git-send-email-Suravee.Suthikulpanit@amd.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>, mika.westerberg@linux.intel.com, wsa@the-dreams.de
Cc: jarkko.nikula@linux.intel.com, lho@apm.com, Ken.Xue@amd.com, linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, 2015-12-22 at 15:35 -0600, Suravee Suthikulpanit wrote:
> The current driver uses input clock source frequency to calculate
> values for [SS|FS]_[HC|LC] registers. However, when booting ACPI, we
> do not
> currently have a good way to provide the frequency information.
> Instead, we can leverage the SSCN and FFCN ACPI methods, which can be
> used
> to directly provide these values. So, the clock information should
> no longer be required during probing.
>=20
> However, since clk can be invalid, additional checks must be done
> where
> we are making use of it.
>=20
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Signed-off-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
> ---
> Note: This has been tested on AMD Seattle RevB for both DT and ACPI.
>=20
> Changes from V2 (https://lkml.org/lkml/2015/12/22/584):
> =C2=A0=C2=A0=C2=A0=C2=A0* Add the i2c_dw_clk_rate from Mika.
> =C2=A0=C2=A0=C2=A0=C2=A0* Add check if get_clk_rate_khz is set before=
 setting
> sda_hold_time
>=20
> Changes from V1 (https://lkml.org/lkml/2015/12/15/792):
> =C2=A0=C2=A0=C2=A0=C2=A0In v1, I disregarded the clock if SSCN and FM=
CN are provided,
> =C2=A0=C2=A0=C2=A0=C2=A0assuming that it was not needed. That was inc=
orrect assumption,
> =C2=A0=C2=A0=C2=A0=C2=A0and is now fixed in v2.
>=20
> =C2=A0drivers/i2c/busses/i2c-designware-core.c=C2=A0=C2=A0=C2=A0=C2=A0=
| 22 +++++++++++++++--
> -----
> =C2=A0drivers/i2c/busses/i2c-designware-platdrv.c | 24 ++++++++++++--=
-----
> -----
> =C2=A02 files changed, 27 insertions(+), 19 deletions(-)
>=20
> diff --git a/drivers/i2c/busses/i2c-designware-core.c
> b/drivers/i2c/busses/i2c-designware-core.c
> index 8c48b27..25dccd8 100644
> --- a/drivers/i2c/busses/i2c-designware-core.c
> +++ b/drivers/i2c/busses/i2c-designware-core.c
> @@ -271,6 +271,17 @@ static void __i2c_dw_enable(struct dw_i2c_dev
> *dev, bool enable)
> =C2=A0		=C2=A0enable ? "en" : "dis");
> =C2=A0}
> =C2=A0
> +static unsigned long i2c_dw_clk_rate(struct dw_i2c_dev *dev)
> +{
> +	/*
> +	=C2=A0* Clock is not necessary if we got LCNT/HCNT values
> directly from
> +	=C2=A0* the platform code.
> +	=C2=A0*/
> +	if (WARN_ON_ONCE(!dev->get_clk_rate_khz))
> +		return 0;
> +	return dev->get_clk_rate_khz(dev);
> +}
> +
> =C2=A0/**
> =C2=A0 * i2c_dw_init() - initialize the designware i2c master hardwar=
e
> =C2=A0 * @dev: device private data
> @@ -281,7 +292,6 @@ static void __i2c_dw_enable(struct dw_i2c_dev
> *dev, bool enable)
> =C2=A0 */
> =C2=A0int i2c_dw_init(struct dw_i2c_dev *dev)
> =C2=A0{
> -	u32 input_clock_khz;
> =C2=A0	u32 hcnt, lcnt;
> =C2=A0	u32 reg;
> =C2=A0	u32 sda_falling_time, scl_falling_time;
> @@ -295,8 +305,6 @@ int i2c_dw_init(struct dw_i2c_dev *dev)
> =C2=A0		}
> =C2=A0	}
> =C2=A0
> -	input_clock_khz =3D dev->get_clk_rate_khz(dev);
> -
> =C2=A0	reg =3D dw_readl(dev, DW_IC_COMP_TYPE);
> =C2=A0	if (reg =3D=3D ___constant_swab32(DW_IC_COMP_TYPE_VALUE)) {
> =C2=A0		/* Configure register endianess access */
> @@ -325,12 +333,12 @@ int i2c_dw_init(struct dw_i2c_dev *dev)
> =C2=A0		hcnt =3D dev->ss_hcnt;
> =C2=A0		lcnt =3D dev->ss_lcnt;
> =C2=A0	} else {
> -		hcnt =3D i2c_dw_scl_hcnt(input_clock_khz,
> +		hcnt =3D i2c_dw_scl_hcnt(i2c_dw_clk_rate(dev),
> =C2=A0					4000,	/* tHD;STA =3D
> tHIGH =3D 4.0 us */
> =C2=A0					sda_falling_time,
> =C2=A0					0,	/* 0: DW default,
> 1: Ideal */
> =C2=A0					0);	/* No offset */
> -		lcnt =3D i2c_dw_scl_lcnt(input_clock_khz,
> +		lcnt =3D i2c_dw_scl_lcnt(i2c_dw_clk_rate(dev),
> =C2=A0					4700,	/* tLOW =3D 4.7
> us */
> =C2=A0					scl_falling_time,
> =C2=A0					0);	/* No offset */
> @@ -344,12 +352,12 @@ int i2c_dw_init(struct dw_i2c_dev *dev)
> =C2=A0		hcnt =3D dev->fs_hcnt;
> =C2=A0		lcnt =3D dev->fs_lcnt;
> =C2=A0	} else {
> -		hcnt =3D i2c_dw_scl_hcnt(input_clock_khz,
> +		hcnt =3D i2c_dw_scl_hcnt(i2c_dw_clk_rate(dev),
> =C2=A0					600,	/* tHD;STA =3D
> tHIGH =3D 0.6 us */
> =C2=A0					sda_falling_time,
> =C2=A0					0,	/* 0: DW default,
> 1: Ideal */
> =C2=A0					0);	/* No offset */
> -		lcnt =3D i2c_dw_scl_lcnt(input_clock_khz,
> +		lcnt =3D i2c_dw_scl_lcnt(i2c_dw_clk_rate(dev),
> =C2=A0					1300,	/* tLOW =3D 1.3
> us */
> =C2=A0					scl_falling_time,
> =C2=A0					0);	/* No offset */
> diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c
> b/drivers/i2c/busses/i2c-designware-platdrv.c
> index 8ffc36b..04edd09 100644
> --- a/drivers/i2c/busses/i2c-designware-platdrv.c
> +++ b/drivers/i2c/busses/i2c-designware-platdrv.c

Can we introduce

static int i2c_dw_plat_prepare_clk(struct dw_i2c_dev *i_dev, bool
prepare)
{
	if (IS_ERR(i_dev->clk))
		return PTR_ERR(i_dev->clk);

	if (prepare)
/* REMOVEME: Yes, you have to check return value and this is one
benefit of this change */
		return clk_prepare_enable(i_dev->clk);

	clk_disable_unprepare(i_dev->clk);
	return 0;
}

and=E2=80=A6

> @@ -205,16 +205,14 @@ static int dw_i2c_plat_probe(struct
> platform_device *pdev)
> =C2=A0			DW_IC_CON_RESTART_EN | DW_IC_CON_SPEED_FAST;
> =C2=A0
> =C2=A0	dev->clk =3D devm_clk_get(&pdev->dev, NULL);
> -	dev->get_clk_rate_khz =3D i2c_dw_get_clk_rate_khz;
> -	if (IS_ERR(dev->clk))
> -		return PTR_ERR(dev->clk);
> -	clk_prepare_enable(dev->clk);
> -
> -	if (!dev->sda_hold_time && ht) {
> -		u32 ic_clk =3D dev->get_clk_rate_khz(dev);
> -
> -		dev->sda_hold_time =3D div_u64((u64)ic_clk * ht +
> 500000,
> -					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A01000000);
> +	if (!IS_ERR(dev->clk)) {
> +		dev->get_clk_rate_khz =3D i2c_dw_get_clk_rate_khz;
> +		clk_prepare_enable(dev->clk);

if (!i2c_dw_plat_prepare_clk(dev, true)) {
	dev->get_clk_rate_khz =3D i2c_dw_get_clk_rate_khz;
=E2=80=A6

> +
> +		if (!dev->sda_hold_time && ht)
> +			dev->sda_hold_time =3D div_u64(
> +				(u64)dev->get_clk_rate_khz(dev) * ht
> + 500000,
> +				1000000);
> =C2=A0	}
> =C2=A0
> =C2=A0	if (!dev->tx_fifo_depth) {
> @@ -297,7 +295,8 @@ static int dw_i2c_plat_suspend(struct device
> *dev)
> =C2=A0	struct dw_i2c_dev *i_dev =3D platform_get_drvdata(pdev);
> =C2=A0
> =C2=A0	i2c_dw_disable(i_dev);
> -	clk_disable_unprepare(i_dev->clk);
> +	if (!IS_ERR(i_dev->clk))
> +		clk_disable_unprepare(i_dev->clk);

i2c_dw_plat_prepare_clk(i_dev, false);

> =C2=A0
> =C2=A0	return 0;
> =C2=A0}
> @@ -307,7 +306,8 @@ static int dw_i2c_plat_resume(struct device *dev)
> =C2=A0	struct platform_device *pdev =3D to_platform_device(dev);
> =C2=A0	struct dw_i2c_dev *i_dev =3D platform_get_drvdata(pdev);
> =C2=A0
> -	clk_prepare_enable(i_dev->clk);
> +	if (!IS_ERR(i_dev->clk))
> +		clk_prepare_enable(i_dev->clk);

i2c_dw_plat_prepare_clk(i_dev, true);

> =C2=A0
> =C2=A0	if (!i_dev->pm_runtime_disabled)
> =C2=A0		i2c_dw_init(i_dev);

--=20
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
