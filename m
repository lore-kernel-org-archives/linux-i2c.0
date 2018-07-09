From: Esben Haabendal <esben.haabendal@gmail.com>
Subject: Re: [PATCH 1/4] i2c: imx: Fix reinit_completion() use
Date: Mon, 09 Jul 2018 11:20:16 +0200
Message-ID: <87y3ekahpr.fsf@gmail.com>
References: <20180523095623.3347-1-esben.haabendal@gmail.com>
        <20180523095623.3347-2-esben.haabendal@gmail.com>
        <20180704070342.pgnjjffk34nkloob@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180704070342.pgnjjffk34nkloob@pengutronix.de> ("Uwe
        =?utf-8?Q?Kleine-K=C3=B6nig=22's?= message of "Wed, 4 Jul 2018 09:03:42
 +0200")
Sender: linux-kernel-owner@vger.kernel.org
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: linux-i2c@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>, Phil Reid <preid@electromag.com.au>, Philipp Zabel <p.zabel@pengutronix.de>, Lucas Stach <l.stach@pengutronix.de>, Clemens Gruber <clemens.gruber@pqgruber.com>, Michail Georgios Etairidis <m.etairidis@beck-ipc.com>, linux-kernel@vger.kernel.org, Yuan Yao <yao.yuan@freescale.com>, linux-imx@nxp.com
List-Id: linux-i2c@vger.kernel.org

Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de> writes:

> Cc +=3D Yuan Yao who authored DMA support and the NXP team.
>
> On Wed, May 23, 2018 at 11:56:20AM +0200, Esben Haabendal wrote:
>> From: Esben Haabendal <eha@deif.com>
>>=20
>> Make sure to call reinit_completion() before dma is started to avoid race
>> condition where reinit_compleition() is called after complete() and befo=
re
>
> s/compleition/completion/

Will fix in v2.

>
>> wait_for_completion_timeout().
>
> Is this a theoretical problem, or did it trigger on your side?

I thought I did trigger it, but haven't been able to reproduce.
So it might or might not be theoretical based on my experiences, but it
does look like something that can (and thus should) trigger sometimes.

/Esben
