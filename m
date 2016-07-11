From: Jean Delvare <jdelvare@suse.de>
Subject: Re: [PATCH 1/7] i2c: free idr when sanity checks in
 i2c_register_adapter() fail
Date: Mon, 11 Jul 2016 13:51:17 +0200
Message-ID: <20160711135117.6b836415@endymion>
References: <1468038904-2571-1-git-send-email-wsa@the-dreams.de>
	<1468038904-2571-2-git-send-email-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:48528 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932166AbcGKLvV (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Mon, 11 Jul 2016 07:51:21 -0400
In-Reply-To: <1468038904-2571-2-git-send-email-wsa@the-dreams.de>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org

On Sat,  9 Jul 2016 13:34:58 +0900, Wolfram Sang wrote:
> On error, we should give idr back to the pool in any case.
> 
> Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
> Cc: Jean Delvare <jdelvare@suse.de>
> ---
>  drivers/i2c/i2c-core.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
> index 71ad532be1d891..7e6ff6d4cf659a 100644
> --- a/drivers/i2c/i2c-core.c
> +++ b/drivers/i2c/i2c-core.c
> @@ -1560,7 +1560,7 @@ static int __process_new_adapter(struct device_driver *d, void *data)
>  
>  static int i2c_register_adapter(struct i2c_adapter *adap)
>  {
> -	int res = 0;
> +	int res = -EINVAL;
>  
>  	/* Can't register until after driver model init */
>  	if (WARN_ON(!is_registered)) {
> @@ -1572,12 +1572,12 @@ static int i2c_register_adapter(struct i2c_adapter *adap)
>  	if (unlikely(adap->name[0] == '\0')) {
>  		pr_err("i2c-core: Attempt to register an adapter with "
>  		       "no name!\n");
> -		return -EINVAL;
> +		goto out_list;
>  	}
>  	if (unlikely(!adap->algo)) {
>  		pr_err("i2c-core: Attempt to register adapter '%s' with "
>  		       "no algo!\n", adap->name);
> -		return -EINVAL;
> +		goto out_list;
>  	}
>  
>  	if (!adap->lock_bus) {

Good catch.

Reviewed-by: Jean Delvare <jdelvare@suse.de>

-- 
Jean Delvare
SUSE L3 Support
