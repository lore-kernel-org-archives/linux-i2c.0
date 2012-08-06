From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH v2] i2c: convert struct i2c_msg initialization to C99
 format
Date: Mon, 6 Aug 2012 16:12:05 +0200
Message-ID: <20120806161205.7ee28000@endymion.delvare>
References: <1344243467-7237-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1344243467-7237-1-git-send-email-shubhrajyoti-l0cyMroinI0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Mon, 6 Aug 2012 14:27:47 +0530, Shubhrajyoti D wrote:
> Convert the struct i2c_msg initialization to C99 format. This makes
> maintaining and editing the code simpler. Also helps once other fields
> like transferred are added in future.
> 
> Signed-off-by: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
> ---
>  drivers/i2c/i2c-core.c |   17 ++++++++++++++---
>  1 files changed, 14 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
> index 2efa56c..c77a1ac 100644
> --- a/drivers/i2c/i2c-core.c
> +++ b/drivers/i2c/i2c-core.c
> @@ -1971,12 +1971,23 @@ static s32 i2c_smbus_xfer_emulated(struct i2c_adapter *adapter, u16 addr,
>  	unsigned char msgbuf0[I2C_SMBUS_BLOCK_MAX+3];
>  	unsigned char msgbuf1[I2C_SMBUS_BLOCK_MAX+2];
>  	int num = read_write == I2C_SMBUS_READ ? 2 : 1;
> -	struct i2c_msg msg[2] = { { addr, flags, 1, msgbuf0 },
> -	                          { addr, flags | I2C_M_RD, 0, msgbuf1 }
> -	                        };
>  	int i;
>  	u8 partial_pec = 0;
>  	int status;
> +	struct i2c_msg msg[2] = {
> +		{
> +			.addr = addr,
> +			.flags = flags,
> +			.len = 1,
> +			.buf = msgbuf0,
> +		 },
> +		{
> +			.addr = addr,
> +			.flags = flags | I2C_M_RD,
> +			.len = 0,
> +			.buf = msgbuf1,
> +		},
> +	};
>  
>  	msgbuf0[0] = command;
>  	switch (size) {

Applied, thanks.

-- 
Jean Delvare
