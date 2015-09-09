From: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [Patch v2] i2c: imx: implement bus recovery
Date: Wed, 9 Sep 2015 10:46:19 +0200
Message-ID: <CACRpkdaj6EVMjyfVC05gvDm6LsyY9n9aP6K3X1PAKEcQLR4jTQ@mail.gmail.com>
References: <1437100605-28047-1-git-send-email-b54642@freescale.com>
	<20150813081528.GA9999@pengutronix.de>
	<CY1PR0301MB0858E4EEEC54C81BC4E7A621CF670@CY1PR0301MB0858.namprd03.prod.outlook.com>
	<20150819070218.GE9999@pengutronix.de>
	<CACRpkdYy3xQ3N7199GcV83-HrgOERnffNLh=qak8K8hpcAHs1Q@mail.gmail.com>
	<20150907080032.GO9999@pengutronix.de>
	<CACRpkdaRu0jLJUddpjVvO9cBCRfHJpzAm0K1v825dCiSy0Zweg@mail.gmail.com>
	<20150908202258.GY14598@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150908202258.GY14598-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Gao Pandy <gaopan-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org" <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Li Frank <Frank.Li-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Duan Andy <fugang.duan-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Tue, Sep 8, 2015 at 10:22 PM, Uwe Kleine-K=C3=B6nig
<u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org> wrote:
> [Me]
>> I don't understand. What does "manually" mean in this context?
>> Code examples for "manual" and "automatic"?
>
> Normally i2c operations are done using the i2c core in the SoC and us=
ing
> the i2c function of the respective pins. Recovery
> however must be done (manually) by configuring the lines as GPIO and
> using a sequence of calls to gpio_[gs]et_value.
>
> The sleep state of the i2c bus device (usually?) configures the i2c
> lines as GPIO. Is it ok to (ab)use the sleep state to prepare for the
> recovery procedure or should we better introduce a dedicated gpio mod=
e
> pinctrl?

OK now I understand (I think).

I think it's OK to use tyhe sleep state as long as there are comments
in the code explaining what is going on. It is something extraordinary
after all.

I guess this means that you're using GPIO orthogonally to I2C,
and thus the pin controller does not have the .strict property
set. There should be a comment in the struct pinmux_ops of
the driver saying that this pin controller cannot be used as
strict. Need to keep the information there so people don't get
confused.

Yours,
Linus Walleij
