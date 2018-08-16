From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v3 2/3] i2c: imx: Simplify stopped state tracking
Date: Thu, 16 Aug 2018 10:23:48 +0200
Message-ID: <20180816082348.wei7fnbqbzowe6er@pengutronix.de>
References: <20180809123207.9732-1-esben.haabendal@gmail.com>
 <20180809123207.9732-3-esben.haabendal@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180809123207.9732-3-esben.haabendal@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Esben Haabendal <esben.haabendal@gmail.com>
Cc: linux-i2c@vger.kernel.org, Esben Haabendal <eha@deif.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Lucas Stach <l.stach@pengutronix.de>, Fabio Estevam <fabio.estevam@nxp.com>, Wei Jinhua <wei.jinhua1@zte.com.cn>, Phil Reid <preid@electromag.com.au>, Peter Rosin <peda@axentia.se>, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Thu, Aug 09, 2018 at 02:32:06PM +0200, Esben Haabendal wrote:
> From: Esben Haabendal <eha@deif.com>
> 
> Always update the stopped state when busy status have been checked.
> This is identical to what was done before, with the exception of error
> handling.
> Without this change, some errors cause the stopped state to be left in
> incorrect state in i2c_imx_stop(), i2c_imx_dma_read(), i2c_imx_read() and
> i2c_imx_xfer().
> 
> Signed-off-by: Esben Haabendal <eha@deif.com>
Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>


-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
