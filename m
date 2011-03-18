From: Alan Cox <alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>
Subject: Re: [PATCH] NFC: Driver for Inside Secure MicroRead NFC chip
Date: Fri, 18 Mar 2011 15:12:19 +0000
Message-ID: <20110318151219.7aedc765@lxorguk.ukuu.org.uk>
References: <1300444824-13713-1-git-send-email-waldemar.rymarkiewicz@tieto.com>
	<1300444824-13713-2-git-send-email-waldemar.rymarkiewicz@tieto.com>
	<20110318110348.728f6036@lxorguk.ukuu.org.uk>
	<99B09243E1A5DA4898CDD8B7001114481085881963@EXMB04.eu.tieto.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <99B09243E1A5DA4898CDD8B7001114481085881963-TzrFtyi11j7rLp5S7fUuNkEOCMrvLtNR@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Waldemar.Rymarkiewicz-++hxYGjEMp0AvxtiuMwx3w@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, hthebaud-Umy9UjvE/gtWk0Htik3J/w@public.gmane.org, matti.j.aaltonen-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

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
> 	mutex_lock(&info->rx_mutex);
> 	ret = i2c_master_recv(client, info->buf, info->buflen);
> 	info->irq_state = 0;
> 	mutex_unlock(&info->rx_mutex);
> 

I was thinking clear_bit/test_and_set_bit rather than atomic_t operations.

ie in the IRQ

	clear_bit(0, &info->irq_state);


in the main path

	if (test_and_set_bit(0, &info->state))
		i2c_master_recv(...)

but if the mutex is needed anyway it doesn't help make the code saner.
