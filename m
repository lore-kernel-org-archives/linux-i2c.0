From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] NFC: Driver for Inside Secure MicroRead NFC chip
Date: Mon, 14 Mar 2011 18:01:01 +0100
Message-ID: <201103141801.01333.arnd@arndb.de>
References: <1299766808-2535-1-git-send-email-waldemar.rymarkiewicz@tieto.com> <201103141700.26457.arnd@arndb.de> <99B09243E1A5DA4898CDD8B7001114481082FAE168@EXMB04.eu.tieto.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <99B09243E1A5DA4898CDD8B7001114481082FAE168@EXMB04.eu.tieto.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Waldemar.Rymarkiewicz@tieto.com
Cc: matti.j.aaltonen@nokia.com, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, hthebaud@insidefr.com
List-Id: linux-i2c@vger.kernel.org

On Monday 14 March 2011, Waldemar.Rymarkiewicz@tieto.com wrote:
> >> No, it's simply there as I have been faceing i2c write error while I 
> >> do two consecutive writes.
> >> The second fails now and then. That's seems to be a chip issue.
> >> I will try to investigate this issue.
> >
> >Ok. It sounds like a bug in the i2c driver, you should also 
> >take a look there. Maybe it has never had to deal with this 
> >much write data at once.
> 
> It's been confirmed now that this is how chip is supposed to work and the
> driver should not care about this scenario. Upper layers (onfc stack) handle this.
> Thus, will simply remove urange_sleep and that's it.

It sounds strange that this will be handled in user space, since
it won't have any idea if the hardware is available again.

I've tried to find the onfc stack that talks to this device but
couldn't see it. Do you have a URL for this?

	Arnd
