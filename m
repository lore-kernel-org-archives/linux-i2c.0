From: "Grygorii.Strashko-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <grygorii.strashko-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v3 4/5] i2c: davinci: use bus recovery infrastructure
Date: Mon, 06 Apr 2015 19:28:12 +0300
Message-ID: <5522B41C.40107@linaro.org>
References: <1417448047-15236-1-git-send-email-grygorii.strashko@ti.com> <1417448047-15236-5-git-send-email-grygorii.strashko@ti.com> <20150318203151.GA12072@katana> <550C67D6.3080909@linaro.org> <20150403201846.GH2016@katana> <55228613.2060607@linaro.org> <20150406160930.GA937@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150406160930.GA937@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>, Santosh Shilimkar <ssantosh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Murali Karicheri <m-karicheri2-l0cyMroinI0@public.gmane.org>, Alexander Sverdlin <alexander.sverdlin-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, =?windows-1252?Q?Uwe_Kleine-K=F6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.orgAlexander Sverdlin <alexander.sverdlin-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On 04/06/2015 07:09 PM, Wolfram Sang wrote:
>
>>>> Of course,  i2c_davinci_wait_bus_not_busy() has to be fixed first
>>>> as proposed by Alexander Sverdlin here:
>>>>    https://patchwork.ozlabs.org/patch/448994/.
>>>
>>> Okay, good that you said it. So I'll give his patch series priority over
>>> this one.
>>
>>
>> Sorry, but this series already mises few merge windows and it has a lot
>> of revied-by and tested-by, so could we proceed please?
>>
>> Re-based & re-sent http://www.spinics.net/lists/arm-kernel/msg410810.html
>
> ??? Didn't you say above that Alexaders's patch is needed first?
>

Sorry for misunderstanding.

I said that if We'd like to continue and optimize more recovery path
then yes - Alexaders's patch will be needed (patch 2 from his series
[PATCH 2/3] i2c: davinci: Refactor i2c_davinci_wait_bus_not_busy(), 
which, in turn need to be rebased as the first one in his series and 
re-send). And in my opinion all such improvements could be done by 
subsequent patches.

-- 
regards,
-grygorii
