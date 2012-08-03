From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] i2c: convert struct i2c_msg initialization to C99
 format
Date: Fri, 3 Aug 2012 15:14:12 +0200
Message-ID: <20120803151412.0cb16ed6@endymion.delvare>
References: <1343994924-2341-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1343994924-2341-1-git-send-email-shubhrajyoti-l0cyMroinI0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Shubhrajyoti,

On Fri, 3 Aug 2012 17:25:24 +0530, Shubhrajyoti D wrote:
> Convert the struct i2c_msg initialization to C99 format. This makes
> maintaining and editing the code simpler. Also helps once other fields
> like transferred are added in future.
> 
> Signed-off-by: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
> ---
>  drivers/i2c/i2c-core.c |   13 ++++++++++---
>  1 files changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
> index 2efa56c..33cfdd3 100644
> --- a/drivers/i2c/i2c-core.c
> +++ b/drivers/i2c/i2c-core.c
> @@ -1971,12 +1971,19 @@ static s32 i2c_smbus_xfer_emulated(struct i2c_adapter *adapter, u16 addr,
>  	unsigned char msgbuf0[I2C_SMBUS_BLOCK_MAX+3];
>  	unsigned char msgbuf1[I2C_SMBUS_BLOCK_MAX+2];
>  	int num = read_write == I2C_SMBUS_READ ? 2 : 1;
> -	struct i2c_msg msg[2] = { { addr, flags, 1, msgbuf0 },
> -	                          { addr, flags | I2C_M_RD, 0, msgbuf1 }
> -	                        };
>  	int i;
>  	u8 partial_pec = 0;
>  	int status;
> +	struct i2c_msg msg[2];
> +
> +	msg[0].addr = addr;
> +	msg[0].flags = flags;
> +	msg[0].len = 1;
> +	msg[0].buf = msgbuf0;
> +	msg[1].addr = addr;
> +	msg[1].flags = flags | I2C_M_RD;
> +	msg[1].len = 0;
> +	msg[1].buf = msgbuf1;
>  
>  	msgbuf0[0] = command;
>  	switch (size) {

Good idea but I see no good reason to switch from struct-wide
initialization to per-field initialization. AFAIK per-field
initialization is less efficient and might leave some fields
uninitialized, while I seem to remember struct-wide initialization sets
them to 0.

Can you please resubmit with struct-wide initialization preserved?

Thanks,
-- 
Jean Delvare
