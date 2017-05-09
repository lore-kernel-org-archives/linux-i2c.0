From: Scott Wood <oss@buserror.net>
Subject: Re: i2c-mpc: Correct I2C reset procedure
Date: Tue, 9 May 2017 15:54:47 -0500
Message-ID: <20170509205447.ww7436pixxl2sxt6@home.buserror.net>
References: <20170509120351.28273-1-joakim.tjernlund@infinera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from host.buserror.net ([209.198.135.123]:56839 "EHLO
        host.buserror.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750987AbdEIUy4 (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Tue, 9 May 2017 16:54:56 -0400
Content-Disposition: inline
In-Reply-To: <20170509120351.28273-1-joakim.tjernlund@infinera.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Joakim Tjernlund <Joakim.Tjernlund@infinera.com>
Cc: linux-i2c@vger.kernel.org

On Tue, May 09, 2017 at 02:03:51PM +0200, Joakim Tjernlund wrote:
> Current I2C reset procedure is broken in two ways:
> 1) It only generate 1 START instead of 9 STARTs and STOP.
> 2) It leaves the bus Busy so every I2C xfer after the first
>    fixup calls the reset routine again, for every xfer there after.
> 
> This fixes both errors. Add an iobarrier_rw() when writing the
> I2C control register as well to make sure the register reaches the
> controller in time.
> 
> Signed-off-by: Joakim Tjernlund <joakim.tjernlund@infinera.com>
> ---
> 
>  Not sure where to sent this as there is no maintainer so adding
>  Scott Wood as well.
> 
>  drivers/i2c/busses/i2c-mpc.c | 24 ++++++++++++++++--------
>  1 file changed, 16 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-mpc.c b/drivers/i2c/busses/i2c-mpc.c
> index 8393140..09b826d 100644
> --- a/drivers/i2c/busses/i2c-mpc.c
> +++ b/drivers/i2c/busses/i2c-mpc.c
> @@ -86,6 +86,7 @@ struct mpc_i2c_data {
>  static inline void writeccr(struct mpc_i2c *i2c, u32 x)
>  {
>  	writeb(x, i2c->base + MPC_I2C_CR);
> +	iobarrier_rw();
>  }

Why are the barriers in the I/O accessors insufficient?

-Scott
