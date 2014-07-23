From: Lothar =?UTF-8?B?V2HDn21hbm4=?= <LW-bxm8fMRDkQLDiMYJYoSAnRvVK+yQ3ZXh@public.gmane.org>
Subject: Re: [PATCH v5 1/2] i2c: add DMA support for freescale i2c driver
Date: Wed, 23 Jul 2014 14:15:02 +0200
Message-ID: <20140723141502.2d726afe@ipc1.ka-ro>
References: <1406103883-3572-1-git-send-email-yao.yuan@freescale.com>
	<1406103883-3572-2-git-send-email-yao.yuan@freescale.com>
	<20140723114834.411f6bb4@ipc1.ka-ro>
	<b1778af62e7b42b39381fb2699b34eb1@BL2PR03MB338.namprd03.prod.outlook.com>
	<53CF9933.8030908@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <53CF9933.8030908-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Varka Bhadram <varkabhadram-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Yao Yuan <yao.yuan-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org" <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, "marex-ynQEQJNshbs@public.gmane.org" <marex-ynQEQJNshbs@public.gmane.org>, "mark.rutland-5wv7dgnIgG8@public.gmane.org" <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi,

Varka Bhadram wrote:
> On 07/23/2014 04:41 PM, Yao Yuan wrote:
> > Hi,
> >
> > Thanks for your review.
> >
> > Lothar Wa=C3=9Fmann wrote:
> >> Yuan Yao wrote:
> >>> Add dma support for i2c. This function depend on DMA driver.
> >>> You can turn on it by write both the dmas and dma-name properties=
 in dts node.
> >>>
> >>> Signed-off-by: Yuan Yao <yao.yuan-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
> >>> ---
> >>>   drivers/i2c/busses/i2c-imx.c | 377
> > [...]
> >>> +
> >>> +fail_rx:
> >>> +	dma_release_channel(dma->chan_rx);
> >>> +fail_tx:
> >>> +	dma_release_channel(dma->chan_tx);
> >>> +fail_al:
> >>> +	devm_kfree(dev, dma);
> >>>
> >> No need for this one (that's the whole point of using devm_kzalloc=
())!
> >>
> > When DMA request failed, I2C will switch to PIO mode. So if the fai=
led reason is just like DMA channel request failed. At this time the DM=
A should free by devm_kfree(). Is it?
>=20
> If probe failed the memory will be freed automatically because
> we are using devm_kzalloc()...
>=20
> If we use devm_kzalloc() ,no need to free manually on fail...
>=20
Yes, but as Yuan Yao stated, the driver will still work
without DMA but carry around the unecessary allocated imx_i2c_dma
struct.
The devm_kfree() is not in the failure path of the driver's probe()
function, but in the function that tries to initialize the optional DMA
support.


Lothar Wa=C3=9Fmann
--=20
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra=C3=9Fe 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch=C3=A4ftsf=C3=BChrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info-AvR2QvxeiV7DiMYJYoSAnRvVK+yQ3ZXh@public.gmane.org
___________________________________________________________
