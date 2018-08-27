From: Shawn Guo <shawnguo@kernel.org>
Subject: Re: [PATCH v3 3/3] arm: dts: ls1021a: Enable I2C DMA support
Date: Mon, 27 Aug 2018 14:51:11 +0800
Message-ID: <20180827065106.GD3850@dragon>
References: <20180809123207.9732-1-esben.haabendal@gmail.com>
 <20180809123207.9732-4-esben.haabendal@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180809123207.9732-4-esben.haabendal@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Esben Haabendal <esben.haabendal@gmail.com>
Cc: linux-i2c@vger.kernel.org, Esben Haabendal <eha@deif.com>, kernel@pengutronix.de, NXP Linux Team <linux-imx@nxp.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Thu, Aug 09, 2018 at 02:32:07PM +0200, Esben Haabendal wrote:
> From: Esben Haabendal <eha@deif.com>
> 
> Gives substantial performance improvement for transfers larger than 16
> bytes (DMA_THRESHOLD).  Smaller transfers are unaffected.
> 
> Signed-off-by: Esben Haabendal <eha@deif.com>

Applied, thanks.
