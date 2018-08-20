From: Esben Haabendal <esben.haabendal@gmail.com>
Subject: Re: [PATCH v4 3/3] arm: dts: ls1021a: Enable I2C DMA support
Date: Mon, 20 Aug 2018 11:23:45 +0200
Message-ID: <87zhxhgzmm.fsf@gmail.com>
References: <20180816084315.7857-1-esben.haabendal@gmail.com>
        <20180816084315.7857-4-esben.haabendal@gmail.com>
        <20180820091531.komc6ypyybnq22nw@ninjato>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180820091531.komc6ypyybnq22nw@ninjato> (Wolfram Sang's message
        of "Mon, 20 Aug 2018 11:15:31 +0200")
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>, kernel@pengutronix.de, NXP Linux Team <linux-imx@nxp.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Wolfram Sang <wsa@the-dreams.de> writes:

> On Thu, Aug 16, 2018 at 10:43:14AM +0200, Esben Haabendal wrote:
>> From: Esben Haabendal <eha@deif.com>
>> 
>> Gives substantial performance improvement for transfers larger than 16
>> bytes (DMA_THRESHOLD).  Smaller transfers are unaffected.
>> 
>> Signed-off-by: Esben Haabendal <eha@deif.com>
>
> This needs to go via arm-soc. The two other patches will be in v4.19
> with my pull request later this week.

Ok, do I need to send to additional list(s)?
linux-arm-kernel@lists.infradead.org?

/Esben
