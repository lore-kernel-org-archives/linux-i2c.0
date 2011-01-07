From: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Subject: Re: I2C support for CE4100, v3
Date: Fri, 7 Jan 2011 12:20:10 +0100
Message-ID: <20110107112010.GA18652@www.tglx.de>
References: <1294246263-31960-1-git-send-email-bigeasy@linutronix.de> <20110105215159.GU817@trinity.fluff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20110105215159.GU817-SMNkleLxa3Z6Wcw2j4pizdi2O/JbrIOy@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Cc: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sodaville-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, eric.y.miao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

* Ben Dooks | 2011-01-05 21:51:59 [+0000]:

>> Sebastian Andrzej Siewior (6):
>>       i2c/pxa: use dynamic register layout
>>       arm/pxa2xx: reorganize I2C files
>>       i2c/pxa2xx: Add PCI support for PXA I2C controller
>>       i2c/pxa2xx: add support for shared IRQ handler
>>       i2c/pxa2xx: check timeout correctly
>>       i2c/pxa2xx: pass of_node from platform driver to adapter and publish
>
>please rename these i2c-pxa2xx
>and for the ARM, use ARM: pxa2xx as the prefix
> 
Done

Sebastian
