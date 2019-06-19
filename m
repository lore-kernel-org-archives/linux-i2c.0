From: Brendan Higgins <brendanhiggins@google.com>
Subject: Re: [PATCH 1/2] i2c: aspeed: allow to customize base clock divisor
Date: Wed, 19 Jun 2019 14:25:29 -0700
Message-ID: <CAFd5g45TMtXcuqONdkpN_K+c0O+wUw8wkGzcQfV+sO8p5Krc9w@mail.gmail.com>
References: <20190619205009.4176588-1-taoren@fb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190619205009.4176588-1-taoren@fb.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tao Ren <taoren@fb.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-i2c@vger.kernel.org, OpenBMC Maillist <openbmc@lists.ozlabs.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, linux-aspeed@lists.ozlabs.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, devicetree <devicetree@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

On Wed, Jun 19, 2019 at 2:00 PM Tao Ren <taoren@fb.com> wrote:
>
> Some intermittent I2C transaction failures are observed on Facebook CMM and
> Minipack (ast2500) BMC platforms, because slave devices (such as CPLD, BIC
> and etc.) NACK the address byte sometimes. The issue can be resolved by
> increasing base clock divisor which affects ASPEED I2C Controller's base
> clock and other AC timing parameters.
>
> This patch allows to customize ASPEED I2C Controller's base clock divisor
> in device tree.

First off, are you sure you actually need this?

You should be able to achieve an effectively equivalent result by just
lowering the `bus-frequency` property specified in the DT. The
`bus-frequency` property ultimately determines all the register
values, and you should be able to set it to whatever you want by
refering to the Aspeed documentation.

Nevertheless, the code that determines the correct dividers from the
frequency is based on the tables in the Aspeed documentation. I don't
think the equation makes sense when the base_clk_divisor is fixed; I
mean it will probably just set the other divisor to max or min
depending on the values chosen. I think if someone really wants to
program this parameter manually, they probably want to set the other
parameters manually too.

[snip]
