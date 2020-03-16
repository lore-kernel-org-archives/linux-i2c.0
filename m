From: Stefan Lengfeld <contact@stefanchrist.eu>
Subject: Re: [PATCH] i2c: at91: support atomic write xfer
Date: Mon, 16 Mar 2020 18:20:03 +0100
Message-ID: <20200316172003.lguso2fczz5imh6g@porty>
References: <c05f76f74cd6a7ec2735c96861f9d5933631c112.1584296795.git.mirq-linux@rere.qmqm.pl>
 <9924dd54-dd8b-d130-9607-2bbbc65675d5@gmail.com>
 <20200316144221.GC19141@qmqm.qmqm.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from stcim.de ([78.46.90.227]:58902 "EHLO stcim.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730437AbgCPRor (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 16 Mar 2020 13:44:47 -0400
Content-Disposition: inline
In-Reply-To: <20200316144221.GC19141@qmqm.qmqm.pl>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc: Dmitry Osipenko <digetx@gmail.com>, Ludovic Desroches <ludovic.desroches@microchip.com>, Nicolas Ferre <nicolas.ferre@microchip.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Marco Felsch <m.felsch@pengutronix.de>

Hi Michał,

On Mon, Mar 16, 2020 at 03:42:21PM +0100, Michał Mirosław wrote:
> On Sun, Mar 15, 2020 at 11:46:33PM +0300, Dmitry Osipenko wrote:
> > 15.03.2020 21:27, Michał Mirosław пишет:
> > > Implement basic support for atomic write - enough to get a simple
> > > write to PMIC on shutdown. Only for chips having ALT_CMD register,
> > > eg. SAMA5D2.
> > > 
> > > Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
> > > ---
> > 
> > Hello Michał,
> > 
> > ...
> > > +	ret = pm_runtime_get_sync(dev->dev);
> > > +	if (ret < 0)
> > > +		goto out;
> > 
> > Runtime PM can't be used while interrupts are disabled, unless
> > pm_runtime_irq_safe() is used and driver's RPM callback is IRQ-safe.
> 
> I didn't get any warnings from lockdep and friends, but I'll double
> check if this is by luck.

You can have a look at the I2C atomic patch for the imx-driver. See

   https://patchwork.ozlabs.org/patch/1225802/

In that patch Marco Felsch is using clk_enable() and clk_disable() calls.

> 
> > ...
> > > +	timeout = jiffies + (2 + msg->len) * HZ/1000;
> > > +	for (;;) {
> > > +		stat = at91_twi_read(dev, AT91_TWI_SR);
> > > +		if (stat & AT91_TWI_TXCOMP)
> > > +			break;
> > > +		if (time_after(jiffies, timeout)) {
> > > +			ret = -ETIMEDOUT;
> > > +			goto out;
> > > +		}
> > > +		udelay(100);
> > > +	}
> > 
> > Jiffies can't be used with the disabled interrupts because jiffies are
> > updated by timer's interrupt.
> > 
> > Either ktime() API or iterator-based loop should be used.
> 
> Thanks for the pointers. In my use-case power is cut from the CPU at this
> point so it didn't matter that the loop was infinite.

Here again you can have a look at Marco Felsch's patch. He used the
function readb_poll_timeout_atomic(). So the loop can potentially
replaced by a single line.

Kind regards,
Stefan
