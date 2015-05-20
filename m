From: Eddie Huang <eddie.huang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH v8 2/3] I2C: mediatek: Add driver for MediaTek I2C
 controller
Date: Wed, 20 May 2015 13:33:52 +0800
Message-ID: <1432100032.3422.13.camel@mtksdaap41>
References: <1431967209-5261-1-git-send-email-eddie.huang@mediatek.com>
	 <1431967209-5261-3-git-send-email-eddie.huang@mediatek.com>
	 <20150518184300.GB28888@pengutronix.de>
	 <CABuKBeJcpufi-eEWmDRK6F2kgpz3DmCz8rp4hVPCJVgkmGr-KA@mail.gmail.com>
	 <20150519194917.GI24769@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150519194917.GI24769-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Xudong Chen <xudong.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, srv_heupstream <srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Liguo Zhang <liguo.zhang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Uwe,

On Tue, 2015-05-19 at 21:49 +0200, Uwe Kleine-K=C3=B6nig wrote:
> Hello Matthias,
>=20
> On Tue, May 19, 2015 at 04:48:23PM +0200, Matthias Brugger wrote:
> > 2015-05-18 20:43 GMT+02:00 Uwe Kleine-K=C3=B6nig <u.kleine-koenig@p=
engutronix.de>:
> > > On Tue, May 19, 2015 at 12:40:08AM +0800, Eddie Huang wrote:
> > >> [...]
> > >>  drivers/i2c/busses/i2c-mt65xx.c | 675 +++++++++++++++++++++++++=
+++++++++++++++
> > >> [...]
> > >> +#define I2C_DRV_NAME         "mt-i2c"
> > > i2c-mt65xx ?
> >=20
> > As this works for all SoCs so far, I would propose: i2c-mtk
> Hmm, currently we have:
>=20
>   - #define I2C_DRV_NAME mt-i2c
Change to i2c-mt65xx.

>   - dt-compatibles: "mediatek,mt6577-i2c" + "mediatek,mt6589-i2c"

We hope all mobile chip series use the same I2C driver.
I don't list all chips in driver to avoid too many dt-compatibles.
Only list chips that are different from others.

>   - function prefix: mtk_i2c_
Maybe use i2c-mt65xx_ is better, but I tend to keep mtk_i2c_ after thes=
e
review rounds.

>   - filename: i2c-mt65xx.c
>   - Kconfig symbol: I2C_MT65XX
>=20
> Getting some harmonization here would definitly be nice.
>=20

Eddie Huang
