From: Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [V2 1/2] i2c: brcmstb: Add Broadcom settop SoC i2c controller
 driver
Date: Fri, 17 Apr 2015 10:12:10 -0700
Message-ID: <55313EEA.8040103@gmail.com>
References: <1428004866-13543-1-git-send-email-kdasu.kdev@gmail.com>	<CAA7nrtjWUZOBQiTr0YrZFmLOoAttyJ5gMxb+hR7jnz1HC51Buw@mail.gmail.com>	<CAC=U0a3OXKBSUeRnbsXZ2J7snhRzhGAFctvzjwg=o90w59oNHg@mail.gmail.com> <CAA7nrtjyVXkMYTL8AWMMp1peZ0TGMwYtYhRxrTrBH3kyZzi1tw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAA7nrtjyVXkMYTL8AWMMp1peZ0TGMwYtYhRxrTrBH3kyZzi1tw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: rajeev kumar <rajeevkumar.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Kamal Dasu <kdasu.kdev-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Gregory Fong <gregory.0xf0-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On 16/04/15 22:52, rajeev kumar wrote:

>>>> +#define bsc_readl(_dev, reg)                                           \
>>>> +       __bsc_readl(_dev, offsetof(struct bsc_regs, reg))
>>>> +
> 
> use readl/writel

This peripheral is used on chips that can run in either little or
big-endian, and in both cases, this is a board-level strap that dictates
the entire endianess of the system, such that on-chip peripherals should
always be accessed in the host (native) endianess.

readl/writel introduce an implicit endian conversion for kernels
compiled in big-endian, that we do not want here. Depending on the
architecture, there is also an additional barrier that is not needed,
since the underlying bus serving this peripheral (GISB) does not
re-order transactions, and writes are not posted.

A better abstraction however could be something like this:

#ifdef CONFIG_CPU_BIG_ENDIAN
#define __bsc_readl(_dev, reg)	ioread32be(...)
#else
#define __bsc_readl(_dev, reg)	ioread32(...)
#endif

Such that we preserve the host endianess access, but we clearly identify
the differences in running in a big or little endian configuration?
-- 
Florian
