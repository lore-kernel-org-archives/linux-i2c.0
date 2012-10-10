From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] matroxfb: Convert struct i2c_msg initialization to C99
 format
Date: Wed, 10 Oct 2012 11:05:21 +0200
Message-ID: <20121010110521.3981a23f@endymion.delvare>
References: <1349782668-9098-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1349782668-9098-1-git-send-email-shubhrajyoti-l0cyMroinI0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
Cc: linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, FlorianSchandinat-Mmb7MZpHnFY@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Tue, 9 Oct 2012 17:07:48 +0530, Shubhrajyoti D wrote:
> Convert the struct i2c_msg initialization to C99 format. This makes
> maintaining and editing the code simpler. Also helps once other fields
> like transferred are added in future.
> 
> Thanks to Julia Lawall <julia.lawall-L2FTfq7BK8M@public.gmane.org>  for automating the conversion
> 
> Signed-off-by: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
> ---
>  drivers/video/matrox/matroxfb_maven.c |   15 +++++++++++++--
>  1 files changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/video/matrox/matroxfb_maven.c b/drivers/video/matrox/matroxfb_maven.c
> index 217678e..fb5c123 100644
> --- a/drivers/video/matrox/matroxfb_maven.c
> +++ b/drivers/video/matrox/matroxfb_maven.c
> @@ -137,8 +137,19 @@ static int* get_ctrl_ptr(struct maven_data* md, int idx) {
>  
>  static int maven_get_reg(struct i2c_client* c, char reg) {
>  	char dst;
> -	struct i2c_msg msgs[] = {{ c->addr, I2C_M_REV_DIR_ADDR, sizeof(reg), &reg },
> -				 { c->addr, I2C_M_RD | I2C_M_NOSTART, sizeof(dst), &dst }};
> +	struct i2c_msg msgs[] = {{
> +					.addr = c->addr,
> +					.flags = I2C_M_REV_DIR_ADDR,
> +					.len = sizeof(reg),
> +					.buf = &reg
> +				},
> +				{
> +					.addr = c->addr,
> +					.flags = I2C_M_RD | I2C_M_NOSTART,
> +					.len = sizeof(dst),
> +					.buf = &dst
> +				}

I'd prefer clean indentation as you have in the previous patches.

> +	};
>  	s32 err;
>  
>  	err = i2c_transfer(c->adapter, msgs, 2);

Acked-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>

-- 
Jean Delvare
