From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: Re: [PATCH] NFC: Driver for Inside Secure MicroRead NFC chip
Date: Fri, 18 Mar 2011 15:20:14 +0100
Message-ID: <201103181520.14315.arnd@arndb.de>
References: <1300444824-13713-1-git-send-email-waldemar.rymarkiewicz@tieto.com> <201103181319.54191.arnd@arndb.de> <20110318125150.GD27129@sirena.org.uk>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20110318125150.GD27129-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Cc: Waldemar Rymarkiewicz <waldemar.rymarkiewicz-++hxYGjEMp0AvxtiuMwx3w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, hthebaud-Umy9UjvE/gtWk0Htik3J/w@public.gmane.org, matti.j.aaltonen-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org, Alan Cox <alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Friday 18 March 2011, Mark Brown wrote:
> On Fri, Mar 18, 2011 at 01:19:53PM +0100, Arnd Bergmann wrote:
> > On Friday 18 March 2011, Waldemar Rymarkiewicz wrote:
> 
> > > +
> > > +   mutex_lock(&info->rx_mutex);
> > > +   info->irq_state = 1;
> > > +   mutex_unlock(&info->rx_mutex);
> > > +
> > > +   wake_up_interruptible(&info->rx_waitq);
> > > +
> > > +   return IRQ_HANDLED;
> > > +}
> 
> > You cannot take a mutex from interrupt context, that may
> > cause deadlocks.
> 
> This is a threaded IRQ handler so mutexes are fine.

Ah, right. I've never seen one of these used in the field,
so I didn't think of this.

Looking at the mutexes though: The read function does
not hold the rx_mutex when reading the irq_state
variable, so that is potentially racy.

The read function seems to have another problem regarding
the user space buffer: it bails out if the provided buffer
is larger than the available data, which is pointless,
but it does not check if the user buffer is too short.

	Arnd
