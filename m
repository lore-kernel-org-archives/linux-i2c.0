From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH 09/34] media: i2c: mt9p031: simplify getting the adapter
 of a client
Date: Sat, 8 Jun 2019 14:42:59 +0300
Message-ID: <20190608114259.GB4786@pendragon.ideasonboard.com>
References: <20190608105619.593-1-wsa+renesas@sang-engineering.com>
 <20190608105619.593-10-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190608105619.593-10-wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-i2c@vger.kernel.org, Mauro Carvalho Chehab <mchehab@kernel.org>, linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Hi Wolfram,

Thank you for the patch.

On Sat, Jun 08, 2019 at 12:55:48PM +0200, Wolfram Sang wrote:
> We have a dedicated pointer for that, so use it. Much easier to read and
> less computation involved.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

and taken in my tree.

> ---
> 
> Please apply to your subsystem tree.
> 
>  drivers/media/i2c/mt9p031.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/media/i2c/mt9p031.c b/drivers/media/i2c/mt9p031.c
> index 715be3632b01..5d824dd33edd 100644
> --- a/drivers/media/i2c/mt9p031.c
> +++ b/drivers/media/i2c/mt9p031.c
> @@ -1034,7 +1034,7 @@ static int mt9p031_probe(struct i2c_client *client,
>  			 const struct i2c_device_id *did)
>  {
>  	struct mt9p031_platform_data *pdata = mt9p031_get_pdata(client);
> -	struct i2c_adapter *adapter = to_i2c_adapter(client->dev.parent);
> +	struct i2c_adapter *adapter = client->adapter;
>  	struct mt9p031 *mt9p031;
>  	unsigned int i;
>  	int ret;

-- 
Regards,

Laurent Pinchart
