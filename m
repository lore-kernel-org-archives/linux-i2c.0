From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 04/15] ipmi_ssif: Remove duplicate NULL check
Date: Thu, 18 Jan 2018 17:29:48 +0200
Message-ID: <1516289388.7000.1092.camel@linux.intel.com>
References: <20171031142149.32512-1-andriy.shevchenko@linux.intel.com>
         <20171031142149.32512-4-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:28460 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932348AbeARP3w (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 18 Jan 2018 10:29:52 -0500
In-Reply-To: <20171031142149.32512-4-andriy.shevchenko@linux.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>
Cc: Corey Minyard <minyard@acm.org>, openipmi-developer@lists.sourceforge.net

On Tue, 2017-10-31 at 16:21 +0200, Andy Shevchenko wrote:
> Since i2c_unregister_device() became NULL-aware we may remove
> duplicate
> NULL check.

Anyone?

Wolfram, I think if no one picks this soon it's quite safe to push it
through i2c tree.

> Cc: Corey Minyard <minyard@acm.org>
> Cc: openipmi-developer@lists.sourceforge.net
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/char/ipmi/ipmi_ssif.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/char/ipmi/ipmi_ssif.c
> b/drivers/char/ipmi/ipmi_ssif.c
> index 466b3a1c0adf..8d183e182eab 100644
> --- a/drivers/char/ipmi/ipmi_ssif.c
> +++ b/drivers/char/ipmi/ipmi_ssif.c
> @@ -2072,8 +2072,7 @@ static int ssif_platform_remove(struct
> platform_device *dev)
>  		return 0;
>  
>  	mutex_lock(&ssif_infos_mutex);
> -	if (addr_info->client)
> -		i2c_unregister_device(addr_info->client);
> +	i2c_unregister_device(addr_info->client);
>  
>  	list_del(&addr_info->link);
>  	kfree(addr_info);

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
