From: Max Schwarz <max.schwarz-BGeptl67XyCzQB+pC5nmwQ@public.gmane.org>
Subject: Re: [PATCH v5] i2c: add driver for Rockchip RK3xxx SoC I2C adapter
Date: Wed, 11 Jun 2014 22:24:51 +0200
Message-ID: <3519802.k4TzPo54uS@typ>
References: <5192968.EzcUiXba22@typ> <10794912.fZysmMBNIZ@typ> <20140610192709.GA3122@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140610192709.GA3122@katana>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, kfx-TNX95d0MmH7DzftRWevZcw@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Wolfram,

thanks for your comments.

On Tuesday 10 June 2014 at 21:27:09, Wolfram Sang wrote:
> Checking if the spinlock is needed would be nice, but we can also fix
> this later.

I'm simply not sure about the spinlock. My knowledge about IRQ handling in 
linux is limited.

We have an SMP system here (quadcore), so isn't it possible that the interrupt 
handler is still executing on another core when we hit the timeout? Disabling 
the interrupt enable bit in the hw would not be enough in that case, because 
it does not stop the running interrupt handler. So in my opinion, we need the
spinlock.

For those listening in, here is the code in question:

		timeout = wait_event_timeout(i2c->wait, !i2c->busy,
					     msecs_to_jiffies(WAIT_TIMEOUT));

		spin_lock_irqsave(&i2c->lock, flags);

		if (timeout == 0) {
			dev_err(i2c->dev, "timeout, ipd: 0x%02x, state: %d\n",
				i2c_readl(i2c, REG_IPD), i2c->state);

			/* Force a STOP condition without interrupt */
			i2c_writel(i2c, 0, REG_IEN);
			i2c_writel(i2c, REG_CON_EN | REG_CON_STOP, REG_CON);

			i2c->state = STATE_IDLE;
			...

The irq handler also locks i2c->lock and checks for i2c->state == STATE_IDLE 
and does nothing in that case.

> Besides this, my code-checkers say:
> 
>     CHECKPATCH
> CHECK: Logical continuations should be on the previous line
> #615: FILE: drivers/i2c/busses/i2c-rk3x.c:470:
> +	if (num >= 2 && msgs[0].len < 4
> +	    && !(msgs[0].flags & I2C_M_RD)
> 
> CHECK: Logical continuations should be on the previous line
> #616: FILE: drivers/i2c/busses/i2c-rk3x.c:471:
> +	    && !(msgs[0].flags & I2C_M_RD)
> +	    && (msgs[1].flags & I2C_M_RD)) {
> 
>     SPARSE
> drivers/i2c/busses/i2c-rk3x.c:173:20: warning: Using plain integer as NULL
> pointer drivers/i2c/busses/i2c-rk3x.c:664:45: warning: Using plain integer
> as NULL pointer drivers/i2c/busses/i2c-rk3x.c:735:9: warning: cast removes
> address space of expression
> SMATCH
> drivers/i2c/busses/i2c-rk3x.c:592 rk3x_i2c_xfer() error: double unlock
> 'spin_lock:&i2c->lock'
> SPATCH
> drivers/i2c/busses/i2c-rk3x.c:366:1-10: WARNING: Assignment of bool to 0/1
> drivers/i2c/busses/i2c-rk3x.c:187:2-11: WARNING: Assignment of bool to 0/1
>   CC      drivers/i2c/busses/i2c-rk3x.o
> drivers/i2c/busses/i2c-rk3x.c: In function 'rk3x_i2c_irq':
> drivers/i2c/busses/i2c-rk3x.c:336:15: warning: 'val' may be used
> uninitialized in this function [-Wuninitialized]
> drivers/i2c/busses/i2c-rk3x.c:321:15: note: 'val' was declared here

Thanks for those, fixed. And now I know how to run the checkers ;-)

> The smatch warning may be a false positive, please check.

It is a false positive. After initially locking it, I'm unlocking and locking 
the exactly once per loop iteration, so after the loop the lock is locked and 
I have to unlock again.

wait_event_timeout is a big macro construct with labels, so probably smatch 
gets confused there.

I agree with all your other comments and have modified the code accordingly.

> Thanks, I think we're very close to go...

I'll send a new version shortly, but I'd be really happy if someone could 
confirm or refute my thoughts about the lock...

Cheers,
  Max
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
