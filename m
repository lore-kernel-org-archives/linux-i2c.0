From: Yao Yuan <yao.yuan-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: RE: [PATCH v5 1/2] i2c: add DMA support for freescale i2c driver
Date: Thu, 31 Jul 2014 06:16:55 +0000
Message-ID: <1a4d2e9ddc67421d8588305c927f3d3d@BL2PR03MB338.namprd03.prod.outlook.com>
References: <1406103883-3572-1-git-send-email-yao.yuan@freescale.com>
 <53CF9933.8030908@gmail.com> <20140723141502.2d726afe@ipc1.ka-ro>
 <201407231852.53893.marex@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <201407231852.53893.marex-ynQEQJNshbs@public.gmane.org>
Content-Language: en-US
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>, =?iso-8859-1?Q?Lothar_Wa=DFmann?= <LW-AvR2QvxeiV7DiMYJYoSAnRvVK+yQ3ZXh@public.gmane.org>
Cc: Varka Bhadram <varkabhadram-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org" <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, "mark.rutland-5wv7dgnIgG8@public.gmane.org" <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Marek Vasut wrote:
> On Wednesday, July 23, 2014 at 02:15:02 PM, Lothar Wa=DFmann wrote:
> > Hi,
> >
> > Varka Bhadram wrote:
> > > On 07/23/2014 04:41 PM, Yao Yuan wrote:
> > > > Hi,
> > > >
> > > > Thanks for your review.
> > > >
> > > > Lothar Wa=DFmann wrote:
> > > >> Yuan Yao wrote:
> > > >>> Add dma support for i2c. This function depend on DMA driver.
> > > >>> You can turn on it by write both the dmas and dma-name
> > > >>> properties in dts node.
> > > >>>
> > > >>> Signed-off-by: Yuan Yao <yao.yuan-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
> > > >>> ---
> > > >>>
> > > >>>   drivers/i2c/busses/i2c-imx.c | 377
> > > >
> > > > [...]
> > > >
> > > >>> +
> > > >>> +fail_rx:
> > > >>> +	dma_release_channel(dma->chan_rx);
> > > >>> +fail_tx:
> > > >>> +	dma_release_channel(dma->chan_tx);
> > > >>> +fail_al:
> > > >>> +	devm_kfree(dev, dma);
> > > >>
> > > >> No need for this one (that's the whole point of using devm_kza=
lloc())!
> > > >
> > > > When DMA request failed, I2C will switch to PIO mode. So if the
> > > > failed reason is just like DMA channel request failed. At this
> > > > time the DMA should free by devm_kfree(). Is it?
> > >
> > > If probe failed the memory will be freed automatically because we
> > > are using devm_kzalloc()...
> > >
> > > If we use devm_kzalloc() ,no need to free manually on fail...
> >
> > Yes, but as Yuan Yao stated, the driver will still work without DMA
> > but carry around the unecessary allocated imx_i2c_dma struct.
> > The devm_kfree() is not in the failure path of the driver's probe()
> > function, but in the function that tries to initialize the optional
> > DMA support.
>=20
> If the DMA fails, I'd just make the entire probe fail. In case you ca=
nnot probe
> DMA for your hardware, which is exected to be DMA capable, it means
> something is wrong anyway.

Yes, but if there is something wrong in dma, I think the i2c is innocen=
t. So I think the error message is necessary but i2c can continue work.


Best regards,
Yuan Yao
