From: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [Patch v2] i2c: imx: implement bus recovery
Date: Tue, 8 Sep 2015 16:18:41 +0200
Message-ID: <CACRpkdaRu0jLJUddpjVvO9cBCRfHJpzAm0K1v825dCiSy0Zweg@mail.gmail.com>
References: <1437100605-28047-1-git-send-email-b54642@freescale.com>
	<20150813081528.GA9999@pengutronix.de>
	<CY1PR0301MB0858E4EEEC54C81BC4E7A621CF670@CY1PR0301MB0858.namprd03.prod.outlook.com>
	<20150819070218.GE9999@pengutronix.de>
	<CACRpkdYy3xQ3N7199GcV83-HrgOERnffNLh=qak8K8hpcAHs1Q@mail.gmail.com>
	<20150907080032.GO9999@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150907080032.GO9999-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Gao Pandy <gaopan-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org" <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Li Frank <Frank.Li-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Duan Andy <fugang.duan-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Mon, Sep 7, 2015 at 10:00 AM, Uwe Kleine-K=C3=B6nig
<u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org> wrote:
> [Me]

>> If the use case is around the i2c traffic, it is a mode related to I=
2C,
>> and if this mode is called "GPIO mode" in the data sheet
>> is irrelevant, because it is obviously not used for the generic
>> input/output but the specific I2C. The terminology should be
>> made familiar to whoever needs to go in and read the code later.
>
> The background info that was obviously missing from the part of the
> thread I sent to you is that pinctrl_pm_select_sleep_state is used to
> prepare bitbanging on the i2c bus to do bus recovery. (The controller
> doesn't implement this, so we have to resort to manually drive the
> pins.)

I don't understand. What does "manually" mean in this context?
Code examples for "manual" and "automatic"?

Generally the word "manual" is so ambigous that we should
refrain from using it, to me that means something like
hammering on a keyboard to alter things through sysfs
or debugfs but I hardly believe this is what you mean.

> Is this good enough? I'd like to see implemented a separate pinctrl s=
et
> for bitbanging instead of relying on the sleep state being the right
> thing to enable gpio functionality.

This sounds right but I need to see the two different code sets
to understand. Now my head is all fuzzy...

Yours,
Linus Walleij
