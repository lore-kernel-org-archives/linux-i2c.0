From: "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>
Subject: Re: [PATCH] i2c: Hook up runtime PM support
Date: Mon, 15 Feb 2010 20:08:24 +0100
Message-ID: <201002152008.24142.rjw@sisk.pl>
References: <1265373011-12874-1-git-send-email-broonie@opensource.wolfsonmicro.com> <20100215191409.14d87257@hyperion.delvare> <20100215183058.GA24590@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100215183058.GA24590-HF5t3jzXg/6ND3a5+9QAFujbO/Zr0HzV@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Monday 15 February 2010, Mark Brown wrote:
> On Mon, Feb 15, 2010 at 07:14:09PM +0100, Jean Delvare wrote:
> 
> > Applied, thanks. I am a little surprised to see that these functions
> > have nothing i2c-specific, so I am wondering why we have to duplicate
> > them in every bus type... Shouldn't the functions above be part of
> > drivers/base/power/runtime.c and exported so that all bus types that
> > want them can reuse them?

In fact this is the first bus type that doesn't need anything specific in these
routines so fat.

> I tend to agree - in fact I'd been a little surprised the default for
> buses that don't provide anything was to refuse to do runtime PM (though
> I can see the transition issues when a bus does want to go and do its
> own thing).
> 
> My actual plan here was to implement this for a couple of buses and then
> present a patch factoring out the common code.

That's a good approach IMO.

Rafael
