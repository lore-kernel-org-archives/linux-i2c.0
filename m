From: Yingjoe Chen <yingjoe.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH v4 2/2] I2C: mediatek: Add driver for MediaTek I2C
 controller
Date: Wed, 21 Jan 2015 20:49:40 +0800
Message-ID: <1421844580.11671.145.camel@mtksdaap41>
References: <1421404418-50718-1-git-send-email-eddie.huang@mediatek.com>
	 <1421404418-50718-3-git-send-email-eddie.huang@mediatek.com>
	 <20150118101816.GF22880@pengutronix.de>
	 <1421810004.15468.825.camel@mtksdaap41>
	 <1421821809.11671.117.camel@mtksdaap41>
	 <20150121081519.GS22880@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150121081519.GS22880-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Eddie Huang <eddie.huang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Andrew Bresticker <abrestic-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>, Xudong Chen <xudong.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Boris BREZILLON <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, yh.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, Wei Yan <sledge.yanwei-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, Bjorn Andersson <bjorn.andersson-/MT0OVThwyLZJqsBc5GL+g@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Beniamino Galvani <b.galvani-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Neelesh Gupta <neelegup-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, srv_he
List-Id: linux-i2c@vger.kernel.org

On Wed, 2015-01-21 at 09:15 +0100, Uwe Kleine-K=C3=B6nig wrote:
> Hello,
>=20
> On Wed, Jan 21, 2015 at 02:30:09PM +0800, Yingjoe Chen wrote:
> > On Wed, 2015-01-21 at 11:13 +0800, Eddie Huang wrote:
> > <...>
> > > > > +		ret =3D -EINVAL;
> > > > > +		goto err_exit;
> > > > > +	}
> > > > > +
> > > > > +	if (msgs->buf =3D=3D NULL) {
> > > > > +		dev_dbg(i2c->dev, " data buffer is NULL.\n");
> > > > > +		ret =3D -EINVAL;
> > > > > +		goto err_exit;
> > > > > +	}
> > > > > +
> > > > > +	i2c->addr =3D msgs->addr;
> > > > > +	i2c->msg_len =3D msgs->len;
> > > > > +	i2c->msg_buf =3D msgs->buf;
> > > > > +
> > > > > +	if (msgs->flags & I2C_M_RD)
> > > > > +		i2c->op =3D I2C_MASTER_RD;
> > > > > +	else
> > > > > +		i2c->op =3D I2C_MASTER_WR;
> > > > > +
> > > > > +	/* combined two messages into one transaction */
> > > > > +	if (num > 1) {
> > > > > +		i2c->msg_aux_len =3D (msgs + 1)->len;
> > > > > +		i2c->op =3D I2C_MASTER_WRRD;
> > > > > +	}
> > > > This means "write then read", right? You should check here that=
 the
> > > > first message is really a write and the 2nd a read then.
> > > > Can this happen at all with the quirks defined below (.max_num_=
msgs =3D
> > > > 1)?
> > > Yes, mean write then read. Indeed, add check is better.
> > > If msg number is 1, means normal write or read, not "write then r=
ead".
> >=20
> > The quirks will increase the message count and check 'write then re=
ad'
> > for us. We don't have to add check here.
> I have to admit I don't know that quirks stuff, so it's well possible
> that I'm wrong here.
> =20
> > > > > +static int mtk_i2c_remove(struct platform_device *pdev)
> > > > > +{
> > > > > +	struct mtk_i2c *i2c =3D platform_get_drvdata(pdev);
> > > > > +
> > > > > +	i2c_del_adapter(&i2c->adap);
> > > > > +	free_i2c_dma_bufs(i2c);
> > > > > +	platform_set_drvdata(pdev, NULL);
> > > > > +
> > > > Here you need to make sure that no irq is running when i2c_del_=
adapter
> > > > is called.
> > > OK, add check here
> >=20
> > I thought after i2c_del_adapter() is complete, all i2c_transfer for=
 this
> > adapter is completed. If this is true, then i2c clock is already of=
f and
> > we won't have any on-going transfer/pending irq.
> Consider that there is an ongoing transaction and before it completes
> the adapter-device is unbound from the driver. Then i2c_del_adapter i=
s
> called which frees the resources managed by the core, then the device=
's
> completion irq triggers and the freed adapter is used which probably
> results in an oops.

Not sure if I missed anything. i2c_transfer() is a synchronize call. If
we fixed timeout issue you mentioned in mtk_i2c_transfer(), it will tur=
n
off clock before it return, which disable any transaction and clear all
pending irq.

Your scenario can only happens when one thread is still running in
i2c_transfer/algo->master_xfer and the other thread is trying to remove
the device. If that happened, then every device data access in
mtk_i2c_transfer might cause oops. I looked at some i2c drivers and
can't find any checking for this case, I can't find anything prevent i2=
c
device removal before pending i2c_transfer complete either. Would you
give me an example?

Joe.C
