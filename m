From: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Subject: Re: [sodaville] [PATCH 1/7] i2c/pxa2xx: Don't touch ISAR if not in
 slave mode
Date: Fri, 26 Nov 2010 19:28:32 +0100
Message-ID: <4CEFFC50.4090702@linutronix.de>
References: <1290633617-15311-1-git-send-email-bigeasy@linutronix.de>	<1290633617-15311-2-git-send-email-bigeasy@linutronix.de> <20101125235255.GB15948@trinity.fluff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20101125235255.GB15948-SMNkleLxa3Z6Wcw2j4pizdi2O/JbrIOy@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Cc: eric.y.miao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, sodaville-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Ben Dooks wrote:
>> +#ifdef CONFIG_I2C_PXA_SLAVE
>>  	writel(i2c->slave_addr, _ISAR(i2c));
>> +#endif
> 
> I was thinking about whether to add a flag to this to say whether the
> slave_addr field is valid, but to keep full compatiblity with the existing
> pxa users, we'd have to go and change every board using it.

i2c->slave_addr is 1 if slave mode is not enabled. Why should this value
be used in master mode?

Sebastian
