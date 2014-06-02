From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: Re: [PATCH v2] i2c: nuc900: remove driver
Date: Mon, 02 Jun 2014 11:07:19 +0200
Message-ID: <5344745.s7ruhXG564@wuerfel>
References: <1401654925-20791-1-git-send-email-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1401654925-20791-1-git-send-email-wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Wan ZongShun <mcuos.com-wSZih8+RwX/YtjvyW6yDsg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Sunday 01 June 2014 22:35:25 Wolfram Sang wrote:
> Arnd said in another patch:
> 
> "As far as I can tell, this driver must have produced this
> error for as long as it has been merged into the mainline kernel, but
> it was never part of the normal build tests:
> 
> drivers/i2c/busses/i2c-nuc900.c: In function 'nuc900_i2c_probe':
> drivers/i2c/busses/i2c-nuc900.c:601:17: error: request for member
> 'apbfreq' in something not a structure or union
>   ret = (i2c->clk.apbfreq)/(pdata->bus_freq * 5) - 1;
>                  ^
> This is an attempt to get the driver to build and possibly
> work correctly, although I do wonder whether we should just
> remove it, as it has clearly never worked."
> 
> I agree with removing it since nobody showed interest in Arnd's fixup
> patch.
> 
> Reported-by: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
> Signed-off-by: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
> Cc: Wan ZongShun <mcuos.com-wSZih8+RwX/YtjvyW6yDsg@public.gmane.org>
> 

Acked-by: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
