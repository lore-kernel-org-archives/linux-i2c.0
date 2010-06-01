From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH 11/27] drivers/i2c: Use memdup_user
Date: Tue, 1 Jun 2010 13:14:35 +0200
Message-ID: <20100601131435.5904351c@hyperion.delvare>
References: <Pine.LNX.4.64.1005221021270.13021@ask.diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <Pine.LNX.4.64.1005221021270.13021-QfmoRoYWmW9knbxzx/v8hQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Julia Lawall <julia-dAYI7NvHqcQ@public.gmane.org>
Cc: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kernel-janitors-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Julia,

On Sat, 22 May 2010 10:21:45 +0200 (CEST), Julia Lawall wrote:
> From: Julia Lawall <julia-dAYI7NvHqcQ@public.gmane.org>
> 
> Use memdup_user when user data is immediately copied into the allocated
> region.  Note that in the second case, the ++i is no longer necessary, as
> the last value is already freed if needed by the call to memdup_user.
> 
> The semantic patch that makes this change is as follows:
> (http://coccinelle.lip6.fr/)
> 
> // <smpl>
> @@
> expression from,to,size,flag;
> position p;
> identifier l1,l2;
> @@
> 
> -  to = \(kmalloc@p\|kzalloc@p\)(size,flag);
> +  to = memdup_user(from,size);
>    if (
> -      to==NULL
> +      IS_ERR(to)
>                  || ...) {
>    <+... when != goto l1;
> -  -ENOMEM
> +  PTR_ERR(to)
>    ...+>
>    }
> -  if (copy_from_user(to, from, size) != 0) {
> -    <+... when != goto l2;
> -    -EFAULT
> -    ...+>
> -  }
> // </smpl>
> 
> Signed-off-by: Julia Lawall <julia-dAYI7NvHqcQ@public.gmane.org>
> 
> ---
>  drivers/i2c/i2c-dev.c |   22 ++++++----------------
>  1 file changed, 6 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/i2c/i2c-dev.c b/drivers/i2c/i2c-dev.c
> index e0694e4..03e9ef8 100644
> --- a/drivers/i2c/i2c-dev.c
> +++ b/drivers/i2c/i2c-dev.c
> @@ -167,13 +167,9 @@ static ssize_t i2cdev_write(struct file *file, const char __user *buf,
>  	if (count > 8192)
>  		count = 8192;
>  
> -	tmp = kmalloc(count, GFP_KERNEL);
> -	if (tmp == NULL)
> -		return -ENOMEM;
> -	if (copy_from_user(tmp, buf, count)) {
> -		kfree(tmp);
> -		return -EFAULT;
> -	}
> +	tmp = memdup_user(buf, count);
> +	if (IS_ERR(tmp))
> +		return PTR_ERR(tmp);
>  
>  	pr_debug("i2c-dev: i2c-%d writing %zu bytes.\n",
>  		iminor(file->f_path.dentry->d_inode), count);
> @@ -247,15 +243,9 @@ static noinline int i2cdev_ioctl_rdrw(struct i2c_client *client,
>  			break;
>  		}
>  		data_ptrs[i] = (u8 __user *)rdwr_pa[i].buf;
> -		rdwr_pa[i].buf = kmalloc(rdwr_pa[i].len, GFP_KERNEL);
> -		if (rdwr_pa[i].buf == NULL) {
> -			res = -ENOMEM;
> -			break;
> -		}
> -		if (copy_from_user(rdwr_pa[i].buf, data_ptrs[i],
> -				   rdwr_pa[i].len)) {
> -				++i; /* Needs to be kfreed too */
> -				res = -EFAULT;
> +		rdwr_pa[i].buf = memdup_user(data_ptrs[i], rdwr_pa[i].len);
> +		if (IS_ERR(rdwr_pa[i].buf)) {
> +			res = PTR_ERR(rdwr_pa[i].buf);
>  			break;
>  		}
>  	}

Applied, thanks.

-- 
Jean Delvare
