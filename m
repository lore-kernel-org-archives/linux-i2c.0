From: Ray Jui <rjui@broadcom.com>
Subject: Re: [PATCH v3 2/3] i2c: iproc: Add Broadcom iProc I2C Driver
Date: Wed, 14 Jan 2015 12:05:20 -0800
Message-ID: <54B6CC00.3050609@broadcom.com>
References: <rjui@broadcom.com> <1418183832-24793-1-git-send-email-rjui@broadcom.com> <1418183832-24793-3-git-send-email-rjui@broadcom.com> <20150113225012.GK22880@pengutronix.de> <54B5D0F9.8030902@broadcom.com> <20150114075137.GL22880@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150114075137.GL22880@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: =?windows-1252?Q?Uwe_Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Wolfram Sang <wsa@the-dreams.de>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Grant Likely <grant.likely@linaro.org>, Christian Daudt <bcm@fixthebug.org>, Matt Porter <mporter@linaro.org>, Florian Fainelli <f.fainelli@gmail.com>, Russell King <linux@arm.linux.org.uk>, Scott Branden <sbranden@broadcom.com>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org



On 1/13/2015 11:51 PM, Uwe Kleine-K=F6nig wrote:
> Hello,
>=20
> On Tue, Jan 13, 2015 at 06:14:17PM -0800, Ray Jui wrote:
>>>> +	irq =3D platform_get_irq(pdev, 0);
>>>> +	if (irq < 0) {
>>> irq =3D=3D 0 should be handled as error, too.
>>>
>> Ah. I thought zero is a valid global interrupt number, and I see oth=
er
>> drivers checking against < 0 as well. Is my understanding incorrect?
> These are wrong, too. 0 should never be a valid interrupt number. The=
re
> are some exceptions but mostly for historic reasons. The right handli=
ng
> is used for example in drivers/i2c/busses/i2c-efm32.c.
>=20
Okay. Will check against <=3D 0. Thanks.

>>>> +		dev_err(dev->device, "no irq resource\n");
>>>> +		return irq;
>>>> +	}
>> [...]
>>>> +static int bcm_iproc_i2c_remove(struct platform_device *pdev)
>>>> +{
>>>> +	struct bcm_iproc_i2c_dev *dev =3D platform_get_drvdata(pdev);
>>>> +
>>>> +	i2c_del_adapter(&dev->adapter);
>>>> +	bcm_iproc_i2c_disable(dev);
>>> I think you have a problem here if bcm_iproc_i2c_remove is called w=
hile
>>> an irq is still being serviced. I'm not sure how to prevent this
>>> properly for a shared interrupt.
>>>
>> Can I grab i2c_lock_adapter to ensure the bus is locked (so there's =
no
>> outstanding transactions or IRQs by the time we remove the adapter)?=
 But
>> I see no I2C bus driver does this in their remove function...
> The problem I pointed out is the reason for some driver authors not t=
o
> use devm_request_irq. If you use plain request_irq and the matching
> free_irq in the .remove callback you can be sure that the irq isn't
> running any more as soon as free_irq returns.
>=20
Okay. Will change to use request_irq and make sure that it's freed in
the remove function. Also, the interrupt is dedicated to the I2C
controller, so I'll remove the IRQF_SHARED flag.

> BTW, if you use vim, you can add
>=20
> 	set cinoptions=3D(,:
> 	if has("autocmd")
> 		filetype plugin indent on
> 	endif
>=20
> to your .vimrc. Then while typing vim does the indention right and
> consistent, and with the =3D command you can reindent.
>=20
Wow this is excellent! Just tried and it works perfectly. Thanks a lot!=
!!

> Best regards
> Uwe
>=20
