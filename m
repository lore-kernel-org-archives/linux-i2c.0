From: Gao Pandy <gaopan@freescale.com>
Subject: RE: [Patch V8] i2c: imx: add runtime pm support to improve the
 performance
Date: Tue, 13 Oct 2015 09:08:10 +0000
Message-ID: <CY1PR0301MB0858AB5F33E75B6C12E1CAB5CF300@CY1PR0301MB0858.namprd03.prod.outlook.com>
References: <1442569869-10584-1-git-send-email-b54642@freescale.com>
 <20151013070711.GA3982@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-bl2on0116.outbound.protection.outlook.com ([65.55.169.116]:19872
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751924AbbJMJIO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Tue, 13 Oct 2015 05:08:14 -0400
In-Reply-To: <20151013070711.GA3982@pengutronix.de>
Content-Language: en-US
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: "wsa@the-dreams.de" <wsa@the-dreams.de>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, Li Frank <Frank.Li@freescale.com>, Duan Andy <fugang.duan@freescale.com>, "kernel@pengutronix.de" <kernel@pengutronix.de>, "hkallweit1@gmail.com" <hkallweit1@gmail.com>

 From: Uwe Kleine-K=F6nig <mailto:u.kleine-koenig@pengutronix.de> Sent:=
 Tuesday, October 13, 2015 3:07 PM
> To: Gao Pan-B54642
> Cc: wsa@the-dreams.de; linux-i2c@vger.kernel.org; Li Frank-B20596; Du=
an
> Fugang-B38611; kernel@pengutronix.de; hkallweit1@gmail.com
> Subject: Re: [Patch V8] i2c: imx: add runtime pm support to improve t=
he
> performance
>=20
> Hello,
>=20
> On Fri, Sep 18, 2015 at 05:51:09PM +0800, Gao Pan wrote:
> > In our former i2c driver, i2c clk is enabled and disabled in xfer
> > function, which contributes to power saving. However, the clk enabl=
e
> > process brings a busy wait delay until the core is stable. As a
> > result, the performance is sacrificed.
> >
> > To weigh the power consumption and i2c bus performance, runtime pm =
is
> > the good solution for it. The clk is enabled when a i2c transfer
> > starts, and disabled after a specifically defined delay.
> >
> > Without the patch the test case (many eeprom reads) executes with
> approx:
> > real 1m7.735s
> > user 0m0.488s
> > sys 0m20.040s
> >
> > With the patch the same test case (many eeprom reads) executes with
> approx:
> > real 0m54.241s
> > user 0m0.440s
> > sys 0m5.920s
> >
> > Signed-off-by: Fugang Duan <B38611@freescale.com>
> > Signed-off-by: Gao Pan <b54642@freescale.com>
>=20
> If runtime-pm is disabled the net result of this patch is that the cl=
ock
> is never disabled, right? I think this is ok, but I would have pointe=
d
> that out in the commit log.
=20
Yes, you are right, I will point that out in the commit log in next ver=
sion.

> > @@ -1037,6 +1045,18 @@ static int i2c_imx_probe(struct platform_dev=
ice
> *pdev)
> >  	/* Set up adapter data */
> >  	i2c_set_adapdata(&i2c_imx->adapter, i2c_imx);
> >
> > +	/* Set up platform driver data */
> > +	platform_set_drvdata(pdev, i2c_imx);
> > +
> > +	pm_runtime_set_autosuspend_delay(&pdev->dev, I2C_PM_TIMEOUT);
> > +	pm_runtime_use_autosuspend(&pdev->dev);
> > +	pm_runtime_set_active(&pdev->dev);
> > +	pm_runtime_enable(&pdev->dev);
> > +
> > +	ret =3D pm_runtime_get_sync(&pdev->dev);
> > +	if (ret < 0)
> > +		goto rpm_disable;
> > +
> >  	/* Set up clock divider */
> >  	i2c_imx->bitrate =3D IMX_I2C_BIT_RATE;
> >  	ret =3D of_property_read_u32(pdev->dev.of_node,
> > @@ -1053,12 +1073,11 @@ static int i2c_imx_probe(struct platform_de=
vice
> *pdev)
> >  	ret =3D i2c_add_numbered_adapter(&i2c_imx->adapter);
> >  	if (ret < 0) {
> >  		dev_err(&pdev->dev, "registration failed\n");
> > -		goto clk_disable;
> > +		goto rpm_disable;
>=20
> Is it right, that here the same error path is taken as when
> pm_runtime_get_sync fails above? Even if it works now, not having the
> error cleanup path undo all things in reverse order is a danger to ge=
t it
> wrong in the next change. So if this is fixable, it would be nice to
> implement.
=20
When i2c_add_numbered_adapter fails, the cleanup should include the run=
time pm stuff.=20
So it's ok to take the same error patch.

What do you mean by undo all things in reverse order, I think the clean=
up is in reverse order.

The calling sequence is:=20
pm_runtime_use_autosuspend(&pdev->dev);
pm_runtime_set_active(&pdev->dev);
pm_runtime_enable(&pdev->dev);	=09
pm_runtime_get_sync(&pdev->dev);

The cleanup order is:
pm_runtime_put_noidle(&pdev->dev);
pm_runtime_disable(&pdev->dev);
pm_runtime_set_suspended(&pdev->dev);

Is it that I miss pm_runtime_dont_use_autosuspend(&pdev->dev);

Thank you!

Best Reguards
Gao Pan
