From: Brendan Higgins <brendanhiggins@google.com>
Subject: Re: [PATCH v11 3/4] i2c: aspeed: added driver for Aspeed I2C
Date: Tue, 27 Jun 2017 01:36:10 -0700
Message-ID: <CAFd5g459JVzKNdY461pma=e_kvW-xO-mAiVA6Rxvq7Dt_kueVA@mail.gmail.com>
References: <20170620211516.13095-1-brendanhiggins@google.com>
 <20170620211516.13095-4-brendanhiggins@google.com> <20170623184305.xqqhjgrbdmgk6lsr@ninjato>
 <CACPK8XepziqsQVC6R_97s24=8o5F-TZCO1+opZxBJW8SNHRHkg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CACPK8XepziqsQVC6R_97s24=8o5F-TZCO1+opZxBJW8SNHRHkg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Joel Stanley <joel@jms.id.au>
Cc: Wolfram Sang <wsa@the-dreams.de>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Greg KH <gregkh@linuxfoundation.org>, "David S . Miller" <davem@davemloft.net>, mchehab@kernel.org, martin.petersen@oracle.com, Benjamin Herrenschmidt <benh@kernel.crashing.org>, linux-i2c@vger.kernel.org, devicetree <devicetree@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, OpenBMC Maillist <openbmc@lists.ozlabs.org>, Rick Altherr <raltherr@google.com>
List-Id: linux-i2c@vger.kernel.org

On Sun, Jun 25, 2017 at 11:18 PM, Joel Stanley <joel@jms.id.au> wrote:
> On Sat, Jun 24, 2017 at 4:13 AM, Wolfram Sang <wsa@the-dreams.de> wrote:
>> On Tue, Jun 20, 2017 at 02:15:15PM -0700, Brendan Higgins wrote:
>>> Added initial master support for Aspeed I2C controller. Supports
>>> fourteen busses present in AST24XX and AST25XX BMC SoCs by Aspeed.
>>>
>>> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
>>
>> Applied to for-next, thanks for all the hard work!
>
> Congratulations Brendan. It's great to see this driver in the tree.
>
> Cheers,
>
> Joel

Thanks! And thank you to everyone who helped! I am not the only person who
put in a lot of hard work.
