From: Jisheng Zhang <jszhang@marvell.com>
Subject: Re: [PATCH v4] i2c: designware-platdrv: fix unbalanced clk enable
 and prepare
Date: Mon, 25 Apr 2016 17:13:32 +0800
Message-ID: <20160425171332.468f0bc0@xhacker>
References: <1461314971-5944-1-git-send-email-jszhang@marvell.com>
	<571A2E43.9030109@linux.intel.com>	<1461575235.17131.3.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:58587 "EHLO
	mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753598AbcDYJSJ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Mon, 25 Apr 2016 05:18:09 -0400
In-Reply-To: <1461575235.17131.3.camel@linux.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Jarkko Nikula <jarkko.nikula@linux.intel.com>, mika.westerberg@linux.intel.com, wsa@the-dreams.de, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Dear Andy

On Mon, 25 Apr 2016 12:07:15 +0300 Andy Shevchenko  wrote:

> On Fri, 2016-04-22 at 16:59 +0300, Jarkko Nikula wrote:
> > Hi
> >=20
> > On 04/22/2016 11:49 AM, Jisheng Zhang wrote: =20
> > >=20
> > > If i2c_dw_probe() fails, we should disable and unprepare the cloc=
k,
> > > otherwise the clock enable and prepare is left unbalanced.
> > >=20
> > > In dw_i2c_plat_remove(), we'd better to not rely on runtime PM to
> > > disable and unprepare the clock since CONFIG_PM may be disabled w=
hen
> > > configuring the kernel. So we explicitly disable and unprepare th=
e
> > > clock in dw_i2c_plat_remove() rather than implicitly rely on
> > > pm_runtime_put_sync(). To keep the device usage count balanced, w=
e
> > > call pm_runtime_put_noidle() to decrease the usage count.
> > >=20
> > > Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
> > > ---
> > > =C2=A0 Since v3:
> > > =C2=A0=C2=A0=C2=A0- use runtime PM rather than rpm in commit msg
> > > =C2=A0=C2=A0=C2=A0- remove duplicated "(" in commit msg
> > >=20
> > > =C2=A0 Since v2:
> > > =C2=A0=C2=A0=C2=A0- s/clk/clock
> > > =C2=A0=C2=A0=C2=A0- describe why use pm_runtime_put_noidle()
> > >=20
> > > =C2=A0 Since v1:
> > > =C2=A0=C2=A0=C2=A0- fix commit msg: "not rely on rpm" rather than=
 "rely on rpm"
