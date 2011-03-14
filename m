From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: Re: [PATCH] NFC: Driver for Inside Secure MicroRead NFC chip
Date: Mon, 14 Mar 2011 17:00:26 +0100
Message-ID: <201103141700.26457.arnd@arndb.de>
References: <1299766808-2535-1-git-send-email-waldemar.rymarkiewicz@tieto.com> <201103141634.10865.arnd@arndb.de> <99B09243E1A5DA4898CDD8B7001114481082FAE15A@EXMB04.eu.tieto.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <99B09243E1A5DA4898CDD8B7001114481082FAE15A-TzrFtyi11j7rLp5S7fUuNkEOCMrvLtNR@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Waldemar.Rymarkiewicz-++hxYGjEMp0AvxtiuMwx3w@public.gmane.org
Cc: matti.j.aaltonen-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, hthebaud-Umy9UjvE/gtWk0Htik3J/w@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Monday 14 March 2011, Waldemar.Rymarkiewicz-++hxYGjEMp0AvxtiuMwx3w@public.gmane.org wrote:
> >
> >If the usleep_range is trying to synchronize between the NFC 
> >and the I2C chip, you must wait for a notication from the NFC 
> >hardware that it's done.
> 
> No, it's simply there as I have been faceing i2c write error while
> I do two consecutive writes.
> The second fails now and then. That's seems to be a chip issue.
> I will try to investigate this issue.

Ok. It sounds like a bug in the i2c driver, you should also take
a look there. Maybe it has never had to deal with this much
write data at once.

	Arnd
