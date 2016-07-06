From: Peter Rosin <peda@axentia.se>
Subject: Re: [PATCH 2/2] i2c-dev: Don't block the adapter from unregistering
Date: Wed, 6 Jul 2016 10:22:23 +0200
Message-ID: <415dcaa7-8ad9-492e-5c5c-605173bc4345@axentia.se>
References: <cover.1467772840.git.viresh.kumar@linaro.org>
 <021486be2f5425ce2379219a7ac163ee14ba2aba.1467772840.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-db5eur01on0133.outbound.protection.outlook.com ([104.47.2.133]:50720
	"EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751007AbcGFIi3 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Wed, 6 Jul 2016 04:38:29 -0400
In-Reply-To: <021486be2f5425ce2379219a7ac163ee14ba2aba.1467772840.git.viresh.kumar@linaro.org>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, Wolfram Sang <wsa@the-dreams.de>, Jean Delvare <jdelvare@suse.com>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org, Johan Hovold <johan@kernel.org>, Alex Elder <elder@linaro.org>

On 2016-07-06 04:57, Viresh Kumar wrote:
> The i2c-dev calls i2c_get_adapter() from the .open() callback, which
> doesn't let the adapter device unregister unless the .close() callback
> is called.
> 
> On some platforms (like Google ARA), this doesn't let the modules
> (hardware attached to the phone) eject from the phone as the cleanup
> path for the module hasn't finished yet (i2c adapter not removed).
> 
> We can't let the userspace block the kernel forever in such cases.
> 
> Fix this by calling i2c_get_adapter() from all other file operations,
> i.e.  read/write/ioctl, to make sure the adapter doesn't get away while
> we are in the middle of a operation, but not otherwise. In .open() we
> will release the adapter device before returning and so if there is no
> data transfer in progress, then the i2c-dev doesn't block the adapter
> from unregistering.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/i2c/i2c-dev.c | 72 ++++++++++++++++++++++++++++++++++++++++++++++-----
>  include/linux/i2c.h   |  1 +
>  2 files changed, 66 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/i2c/i2c-dev.c b/drivers/i2c/i2c-dev.c
> index 66f323fd3982..b2562603daa9 100644
> --- a/drivers/i2c/i2c-dev.c
> +++ b/drivers/i2c/i2c-dev.c
> @@ -142,13 +142,25 @@ static ssize_t i2cdev_read(struct file *file, char __user *buf, size_t count,
>  	int ret;
>  
>  	struct i2c_client *client = file->private_data;
> +	struct i2c_adapter *adap;
> +
> +	adap = i2c_get_adapter(client->adapter_nr);
> +	if (!adap)
> +		return -ENODEV;
> +
> +	if (adap != client->adapter) {
> +		ret = -EINVAL;
> +		goto put_adapter;
> +	}

I don't see how this can work with the i2c-demux-pinctrl driver.
I also wonder if/how other muxes handle this relaxed adapter
lifetime thingy?

Out of curiosity, why would client->adapter change anyway?
(that is, if not because of a demux-pinctrl op)

Or maybe I'm just paranoid, but this is not obvious...

Cheers,
Peter
