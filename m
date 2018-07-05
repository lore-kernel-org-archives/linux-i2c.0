From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 2/4] i2c: imx: Fix race condition in dma read
Date: Thu, 5 Jul 2018 08:32:29 +0200
Message-ID: <20180705063229.sr6jplg63ybyzxta@pengutronix.de>
References: <20180523095623.3347-1-esben.haabendal@gmail.com>
 <20180523095623.3347-3-esben.haabendal@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180523095623.3347-3-esben.haabendal@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Esben Haabendal <esben.haabendal@gmail.com>
Cc: linux-i2c@vger.kernel.org, Esben Haabendal <eha@deif.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Lucas Stach <l.stach@pengutronix.de>, Phil Reid <preid@electromag.com.au>, Linus Walleij <linus.walleij@linaro.org>, Clemens Gruber <clemens.gruber@pqgruber.com>, Wei Jinhua <wei.jinhua1@zte.com.cn>, Michail Georgios Etairidis <m.etairidis@beck-ipc.com>, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Wed, May 23, 2018 at 11:56:21AM +0200, Esben Haabendal wrote:
> From: Esben Haabendal <eha@deif.com>
> 
> This fixes a race condition, where the DMAEN bit ends up being set after
> I2C slave has transmitted a byte following the dummy read.  When that
> happens, an interrupt is generated instead, and no DMA request is generated
> to kickstart the DMA read, and a timeout happens after DMA_TIMEOUT (1 sec).
> 
> Fixed by setting the DMAEN bit before the dummy read.

Does this fix the problem or just narrow the race window?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
