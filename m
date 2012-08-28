From: phil.edworthy-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org
Subject: Re: [PATCH] i2c: add Renesas R-Car I2C driver
Date: Tue, 28 Aug 2012 07:26:39 +0100
Message-ID: <OF0AA2687D.3C2F6EFC-ON80257A56.003BB6CC-80257A68.0023665F@eu.necel.com>
References: <871uk04aa2.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <871uk04aa2.wl%kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Cc: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Kuninori Morimoto <kuninori.morimoto.gx-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Linux-I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Magnus <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Shubhrajyoti Datta <omaplinuxkernel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Morimoto-san,

Apologies for the late review, I have some comments below.

Thanks,
Phil

<snip>
> +static void rcar_i2c_write(struct rcar_i2c_priv *priv, int reg, u32 
val)
> +{
> +   __raw_writel(val, priv->io + reg);
> +}
> +
> +static u32 rcar_i2c_read(struct rcar_i2c_priv *priv, int reg)
> +{
> +   return __raw_readl(priv->io + reg);
> +}
I think we should use writel/readl here. We have a number of devices where 
the virtual address map conflicts with register addresses for other 
peripherals.

<snip>
> +static void rcar_i2c_bus_phase(struct rcar_i2c_priv *priv, int phase)
> +{
> +   switch (phase) {
> +   case RCAR_BUS_PHASE_ADDR:
> +      rcar_i2c_write(priv, ICMCR, MDBS | MIE | ESG);
> +      break;
> +   case RCAR_BUS_PHASE_DATA:
> +      rcar_i2c_write(priv, ICMCR, MDBS | MIE);
> +      break;
> +   case RCAR_BUS_PHASE_STOP:
> +      rcar_i2c_write(priv, ICMCR, MDBS | MIE | FSB);
> +      break;
> +   }
> +
> +   return;
> +}
Don't need the return.

