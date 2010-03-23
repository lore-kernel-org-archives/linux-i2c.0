From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH]I2C device - release cleanup
Date: Tue, 23 Mar 2010 13:54:10 +0100
Message-ID: <20100323135410.47276f58@hyperion.delvare>
References: <8cad0aa1003230301g44434763w13da24799f811faa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <8cad0aa1003230301g44434763w13da24799f811faa-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean-Michel Hautbois <jhautbois-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Jean-Michel,

On Tue, 23 Mar 2010 11:01:28 +0100, Jean-Michel Hautbois wrote:
> Hi there,
> 
> Here is a little patch which aims to cleanup the release function in i2c-dev.c.
> This is only a call to single_release, instead of kfree and several things.
> 
> Signed-off-by: Jean-Michel Hautbois <jhautbois-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
> drivers/i2c/i2c-dev.c
> 
> --- linux-2.6.34-rc2/drivers/i2c/i2c-dev.c.orig	2010-03-23
> 10:19:26.000000000 +0100
> +++ linux-2.6.34-rc2/drivers/i2c/i2c-dev.c	2010-03-23 10:55:54.000000000 +0100
> @@ -36,6 +36,7 @@
>  #include <linux/i2c-dev.h>
>  #include <linux/jiffies.h>
>  #include <asm/uaccess.h>
> +#include <linux/seq_file.h>
> 
>  static struct i2c_driver i2cdev_driver;
> 
> @@ -477,12 +478,10 @@ static int i2cdev_open(struct inode *ino
>  static int i2cdev_release(struct inode *inode, struct file *file)
>  {
>  	struct i2c_client *client = file->private_data;
> -
> +	

This is adding trailing white-space. Obviously you did not review your
own patch before sending it. And you did not run it through
scripts/checkpatch.pl either.

>  	i2c_put_adapter(client->adapter);
> -	kfree(client);
> -	file->private_data = NULL;
> -
> -	return 0;
> +	
> +	return single_release(inode, file);
>  }
> 
>  static const struct file_operations i2cdev_fops = {

Did you test your patch? I am very skeptical that calling
single_release() out of the blue is the right thing to do. My instinct
tells me that single_release() is only meant for callers of
single_open().

-- 
Jean Delvare
http://khali.linux-fr.org/wishlist.html
