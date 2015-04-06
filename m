From: "Grygorii.Strashko-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <grygorii.strashko-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v3 4/5] i2c: davinci: use bus recovery infrastructure
Date: Mon, 06 Apr 2015 16:11:47 +0300
Message-ID: <55228613.2060607@linaro.org>
References: <1417448047-15236-1-git-send-email-grygorii.strashko@ti.com> <1417448047-15236-5-git-send-email-grygorii.strashko@ti.com> <20150318203151.GA12072@katana> <550C67D6.3080909@linaro.org> <20150403201846.GH2016@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150403201846.GH2016@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, "Grygorii.Strashko-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <grygorii.strashko-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>, Santosh Shilimkar <ssantosh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Murali Karicheri <m-karicheri2-l0cyMroinI0@public.gmane.org>, Alexander Sverdlin <alexander.sverdlin-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, =?windows-1252?Q?Uwe_Kleine-K=F6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On 04/03/2015 11:18 PM, Wolfram Sang wrote:
> 
>>> The I2C specs say in 3.1.16 that the recovery procedure should be used
>>> when SDA is stuck low. So, I do wonder if we should apply the recovery
>>> after a timeout. Stuck SDA might be one reason for timeout, but there
>>> may be others...
>>
>> This is ancient code. And regarding your question -
>> Might be it would be reasonable to add call of
>> i2c_davinci_wait_bus_not_busy() at the end of i2c_davinci_xfer()?
>> This way we will wait for Bus Free before performing recovery.
> 
> That might be an improvement, but the generic question still remains:
> Is a timeout a reason for recovery? SDA stuck low is one reason for a
> timeout. I have problems making up my mind here between being pragmatic
> and being in accordance with the specs.

The timeout here means there were no responses from I2C controller within some
reasonable time period (default - 1 sec). Which in turn
means that Bus/HW state is "unknown" and init&recovery seems reasonable here, but
yes - "init&recovery" could be optimized more, but, in my opinion, only
as subsequent patches.

Actually, i2c_generic_recovery() will just exit if SDA is high already.

> 
>> Of course,  i2c_davinci_wait_bus_not_busy() has to be fixed first
>> as proposed by Alexander Sverdlin here:
>>   https://patchwork.ozlabs.org/patch/448994/.
> 
> Okay, good that you said it. So I'll give his patch series priority over
> this one.


Sorry, but this series already mises few merge windows and it has a lot
of revied-by and tested-by, so could we proceed please?

Re-based & re-sent http://www.spinics.net/lists/arm-kernel/msg410810.html

-- 
regards,
-grygorii
