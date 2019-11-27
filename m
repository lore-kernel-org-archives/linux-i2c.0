From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] i2c: imx: Defer probing if EDMA not available
Date: Wed, 27 Nov 2019 08:27:23 +0100
Message-ID: <20191127072723.7twwbjafqdd22v6m@pengutronix.de>
References: <20191127071136.5240-1-peng.ma@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20191127071136.5240-1-peng.ma@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peng Ma <peng.ma@nxp.com>
Cc: "linux@rempel-privat.de" <linux@rempel-privat.de>, "kernel@pengutronix.de" <kernel@pengutronix.de>, "shawnguo@kernel.org" <shawnguo@kernel.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, dl-linux-imx <linux-imx@nxp.com>, "festevam@gmail.com" <festevam@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

Hello, 

On Wed, Nov 27, 2019 at 07:12:09AM +0000, Peng Ma wrote:
> EDMA may be not available or defered due to dependencies on
> other modules, If these scenarios is encountered, we should
> defer probing.

I'd write:

	i2c: imx: Defer probing if requesting DMA yields EPROBE_DEFER

	DMA might not be available yet when the i2c device probes.
	Properly handle EPROBE_DEFER on dma channel allocation by
	passing on this error.

It would be nice to point out where/how this failed for you.

Other than that this looks reasonable.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
