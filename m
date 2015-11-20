From: Li Yang <leoli@freescale.com>
Subject: Re: [PATCH] i2c: imx: make bus recovery through pinctrl optional
Date: Fri, 20 Nov 2015 12:04:44 -0600
Message-ID: <CADRPPNSVhpQCScw8J4EMPhcAF_j6b2_DmDw0wXORcNsbitn12w@mail.gmail.com>
References: <1447804979-29550-1-git-send-email-leoli@freescale.com>
	<20151118072437.GS22022@pengutronix.de>
	<CADRPPNQZye7t2biS2Z8p3y7O6=xw4UcOLRC5ngs2Qvuh0UHXGg@mail.gmail.com>
	<20151119080822.GY22022@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <20151119080822.GY22022@pengutronix.de>
Sender: linux-gpio-owner@vger.kernel.org
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Wolfram Sang <wsa@the-dreams.de>, Linus Walleij <linus.walleij@linaro.org>, lkml <linux-kernel@vger.kernel.org>, Gao Pan <b54642@freescale.com>, linux-gpio@vger.kernel.org, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-i2c@vger.kernel.org

On Thu, Nov 19, 2015 at 2:08 AM, Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
> Hello,
>
> Cc +=3D Linus Walleij, linux-gpio
>
> On Wed, Nov 18, 2015 at 04:59:11PM -0600, Li Yang wrote:
>> On Wed, Nov 18, 2015 at 1:24 AM, Uwe Kleine-K=C3=B6nig
>> <u.kleine-koenig@pengutronix.de> wrote:
>> > On Tue, Nov 17, 2015 at 06:02:59PM -0600, Li Yang wrote:
>> >> @@ -1125,7 +1119,12 @@ static int i2c_imx_probe(struct platform_d=
evice *pdev)
>> >>               goto clk_disable;
>> >>       }
>> >>
>> >> -     i2c_imx_init_recovery_info(i2c_imx, pdev);
>> >> +     /* optional bus recovery feature through pinctrl */
>> >> +     i2c_imx->pinctrl =3D devm_pinctrl_get(&pdev->dev);
>> >> +     if (IS_ERR_OR_NULL(i2c_imx->pinctrl))
>> >> +             dev_info(&pdev->dev, "can't get pinctrl, bus recove=
ry feature disabled\n");
>> >> +     else
>> >> +             i2c_imx_init_recovery_info(i2c_imx, pdev);
>> >
>> > I'm pretty sure this is wrong. If pinctrl isn't available
>> > devm_pinctrl_get returns NULL? But AFAIK you must not ignore an er=
ror,
>> > so the better thing to do is:
>>
>> If CONFIG_PINCTRL is not enabled, the devm_pinctrl_get() will return
>> NULL directly as defined in the include/linux/pinctrl/consumer.h.
>>
>> If CONFIG_PINCTRL is enabled because we are using a multi-platform
>> image but the actual hardware used doesn't have a pinctrl driver or
>> pinctrl device tree nodes.  It is expected that the devm_pinctrl_get=
()
>> will return error.  But as the pinctrl is only used for bus recovery
>> which is just an optional function of this driver.  We shouldn't
>> bailout the probe but keep the driver working without the bus recove=
ry
>> function.  As for generic errors like (!dev) or out-of-memory, the
>> probe will fail elsewhere anyway.
>
> IMHO you shouldn't ignore -ENOMEM from devm_pinctrl_get but just the
> case for "there was no pinctrl specified in dt". Also consider the i2=
c
> driver is loaded before the pinctrl driver and devm_pinctrl_get retur=
ns
> -EPROBE_DEFER (I assume it does, didn't check), this should be handle=
d.

Make sense.   -EPROBE_DEFER should be honored.  Maybe it's good to
check the -ENOMEM too.  I will send a new version.

Thanks,
Leo
--
To unsubscribe from this list: send the line "unsubscribe linux-gpio" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
