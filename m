From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH v6 1/5] irqchip/aspeed-i2c-ic: binding docs for Aspeed
 I2C Interrupt Controller
Date: Thu, 30 Mar 2017 08:17:15 +1100
Message-ID: <1490822235.3177.192.camel@kernel.crashing.org>
References: <20170328051226.21677-1-brendanhiggins@google.com>
         <20170328051226.21677-2-brendanhiggins@google.com>
         <1490690980.3177.108.camel@kernel.crashing.org>
         <CAFd5g47Pij6TxkmS6akWoAL0FZ2WLh+FWUrr099RiabWn+pneQ@mail.gmail.com>
         <1490789505.3177.184.camel@kernel.crashing.org>
         <CAFd5g460U4c3rMtKphxnu=OADTfD=oe8Z+JPn-H82zpHKJUqfw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAFd5g460U4c3rMtKphxnu=OADTfD=oe8Z+JPn-H82zpHKJUqfw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Brendan Higgins <brendanhiggins@google.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Joel Stanley <joel@jms.id.au>, Vladimir Zapolskiy <vz@mleia.com>, Kachalov Anton <mouse@mayc.ru>, =?ISO-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, OpenBMC Maillist <openbmc@lists.ozlabs.org>
List-Id: linux-i2c@vger.kernel.org

On Wed, 2017-03-29 at 13:51 -0700, Brendan Higgins wrote:
> so maybe instead of setting a hard limit like I did, maybe the best
> thing is to just check and see what the base_clk gets set to and if
> it gets set to zero, we turn on high speed mode. What do you think?

Ah maybe. Did you scope it to see if clock_hi/low do indeed apply in
high speed mode ?

I wonder if that bit does other things.. I would be interesting to
check. Ohterwise why have the bit rather than just have the driver
write 0 to the divisor ?

The doc for the high speed mode bit says "high speed mode (3.4Mbps)"
which is why I, maybe incorrectly, assumed it was a fixed frequency.

Anyway, not a huge deal at this point, but something to look into
at some stage.

Cheers,
Ben.
