From: Brendan Higgins <brendanhiggins@google.com>
Subject: Re: [PATCH v11 3/4] i2c: aspeed: added driver for Aspeed I2C
Date: Tue, 27 Jun 2017 01:28:31 -0700
Message-ID: <CAFd5g45=O2_MgfZEkmbY-=ZZY+izxeWSuhZT+B2e08P=O+WEog@mail.gmail.com>
References: <20170620211516.13095-1-brendanhiggins@google.com>
 <20170620211516.13095-4-brendanhiggins@google.com> <20170623184305.xqqhjgrbdmgk6lsr@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170623184305.xqqhjgrbdmgk6lsr@ninjato>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, gregkh@linuxfoundation.org, davem@davemloft.net, mchehab@kernel.org, Joel Stanley <joel@jms.id.au>, martin.petersen@oracle.com, Benjamin Herrenschmidt <benh@kernel.crashing.org>, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, OpenBMC Maillist <openbmc@lists.ozlabs.org>
List-Id: linux-i2c@vger.kernel.org

On Fri, Jun 23, 2017 at 11:43 AM, Wolfram Sang <wsa@the-dreams.de> wrote:
> On Tue, Jun 20, 2017 at 02:15:15PM -0700, Brendan Higgins wrote:
>> Added initial master support for Aspeed I2C controller. Supports
>> fourteen busses present in AST24XX and AST25XX BMC SoCs by Aspeed.
>>
>> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
>
> Applied to for-next, thanks for all the hard work!

Thanks for the patience!

>
> One question however which can be solved incrementally if needed:
>
>> +     if (command & ASPEED_I2CD_SDA_LINE_STS) {
>> +             /* Bus is idle: no recovery needed. */
>> +             if (command & ASPEED_I2CD_SCL_LINE_STS)
>> +                     goto out;
>> +             dev_dbg(bus->dev, "SCL hung (state %x), attempting recovery\n",
>> +                     command);
>> +
>> +             reinit_completion(&bus->cmd_complete);
>> +             writel(ASPEED_I2CD_M_STOP_CMD, bus->base + ASPEED_I2C_CMD_REG);
>
> If SCL is stuck low, how do you want to send a STOP?
>

Fair point. I should probably drop that in the future and just do a
reset, and even then, doing a
reset is probably just wishful thinking. If a slave is holding down
SCL, we are pretty screwed.
