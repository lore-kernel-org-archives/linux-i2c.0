From: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: Re: [PATCH V9] I2C driver for IMX
Date: Thu, 17 Jul 2008 16:22:36 +0100
Message-ID: <20080717152236.GN30539@fluff.org.uk>
References: <g56uvk$e6s$1@ger.gmane.org> <20080715163734.GK30539@fluff.org.uk>
	<g5kgl6$sva$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <g5kgl6$sva$1@ger.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Darius <augulis.darius-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Wed, Jul 16, 2008 at 12:50:51PM +0300, Darius wrote:
> Ben Dooks wrote:
> 
> > 
> > I'll need a reasonable header/description in place of the
> > changelog before this can be merged.
> 
> I'll send it with patch final release, ok?
> 
> > 
> > I'm not going to step on RMK's toes unless he gives me explicit
> > acknowledgement to merge arch/arm/mach-imx/mx1ads.c 
> 
> I can split this patch into two separate patches: one with I2C driver only, second with MX1ADS support for this driver only.
> Should I do so?

This is the best plan, merging across trees is difficult.
 
> >> +	/* wait for bus not busy */
> >> +	for (i = 0; i < I2C_IMX_TIME_BUSY; i++) {
> >> +		if (!(readb(i2c_imx->base + IMX_I2C_I2SR) & (I2SR_IBB | I2SR_IAL)))
> >> +			return 0;
> >> +		udelay(1);
> >> +	}
> >> +	dev_dbg(&i2c_imx->adapter.dev, "<%s> I2C bus is busy!\n", __func__);
> >> +	return -EBUSY;
> >> +}
> > 
> > out of interest, do you really want to be busy-looping here and
> > not allowing the task to sleep?
> 
> Really not. I see that i2c-mpc driver handles this bit different.
> Maybe it's a good idea to make the same in i2c-imx driver, because I2C controller itself is the same in MPC and in IMX.

I think calling schedule() here (or similar) is a better use of the
cpu cycles, simply sitting and spinning isn't doing anybody much good.
 
> >> +static int i2c_imx_acked(struct imx_i2c_struct *i2c_imx)
> >> +{
> >> +	unsigned int i = 0;
> >> +
> >> +	for (i = 0; i < I2C_IMX_TIME_ACK; i++) {
> >> +		if (!(readb(i2c_imx->base + IMX_I2C_I2SR) & I2SR_RXAK)) {
> >> +			dev_dbg(&i2c_imx->adapter.dev,
> >> +				"<%s> ACK received\n", __func__);
> >> +			return 0;
> >> +		}
> >> +		udelay(1);
> >> +	}
> >> +	dev_dbg(&i2c_imx->adapter.dev, "<%s> No ACK!\n", __func__);
> >> +	return -EIO;   /* No ACK */
> >> +}
> 
> btw, with this function is similar situation like in previous one.
> I'll change it in the same way.

yep.

if you can post a new version in the next day or so
I will try and put it in my next pull request.

-- 
Ben (ben-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
