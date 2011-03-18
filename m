From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: Re: [PATCH] NFC: Driver for Inside Secure MicroRead NFC chip
Date: Fri, 18 Mar 2011 16:05:36 +0100
Message-ID: <201103181605.36877.arnd@arndb.de>
References: <1300444824-13713-1-git-send-email-waldemar.rymarkiewicz@tieto.com> <20110318110348.728f6036@lxorguk.ukuu.org.uk> <99B09243E1A5DA4898CDD8B7001114481085881963@EXMB04.eu.tieto.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <99B09243E1A5DA4898CDD8B7001114481085881963-TzrFtyi11j7rLp5S7fUuNkEOCMrvLtNR@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Waldemar.Rymarkiewicz-++hxYGjEMp0AvxtiuMwx3w@public.gmane.org
Cc: alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, hthebaud-Umy9UjvE/gtWk0Htik3J/w@public.gmane.org, matti.j.aaltonen-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Friday 18 March 2011, Waldemar.Rymarkiewicz-++hxYGjEMp0AvxtiuMwx3w@public.gmane.org wrote:
> >
> >Ermm nope.. why do we have do nothing ioctls ?
> >
> 
> onfc stack requires those ones, but they are only valid for a specific test enviroment.
> This should not be a case for driver and the stack should care about it if it needs
> this. Then will remove it.

The way this normally works is to figure out the correct
way to implement the kernel driver first and then write
a user space stack around it, not the other way round...
  
> >> +
> >> +    mutex_lock(&info->rx_mutex);
> >> +    info->irq_state = 1;
> >> +    mutex_unlock(&info->rx_mutex);
> >
> >Would it not be lighter to use atomic bit ops ?
> 
> Do you mean  in order to remove rx_mutex? 
> 
> mutex_lock(&info->rx_mutex);
> atomic_set(info->irq_state ,1);
> mutex_unlock(&info->rx_mutex);
> 
> looks a bit strange. I still need the rx_mutex to protect irq_state while reading i2c.
> 
>         mutex_lock(&info->rx_mutex);
>         ret = i2c_master_recv(client, info->buf, info->buflen);
>         info->irq_state = 0;
>         mutex_unlock(&info->rx_mutex);

What Alan meant was set_bit/test_and_clear_bit here, not atomic_*().
As I mentioned in the other mail, the way you check the flag is
probably still racy with the current mutex use.

Note that the interrupt handler doesn't do much at all, so it's probably
a good idea to use a regular (non-threaded) handler here to reduce
the overhead, once you have removed the mutex.

	Arnd
