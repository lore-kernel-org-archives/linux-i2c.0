From: "Ivan T. Ivanov" <iivanov-NEYub+7Iv8PQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v2 2/2] i2c: New bus driver for the QUP I2C controller
Date: Thu, 16 Jan 2014 15:37:24 +0200
Message-ID: <1389879444.2794.44.camel@iivanov-dev.int.mm-sol.com>
References: <1389659437-16406-1-git-send-email-bjorn.andersson@sonymobile.com>
	 <1389659437-16406-3-git-send-email-bjorn.andersson@sonymobile.com>
	 <20140115164604.GI14405@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140115164604.GI14405-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: Bjorn Andersson <bjorn.andersson-/MT0OVThwyLZJqsBc5GL+g@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Rob Landley <rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Martin Schwidefsky <schwidefsky-tA70FqPdS9bQT0dZR+AlfA@public.gmane.org>, James Ralston <james.d.ralston-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Bill Brown <bill.e.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Matt Porter <matt.porter-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


Hi,

On Wed, 2014-01-15 at 08:46 -0800, Stephen Boyd wrote: 
> On 01/13, Bjorn Andersson wrote:
> > +/*
> > + * QUP driver for Qualcomm MSM platforms
> > + *
> > + */
> 
> This comment seems redundant, we know what file we're looking at.
> 
> > +
> > +struct qup_i2c_dev {
> > +	struct device		*dev;
> > +	void __iomem		*base;
> > +	struct pinctrl		*pctrl;
> 
> This is unused.
> 
> > +	int			irq;
> > +	struct clk		*clk;
> > +	struct clk		*pclk;
> > +	struct i2c_adapter	adap;
> > +
> > +	int			clk_freq;
> 
> This is only ever used in probe, so why do we need to store it
> away?
> 
> > +	int			clk_ctl;
> > +	int			one_bit_t;
> > +	int			out_fifo_sz;
> > +	int			in_fifo_sz;
> > +	int			out_blk_sz;
> > +	int			in_blk_sz;
> > +	unsigned long		xfer_time;
> > +	unsigned long		wait_idle;
> > +
> > +	struct i2c_msg		*msg;
> > +	/* Current possion in user message buffer */
> 
> s/possion/position/?
> 
> > +	int			pos;
> > +	/* Keep number of bytes left to be transmitted */
> > +	int			cnt;
> > +	/* I2C protocol errors */
> > +	u32			bus_err;
> > +	/* QUP core errors */
> > +	u32			qup_err;
> > +	/*
> > +	 * maximum bytes that could be send (per iterration). could be
> 
> s/iterration/iteration/?
> 
> > +	 * equal of fifo size or block size (in block mode)
> > +	 */
> > +	int			chunk_sz;
> > +	struct completion	xfer;
> > +};
> > +
> > +static irqreturn_t qup_i2c_interrupt(int irq, void *dev)
> > +{
> > +	struct qup_i2c_dev *qup = dev;
> > +	u32 bus_err;
> > +	u32 qup_err;
> > +	u32 opflags;
> > +
> [...]
> > +
> > +	if (opflags & QUP_OUT_SVC_FLAG)
> > +		writel(QUP_OUT_SVC_FLAG, qup->base + QUP_OPERATIONAL);
> > +
> > +	if (!(qup->msg->flags == I2C_M_RD))
> 
> Should this be?
> 
> 	if (!(qup->msg->flags & I2C_M_RD))
> 
> Otherwise it should be
> 
> 	if (qup->msg->flags != I2C_M_RD)
> 

This check is actually broken. Intention was that if this is read
transaction and there is no QUP_MX_INPUT_DONE or QUP_IN_SVC_FLAG
to exit without wakeup transfer thread. As is it now it will never
complete write transactions.

Regards,
Ivan

> > +		return IRQ_HANDLED;
> > +
> > +	if ((opflags & QUP_MX_INPUT_DONE) || (opflags & QUP_IN_SVC_FLAG))
> > +		writel(QUP_IN_SVC_FLAG, qup->base + QUP_OPERATIONAL);
> > +
> > +done:
> > +	qup->qup_err = qup_err;
> > +	qup->bus_err = bus_err;
> > +	complete(&qup->xfer);
> > +	return IRQ_HANDLED;
> > +}
> > +
