From: Brendan Higgins <brendanhiggins@google.com>
Subject: Re: [PATCH v6 1/5] irqchip/aspeed-i2c-ic: binding docs for Aspeed I2C
 Interrupt Controller
Date: Wed, 29 Mar 2017 13:51:57 -0700
Message-ID: <CAFd5g460U4c3rMtKphxnu=OADTfD=oe8Z+JPn-H82zpHKJUqfw@mail.gmail.com>
References: <20170328051226.21677-1-brendanhiggins@google.com>
 <20170328051226.21677-2-brendanhiggins@google.com> <1490690980.3177.108.camel@kernel.crashing.org>
 <CAFd5g47Pij6TxkmS6akWoAL0FZ2WLh+FWUrr099RiabWn+pneQ@mail.gmail.com> <1490789505.3177.184.camel@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1490789505.3177.184.camel@kernel.crashing.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Wolfram Sang <wsa@the-dreams.de>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Joel Stanley <joel@jms.id.au>, Vladimir Zapolskiy <vz@mleia.com>, Kachalov Anton <mouse@mayc.ru>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, OpenBMC Maillist <openbmc@lists.ozlabs.org>
List-Id: linux-i2c@vger.kernel.org

> Regarding the other comment about the "fast mode", my main worry here
> is that somebody might come up with a 2Mhz capable device, we'll hit
> your 1Mhz test, enable fast mode, and shoot it with 3.4Mhz which it
> might not be happy at all about...
>
> I think the cut-off for switching to the "fast" mode should basically
> be the fast speed mode frequency (which isn't clear from the spec but
> seems to be 3.4Mhz). Otherwise people will end up with higher speeds
> than what they asked for and that's bad.

Ah, but see the documentation only says that high speed mode sets the
Base Clock divisor to zero; is does not say anything about tCKHigh or
tCKLow (clk_high and clk_low in my code respectively), which are the
only parameters which are manipulated for speeds greater than or equal
to 1.5MHz since:

# I forgot the "APB_freq /" part in the comment on my
aspeed_i2c_get_clk_reg_val(...)
# My function still does the computation correctly, I just forgot this
in the comment.
SCL_freq = APB_freq / (1 << base_clk) * (clk_high + 1 + clk_low + 1)

so if base_clk = 0, clk_high = 15, clk_low = 15, APB_freq = 50MHz

SCL_freq = APB_freq / (1 << base_clk) * (clk_high + 1 + clk_low + 1)
                = 50000000 / (1 << 0) * (15 + 1 + 15 + 1)
                = 50000000 / 32
                = 1562500Hz
                = ~1.5MHz

so maybe instead of setting a hard limit like I did, maybe the best
thing is to just check and see what the base_clk gets set to and if it
gets set to zero, we turn on high speed mode. What do you think?

Cheers
