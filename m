From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: Re: [PATCH] NFC: Driver for Inside Secure MicroRead NFC chip
Date: Mon, 14 Mar 2011 16:34:10 +0100
Message-ID: <201103141634.10865.arnd@arndb.de>
References: <1299766808-2535-1-git-send-email-waldemar.rymarkiewicz@tieto.com> <201103101720.53782.arnd@arndb.de> <99B09243E1A5DA4898CDD8B7001114481082FAE10A@EXMB04.eu.tieto.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <99B09243E1A5DA4898CDD8B7001114481082FAE10A-TzrFtyi11j7rLp5S7fUuNkEOCMrvLtNR@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Waldemar.Rymarkiewicz-++hxYGjEMp0AvxtiuMwx3w@public.gmane.org
Cc: matti.j.aaltonen-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, hthebaud-Umy9UjvE/gtWk0Htik3J/w@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Monday 14 March 2011, Waldemar.Rymarkiewicz-++hxYGjEMp0AvxtiuMwx3w@public.gmane.org wrote:
> >Oh, I see you simply do
> >
> >       ret = i2c_master_send(client, info->buf, len);
> >       usleep_range(1000, 10000);
> >
> >and assume that the buffer can always be written within a 
> >milisecond, so you just slow down output enough to never have 
> >to worry about it, right?
> >
> >A nicer solution would be to have an interrupt driven output 
> >so you know when the i2c buffers have been flushed.
> 
> Well, I get the idea of interrupt driven output, but as I have
> little linux kernel experience I'm not sure how to implement this. 
> Can you extend you thoughts or if you know piont me a driver which
> uses that concept?

Most serial drivers do this, see drivers/tty/serial for a number
of examples, or drivers/serial on older kernels.

> I'm not sure who should rise an interrupt when data has
> been flushed. I2c core or the chip itself?

That would depend on your hardware. The only important
part is that you make sure you can send out data at any
time. If i2c_master_send() causes accesses to your
buffer after returning, there has to be an i2c method
of making sure that it has completed.

If the usleep_range is trying to synchronize between the
NFC and the I2C chip, you must wait for a notication from
the NFC hardware that it's done.

> What's more, I guess the i2c_master_send  is a synchronous
> call and when it returnes we know it flushed data. Right? 

If i2c_master_send is synchronous, you might not
need the usleep_range() at all. Removing that call
would be entirely reasonable.

	Arnd
