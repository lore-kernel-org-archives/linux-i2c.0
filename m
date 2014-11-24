From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [4/5] i2c: davinci: use bus recovery infrastructure
Date: Mon, 24 Nov 2014 15:26:10 +0200
Message-ID: <547331F2.3000006@ti.com>
References: <1416477788-5544-5-git-send-email-grygorii.strashko@ti.com> <20141121190744.GB4431@pengutronix.de> <546F9382.40102@ti.com> <20141123203634.GG4431@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20141123203634.GG4431@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: =?windows-1252?Q?Uwe_Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, Santosh Shilimkar <ssantosh@kernel.org>, Murali Karicheri <m-karicheri2@ti.com>
List-Id: linux-i2c@vger.kernel.org

Hi Uwe,

On 11/23/2014 10:36 PM, Uwe Kleine-K=F6nig wrote:
> On Fri, Nov 21, 2014 at 09:33:22PM +0200, Grygorii Strashko wrote:
>> On 11/21/2014 09:07 PM, Uwe Kleine-K=F6nig wrote:
>>> On Thu, Nov 20, 2014 at 12:03:07PM +0200, Grygorii Strashko wrote:
>>> Just another general comment about the driver that doesn't influenc=
e the
>>> correctness of this patch: The i2c-davinci driver is quite quick to
>>> reset the bus. I wonder how often this reset triggers. Is the bus i=
n
>>> question less "stable" than others?
>>
>> In comparison to ..? :)
> In comparison to other bus drivers in other SoCs. I know this might b=
e
> hard to answer. I just wonder where the reason for this has to be
> located. Strange hardware? Software bug? Or is this SoC just operatin=
g
> with strange slaves more often than others?

Davinci driver does reset in two cases:
- when I2C transaction isn't completed due to timeout (no irq received)
- when BB is detected
both cases are reasonable, because in 1st case HW state is undefined
in 2d case - Davinci I2C supports only master mode and if BB detected
we need perform some recovery procedure.

Also, this patch doesn't introduce functional changes - it's just code
reworking intended to reuse I2C bus recovery infrastructure

i2c-omap.c - OMAP I2C driver does mostly the same now.
i2c-tegra.c - seems, It will do reset even frequently.
i2c-imx.c - if understand right, it will reinitialize I2C controller=20
before each transfer, because it enables/disables I2C clocks.
=2E..=20

So, what i can say here is just "In comparison to ..?" :)

regards,
-grygorii
