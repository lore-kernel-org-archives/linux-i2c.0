From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: Re: [PATCH] NFC: Driver for Inside Secure MicroRead NFC chip
Date: Tue, 15 Mar 2011 10:06:53 +0100
Message-ID: <201103151006.53558.arnd@arndb.de>
References: <1299766808-2535-1-git-send-email-waldemar.rymarkiewicz@tieto.com> <201103141801.01333.arnd@arndb.de> <99B09243E1A5DA4898CDD8B7001114481082FAE39E@EXMB04.eu.tieto.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <99B09243E1A5DA4898CDD8B7001114481082FAE39E-TzrFtyi11j7rLp5S7fUuNkEOCMrvLtNR@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Waldemar.Rymarkiewicz-++hxYGjEMp0AvxtiuMwx3w@public.gmane.org
Cc: matti.j.aaltonen-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, hthebaud-Umy9UjvE/gtWk0Htik3J/w@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Tuesday 15 March 2011 09:37:04 Waldemar.Rymarkiewicz-++hxYGjEMp0AvxtiuMwx3w@public.gmane.org wrote:
> >It sounds strange that this will be handled in user space, 
> >since it won't have any idea if the hardware is available again.
> 
> >I've tried to find the onfc stack that talks to this device 
> >but couldn't see it. Do you have a URL for this?
> 
> Here you are
> 
> http://sourceforge.net/projects/open-nfc/
> http://www.open-nfc.org

I found these before, but I did not find code that opens your
device to read or write it. There is a .zip file with some
source code, but that seems to have no connection to your
driver and no build instructions.

	Arnd
