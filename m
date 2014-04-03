From: =?utf-8?B?U8O2cmVu?= Brinkmann <soren.brinkmann@xilinx.com>
Subject: Re: [PATCH v3 1/2] i2c: Add driver for Cadence I2C controller
Date: Thu, 3 Apr 2014 08:42:43 -0700
Message-ID: <d3723b56-61d7-4983-a5d5-6c885c0e9a8e@CH1EHSMHS002.ehs.local>
References: <1394556613-11692-1-git-send-email-soren.brinkmann@xilinx.com>
 <533CF913.4020308@monstr.eu>
 <20140403071004.GA2571@katana>
 <533D0CFB.7050707@monstr.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <533D0CFB.7050707@monstr.eu>
Sender: linux-doc-owner@vger.kernel.org
To: Michal Simek <monstr@monstr.eu>
Cc: Wolfram Sang <wsa@the-dreams.de>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Rob Landley <rob@landley.net>, Russell King <linux@arm.linux.org.uk>, Michal Simek <michal.simek@xilinx.com>, Grant Likely <grant.likely@linaro.org>, Mike Looijmans <mike.looijmans@topic.nl>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, devicetree@vger.kernel.org, linux-i2c@vger.kernel.org, Harini Katakam <harinik@xilinx.com>
List-Id: linux-i2c@vger.kernel.org

On Thu, 2014-04-03 at 09:25AM +0200, Michal Simek wrote:
> On 04/03/2014 09:10 AM, Wolfram Sang wrote:
> >=20
> > Please don't quote large parts of the message f you are not referri=
ng to
> > it.
>=20
> Normally I do it. Forgot sorry.
>=20
> >>> +#ifdef CONFIG_PM_SLEEP
> >>> +/**
> >>> + * cdns_i2c_suspend - Suspend method for the driver
> >>> + * @_dev:	Address of the platform_device structure
> >>> + * Return: 0 always
> >>> + *
> >>> + * Put the driver into low power mode.
> >>> + */
> >>> +static int cdns_i2c_suspend(struct device *_dev)
> >>> +{
> >>> +	struct platform_device *pdev =3D container_of(_dev,
> >>> +			struct platform_device, dev);
> >>> +	struct cdns_i2c *xi2c =3D platform_get_drvdata(pdev);
> >>> +
> >>> +	clk_disable(xi2c->clk);
> >>> +	xi2c->suspended =3D 1;
> >>> +
> >>> +	return 0;
> >>> +}
> >>> +
> >>> +/**
> >>> + * cdns_i2c_resume - Resume from suspend
> >>> + * @_dev:	Address of the platform_device structure
> >>> + * Return: 0 on success and error value on error
> >>> + *
> >>> + * Resume operation after suspend.
> >>> + */
> >>> +static int cdns_i2c_resume(struct device *_dev)
> >>> +{
> >>> +	struct platform_device *pdev =3D container_of(_dev,
> >>> +			struct platform_device, dev);
> >>> +	struct cdns_i2c *xi2c =3D platform_get_drvdata(pdev);
> >>> +	int ret;
> >>> +
> >>> +	ret =3D clk_enable(xi2c->clk);
> >>> +	if (ret) {
> >>> +		dev_err(_dev, "Cannot enable clock.\n");
> >>> +		return ret;
> >>> +	}
> >>> +
> >>> +	xi2c->suspended =3D 0;
> >>> +
> >>> +	return 0;
> >>> +}
> >>> +#endif
> >>
> >> Can you also please remove this #ifdef and use __maybe_used
> >> instead? Better not to have any ifdef in the code.
> >=20
> > Is this a new pattern? For PM_SLEEP, #ifdef seems to be quite commo=
n.
>=20
> The first suggestion to do it came from CAN maintainer.
> It is valid in general for ifdef.
> I have checked all our drivers and we are changing them to use __mayb=
e_used
> because then we can easily find out if there is any problem
> when function prototype has changed.

I already have that change in my current version. I hope to send v4 to =
the list
soon.

	S=C3=B6ren


