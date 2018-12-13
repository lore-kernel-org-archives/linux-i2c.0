From: Qii Wang <qii.wang@mediatek.com>
Subject: Re: [PATCH 2/5] i2c: mediatek: remove useless code and replace
 definitions
Date: Thu, 13 Dec 2018 17:13:49 +0800
Message-ID: <1544692429.11699.31.camel@mhfsdcap03>
References: <1543843974-4054-1-git-send-email-qii.wang@mediatek.com>
         <1543843974-4054-3-git-send-email-qii.wang@mediatek.com>
         <20181211202058.cd4wyz4so66iqspt@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181211202058.cd4wyz4so66iqspt@ninjato>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com, leilk.liu@mediatek.com, ryder.lee@mediatek.com
List-Id: linux-i2c@vger.kernel.org

On Tue, 2018-12-11 at 21:20 +0100, Wolfram Sang wrote:
> On Mon, Dec 03, 2018 at 09:32:51PM +0800, qii.wang@mediatek.com wrote:
> > From: qii wang <qii.wang@mediatek.com>
> > 
> > Completion_done is useless when we don't use its return value,
> > so we remove it. Different speeds have been defined by macros,
> > so we use macros definitions.
> 
> Those are two seperate patches, or?
> 

These two changes are relatively small, but it seems better to be
divided into two seperate patches.

> > 
> > Signed-off-by: qii wang <qii.wang@mediatek.com>
> > ---
> >  drivers/i2c/busses/i2c-mt65xx.c |    6 ++----
> >  1 file changed, 2 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/i2c/busses/i2c-mt65xx.c b/drivers/i2c/busses/i2c-mt65xx.c
> > index a74ef76..660de1e 100644
> > --- a/drivers/i2c/busses/i2c-mt65xx.c
> > +++ b/drivers/i2c/busses/i2c-mt65xx.c
> > @@ -456,7 +456,7 @@ static int mtk_i2c_do_transfer(struct mtk_i2c *i2c, struct i2c_msg *msgs,
> >  
> >  	control_reg = readw(i2c->base + OFFSET_CONTROL) &
> >  			~(I2C_CONTROL_DIR_CHANGE | I2C_CONTROL_RS);
> > -	if ((i2c->speed_hz > 400000) || (left_num >= 1))
> > +	if ((i2c->speed_hz > MAX_FS_MODE_SPEED) || (left_num >= 1))
> >  		control_reg |= I2C_CONTROL_RS;
> >  
> >  	if (i2c->op == I2C_MASTER_WRRD)
> > @@ -465,7 +465,7 @@ static int mtk_i2c_do_transfer(struct mtk_i2c *i2c, struct i2c_msg *msgs,
> >  	writew(control_reg, i2c->base + OFFSET_CONTROL);
> >  
> >  	/* set start condition */
> > -	if (i2c->speed_hz <= 100000)
> > +	if (i2c->speed_hz <= I2C_DEFAULT_SPEED)
> >  		writew(I2C_ST_START_CON, i2c->base + OFFSET_EXT_CONF);
> >  	else
> >  		writew(I2C_FS_START_CON, i2c->base + OFFSET_EXT_CONF);
> > @@ -642,8 +642,6 @@ static int mtk_i2c_do_transfer(struct mtk_i2c *i2c, struct i2c_msg *msgs,
> >  		return -ETIMEDOUT;
> >  	}
> >  
> > -	completion_done(&i2c->msg_complete);
> > -
> >  	if (i2c->irq_stat & (I2C_HS_NACKERR | I2C_ACKERR)) {
> >  		dev_dbg(i2c->dev, "addr: %x, transfer ACK error\n", msgs->addr);
> >  		mtk_i2c_init_hw(i2c);
> > -- 
> > 1.7.9.5
> > 
