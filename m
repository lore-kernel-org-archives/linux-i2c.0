From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v3 2/3] i2c: iproc: Add Broadcom iProc I2C Driver
Date: Wed, 14 Jan 2015 08:51:37 +0100
Message-ID: <20150114075137.GL22880@pengutronix.de>
References: <rjui@broadcom.com>
 <1418183832-24793-1-git-send-email-rjui@broadcom.com>
 <1418183832-24793-3-git-send-email-rjui@broadcom.com>
 <20150113225012.GK22880@pengutronix.de>
 <54B5D0F9.8030902@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <54B5D0F9.8030902@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ray Jui <rjui@broadcom.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Grant Likely <grant.likely@linaro.org>, Christian Daudt <bcm@fixthebug.org>, Matt Porter <mporter@linaro.org>, Florian Fainelli <f.fainelli@gmail.com>, Russell King <linux@arm.linux.org.uk>, Scott Branden <sbranden@broadcom.com>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Hello,

On Tue, Jan 13, 2015 at 06:14:17PM -0800, Ray Jui wrote:
> >> +	irq =3D platform_get_irq(pdev, 0);
> >> +	if (irq < 0) {
> > irq =3D=3D 0 should be handled as error, too.
> >=20
> Ah. I thought zero is a valid global interrupt number, and I see othe=
r
> drivers checking against < 0 as well. Is my understanding incorrect?
These are wrong, too. 0 should never be a valid interrupt number. There
are some exceptions but mostly for historic reasons. The right handling
is used for example in drivers/i2c/busses/i2c-efm32.c.

> >> +		dev_err(dev->device, "no irq resource\n");
> >> +		return irq;
> >> +	}
> [...]
> >> +static int bcm_iproc_i2c_remove(struct platform_device *pdev)
> >> +{
> >> +	struct bcm_iproc_i2c_dev *dev =3D platform_get_drvdata(pdev);
> >> +
> >> +	i2c_del_adapter(&dev->adapter);
> >> +	bcm_iproc_i2c_disable(dev);
> > I think you have a problem here if bcm_iproc_i2c_remove is called w=
hile
> > an irq is still being serviced. I'm not sure how to prevent this
> > properly for a shared interrupt.
> >=20
> Can I grab i2c_lock_adapter to ensure the bus is locked (so there's n=
o
> outstanding transactions or IRQs by the time we remove the adapter)? =
But
> I see no I2C bus driver does this in their remove function...
The problem I pointed out is the reason for some driver authors not to
use devm_request_irq. If you use plain request_irq and the matching
free_irq in the .remove callback you can be sure that the irq isn't
running any more as soon as free_irq returns.

BTW, if you use vim, you can add

	set cinoptions=3D(,:
	if has("autocmd")
		filetype plugin indent on
	endif

to your .vimrc. Then while typing vim does the indention right and
consistent, and with the =3D command you can reindent.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
