From: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH] i2c: designware: Suppress error message if
 platform_get_irq() returns -EPROBE_DEFER
Date: Tue, 03 Mar 2015 21:34:31 +0200
Message-ID: <1425411271.14897.159.camel@linux.intel.com>
References: <1425396456-10633-1-git-send-email-abrodkin@synopsys.com>
	 <54F5E120.3090705@alitech.com> <1425400650.17965.53.camel@synopsys.com>
	 <OF441D1D4D.39476C28-ONC1257DFD.005BE73C-C1257DFD.005C7908@alitech.com>
	 <20150303172145.GA7076@katana> <54F5F38D.5050309@alitech.com>
	 <1425409412.14897.157.camel@linux.intel.com> <20150303191153.GA7862@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150303191153.GA7862@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Christian Ruppert <christian.ruppert-Yycd8EPnGM5BDgjK7y7TUQ@public.gmane.org>, Alexey Brodkin <Alexey.Brodkin-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>, "christian.ruppert-ux6zf3SgZrrQT0dZR+AlfA@public.gmane.org" <christian.ruppert-ux6zf3SgZrrQT0dZR+AlfA@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org" <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, "Vineet.Gupta1-HKixBCOQz3hWk0Htik3J/w@public.gmane.org" <Vineet.Gupta1-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Tue, 2015-03-03 at 20:11 +0100, Wolfram Sang wrote:
> > Yes, I was thinking even about some wrapper on top of platform_get_irq()
> > since it seems there are no messaging done inside platform.c, though
> > devm_* functions usually have it.
> 
> When I had a look a few months ago, the situation with devm_* was messy.
> Some rightfully printed errors, some rightfully didn't, some vice versa,
> some the other way around, and some did something else...
> 
> For driver authors, it is hard to see/remember which devm function does
> it and which doesn't. IMO a good cleanup will get rid of this mess. I
> started sketching something but especially clks and irqs are basically
> everywhere and so it easily grew out of the fun-time project scale,
> sadly.

Yeah, same for me. I've checked the situation with platform_get_irq()
and estimate the amount of drivers about 300.

That's why I discourage to create another one that needs to be fixed in
the future.

-- 
Andy Shevchenko <andriy.shevchenko-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Intel Finland Oy
