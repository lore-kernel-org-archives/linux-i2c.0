From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH v4 2/2] I2C: mediatek: Add driver for MediaTek I2C
 controller
Date: Wed, 21 Jan 2015 09:15:19 +0100
Message-ID: <20150121081519.GS22880@pengutronix.de>
References: <1421404418-50718-1-git-send-email-eddie.huang@mediatek.com>
 <1421404418-50718-3-git-send-email-eddie.huang@mediatek.com>
 <20150118101816.GF22880@pengutronix.de>
 <1421810004.15468.825.camel@mtksdaap41>
 <1421821809.11671.117.camel@mtksdaap41>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1421821809.11671.117.camel@mtksdaap41>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Yingjoe Chen <yingjoe.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Cc: Eddie Huang <eddie.huang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Andrew Bresticker <abrestic-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>, Xudong Chen <xudong.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Boris BREZILLON <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, yh.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, Wei Yan <sledge.yanwei-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, Bjorn Andersson <bjorn.andersson-/MT0OVThwyLZJqsBc5GL+g@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Beniamino Galvani <b.galvani-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Neelesh Gupta <neelegup-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, srv_heupstream@med
List-Id: linux-i2c@vger.kernel.org

Hello,

On Wed, Jan 21, 2015 at 02:30:09PM +0800, Yingjoe Chen wrote:
> On Wed, 2015-01-21 at 11:13 +0800, Eddie Huang wrote:
> <...>
> > > > +		ret =3D -EINVAL;
> > > > +		goto err_exit;
> > > > +	}
> > > > +
> > > > +	if (msgs->buf =3D=3D NULL) {
> > > > +		dev_dbg(i2c->dev, " data buffer is NULL.\n");
> > > > +		ret =3D -EINVAL;
> > > > +		goto err_exit;
> > > > +	}
> > > > +
> > > > +	i2c->addr =3D msgs->addr;
> > > > +	i2c->msg_len =3D msgs->len;
> > > > +	i2c->msg_buf =3D msgs->buf;
> > > > +
> > > > +	if (msgs->flags & I2C_M_RD)
> > > > +		i2c->op =3D I2C_MASTER_RD;
> > > > +	else
> > > > +		i2c->op =3D I2C_MASTER_WR;
> > > > +
> > > > +	/* combined two messages into one transaction */
> > > > +	if (num > 1) {
> > > > +		i2c->msg_aux_len =3D (msgs + 1)->len;
> > > > +		i2c->op =3D I2C_MASTER_WRRD;
> > > > +	}
> > > This means "write then read", right? You should check here that t=
he
> > > first message is really a write and the 2nd a read then.
> > > Can this happen at all with the quirks defined below (.max_num_ms=
gs =3D
> > > 1)?
> > Yes, mean write then read. Indeed, add check is better.
> > If msg number is 1, means normal write or read, not "write then rea=
d".
>=20
> The quirks will increase the message count and check 'write then read=
'
> for us. We don't have to add check here.
I have to admit I don't know that quirks stuff, so it's well possible
that I'm wrong here.
=20
> > > > +static int mtk_i2c_remove(struct platform_device *pdev)
> > > > +{
> > > > +	struct mtk_i2c *i2c =3D platform_get_drvdata(pdev);
> > > > +
> > > > +	i2c_del_adapter(&i2c->adap);
> > > > +	free_i2c_dma_bufs(i2c);
> > > > +	platform_set_drvdata(pdev, NULL);
> > > > +
> > > Here you need to make sure that no irq is running when i2c_del_ad=
apter
> > > is called.
> > OK, add check here
>=20
> I thought after i2c_del_adapter() is complete, all i2c_transfer for t=
his
> adapter is completed. If this is true, then i2c clock is already off =
and
> we won't have any on-going transfer/pending irq.
Consider that there is an ongoing transaction and before it completes
the adapter-device is unbound from the driver. Then i2c_del_adapter is
called which frees the resources managed by the core, then the device's
completion irq triggers and the freed adapter is used which probably
results in an oops.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
