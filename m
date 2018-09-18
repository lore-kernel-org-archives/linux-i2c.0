From: Brendan Higgins <brendanhiggins@google.com>
Subject: Re: [PATCH] i2c: aspeed: Acknowledge most interrupts early in
 interrupt handler
Date: Mon, 17 Sep 2018 18:28:32 -0700
Message-ID: <CAFd5g44dZ+SvCBGNztuq2izMb7401izXVoq=fU9=BehrwikVwA@mail.gmail.com>
References: <1536895810-28903-1-git-send-email-linux@roeck-us.net> <CACPK8XchoryZ_RS8f4n=-GoT-Ak+dXuC3cgqLmxK9C=gySEJFQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CACPK8XchoryZ_RS8f4n=-GoT-Ak+dXuC3cgqLmxK9C=gySEJFQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Joel Stanley <joel@jms.id.au>
Cc: linux@roeck-us.net, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Andrew Jeffery <andrew@aj.id.au>, linux-i2c@vger.kernel.org, OpenBMC Maillist <openbmc@lists.ozlabs.org>, linux-aspeed@lists.ozlabs.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
List-Id: linux-i2c@vger.kernel.org

On Mon, Sep 17, 2018 at 6:11 PM Joel Stanley <joel@jms.id.au> wrote:
>
> On Fri, 14 Sep 2018 at 13:00, Guenter Roeck <linux@roeck-us.net> wrote:
> >
> > Commit 3e9efc3299dd ("i2c: aspeed: Handle master/slave combined irq events
> > properly") moved interrupt acknowledgment to the end of the interrupt
> > handler. In part this was done because the AST2500 datasheet says:
> >
> >  I2CD10 Interrupt Status Register
> >    bit 2 Receive Done Interrupt status
> >          S/W needs to clear this status bit to allow next data receiving.
> >
> > Acknowledging Receive Done before receive data was handled resulted in
> > receive errors on high speed I2C busses.
> >
> > However, interrupt acknowledgment was not only moved to the end of the
> > interrupt handler for Receive Done Interrupt status, but for all interrupt
> > status bits. This could result in race conditions if a second interrupt was
> > received during interrupt handling and not handled but still acknowledged
> > at the end of the interrupt handler.
> >
> > Acknowledge only "Receive Done Interrupt status" late in the interrupt
> > handler to solve the problem.
> >
> > Fixes: 3e9efc3299dd ("i2c: aspeed: Handle master/slave combined irq events properly")
> > Cc: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
> > Cc: Joel Stanley <joel@jms.id.au>
> > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>
> Thanks for getting to the bottom of this Guenter. I gave it a spin on
> Romulus (ast2500) and Palmetto (ast2400) without issue.
>
> Tested-by: Joel Stanley <joel@jms.id.au>
>

Nice work! Thanks!

Acked-by: Brendan Higgins <brendanhiggins@google.com>
