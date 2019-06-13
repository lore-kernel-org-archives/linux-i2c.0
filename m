From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 06/34] media: i2c: ak881x: simplify getting the adapter
 of a client
Date: Thu, 13 Jun 2019 11:47:17 +0200
Message-ID: <20190613094717.c7vc52wx5gax7psn@verge.net.au>
References: <20190608105619.593-1-wsa+renesas@sang-engineering.com>
 <20190608105619.593-7-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190608105619.593-7-wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-i2c@vger.kernel.org, Mauro Carvalho Chehab <mchehab@kernel.org>, linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Sat, Jun 08, 2019 at 12:55:45PM +0200, Wolfram Sang wrote:
> We have a dedicated pointer for that, so use it. Much easier to read and
> less computation involved.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>

> ---
> 
> Please apply to your subsystem tree.
> 
>  drivers/media/i2c/ak881x.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/media/i2c/ak881x.c b/drivers/media/i2c/ak881x.c
> index 30f9db1351b9..09860603da64 100644
> --- a/drivers/media/i2c/ak881x.c
> +++ b/drivers/media/i2c/ak881x.c
> @@ -232,7 +232,7 @@ static const struct v4l2_subdev_ops ak881x_subdev_ops = {
>  static int ak881x_probe(struct i2c_client *client,
>  			const struct i2c_device_id *did)
>  {
> -	struct i2c_adapter *adapter = to_i2c_adapter(client->dev.parent);
> +	struct i2c_adapter *adapter = client->adapter;
>  	struct ak881x *ak881x;
>  	u8 ifmode, data;
>  
> -- 
> 2.19.1
> 
