From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH v8 4/5] i2c: aspeed: added driver for Aspeed I2C
Date: Fri, 02 Jun 2017 22:09:46 +1000
Message-ID: <1496405386.2842.8.camel@kernel.crashing.org>
References: <20170525064925.16867-1-brendanhiggins@google.com>
         <20170525064925.16867-5-brendanhiggins@google.com>
         <1496197001.3354.19.camel@kernel.crashing.org>
         <CAFd5g45en_S0NYgufoET_Lwgu3Rs=7RafsFJZeCUiYCWyxogag@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAFd5g45en_S0NYgufoET_Lwgu3Rs=7RafsFJZeCUiYCWyxogag@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Brendan Higgins <brendanhiggins@google.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Joel Stanley <joel@jms.id.au>, Vladimir Zapolskiy <vz@mleia.com>, Kachalov Anton <mouse@mayc.ru>, =?ISO-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, OpenBMC Maillist <openbmc@lists.ozlabs.org>
List-Id: linux-i2c@vger.kernel.org

On Fri, 2017-06-02 at 02:29 -0700, Brendan Higgins wrote:
> > That way you avoid the above lock which is racy, slave activity could
> > get in there and trigger an error interrupt clobbering cmd_err for
> > example no ? Or am I missing something...
> 
> The slave handler does not touch these fields, so that should be fine.
> The only way I can think
> that we could get in this state is if we had some sort of error
> interrupt fire after we handled a
> STOP or previous error; this should not happen, but I think it is
> better to be safe than sorry.
> Nevertheless, I do not think it is necessary to do more than what I
> have already done because
> it would mean the bus is in a pretty bad state anyway. Maybe I should
> just drop the locks here.
> 
> If you disagree, could you elaborate on what you meant by putting
> cmd_err in a separate field?
> Did you just mean having one for xfer and one for everything else (like resets)?

None of that is a big deal and definitely not a blocker for merging,
you can always "improve" things with a latter patch.

I was thinking that the act of "completing" a request could cleaner if
entirely done from the interrupt code, thus clearing bus->msgs and
setting a "final" status code to be returned to the caller.

Now that could be "cmd_err", it's just that today, that is written to
under various circumstances that may or may not related to a command
being in progress and this I worry that with the lock dropping, we
might "lose" the value that actually pertain to the command itself (and
possibly caused it to fail).

This is all quite academic however, as you said, if that happens we are
already probably in a pretty bad shape.

I suspect the only errors that would happen in "normal" circumstances
would be loss of arbitration and nacks, which are I think, already
properly handled, at least from my reading of the code.

Cheers,
Ben.

> > > +     /* If nothing went wrong, return number of messages transferred. */
> > > +     if (ret >= 0)
> > > +             return bus->msgs_index + 1;
> > > +     else
> > > +             return ret;
> > > +}
> > > +
> 
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
