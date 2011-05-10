From: Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: Re: [PATCH 00/13] Various updates to the Nomadik I2C controller
Date: Tue, 10 May 2011 23:24:48 +0100
Message-ID: <20110510222448.GC634@freya.fluff.org>
References: <1304976877-31366-1-git-send-email-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1304976877-31366-1-git-send-email-linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Mon, May 09, 2011 at 11:34:37PM +0200, Linus Walleij wrote:
> A lot of internal refining of this driver has happened on this
> driver inside ST-Ericsson since last kernel cycle. Here are the
> accumulated changes. I have NOT squashed any development history
> this time, since I was severely beat up about it last time.
> 
> The last patch in the series for mach-ux500 shall go into my ux500
> tree, it is not required for the driver to function, so the rest
> of the patches can be applied to the I2C tree without causing any
> problems with the platforms using the driver.
> 
> Jonas Aberg (1):
>   i2c/i2c-nomadik: add regulator support
> 
> Linus Walleij (2):
>   i2c/i2c-nomadik: fix speed enumerator
>   mach-ux500: set proper I2C platform data from MOP500s
> 
> Rabin Vincent (1):
>   i2c/i2c-nomadik: use pm_runtime API
> 
> Virupax Sadashivpetimath (8):
>   i2c/i2c-nomadik: make i2c timeout specific per i2c bus
>   i2c/i2c-nomadik: corrrect returned error numbers
>   i2c/i2c-nomadik: correct adapter timeout initialization
>   i2c/i2c-nomadik: print abort cause only on abort tag
>   i2c/i2c-nomadik: add code to retry on timeout failure
>   i2c/i2c-nomadik: change the TX and RX threshold
>   i2c/i2c-nomadik: remove the unnecessary delay
>   i2c/i2c-nomadik: reset the hw after status check
> 
> srinidhi kasagar (1):
>   i2c/i2c-nomadik: remove the redundant error message
> 
>  arch/arm/mach-ux500/board-mop500.c       |   14 +-
>  arch/arm/plat-nomadik/include/plat/i2c.h |    8 +-
>  drivers/i2c/busses/i2c-nomadik.c         |  272 ++++++++++++++++++++----------
>  3 files changed, 194 insertions(+), 100 deletions(-)

right, mostly looks fine, just one or two bits
that could do with looking at if possible.