> +
> +/*
> + *      clock function
> + */
> +static int rcar_i2c_clock_calculate(struct rcar_i2c_priv *priv,
> +                u32 bus_speed,
> +                struct device *dev)
> +{
> +   struct clk *clkp = clk_get(NULL, "peripheral_clk");
> +   u32 scgd, cdf;
> +   u32 round, ick;
> +
> +   if (!clkp) {
> +      dev_err(dev, "there is no peripheral_clk\n");
> +      return -EIO;
> +   }
> +
> +   /*
> +    * use 95% bus speed for safety.
> +    */
> +   bus_speed = bus_speed * 95 / 100;
Why do you use 95% of the bus speed? Surely, either the hardware supports 
a specific speed or it doesn't.

> +
> +   /*
> +    * calculate SCL clock
> +    * see
> +    *   ICCCR
> +    *
> +    * ick   = clkp / (1 + CDF)
> +    * SCL   = ick / (20 + SCGD * 8 + F[(ticf + tr + intd) * ick])
> +    *
> +    * ick  : I2C internal clock < 20 MHz
> +    * ticf : I2C SCL falling time  =  35 ns here
> +    * tr   : I2C SCL rising  time  = 200 ns here
> +    * intd : LSI internal delay    =  50 ns here
> +    * clkp : peripheral_clk
> +    * F[]  : integer up-valuation
> +    */
> +   for (cdf = 0; cdf < 4; cdf++) {
> +      ick = clk_get_rate(clkp) / (1 + cdf);
> +      if (ick < 20000000)
> +         goto ick_find;
> +   }
> +   dev_err(dev, "there is no best CDF\n");
> +
> +   return -EIO;
> +
> +ick_find:
> +   /*
> +    * it is impossible to calculate large scale
> +    * number on u32
> +    *
> +    * F[(ticf + tr + intd) * ick]
> +    *  = F[(35 + 200 + 50)ns * ick]
> +    *  = F[285 * ick / 1000000000]
> +    *  = F[(ick / 1000000) * 285 / 1000]
> +    */
> +   round = (ick + 500000) / 1000000 * 285;
> +   round = (round + 500) / 1000;
Now that I see this, I guess that you used 95% bus clock due to rounding 
errors here. If so, maybe it would be better to try to improve this 
calculation.

<snip>
> +static int rcar_i2c_irq_send(struct rcar_i2c_priv *priv, u32 msr)
> +{
> +   struct i2c_msg *msg = priv->msg;
> +
> +   /*
> +    * FIXME
> +    * sometimes, unknown interrupt happend.
typo: happend => happened 

> +    * Do nothing
> +    */
> +   if (!(msr & MDE))
> +      return 0;
> +
> +   /*
> +    * If address transfer phase finised,
typo: finised => finished

<snip>
> +static int rcar_i2c_irq_recv(struct rcar_i2c_priv *priv, u32 msr)
> +{
> +   struct i2c_msg *msg = priv->msg;
> +
> +   /*
> +    * FIXME
> +    * sometimes, unknown interrupt happend.
typo: happend => happened 

<snip>
> +static int rcar_i2c_master_xfer(struct i2c_adapter *adap,
> +            struct i2c_msg *msgs,
> +            int num)
> +{
> +   struct rcar_i2c_priv *priv = i2c_get_adapdata(adap);
> +   struct device *dev = rcar_i2c_priv_to_dev(priv);
> +   unsigned long flags;
> +   int i, ret, timeout;
> +
> +   /*================== enable i2c device ===================*/
> +   pm_runtime_get_sync(dev);
> +
> +   /*-------------- spin lock -----------------*/
> +   spin_lock_irqsave(&priv->lock, flags);
> +
> +   rcar_i2c_soft_reset(priv);
> +   rcar_i2c_clock_start(priv);
> +
> +   spin_unlock_irqrestore(&priv->lock, flags);
> +   /*-------------- spin unlock -----------------*/
> +
> +   ret = -EINVAL;
> +   for (i = 0; i < num; i++) {
> +      /*-------------- spin lock -----------------*/
> +      spin_lock_irqsave(&priv->lock, flags);
> +
> +      /* init each data */
> +      priv->msg   = &msgs[i];
> +      priv->pos   = 0;
> +      priv->flags   = 0;
> +      if (priv->msg == &msgs[num - 1])
> +         rcar_i2c_flags_set(priv, ID_LAST_MSG);
> +
> +      /* start send/recv */
> +      if (rcar_i2c_is_recv(priv))
> +         ret = rcar_i2c_recv(priv);
> +      else
> +         ret = rcar_i2c_send(priv);
> +
> +      spin_unlock_irqrestore(&priv->lock, flags);
> +      /*-------------- spin unlock -----------------*/
> +
> +      if (ret < 0)
> +         break;
> +
> +      /*
> +       * wait result
> +       */
> +      timeout = wait_event_timeout(priv->wait,
> +                    rcar_i2c_flags_has(priv, ID_DONE),
> +                    5 * HZ);
> +      if (!timeout) {
> +         ret = -ETIMEDOUT;
> +         break;
> +      }
> +
> +      /*
> +       * error handling
> +       */
> +      if (rcar_i2c_flags_has(priv, ID_NACK)) {
> +         ret = -EREMOTEIO;
> +
> +         if (msgs->flags & I2C_M_IGNORE_NAK)
> +            ret = 0;
> +         break;
> +      }
> +
> +      if (rcar_i2c_flags_has(priv, ID_ARBLOST)) {
> +         ret = -EAGAIN;
> +         break;
> +      }
> +
> +      if (rcar_i2c_flags_has(priv, ID_IOERROR)) {
> +         ret = -EIO;
> +         break;
> +      }
> +
> +      ret = i + 1; /* The number of transfer */
> +   }
> +
> +   pm_runtime_put_sync(dev);
> +   /*================== disable i2c device ===================*/
This comment should be above the previous line, unless you the comment is 
meant to say "i2c device disabled"

> +
> +   if (ret < 0)
> +      dev_err(dev, "error %d : %x\n", ret, priv->flags);
> +
> +   return ret;
> +}
