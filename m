From: Eddie Huang <eddie.huang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH v4 2/2] I2C: mediatek: Add driver for MediaTek I2C
 controller
Date: Wed, 21 Jan 2015 16:34:35 +0800
Message-ID: <1421829275.6546.6.camel@mtksdaap41>
References: <1421404418-50718-1-git-send-email-eddie.huang@mediatek.com>
	 <1421404418-50718-3-git-send-email-eddie.huang@mediatek.com>
	 <20150118101816.GF22880@pengutronix.de>
	 <1421810004.15468.825.camel@mtksdaap41>
	 <20150121082022.GT22880@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150121082022.GT22880-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Andrew Bresticker <abrestic-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Max Schwarz <max.schwarz-BGeptl67XyCzQB+pC5nmwQ@public.gmane.org>, Boris BREZILLON <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Anders Berg <anders.berg-1wcpHE2jlwO1Z/+hSey0Gg@public.gmane.org>, Neelesh Gupta <neelegup-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>, Wei Yan <sledge.yanwei-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Simon Glass <sjg-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Jim Cromie <jim.cromie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Bjorn Andersson <bjorn.andersson-/MT0OVThwyLZJqsBc5GL+g@public.gmane.org>, Beniamino Galvani <b.galvani@gmai>
List-Id: linux-i2c@vger.kernel.org

Hi Uwe,

On Wed, 2015-01-21 at 09:20 +0100, Uwe Kleine-K=C3=B6nig wrote:
> Hello,
>=20
> On Wed, Jan 21, 2015 at 11:13:24AM +0800, Eddie Huang wrote:
> > > > +	/* set when doing the transfer */
> > > > +	u16 irq_stat;			/* interrupt status */
> > > > +	unsigned int speed_hz;		/* The speed in transfer */
> > > > +	bool trans_stop;		/* i2c transfer stop */
> > > > +	enum mtk_trans_op op;
> > > > +	u16 msg_len;
> > > > +	u8 *msg_buf;			/* pointer to msg data */
> > > > +	u16 msg_aux_len;		/* WRRD mode to set AUX_LEN register*/
> > > > +	u16 addr;	/* 7bit slave address, without read/write bit */
> > > Wouldn't it be easier to maintain a pointer to the message to be
> > > transferred?
> > I think use mtk_i2c pointer is more flexible than maintain a pointe=
r to
> > message.
> Not sure you understood what I intended to suggest. My idea was to dr=
op
>=20
> 	u16 msg_len;
> 	u8 *msg_buf;
> 	u16 msg_aux_len; // maybe
> 	u16 addr;
>=20
> from struct mtk_i2c and add a struct i2c_msg *msg instead. Up to you =
to
> decide.
>=20
Because this driver pass mtk_i2c pointer between functions, it's
flexible to use any member of struct mtk_i2c. The good thing is avoid
passing one more struct i2c_msg parameter between functions, or another
struct copy. The bad thing is make struct mtk_i2c larger. I prefer to
keep as it is now.

Best Regards
Eddie
