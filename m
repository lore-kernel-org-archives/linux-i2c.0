From: Hans Verkuil <hverkuil@xs4all.nl>
Subject: Re: [RFC PATCH 12/12] media: v4l2-core: convert to
 i2c_new_scanned_device
Date: Wed, 6 Nov 2019 12:24:03 +0100
Message-ID: <4799e282-2f49-a0ae-8396-ee8f0fa26064@xs4all.nl>
References: <20191106095033.25182-1-wsa+renesas@sang-engineering.com>
 <20191106095033.25182-13-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191106095033.25182-13-wsa+renesas@sang-engineering.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-i2c@vger.kernel.org
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>, linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On 11/6/19 10:50 AM, Wolfram Sang wrote:
> Move from the deprecated i2c_new_probed_device() to the new
> i2c_new_scanned_device(). Make use of the new ERRPTR if suitable.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Acked-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>

Regards,

	Hans

> ---
> 
> Build tested only. RFC, please comment and/or ack, but don't apply yet.
> 
>  drivers/media/v4l2-core/v4l2-i2c.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/media/v4l2-core/v4l2-i2c.c b/drivers/media/v4l2-core/v4l2-i2c.c
> index 5bf99e7c0c09..25ddda3b7ce6 100644
> --- a/drivers/media/v4l2-core/v4l2-i2c.c
> +++ b/drivers/media/v4l2-core/v4l2-i2c.c
> @@ -74,10 +74,10 @@ struct v4l2_subdev
>  
>  	/* Create the i2c client */
>  	if (info->addr == 0 && probe_addrs)
> -		client = i2c_new_probed_device(adapter, info, probe_addrs,
> -					       NULL);
> +		client = i2c_new_scanned_device(adapter, info, probe_addrs,
> +					        NULL);
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
> +	if (IS_ERR(client) || !client->dev.driver)
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
