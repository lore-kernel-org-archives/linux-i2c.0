From: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [RFC PATCH] i2c-designware-core: disable adapter before fill
 dev structure
Date: Thu, 13 Jun 2013 11:33:56 +0300
Message-ID: <1371112436.29283.340.camel@smile>
References: <CAHp75VfwSTO7UoEGVpd7qdFVSFNYrBG6aXx1Oj8UAkgbmi=1XQ@mail.gmail.com>
	 <1370597401-22501-1-git-send-email-andriy.shevchenko@linux.intel.com>
	 <20130613081621.GB19061@ab42.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20130613081621.GB19061-7oYq3qWSd+k@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Christian Ruppert <christian.ruppert-ux6zf3SgZrrQT0dZR+AlfA@public.gmane.org>
Cc: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, linux-i2c <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Thu, 2013-06-13 at 10:16 +0200, Christian Ruppert wrote: 
> As promised, I gave this one some over-night stress testing and I can
> confirm what I said previously:
> 
> - The patch does _not_ solve the interrupt loop lockups on its own.

So, it just means my assumptions about what is happening there were
wrong.

> - The patch works well in conjunction with
>   http://patchwork.ozlabs.org/patch/249622/ (which in turn depends on
>   Mika's patch). Under this condition you can assume
>   Tested-By: Christian Ruppert <christian.ruppert-ux6zf3SgZrrQT0dZR+AlfA@public.gmane.org>
> 
> I still think the code is more logical with this patch than without it
> and I am in favour of applying both (if Andy agrees that is).

Since my patch doesn't fix anything, I think we may drop it away.

>  We must keep in mind, however, that http://patchwork.ozlabs.org/patch/249622
> does fix a real problem we can observe on our chip and for our TB10x
> product we do require some form of it for stability reasons.

I feel like a real fix is to add a memory barier to make changes in the
structure consistent. However, I have no clue where.


-- 
Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Intel Finland Oy
