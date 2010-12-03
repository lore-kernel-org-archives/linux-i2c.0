From: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Subject: Re: [PATCH 1/6] i2c/pxa2xx: Don't touch ISAR on X86
Date: Fri, 03 Dec 2010 19:17:04 +0100
Message-ID: <4CF93420.9010006@linutronix.de>
References: <1291320589-31570-1-git-send-email-bigeasy@linutronix.de> <1291320589-31570-2-git-send-email-bigeasy@linutronix.de> <20101203014424.GG24979@trinity.fluff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20101203014424.GG24979-SMNkleLxa3Z6Wcw2j4pizdi2O/JbrIOy@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ben Dooks <ben-SMNkleLxa3Z6Wcw2j4pizdi2O/JbrIOy@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, eric.y.miao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, sodaville-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, Dirk Brandewie <dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Ben Dooks wrote:
>> +#ifndef CONFIG_X86
>>  	writel(i2c->slave_addr, _ISAR(i2c));
>> +#endif


> I'd prefer some way of changing based on either the device name (see
> some other drivers which bind on multiple names) to define things such
> as this, as well as possibly changing the register layout.

Okay, I will hide this ISAR access a platform_device_id id.

Do you want me to also change the register access? This would be a
intrusive patch since I would have to touch every readl()/writel() line
in this file.

Sebastian
