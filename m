From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v2 1/2] i2c: imx: fix dma_request_chan error handling
Date: Wed, 16 Jan 2019 17:47:38 +0100
Message-ID: <20190116164738.ax5mmj2hqse3sqck@pengutronix.de>
References: <20190116112855.13824-1-laurentiu.tudor@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190116112855.13824-1-laurentiu.tudor@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Laurentiu Tudor <laurentiu.tudor@nxp.com>
Cc: linux-i2c@vger.kernel.org, linux-imx@nxp.com, shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de, wsa@the-dreams.de, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, fabio.estevam@nxp.com, leoyang.li@nxp.com
List-Id: linux-i2c@vger.kernel.org

Hello,

On Wed, Jan 16, 2019 at 01:28:54PM +0200, Laurentiu Tudor wrote:
> Use the correct error pointer when extracting the error code.
> 
> Fixes: ea1e5f176e97 ("i2c: imx: notify about real errors on dma i2c_imx_dma_request")
> Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
Reviewed-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Thanks
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
