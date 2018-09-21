From: Brendan Higgins <brendanhiggins@google.com>
Subject: Re: [PATCH v2] i2c: aspeed: fix invalid clock parameters for very
 large divisors
Date: Fri, 21 Sep 2018 15:30:42 -0700
Message-ID: <CAFd5g46==5HG2stvuVfOUtsSW37SvLN6cCmOhRSxibrUpxb8aA@mail.gmail.com>
References: <20180921221025.75003-1-brendanhiggins@google.com> <f5943177-6f1b-9344-3821-2aac001ff45d@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <f5943177-6f1b-9344-3821-2aac001ff45d@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>, OpenBMC Maillist <openbmc@lists.ozlabs.org>, linux-i2c@vger.kernel.org, linux-aspeed@lists.ozlabs.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

On Fri, Sep 21, 2018 at 3:26 PM Jae Hyun Yoo
<jae.hyun.yoo@linux.intel.com> wrote:
>
<snip>
>
> > +     if (base_clk_divisor > ASPEED_I2CD_TIME_BASE_DIVISOR_MASK) {
> > +             base_clk_divisor = ASPEED_I2CD_TIME_BASE_DIVISOR_MASK;
> > +             clk_low = clk_high_low_mask;
> > +             clk_high = clk_high_low_mask;
> > +             dev_err(dev,
> > +                     "clamping clock divider: divider requested, %u, is greater than largest possible divider, %u.",
>
> Please put a newline character at the end of the string.

I always forget to do that. I wonder if anyone has considered adding a
warning for this to checkpatch?

>
> Thanks,
> Jae
>
> [....]
