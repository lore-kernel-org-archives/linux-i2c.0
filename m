From: Esben Haabendal <esben.haabendal@gmail.com>
Subject: Re: [PATCH v4 2/3] i2c: imx: Simplify stopped state tracking
Date: Mon, 20 Aug 2018 11:20:44 +0200
Message-ID: <874lfpiec3.fsf@gmail.com>
References: <20180816084315.7857-1-esben.haabendal@gmail.com>
        <20180816084315.7857-3-esben.haabendal@gmail.com>
        <20180820091413.ranx7smh3f3swvvc@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180820091413.ranx7smh3f3swvvc@ninjato> (Wolfram Sang's message
        of "Mon, 20 Aug 2018 11:14:13 +0200")
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>, Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Lucas Stach <l.stach@pengutronix.de>, Philipp Zabel <p.zabel@pengutronix.de>, Linus Walleij <linus.walleij@linaro.org>, Phil Reid <preid@electromag.com.au>, Peter Rosin <peda@axentia.se>, Fabio Estevam <fabio.estevam@nxp.com>, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Wolfram Sang <wsa@the-dreams.de> writes:

> On Thu, Aug 16, 2018 at 10:43:13AM +0200, Esben Haabendal wrote:
>> From: Esben Haabendal <eha@deif.com>
>>=20
>> Always update the stopped state when busy status have been checked.
>> This is identical to what was done before, with the exception of error
>> handling.
>> Without this change, some errors cause the stopped state to be left in
>> incorrect state in i2c_imx_stop(), i2c_imx_dma_read(), i2c_imx_read() and
>> i2c_imx_xfer().
>>=20
>> Signed-off-by: Esben Haabendal <eha@deif.com>
>> Acked-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
>
> Applied to for-next, thanks! I did not add stable because the cover
> latter said minor issue? Not really sure here, though...

I agree, it does not need to go into stable.

/Esben
