From: Jean Delvare <jdelvare@suse.de>
Subject: Re: [PATCH 1/2] i2c-dev: don't get i2c adapter via i2c_dev
Date: Thu, 7 Jul 2016 15:16:54 +0200
Message-ID: <20160707151654.3d32741c@endymion>
References: <cover.1467772840.git.viresh.kumar@linaro.org>
	<c2ac0349b818d3f3787b939d5eb83e3c80fc205d.1467772840.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:35376 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750879AbcGGNRD (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Thu, 7 Jul 2016 09:17:03 -0400
In-Reply-To: <c2ac0349b818d3f3787b939d5eb83e3c80fc205d.1467772840.git.viresh.kumar@linaro.org>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Wolfram Sang <wsa@the-dreams.de>, Jean Delvare <jdelvare@suse.com>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org, Johan Hovold <johan@kernel.org>, Alex Elder <elder@linaro.org>

On Tue,  5 Jul 2016 19:57:06 -0700, Viresh Kumar wrote:
> There is no code protecting i2c_dev to be freed after it is returned
> from i2c_dev_get_by_minor() and using it to access the value which we
> already have (minor) isn't safe really.
> 
> Avoid using it and get the adapter directly from 'minor'.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/i2c/i2c-dev.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/drivers/i2c/i2c-dev.c b/drivers/i2c/i2c-dev.c
> index 6ecfd76270f2..66f323fd3982 100644
> --- a/drivers/i2c/i2c-dev.c
> +++ b/drivers/i2c/i2c-dev.c
> @@ -485,13 +485,8 @@ static int i2cdev_open(struct inode *inode, struct file *file)
>  	unsigned int minor = iminor(inode);
>  	struct i2c_client *client;
>  	struct i2c_adapter *adap;
> -	struct i2c_dev *i2c_dev;
> -
> -	i2c_dev = i2c_dev_get_by_minor(minor);
> -	if (!i2c_dev)
> -		return -ENODEV;
>  
> -	adap = i2c_get_adapter(i2c_dev->adap->nr);
> +	adap = i2c_get_adapter(minor);
>  	if (!adap)
>  		return -ENODEV;
>  

Anyway, this is a good cleanup/optimization on its own, on top of
fixing a race condition, independently of what we decide for the rest
of the problems being discussed in this thread. So:

Reviewed-by: Jean Delvare <jdelvare@suse.de>
Tested-by: Jean Delvare <jdelvare@suse.de>

Thanks,
-- 
Jean Delvare
SUSE L3 Support
