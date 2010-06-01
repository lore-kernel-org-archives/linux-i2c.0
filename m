From: Jean Delvare <khali@linux-fr.org>
Subject: Re: [PATCH 06/21] drivers/i2c/i2c-dev.c: Remove unnecessary kmalloc
 casts
Date: Tue, 1 Jun 2010 12:57:21 +0200
Message-ID: <20100601125721.4e815e76@hyperion.delvare>
References: <cover.1275360951.git.joe@perches.com>
	<ce6e7e3183f0756b14765076e63251e269e2c9f6.1275360951.git.joe@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <ce6e7e3183f0756b14765076e63251e269e2c9f6.1275360951.git.joe@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Joe Perches <joe@perches.com>
Cc: linux-kernel@vger.kernel.org, "Ben Dooks (embedded platforms)" <ben-linux@fluff.org>, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Hi Joe,

On Mon, 31 May 2010 20:23:08 -0700, Joe Perches wrote:
> Signed-off-by: Joe Perches <joe@perches.com>
> ---
>  drivers/i2c/i2c-dev.c |    4 +---
>  1 files changed, 1 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/i2c/i2c-dev.c b/drivers/i2c/i2c-dev.c
> index e0694e4..b3fcb59 100644
> --- a/drivers/i2c/i2c-dev.c
> +++ b/drivers/i2c/i2c-dev.c
> @@ -219,9 +219,7 @@ static noinline int i2cdev_ioctl_rdrw(struct i2c_client *client,
>  	if (rdwr_arg.nmsgs > I2C_RDRW_IOCTL_MAX_MSGS)
>  		return -EINVAL;
>  
> -	rdwr_pa = (struct i2c_msg *)
> -		kmalloc(rdwr_arg.nmsgs * sizeof(struct i2c_msg),
> -		GFP_KERNEL);
> +	rdwr_pa = kmalloc(rdwr_arg.nmsgs * sizeof(struct i2c_msg), GFP_KERNEL);
>  	if (!rdwr_pa)
>  		return -ENOMEM;
>  

Applied, thanks.

-- 
Jean Delvare
