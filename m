From: Kevin Wells <kevin.wells-3arQi8VN3Tc@public.gmane.org>
Subject: RE: [PATCH] i2c-pnx: fix setting start/stop condition
Date: Mon, 1 Mar 2010 19:43:24 +0100
Message-ID: <083DF309106F364B939360100EC290F805CCF9294A@eu1rdcrdc1wx030.exi.nxp.com>
References: <1267446264-8446-1-git-send-email-l.fu@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1267446264-8446-1-git-send-email-l.fu-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Content-Language: en-US
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Luotao Fu <l.fu-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Vitaly Wool <vitalywool-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Julia Lawall <julia-dAYI7NvHqcQ@public.gmane.org>, Russell King <rmk+kernel-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Luotao,

> 
> The start/stop condtions are set in different places repetedly in the i2c-
> pnx
> driver.  Beside in i2c_pnx_start and i2c_pnx_stop the start/stop bit are
> also
> set during the transfer of a i2c message in the master_xmit/rcv calls.
> This is
> wrong since we can't set the start/stop condition during the transaction
> of a
> single message any way. As a matter of fact, the driver will sometimes set
> both
> the start and the stop bits at one time. This can be easily reproduced by
> sending a simple read request like e.g
> struct i2c_msg msgs[] = {
> { addr, 0, 1, buf },
> { addr, I2C_M_RD, offset, buf }
> };
> While processing the first message the i2c_pnx_master_xmit will set both
> the
> start_bit and the stop_bit, which will eventually confuse the slave.
> 
> Fixed by remove setting start/stop condition from the transmit routines.
> 
> Signed-off-by: Luotao Fu <l.fu-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> ---
>  drivers/i2c/busses/i2c-pnx.c |   11 -----------
>  1 files changed, 0 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-pnx.c b/drivers/i2c/busses/i2c-pnx.c
> index 5d1c260..92c0e46 100644
> --- a/drivers/i2c/busses/i2c-pnx.c
> +++ b/drivers/i2c/busses/i2c-pnx.c
> @@ -175,12 +175,6 @@ static int i2c_pnx_master_xmit(struct i2c_adapter
> *adap)
>  		/* We still have something to talk about... */
>  		val = *alg_data->mif.buf++;
> 
> -		if (alg_data->mif.len == 1) {
> -			val |= stop_bit;
> -			if (!alg_data->last)
> -				val |= start_bit;

Removing the start bit assertion here should be ok. The initial start
condition is setup as part of the start of the transfer when the addr
is sent out. The stop bit needs to stay or the I2C transfer will not
correctly terminate on the last byte out and you will end up with a
bus busy failure (clock low, data high) on the next transfer.

The stop_bit is used to indicate the end of the transfer for the I2C
controller. If it isn't used, the clock will stay low at the end
of the transfer after ACK (thinking more data still needs to be
transferred). If stop is enabled, an extra 1/2 clock is used to
reset the clock state back to high and the cycle is terminated
(dat and clk both high).

> -		}
> -
>  		alg_data->mif.len--;
>  		iowrite32(val, I2C_REG_TX(alg_data));
> 
> @@ -252,11 +246,6 @@ static int i2c_pnx_master_rcv(struct i2c_adapter
> *adap)
>  			"Rx-fifo...\n", __func__);
> 
>  		if (alg_data->mif.len == 1) {
> -			/* Last byte, do not acknowledge next rcv. */
> -			val |= stop_bit;

Likewise to TX, the stop bit needs to stay or the I2C transfer will
not correctly terminate on the last byte in.

 -			if (!alg_data->last)
> -				val |= start_bit;
> -
>  			/*
>  			 * Enable interrupt RFDAIE (data in Rx fifo),
>  			 * and disable DRMIE (need data for Tx)
> --
> 1.7.0

thanks,
Kevin
