From: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Subject: Re: [PATCH v5 1/2] i2c: add DMA support for freescale i2c driver
Date: Wed, 23 Jul 2014 18:52:53 +0200
Message-ID: <201407231852.53893.marex@denx.de>
References: <1406103883-3572-1-git-send-email-yao.yuan@freescale.com> <53CF9933.8030908@gmail.com> <20140723141502.2d726afe@ipc1.ka-ro>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140723141502.2d726afe-VjFSrY7JcPWvSplVBqRQBQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lothar =?iso-8859-1?q?Wa=DFmann?= <LW-AvR2QvxeiV7DiMYJYoSAnRvVK+yQ3ZXh@public.gmane.org>
Cc: Varka Bhadram <varkabhadram-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Yao Yuan <yao.yuan-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org" <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, "mark.rutland-5wv7dgnIgG8@public.gmane.org" <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Wednesday, July 23, 2014 at 02:15:02 PM, Lothar Wa=DFmann wrote:
> Hi,
>=20
> Varka Bhadram wrote:
> > On 07/23/2014 04:41 PM, Yao Yuan wrote:
> > > Hi,
> > >=20
> > > Thanks for your review.
> > >=20
> > > Lothar Wa=DFmann wrote:
> > >> Yuan Yao wrote:
> > >>> Add dma support for i2c. This function depend on DMA driver.
> > >>> You can turn on it by write both the dmas and dma-name properti=
es in
> > >>> dts node.
> > >>>=20
> > >>> Signed-off-by: Yuan Yao <yao.yuan-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
> > >>> ---
> > >>>=20
> > >>>   drivers/i2c/busses/i2c-imx.c | 377
> > >=20
> > > [...]
> > >=20
> > >>> +
> > >>> +fail_rx:
> > >>> +	dma_release_channel(dma->chan_rx);
> > >>> +fail_tx:
> > >>> +	dma_release_channel(dma->chan_tx);
> > >>> +fail_al:
> > >>> +	devm_kfree(dev, dma);
> > >>=20
> > >> No need for this one (that's the whole point of using devm_kzall=
oc())!
> > >=20
> > > When DMA request failed, I2C will switch to PIO mode. So if the f=
ailed
> > > reason is just like DMA channel request failed. At this time the =
DMA
> > > should free by devm_kfree(). Is it?
> >=20
> > If probe failed the memory will be freed automatically because
> > we are using devm_kzalloc()...
> >=20
> > If we use devm_kzalloc() ,no need to free manually on fail...
>=20
> Yes, but as Yuan Yao stated, the driver will still work
> without DMA but carry around the unecessary allocated imx_i2c_dma
> struct.
> The devm_kfree() is not in the failure path of the driver's probe()
> function, but in the function that tries to initialize the optional D=
MA
> support.

If the DMA fails, I'd just make the entire probe fail. In case you cann=
ot probe=20
DMA for your hardware, which is exected to be DMA capable, it means som=
ething is=20
wrong anyway.

Best regards,
Marek Vasut
