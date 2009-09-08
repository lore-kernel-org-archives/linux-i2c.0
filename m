From: "Mark A. Greer" <mgreer-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 2.6.31-rc9] i2c-mv64xxx.c: correct mv64xxx_i2c_intr()
	return type
Date: Tue, 8 Sep 2009 10:11:32 -0700
Message-ID: <20090908171132.GA28918@mag.az.mvista.com>
References: <200909071000.n87A0CBF019863@pilspetsen.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <200909071000.n87A0CBF019863-tgku4HJDRZih8lFjZTKsyTAV6s6igYVG@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mikael Pettersson <mikpe-1zs4UD6AkMk@public.gmane.org>
Cc: ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, mgreer-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Mon, Sep 07, 2009 at 12:00:13PM +0200, Mikael Pettersson wrote:
> The mv64xxx_i2c_intr() irq handler in drivers/i2c/busses/i2c-mv64xxx.c
> is declared as returning 'int', resulting in this compile-time warning:
> 
> drivers/i2c/busses/i2c-mv64xxx.c: In function 'mv64xxx_i2c_probe':
> drivers/i2c/busses/i2c-mv64xxx.c:540: warning: passing argument 2 of 'request_irq' from incompatible pointer type
> 
> Fix: correct the return type to 'irqreturn_t'.
> 
> Signed-off-by: Mikael Pettersson <mikpe-1zs4UD6AkMk@public.gmane.org>

Signed-off-by: Mark A. Greer <mgreer-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>
