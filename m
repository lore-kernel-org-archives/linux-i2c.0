From: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
Subject: Re: [PATCH v2] i2c: move acpi code back into the core
Date: Tue, 30 Sep 2014 12:55:20 +0200
Message-ID: <20140930125520.61b57882@endymion.delvare>
References: <1411594591-5048-1-git-send-email-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1411594591-5048-1-git-send-email-wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Lan Tianyu <tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Wolfram,

Sorry for the late reply, I was on the road for most of the past 2
weeks.

On Wed, 24 Sep 2014 23:36:31 +0200, Wolfram Sang wrote:
> Commit 5d98e61d337c ("I2C/ACPI: Add i2c ACPI operation region support")
> renamed the i2c-core module. This may cause regressions for
> distributions, so put the ACPI code back into the core.
> 
> Reported-by: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
> Signed-off-by: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
> Cc: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> Cc: Lan Tianyu <tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> Cc: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
> ---
> 
> v2: - make all acpi functions static
>     - annotate #endif
>     - remove declarations in i2c.h
>     - add dummy functions to i2c-core.c
>     - make two seperate #ifdef blocks instead of two nested ones
>       (otherwise build errors due to no external decl. anymore)
> 
> Mika, Lan, Jean: please test/review. I am still waiting for some testbot
> results, yet your audit is very wanted.

I see that the patch is already upstream. Nevertheless I reviewed the
integration part of it and it looks OK to me. Thanks for doing that!

The only thing which I find curious is that ACPI_I2C_OPREGION depends
on I2C=y. Is this limitation a leftover from when the code was split to
a separate file? It builds just fine with I2C=m, and I can't see why it
wouldn't work. I have a patch to enable that, I can send it if it is
the right thing to do. But maybe I'm missing something?

Thanks again,
-- 
Jean Delvare
SUSE L3 Support
