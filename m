From: David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Subject: Re: [PATCH 01/24] mtd/maps/pismo: remove dangling pointer and a
	leak
Date: Sun, 21 Mar 2010 08:30:41 +0000
Message-ID: <1269160241.4028.9777.camel@macbook.infradead.org>
References: <1269094385-16114-1-git-send-email-w.sang@pengutronix.de>
	 <1269094385-16114-2-git-send-email-w.sang@pengutronix.de>
	 <20100320145729.GA5399@flint.arm.linux.org.uk>
	 <20100320153146.GB5515@pengutronix.de>
	 <20100320154113.GB14470@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100320154113.GB14470-f404yB8NqCZvn6HldHNs0ANdhmdF6hFW@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Russell King <rmk+lkml-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Cc: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, "linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "kernel-janitors-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <kernel-janitors-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Sat, 2010-03-20 at 15:41 +0000, Russell King wrote:
> 
> Thanks.
> 
> Acked-by: Russell King <rmk+kernel-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
> 
> David, are you going to pick this up? 

http://git.infradead.org/mtd-2.6.git/commitdiff/395b2288

Thanks.

-- 
David Woodhouse                            Open Source Technology Centre
David.Woodhouse-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org                              Intel Corporation
