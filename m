From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 12/34] misc: fsa9480: simplify getting the adapter of a
 client
Date: Thu, 13 Jun 2019 11:49:11 +0200
Message-ID: <20190613094911.ht6eit74uhmee25b@verge.net.au>
References: <20190608105619.593-1-wsa+renesas@sang-engineering.com>
 <20190608105619.593-13-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190608105619.593-13-wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-i2c@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Sat, Jun 08, 2019 at 12:55:51PM +0200, Wolfram Sang wrote:
> We have a dedicated pointer for that, so use it. Much easier to read and
> less computation involved.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>

> ---
> 
> Please apply to your subsystem tree.
> 
>  drivers/misc/fsa9480.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/misc/fsa9480.c b/drivers/misc/fsa9480.c
> index 607b489a6501..a8126790f8de 100644
> --- a/drivers/misc/fsa9480.c
> +++ b/drivers/misc/fsa9480.c
> @@ -410,7 +410,7 @@ static int fsa9480_irq_init(struct fsa9480_usbsw *usbsw)
>  static int fsa9480_probe(struct i2c_client *client,
>  			 const struct i2c_device_id *id)
>  {
> -	struct i2c_adapter *adapter = to_i2c_adapter(client->dev.parent);
> +	struct i2c_adapter *adapter = client->adapter;
>  	struct fsa9480_usbsw *usbsw;
>  	int ret = 0;
>  
> -- 
> 2.19.1
> 
