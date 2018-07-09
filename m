From: Esben Haabendal <esben.haabendal@gmail.com>
Subject: Re: [PATCH 2/4] i2c: imx: Fix race condition in dma read
Date: Mon, 09 Jul 2018 11:22:31 +0200
Message-ID: <87tvp8ahm0.fsf@gmail.com>
References: <20180523095623.3347-1-esben.haabendal@gmail.com>
        <20180523095623.3347-3-esben.haabendal@gmail.com>
        <20180705063229.sr6jplg63ybyzxta@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180705063229.sr6jplg63ybyzxta@pengutronix.de> ("Uwe
        =?utf-8?Q?Kleine-K=C3=B6nig=22's?= message of "Thu, 5 Jul 2018 08:32:29
 +0200")
Sender: linux-kernel-owner@vger.kernel.org
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: linux-i2c@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>, Lucas Stach <l.stach@pengutronix.de>, Phil Reid <preid@electromag.com.au>, Linus Walleij <linus.walleij@linaro.org>, Clemens Gruber <clemens.gruber@pqgruber.com>, Wei Jinhua <wei.jinhua1@zte.com.cn>, Michail Georgios Etairidis <m.etairidis@beck-ipc.com>, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de> writes:

> On Wed, May 23, 2018 at 11:56:21AM +0200, Esben Haabendal wrote:
>> From: Esben Haabendal <eha@deif.com>
>>=20
>> This fixes a race condition, where the DMAEN bit ends up being set after
>> I2C slave has transmitted a byte following the dummy read.  When that
>> happens, an interrupt is generated instead, and no DMA request is genera=
ted
>> to kickstart the DMA read, and a timeout happens after DMA_TIMEOUT (1 se=
c).
>>=20
>> Fixed by setting the DMAEN bit before the dummy read.
>
> Does this fix the problem or just narrow the race window?

It should fix the problem.

/Esben
