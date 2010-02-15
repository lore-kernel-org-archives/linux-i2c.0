From: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Subject: Re: [PATCH] i2c: Hook up runtime PM support
Date: Mon, 15 Feb 2010 18:30:58 +0000
Message-ID: <20100215183058.GA24590@rakim.wolfsonmicro.main>
References: <1265373011-12874-1-git-send-email-broonie@opensource.wolfsonmicro.com>
 <20100215191409.14d87257@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20100215191409.14d87257-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>, Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Mon, Feb 15, 2010 at 07:14:09PM +0100, Jean Delvare wrote:

> Applied, thanks. I am a little surprised to see that these functions
> have nothing i2c-specific, so I am wondering why we have to duplicate
> them in every bus type... Shouldn't the functions above be part of
> drivers/base/power/runtime.c and exported so that all bus types that
> want them can reuse them?

I tend to agree - in fact I'd been a little surprised the default for
buses that don't provide anything was to refuse to do runtime PM (though
I can see the transition issues when a bus does want to go and do its
own thing).

My actual plan here was to implement this for a couple of buses and then
present a patch factoring out the common code.
