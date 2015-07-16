From: Jan =?ISO-8859-1?Q?L=FCbbe?= <jlu-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [Patch v1] i2c: imx: implement bus recovery
Date: Thu, 16 Jul 2015 14:57:42 +0200
Message-ID: <1437051462.3344.140.camel@pengutronix.de>
References: <1436839486-11110-1-git-send-email-b54642@freescale.com>
	 <20150714064832.GY1426@pengutronix.de>
	 <CY1PR0301MB0858C32968C39EA0E60E2904CF9B0@CY1PR0301MB0858.namprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CY1PR0301MB0858C32968C39EA0E60E2904CF9B0-YrwGdl+PljlUWoKpOwApjpwN6zqB+hSMnBOFsp37pqbUKgpGm//BTAC/G2K4zDHf@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Gao Pandy <gaopan-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, "wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org" <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Li Frank <Frank.Li-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Duan Andy <fugang.duan-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Di, 2015-07-14 at 08:12 +0000, Gao Pandy wrote:
> > > --- a/Documentation/devicetree/bindings/i2c/i2c-imx.txt
> > > +++ b/Documentation/devicetree/bindings/i2c/i2c-imx.txt
> > > @@ -14,6 +14,8 @@ Optional properties:
> > >    The absence of the propoerty indicates the default frequency
> 100 kHz.
> > >  - dmas: A list of two dma specifiers, one for each entry in
> dma-names.
> > >  - dma-names: should contain "tx" and "rx".
> > > +- recover-scl: specify the gpio related to SCL pin
> > > +- recover-sda: specify the gpio related to SDA pin
> > I don't like the naming here. That the gpios are used for recovery
> isn't
> > a hardware description. What about "scl-gpio" and "sda-gpio"?
> 
> Thanks. I will change it in the next version. 

There is already a binding for i2c-gpio:
Documentation/devicetree/bindings/i2c/i2c-gpio.txt

We should be able to reuse those properties as-is, instead of defining
something for each i2c controller binding.

Regards,
Jan
-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
