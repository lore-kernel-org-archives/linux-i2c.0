From: Boris BREZILLON <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH] i2c: sun6-p2wi: fix call to snprintf
Date: Fri, 13 Jun 2014 12:09:15 +0200
Message-ID: <539ACDCB.7010209@free-electrons.com>
References: <CAGXu5jLi5NXNsbUAn=XndDb2JSTxiVhMWbiMxtDsUOqZZhxf2A@mail.gmail.com> <1402644002-2591-1-git-send-email-boris.brezillon@free-electrons.com> <20140613095714.GP23430@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140613095714.GP23430-l+eeeJia6m9vn6HldHNs0ANdhmdF6hFW@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Cc: Kees Cook <keescook-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Shuge <shuge-0TFLnhJekD6UEPyfVivIlAC/G2K4zDHf@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Fengguang Wu <fengguang.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, kevin-0TFLnhJekD6UEPyfVivIlAC/G2K4zDHf@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


On 13/06/2014 11:57, Russell King - ARM Linux wrote:
> On Fri, Jun 13, 2014 at 09:20:02AM +0200, Boris BREZILLON wrote:
>> -	snprintf(p2wi->adapter.name, sizeof(p2wi->adapter.name), pdev->name);
>> +	snprintf(p2wi->adapter.name, sizeof(p2wi->adapter.name), "%s",
>> +		 pdev->name);
> Isn't this just a complicated way to express:
>
> 	strlcpy(p2wi->adapter.name, pdev->name, sizeof(p2wi->adapter.name));
>
> ?

Yes it is. I'll make use of strlcpy instead.

Thanks,

Boris

-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
