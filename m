From: Jean Delvare <khali@linux-fr.org>
Subject: Re: [PATCH] i2c-dev: Return correct error code on class_create()
 failure
Date: Thu, 11 Sep 2008 13:04:42 +0200
Message-ID: <20080911130442.6ebd10c6@hyperion.delvare>
References: <alpine.LNX.2.00.0809102128110.19109@titan.stealer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755004AbYIKLFH@vger.kernel.org>
In-Reply-To: <alpine.LNX.2.00.0809102128110.19109@titan.stealer.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Sven Wegener <sven.wegener@stealer.net>
Cc: i2c@lm-sensors.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Hi Sven,

On Wed, 10 Sep 2008 21:30:27 +0200 (CEST), Sven Wegener wrote:
> We need to convert the error pointer from class_create(), else we'll return the
> successful return code from register_chrdev() on failure.
> 
> Signed-off-by: Sven Wegener <sven.wegener@stealer.net>
> ---
>  drivers/i2c/i2c-dev.c |    4 +++-
>  1 files changed, 3 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/i2c/i2c-dev.c b/drivers/i2c/i2c-dev.c
> index af4491f..307d976 100644
> --- a/drivers/i2c/i2c-dev.c
> +++ b/drivers/i2c/i2c-dev.c
> @@ -583,8 +583,10 @@ static int __init i2c_dev_init(void)
>  		goto out;
>  
>  	i2c_dev_class = class_create(THIS_MODULE, "i2c-dev");
> -	if (IS_ERR(i2c_dev_class))
> +	if (IS_ERR(i2c_dev_class)) {
> +		res = PTR_ERR(i2c_dev_class);
>  		goto out_unreg_chrdev;
> +	}
>  
>  	res = i2c_add_driver(&i2cdev_driver);
>  	if (res)

Good catch. Patch applied, thanks.

-- 
Jean Delvare
