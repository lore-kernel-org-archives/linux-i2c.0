From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH v2] i2c: aspeed: fix invalid clock parameters for very
 large divisors
Date: Sat, 22 Sep 2018 07:16:58 -0700
Message-ID: <a31b639d4415d6edd4174b3d4b71528ec94ad10a.camel@perches.com>
References: <20180921221025.75003-1-brendanhiggins@google.com>
         <f5943177-6f1b-9344-3821-2aac001ff45d@linux.intel.com>
         <CAFd5g46==5HG2stvuVfOUtsSW37SvLN6cCmOhRSxibrUpxb8aA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAFd5g46==5HG2stvuVfOUtsSW37SvLN6cCmOhRSxibrUpxb8aA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Brendan Higgins <brendanhiggins@google.com>, Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>, OpenBMC Maillist <openbmc@lists.ozlabs.org>, linux-i2c@vger.kernel.org, linux-aspeed@lists.ozlabs.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

On Fri, 2018-09-21 at 15:30 -0700, Brendan Higgins wrote:
> On Fri, Sep 21, 2018 at 3:26 PM Jae Hyun Yoo
[]
> > > +             dev_err(dev,
> > > +                     "clamping clock divider: divider requested, %u, is greater than largest possible divider, %u.",
> > 
> > Please put a newline character at the end of the string.
> 
> I always forget to do that. I wonder if anyone has considered adding a
> warning for this to checkpatch?

Yes, but it's not possible to know when there
a pr_cont that follows so any checkpatch test
would be a false positive generator too.
