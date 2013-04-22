From: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH] i2c-designware: fix RX FIFO overrun
Date: Mon, 22 Apr 2013 10:19:43 +0300
Message-ID: <20130422071943.GK1283@intel.com>
References: <alpine.DEB.2.02.1304191859570.17829@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.02.1304191859570.17829@localhost>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Josef Ahmad <josef.ahmad-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Stefan Roese <sr-ynQEQJNshbs@public.gmane.org>, Axel Lin <axel.lin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Dirk Brandewie <dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Fri, Apr 19, 2013 at 07:05:30PM +0100, Josef Ahmad wrote:
> >From a969728248c3b439dc97a69e7dac133b5efa34e7 Mon Sep 17 00:00:00 2001
> From: Josef Ahmad <josef.ahmad-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> Date: Fri, 19 Apr 2013 17:28:10 +0100
> Subject: [PATCH] i2c-designware: fix RX FIFO overrun
> 
> i2c_dw_xfer_msg() pushes a number of bytes to transmit/receive
> to/from the bus into the TX FIFO.
> For master-rx transactions, the maximum amount of data that can be
> received is calculated depending solely on TX and RX FIFO load.
> 
> This is racy - TX FIFO may contain master-rx data yet to be
> processed, which will eventually land into the RX FIFO. This
> data is not taken into account and the function may request more
> data than the controller is actually capable of storing.
> 
> This patch ensures the driver takes into account the outstanding
> master-rx data in TX FIFO to prevent RX FIFO overrun.

Can you add something to the changelog to show what the error looks like
(a dump from dmesg for example)?

> Signed-off-by: Josef Ahmad <josef.ahmad-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> ---
>  drivers/i2c/busses/i2c-designware-core.c |   11 ++++++++++-
>  drivers/i2c/busses/i2c-designware-core.h |    2 ++
>  2 files changed, 12 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-designware-core.c b/drivers/i2c/busses/i2c-designware-core.c
> index 94fd818..8dbeef1 100644
> --- a/drivers/i2c/busses/i2c-designware-core.c
> +++ b/drivers/i2c/busses/i2c-designware-core.c
> @@ -426,8 +426,14 @@ i2c_dw_xfer_msg(struct dw_i2c_dev *dev)
>  				cmd |= BIT(9);
> 
>  			if (msgs[dev->msg_write_idx].flags & I2C_M_RD) {
> +
> +				/* avoid rx buffer overrun */
> +				if (rx_limit - dev->rx_outstanding <= 0)
> +					break;
> +
>  				dw_writel(dev, cmd | 0x100, DW_IC_DATA_CMD);
>  				rx_limit--;
> +				dev->rx_outstanding++;

Instead of adding a new variable, is there something preventing a use of
DW_IC_STATUS bits RFNE and TFNF?

>  			} else
>  				dw_writel(dev, cmd | *buf++, DW_IC_DATA_CMD);
>  			tx_limit--; buf_len--;
> @@ -480,8 +486,10 @@ i2c_dw_read(struct dw_i2c_dev *dev)
> 
>  		rx_valid = dw_readl(dev, DW_IC_RXFLR);
> 
> -		for (; len > 0 && rx_valid > 0; len--, rx_valid--)
> +		for (; len > 0 && rx_valid > 0; len--, rx_valid--) {
>  			*buf++ = dw_readl(dev, DW_IC_DATA_CMD);
> +			dev->rx_outstanding--;
> +		}
> 
>  		if (len > 0) {
>  			dev->status |= STATUS_READ_IN_PROGRESS;
> @@ -539,6 +547,7 @@ i2c_dw_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num)
>  	dev->msg_err = 0;
>  	dev->status = STATUS_IDLE;
>  	dev->abort_source = 0;
> +	dev->rx_outstanding = 0;
> 
>  	ret = i2c_dw_wait_bus_not_busy(dev);
>  	if (ret < 0)
