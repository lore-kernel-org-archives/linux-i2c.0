From: Hans Verkuil <hverkuil@xs4all.nl>
Subject: Re: [PATCH V2 RESEND] media: v4l2-core: convert to new API with
 ERRPTR
Date: Fri, 14 Feb 2020 10:18:02 +0100
Message-ID: <1e7e14b6-964d-0715-8cfd-364ff4806e22@xs4all.nl>
References: <20200210165621.5189-1-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from lb3-smtp-cloud8.xs4all.net ([194.109.24.29]:46047 "EHLO
        lb3-smtp-cloud8.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727965AbgBNJSG (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Fri, 14 Feb 2020 04:18:06 -0500
In-Reply-To: <20200210165621.5189-1-wsa+renesas@sang-engineering.com>
Content-Language: en-US
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-media@vger.kernel.org
Cc: linux-i2c@vger.kernel.org, Mauro Carvalho Chehab <mchehab@kernel.org>

On 2/10/20 5:56 PM, Wolfram Sang wrote:
> Use the new APIs instead of the deprecated ones.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

I'm dropping this resend from patchwork since it is in the still pending
PR https://patchwork.linuxtv.org/patch/61113/.

That PR missed the cut for v5.6, so will be merged for v5.7.

Regards,

	Hans

> ---
> 
> Resent from proper email address. Sorry for the confusion!
> 
>  drivers/media/v4l2-core/v4l2-i2c.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/media/v4l2-core/v4l2-i2c.c b/drivers/media/v4l2-core/v4l2-i2c.c
> index 5bf99e7c0c09..b4acca75644b 100644
> --- a/drivers/media/v4l2-core/v4l2-i2c.c
> +++ b/drivers/media/v4l2-core/v4l2-i2c.c
> @@ -74,10 +74,10 @@ struct v4l2_subdev
>  
>  	/* Create the i2c client */
>  	if (info->addr == 0 && probe_addrs)
> -		client = i2c_new_probed_device(adapter, info, probe_addrs,
> -					       NULL);
> +		client = i2c_new_scanned_device(adapter, info, probe_addrs,
> +						NULL);
>  	else
> -		client = i2c_new_device(adapter, info);
> +		client = i2c_new_client_device(adapter, info);
>  
>  	/*
>  	 * Note: by loading the module first we are certain that c->driver
> @@ -88,7 +88,7 @@ struct v4l2_subdev
>  	 * want to use the i2c device, so explicitly loading the module
>  	 * is the best alternative.
>  	 */
> -	if (!client || !client->dev.driver)
> +	if (!i2c_client_has_driver(client))
>  		goto error;
>  
>  	/* Lock the module so we can safely get the v4l2_subdev pointer */
> @@ -110,7 +110,7 @@ struct v4l2_subdev
>  	 * If we have a client but no subdev, then something went wrong and
>  	 * we must unregister the client.
>  	 */
> -	if (client && !sd)
> +	if (!IS_ERR(client) && !sd)
>  		i2c_unregister_device(client);
>  	return sd;
>  }
> 
