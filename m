From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [patch 3/3] i2c: add support for i2c bus on Freescale
 CPM1/CPM2 controllers
Date: Fri, 16 May 2008 21:08:18 +0200
Message-ID: <20080516210818.26bf8cb8@hyperion.delvare>
References: <200805142314.m4ENEjPV026316@imap1.linux-foundation.org>
	<20080516083743.GA4180@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080516083743.GA4180-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: vitb-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org, htoa-hi6Y0CQ0nG0@public.gmane.org, i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, tmbinc-hi6Y0CQ0nG0@public.gmane.org, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Wolfram,

On Fri, 16 May 2008 10:37:43 +0200, Wolfram Sang wrote:
> On Wed, May 14, 2008 at 04:14:45PM -0700, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org wrote:
> 
> I just managed to test the latest version of this driver.
> 
> > +static int cpm_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)
> > +{
> > +	struct cpm_i2c *cpm = i2c_get_adapdata(adap);
> > +	struct i2c_reg __iomem *i2c_reg = cpm->i2c_reg;
> > +	struct i2c_ram __iomem *i2c_ram = cpm->i2c_ram;
> > +	struct i2c_msg *pmsg;
> > +	int ret, i;
> > +	int tptr;
> > +	int rptr;
> > +	cbd_t __iomem *tbdf;
> > +	cbd_t __iomem *rbdf;
> > +
> > +	if (num > CPM_MAXBD)
> > +		return -EINVAL;
> > +
> > +	/* Check if we have any oversized READ requests */
> > +	for (i = 0; i < num; i++) {
> > +		pmsg = &msgs[i];
> > +		if (pmsg->len >= CPM_MAX_READ)
> > +			return -EINVAL;
> > +	}
> > +
> > +	/* Reset to use first buffer */
> > +	out_be16(&i2c_ram->rbptr, in_be16(&i2c_ram->rbase));
> > +	out_be16(&i2c_ram->tbptr, in_be16(&i2c_ram->tbase));
> > +
> > +	tbdf = cpm->tbase;
> > +	rbdf = cpm->rbase;
> > +
> > +	tptr = 0;
> > +	rptr = 0;
> > +
> > +	while (tptr < num) {
> > +		pmsg = &msgs[tptr];
> > +		dev_dbg(&adap->dev, "R: %d T: %d\n", rptr, tptr);
> > +
> > +		cpm_i2c_parse_message(adap, pmsg, num, tptr, rptr);
> > +		if (pmsg->flags & I2C_M_RD)
> > +			rptr++;
> > +		tptr++;
> > +	}
> > +	/* Start transfer now */
> > +	/* Enable RX/TX/Error interupts */
> > +	out_8(&i2c_reg->i2cmr, I2CER_BUSY | I2CER_TXB | I2CER_RXB);
> > +	out_8(&i2c_reg->i2cer, 0xff);	/* Clear interrupt status */
> > +	/* Chip bug, set enable here */
> > +	setbits8(&i2c_reg->i2mod, I2MOD_EN);	/* Enable */
> > +	/* Begin transmission */
> > +	setbits8(&i2c_reg->i2com, I2COM_MASTER);
>
> Bummer! This should not be I2COM_MASTER but I2COM_START! Otherwise no
> I2C communication will happen.
> 
> After applying this change, the driver works fine on an MPC8260 (like
> the previous version did).

Would you have the possibility to review and ack this patch (with the
suggested fix above, of course)? I'd like to include it in my i2c tree
now as it has been around for some time but I'm a bit short of time to
review it and I also can't test it. If you can do that then I'll trust
your review and take the patch quickly. With the time saved, I could,
say, review the at24c driver ;)

Thanks,
-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
