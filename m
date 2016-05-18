From: Rob Herring <robh@kernel.org>
Subject: Re: [RFC v2 7/7] iio: inv_mpu6050: Expose channels from slave sensors
Date: Wed, 18 May 2016 18:49:37 -0500
Message-ID: <20160518234937.GA19288@rob-hp-laptop>
References: <cover.1463582011.git.leonard.crestez@intel.com>
 <fcfd42dc5de104d7535b4181171d9f931d820597.1463582011.git.leonard.crestez@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:46861 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751050AbcERXtn (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Wed, 18 May 2016 19:49:43 -0400
Content-Disposition: inline
In-Reply-To: <fcfd42dc5de104d7535b4181171d9f931d820597.1463582011.git.leonard.crestez@intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Crestez Dan Leonard <leonard.crestez@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Daniel Baluta <daniel.baluta@intel.com>, Ge Gao <ggao@invensense.com>, Peter Rosin <peda@axentia.se>, linux-i2c@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>, devicetree@vger.kernel.org, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>

On Wed, May 18, 2016 at 06:00:54PM +0300, Crestez Dan Leonard wrote:
> This works by copying the iio_chan_specs from the slave device and
> republishing them as if they belonged to the MPU itself. All
> read/write_raw operations are forwarded to the other driver.
> 
> The original device is still registered with linux as a normal driver
> and works normally and you can poke at it to configure stuff like sample
> rates and scaling factors.
> 
> Buffer values are read from the MPU fifo, allowing a much higher
> sampling rate.
> 
> Signed-off-by: Crestez Dan Leonard <leonard.crestez@intel.com>
> ---
>  .../devicetree/bindings/iio/imu/inv_mpu6050.txt    |  47 ++-

Please put all the binding changes in 1 separate patch. The h/w is not 
evolving...

Then I would have had the full picture when replying the to first 
change.

Rob