> > > =C2=A0=C2=A0=C2=A0- call i2c_dw_plat_prepare_clk after pm_rumtime=
_disable()
> > > =C2=A0 drivers/i2c/busses/i2c-designware-platdrv.c | 16 +++++++++=
+------
> > > =C2=A0 1 file changed, 10 insertions(+), 6 deletions(-)
> > >=20
> > > diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c
> > > b/drivers/i2c/busses/i2c-designware-platdrv.c
> > > index d656657..a771781 100644
> > > --- a/drivers/i2c/busses/i2c-designware-platdrv.c
> > > +++ b/drivers/i2c/busses/i2c-designware-platdrv.c
> > > @@ -253,8 +253,11 @@ static int dw_i2c_plat_probe(struct
> > > platform_device *pdev)
> > > =C2=A0=C2=A0	}
> > >=20
> > > =C2=A0=C2=A0	r =3D i2c_dw_probe(dev);
> > > -	if (r && !dev->pm_runtime_disabled)
> > > -		pm_runtime_disable(&pdev->dev);
> > > +	if (r) {
> > > +		if (!dev->pm_runtime_disabled)
> > > +			pm_runtime_disable(&pdev->dev);
> > > +		i2c_dw_plat_prepare_clk(dev, false);
> > > +	}
> > >=20
> > > =C2=A0=C2=A0	return r;
> > > =C2=A0 }
> > > @@ -264,15 +267,16 @@ static int dw_i2c_plat_remove(struct
> > > platform_device *pdev)
> > > =C2=A0=C2=A0	struct dw_i2c_dev *dev =3D platform_get_drvdata(pdev=
);
> > >=20
> > > =C2=A0=C2=A0	pm_runtime_get_sync(&pdev->dev);
> > > +	pm_runtime_dont_use_autosuspend(&pdev->dev);
> > > +	if (!dev->pm_runtime_disabled)
> > > +		pm_runtime_disable(&pdev->dev);
> > > +	pm_runtime_put_noidle(&pdev->dev);
> > >=20
> > > =C2=A0=C2=A0	i2c_del_adapter(&dev->adapter);
> > >=20
> > > =C2=A0=C2=A0	i2c_dw_disable(dev);
> > >=20
> > > -	pm_runtime_dont_use_autosuspend(&pdev->dev);
> > > -	pm_runtime_put_sync(&pdev->dev);
> > > -	if (!dev->pm_runtime_disabled)
> > > -		pm_runtime_disable(&pdev->dev);
> > > +	i2c_dw_plat_prepare_clk(dev, false);
> > >  =20
> > This feels a bit an invasive change to me for unbalanced clock=C2=A0
> > enable/disable and I noticed this changes semantics how=C2=A0
> > drivers/acpi/acpi_lpss.c devices are shutdown when removing the
> > driver.=C2=A0
> > Although I didn't notice does it cause any regression.
> >=20
> > Before patch:
> > 1. drivers/base/dd.c: __device_release_driver()
> > =C2=A0=C2=A0=C2=A0=C2=A0- pm_runtime_get_sync()
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0-> acpi_device_set_power(D0)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0acpi_lpss_res=
tore_ctx()
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0dw_i2c_plat_r=
esume()
> > 2. dw_i2c_plat_remove()
> > =C2=A0=C2=A0=C2=A0=C2=A0- pm_runtime_dont_use_autosuspend()
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0pm_runtime_put_sync()
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0-> dw_i2c_plat_suspend()
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0acpi_lpss_sav=
e_ctx()
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0acpi_device_s=
et_power(D3)
> > 3. __device_release_driver() continue
> > =C2=A0=C2=A0=C2=A0=C2=A0- dev->pm_domain->dismiss(dev)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0-> acpi_lpss_dismiss() ... -> a=
cpi_device_set_power(D3)
> >=20
> > After patch:
> > 1. drivers/base/dd.c: __device_release_driver()
> > =C2=A0 - pm_runtime_get_sync()
> > =C2=A0=C2=A0=C2=A0=C2=A0-> acpi_device_set_power(D0)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0acpi_lpss_restore_ctx()
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0dw_i2c_plat_resume()
> > 2. dw_i2c_plat_remove()
> > =C2=A0=C2=A0=C2=A0=C2=A0- pm_runtime_dont_use_autosuspend()
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0pm_runtime_put_noidle()
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0* no device suspending and acpi=
_lpss_save_ctx()
> > 3. __device_release_driver() continue
> > =C2=A0=C2=A0=C2=A0=C2=A0- dev->pm_domain->dismiss(dev)
> > =C2=A0=C2=A0=C2=A0=C2=A0-> acpi_lpss_dismiss() ... -> acpi_device_s=
et_power(D3)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0* powers down here
> >=20
> > So after patch there is no acpi_lpss_save_ctx() call but I don't se=
e=C2=A0
> > does it cause any issue here. Maybe it's better to track clock only=
=2E=C2=A0
> > What you think Andy? =20
>=20
> Now it looks like two fixes in one patch. From the commit message I
> didn't get the relation between change runtime PM call (one to the
> other) and clock (un)preparation.
>=20

I'm not sure I got your points. There are two unbalanced clk enable and
prepare issues before the patch:

one is in the i2c_dw_probe() failure path. another is in the remove pat=
h when
CONFIG_PM is disabled.

The patch addresses this unbalance.

Thanks,
Jisheng
