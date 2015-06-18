From: Alexander Sverdlin <alexander.sverdlin-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] driver/i2c/mux: Add register based mux i2c-mux-reg
Date: Thu, 18 Jun 2015 11:04:27 +0200
Message-ID: <5582899B.9030307@nokia.com>
References: <1434475692-4611-1-git-send-email-yorksun@freescale.com>
 <1434531244.2069.111.camel@x220> <55818BAB.5090605@nokia.com>
 <1434556990.2400.16.camel@x220> <558275F1.5020100@nokia.com>
 <1434614901.2385.27.camel@x220>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1434614901.2385.27.camel@x220>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: ext Paul Bolle <pebolle-IWqWACnzNjzz+pZb47iToQ@public.gmane.org>
Cc: York Sun <yorksun-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Peter Korsgaard <peter.korsgaard-ob4gmnvZ1/cAvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi!

On 18/06/15 10:08, ext Paul Bolle wrote:
>>>> You do not see the platform_device, because there are no users yet, put
>>>>> > >> > this MODULE_ALIAS() is perfectly fine, it will allow automatic module loading
>>>>> > >> > in non-DT case.
>>> > > Do you mean that it will allow automatic module loading once the patch
>>> > > that adds a struct platform_device with a "i2c-mux-reg" name lands?
>> > 
>> > Any platform code which will register the platform_device will trigger uevent and
>> > udevd will be able to find the module with this macro. This is a legacy alternative
>> > to device-tree approach.
> That means I've correctly figured out the purpose of this
> MODULE_ALIAS("platform:" stuff. Because it might actually be documented
> somewhere but I managed to not stumble on that documentation.
> 
> With that out of the way: am I right in thinking there's currently no
> platform code that triggers that uevent for
> "MODALIAS=platform:i2c-mux-reg"? Because if there's no struct
> platform_device taking care of that I think this MODULE_ALIAS() should
> not be added, not yet.

Maybe (and hopefully) there will never be a legacy user of this driver. But this macro
is perfectly fine, adds no overhead (but modinfo) and make the module "complete" in a
sense that it supports both types of binding. There is a legacy probe function in it,
all the support for legacy binding with platform_data in it and this modalias is simply
the last part of it.

-- 
Best regards,
Alexander Sverdlin.
