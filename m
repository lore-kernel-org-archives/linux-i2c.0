From: radu.rendec@gmail.com
Subject: Re: [PATCH 1/2] i2c: ismt: 16-byte align the DMA buffer address
Date: Tue, 29 Aug 2017 17:37:40 +0100
Message-ID: <1504024660.4416.27.camel@gmail.com>
References: <20170818160128.21228-1-radu.rendec@gmail.com>
         <20170818160128.21228-2-radu.rendec@gmail.com>
         <20170827143755.zpb7l7kuk4hf2pjt@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36469 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751447AbdH2Qho (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Tue, 29 Aug 2017 12:37:44 -0400
Received: by mail-wm0-f67.google.com with SMTP id j72so4282431wmi.3
        for <linux-i2c@vger.kernel.org>; Tue, 29 Aug 2017 09:37:43 -0700 (PDT)
In-Reply-To: <20170827143755.zpb7l7kuk4hf2pjt@ninjato>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, Seth Heasley <seth.heasley@intel.com>, Neil Horman <nhorman@tuxdriver.com>
Cc: linux-i2c@vger.kernel.org

On Sun, 2017-08-27 at 16:37 +0200, Wolfram Sang wrote:
> Please use scripts/get_maintainers.pl as cc-cmd of git-send-email. This
> would have added Seth and Neil (driver maintainers) to CC automatically.
> I have done so now.

My bad; sorry about that and thanks for adding Seth and Neil.

> The IIO subsystems uses ____cacheline_aligned. I have never looked into
> this closely, but it probably is cleaner than working with ALIGN on an
> oversized buffer? Dunno why ____cacheline_aligned has four underscores
> at the beginning, though...

I haven't looked into that either; it seems that ____cacheline_aligned
is just __attribute__((__aligned__(SMP_CACHE_BYTES))) unless already
defined by the architecture (see include/linux/cache.h).

I believe using this on a (whole) structure only makes sense with
statically allocated structures and instructs the compiler to allocate
the structure at an aligned address. My guess is that it has no effect
on dynamically allocated structures (such as struct ismt_priv).

If you were thinking about using ____cacheline_aligned just on the
dma_buffer field, then it would align the field with respect to the
beginning of the structure (i.e. insert the required padding), but the
field would still be misaligned if the structure itself is misaligned.

> @@ -320,7 +320,7 @@ static int ismt_process_desc(const struct
> > ismt_desc *desc,
> >  			     struct ismt_priv *priv, int size,
> >  			     char read_write)
> >  {
> > -	u8 *dma_buffer = priv->dma_buffer;
> > +	u8 *dma_buffer = (u8*)ALIGN((unsigned long)&priv->buffer[0], 16);
> 
> The fixed value here might not work on all (future?) generations?

Good question. In theory this alignment should not be necessary at all.
There is no such requirement in the public datasheet, which is probably
why it was not implemented in the driver in the first place.

This is related to some hardware errata and the problem probably occurs
only with some specific hardware revisions. Hard to say what happens
with future generations. But at least it should not make any difference
to the other (existing) generations.

In any case, it's probably better to use a macro (e.g. #define
ISMT_DMA_ALIGN 16) rather than hardcoding the "16" value.

Radu
