From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] i2c-dev.c: remove unnecessary casts
Date: Wed, 10 Mar 2010 08:56:21 +0100
Message-ID: <20100310085621.3a9a4407@hyperion.delvare>
References: <0D753D10438DA54287A00B027084269763682CE02B@AUSP01VMBX24.collaborationhost.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <0D753D10438DA54287A00B027084269763682CE02B-gaq956PjLg32KbjnnMDalRurcAul1UnsRrxOEX5GOmysTnJN9+BGXg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: H Hartley Sweeten <hartleys-3FF4nKcrg1dE2c76skzGb0EOCMrvLtNR@public.gmane.org>
Cc: "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Tue, 9 Mar 2010 17:45:57 -0600, H Hartley Sweeten wrote:
> The private_data member of struct file is a void *, there is no need
> to cast it.
> 
> Signed-off-by: H Hartley Sweeten <hsweeten-3FF4nKcrg1dE2c76skzGb0EOCMrvLtNR@public.gmane.org>
> Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
> Cc: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
> 
> ---
> 
> diff --git a/drivers/i2c/i2c-dev.c b/drivers/i2c/i2c-dev.c
> index f4110aa..c507204 100644
> --- a/drivers/i2c/i2c-dev.c
> +++ b/drivers/i2c/i2c-dev.c
> @@ -138,7 +138,7 @@ static ssize_t i2cdev_read (struct file *file, char __user *buf, size_t count,
>  	char *tmp;
>  	int ret;
>  
> -	struct i2c_client *client = (struct i2c_client *)file->private_data;
> +	struct i2c_client *client = file->private_data;
>  
>  	if (count > 8192)
>  		count = 8192;
> @@ -162,7 +162,7 @@ static ssize_t i2cdev_write (struct file *file, const char __user *buf, size_t c
>  {
>  	int ret;
>  	char *tmp;
> -	struct i2c_client *client = (struct i2c_client *)file->private_data;
> +	struct i2c_client *client = file->private_data;
>  
>  	if (count > 8192)
>  		count = 8192;
> @@ -369,7 +369,7 @@ static noinline int i2cdev_ioctl_smbus(struct i2c_client *client,
>  
>  static long i2cdev_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
>  {
> -	struct i2c_client *client = (struct i2c_client *)file->private_data;
> +	struct i2c_client *client = file->private_data;
>  	unsigned long funcs;
>  
>  	dev_dbg(&client->adapter->dev, "ioctl, cmd=0x%02x, arg=0x%02lx\n",

Applied, thanks.

-- 
Jean Delvare
