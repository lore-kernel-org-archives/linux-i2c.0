From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 11/34] media: i2c: tw9910: simplify getting the adapter
 of a client
Date: Thu, 13 Jun 2019 11:48:46 +0200
Message-ID: <20190613094846.bveex5pb7qfw7pmi@verge.net.au>
References: <20190608105619.593-1-wsa+renesas@sang-engineering.com>
 <20190608105619.593-12-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190608105619.593-12-wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-i2c@vger.kernel.org, Mauro Carvalho Chehab <mchehab@kernel.org>, linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Sat, Jun 08, 2019 at 12:55:50PM +0200, Wolfram Sang wrote:
> We have a dedicated pointer for that, so use it. Much easier to read and
> less computation involved.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>

> 
> Please apply to your subsystem tree.
> 
>  drivers/media/i2c/tw9910.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/media/i2c/tw9910.c b/drivers/media/i2c/tw9910.c
> index 4d7cd736b930..a25a350b0ddc 100644
> --- a/drivers/media/i2c/tw9910.c
> +++ b/drivers/media/i2c/tw9910.c
> @@ -934,8 +934,7 @@ static int tw9910_probe(struct i2c_client *client,
>  {
>  	struct tw9910_priv		*priv;
>  	struct tw9910_video_info	*info;
> -	struct i2c_adapter		*adapter =
> -		to_i2c_adapter(client->dev.parent);
> +	struct i2c_adapter		*adapter = client->adapter;
>  	int ret;
>  
>  	if (!client->dev.platform_data) {
> -- 
> 2.19.1
> 
