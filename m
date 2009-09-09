From: Mike Frysinger <vapier.adi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [Uclinux-dist-devel] Removing deprecated drivers from
	drivers/i2c/chips
Date: Wed, 9 Sep 2009 19:54:34 -0400
Message-ID: <8bd0f97a0909091654h290180e5ob79178583aca143f@mail.gmail.com>
References: <1252531371-14866-1-git-send-email-w.sang@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1252531371-14866-1-git-send-email-w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org, uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Wed, Sep 9, 2009 at 17:22, Wolfram Sang wrote:
> continuing the quest to clean up and ultimately remove the drivers/i2c/chips
> directory, this patch series removes three drivers for GPIO-expanders which are
> obsoleted and marked as deprecated for more than a year. The newer (and better)
> drivers can be found in drivers/gpio.
>
> As it is ensured that the newer drivers cover the same i2c_device_ids, all
> platform_devices will still match. Some defconfig updates may be necessary
> though, but according to [1] this is left to the arch|platform-maintainers
> (also as most defconfigs are quite outdated). For that reason, I put the
> relevant arch-mailing-lists to Cc. Comments are welcome.

the Blackfin defconfigs refer to an input driver for the PCF8574, not
the I2C client driver
-mike
