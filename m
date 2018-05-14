From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 12/21] i2c: imx: make use of i2c_8bit_addr_from_msg
Date: Mon, 14 May 2018 20:32:19 +0200
Message-ID: <20180514183219.oqjaopmicx4ngmxw@pengutronix.de>
References: <20180514145330.4857-1-peda@axentia.se>
 <20180514145330.4857-13-peda@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180514145330.4857-13-peda@axentia.se>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Rosin <peda@axentia.se>
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>
List-Id: linux-i2c@vger.kernel.org

On Mon, May 14, 2018 at 04:53:21PM +0200, Peter Rosin wrote:
> Because it looks neater.
> i2c_imx_dma_write and i2c_imx_write are always called with a
> write in msgs->flags, and i2c_imx_read with a read.
> 
> Signed-off-by: Peter Rosin <peda@axentia.se>
Reviewed-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
