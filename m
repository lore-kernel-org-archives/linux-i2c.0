From: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Subject: Re: [PATCH] NFC: Driver for Inside Secure MicroRead NFC chip
Date: Fri, 18 Mar 2011 12:51:50 +0000
Message-ID: <20110318125150.GD27129@sirena.org.uk>
References: <1300444824-13713-1-git-send-email-waldemar.rymarkiewicz@tieto.com> <1300444824-13713-2-git-send-email-waldemar.rymarkiewicz@tieto.com> <201103181319.54191.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <201103181319.54191.arnd-r2nGTMty4D4@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Cc: Waldemar Rymarkiewicz <waldemar.rymarkiewicz-++hxYGjEMp0AvxtiuMwx3w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, hthebaud-Umy9UjvE/gtWk0Htik3J/w@public.gmane.org, matti.j.aaltonen-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org, Alan Cox <alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Fri, Mar 18, 2011 at 01:19:53PM +0100, Arnd Bergmann wrote:
> On Friday 18 March 2011, Waldemar Rymarkiewicz wrote:

> > +
> > +	mutex_lock(&info->rx_mutex);
> > +	info->irq_state = 1;
> > +	mutex_unlock(&info->rx_mutex);
> > +
> > +	wake_up_interruptible(&info->rx_waitq);
> > +
> > +	return IRQ_HANDLED;
> > +}

> You cannot take a mutex from interrupt context, that may
> cause deadlocks.

This is a threaded IRQ handler so mutexes are fine.
