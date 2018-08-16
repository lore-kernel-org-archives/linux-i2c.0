From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v4 3/3] arm: dts: ls1021a: Enable I2C DMA support
Date: Thu, 16 Aug 2018 17:50:42 +0200
Message-ID: <20180816155042.2pzipvcuqmtgics5@pengutronix.de>
References: <20180816084315.7857-1-esben.haabendal@gmail.com>
 <20180816084315.7857-4-esben.haabendal@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180816084315.7857-4-esben.haabendal@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Esben Haabendal <esben.haabendal@gmail.com>
Cc: linux-i2c@vger.kernel.org, Esben Haabendal <eha@deif.com>, Shawn Guo <shawnguo@kernel.org>, kernel@pengutronix.de, NXP Linux Team <linux-imx@nxp.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Thu, Aug 16, 2018 at 10:43:14AM +0200, Esben Haabendal wrote:
> From: Esben Haabendal <eha@deif.com>
> 
> Gives substantial performance improvement for transfers larger than 16
> bytes (DMA_THRESHOLD).  Smaller transfers are unaffected.
> 
> Signed-off-by: Esben Haabendal <eha@deif.com>

Looks reasonable to me.

Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
