From: =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>
Subject: Re: [PATCH] i2c: at91: support atomic write xfer
Date: Mon, 16 Mar 2020 15:42:21 +0100
Message-ID: <20200316144221.GC19141@qmqm.qmqm.pl>
References: <c05f76f74cd6a7ec2735c96861f9d5933631c112.1584296795.git.mirq-linux@rere.qmqm.pl>
 <9924dd54-dd8b-d130-9607-2bbbc65675d5@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <9924dd54-dd8b-d130-9607-2bbbc65675d5@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Osipenko <digetx@gmail.com>
Cc: Ludovic Desroches <ludovic.desroches@microchip.com>, Nicolas Ferre <nicolas.ferre@microchip.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Sun, Mar 15, 2020 at 11:46:33PM +0300, Dmitry Osipenko wrote:
> 15.03.2020 21:27, Michał Mirosław пишет:
> > Implement basic support for atomic write - enough to get a simple
> > write to PMIC on shutdown. Only for chips having ALT_CMD register,
> > eg. SAMA5D2.
> > 
> > Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
> > ---
> 
> Hello Michał,
> 
> ...
> > +	ret = pm_runtime_get_sync(dev->dev);
> > +	if (ret < 0)
> > +		goto out;
> 
> Runtime PM can't be used while interrupts are disabled, unless
> pm_runtime_irq_safe() is used and driver's RPM callback is IRQ-safe.

I didn't get any warnings from lockdep and friends, but I'll double
check if this is by luck.

> ...
> > +	timeout = jiffies + (2 + msg->len) * HZ/1000;
> > +	for (;;) {
> > +		stat = at91_twi_read(dev, AT91_TWI_SR);
> > +		if (stat & AT91_TWI_TXCOMP)
> > +			break;
> > +		if (time_after(jiffies, timeout)) {
> > +			ret = -ETIMEDOUT;
> > +			goto out;
> > +		}
> > +		udelay(100);
> > +	}
> 
> Jiffies can't be used with the disabled interrupts because jiffies are
> updated by timer's interrupt.
> 
> Either ktime() API or iterator-based loop should be used.

Thanks for the pointers. In my use-case power is cut from the CPU at this
point so it didn't matter that the loop was infinite.

Best Regards
Michał Mirosław
