From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH V2] i2c: designware: fix wrong tx/rx fifo for ACPI
Date: Wed, 07 Dec 2016 12:15:11 +0200
Message-ID: <1481105711.21899.88.camel@linux.intel.com>
References: <1481011073-29143-1-git-send-email-tnhuynh@apm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:33307 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752425AbcLGKPP (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Wed, 7 Dec 2016 05:15:15 -0500
In-Reply-To: <1481011073-29143-1-git-send-email-tnhuynh@apm.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Tin Huynh <tnhuynh@apm.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Loc Ho <lho@apm.com>, Thang Nguyen <tqnguyen@apm.com>, Phong Vo <pvo@apm.com>, patches@apm.com

On Tue, 2016-12-06 at 14:57 +0700, Tin Huynh wrote:
> ACPI always sets txfifo and rxfifo to 32. This configuration will
> cause problem if the IP core supports a fifo size of less than 32.
> The driver should read the fifo size from the IP and select the 
> smaller one of the two.
> 
> Signed-off-by: Tin Huynh <tnhuynh@apm.com>
> 

The idea looks good, but see my comment below.

> >dev);
> +	u32 param1, tx_fifo_depth, rx_fifo_depth;
>  	struct dw_i2c_dev *dev;
>  	struct i2c_adapter *adap;
>  	struct resource *mem;
> @@ -246,12 +247,18 @@ static int dw_i2c_plat_probe(struct
> platform_device *pdev)
>  				1000000);
>  	}
>  
> +	param1 = i2c_dw_read_comp_param(dev);
> +	tx_fifo_depth = ((param1 >> 16) & 0xff) + 1;
> +	rx_fifo_depth = ((param1 >> 8)  & 0xff) + 1;
>  	if (!dev->tx_fifo_depth) {
> -		u32 param1 = i2c_dw_read_comp_param(dev);
> -
> -		dev->tx_fifo_depth = ((param1 >> 16) & 0xff) + 1;
> -		dev->rx_fifo_depth = ((param1 >> 8)  & 0xff) + 1;
> +		dev->tx_fifo_depth = tx_fifo_depth;
> +		dev->rx_fifo_depth = rx_fifo_depth;
>  		dev->adapter.nr = pdev->id;
> +	} else if (tx_fifo_depth) {
> +		dev->tx_fifo_depth = min_t(u32, dev->tx_fifo_depth,
> +							tx_fifo_depth
> );
> +		dev->rx_fifo_depth = min_t(u32, dev->rx_fifo_depth,
> +							rx_fifo_dept

Can we move this to a separate function like

static void dw_i2c_set_fifo_size(... *dev, ... id)
{
	u32 param, tx_fifo_depth, rx_fifo_depth;

	param = i2c_dw_read_comp_param(dev);
	tx_fifo_depth = ((param >> 16) & 0xff) + 1;
	rx_fifo_depth = ((param >> 8)  & 0xff) + 1;

 	if (!dev->tx_fifo_depth) {
		dev->tx_fifo_depth = tx_fifo_depth;
		dev->rx_fifo_depth = rx_fifo_depth;
 		dev->adapter.nr = id;
	}

	dev->tx_fifo_depth = min_t(u32, dev->tx_fifo_depth,
tx_fifo_depth);
	dev->rx_fifo_depth = min_t(u32, dev->rx_fifo_depth,
rx_fifo_depth);
}

?

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
