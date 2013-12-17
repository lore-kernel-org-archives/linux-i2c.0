From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH 04/13] i2c: isch: Use devm_request_region()
Date: Tue, 17 Dec 2013 08:53:09 +0100
Message-ID: <20131217085309.1459ea27@endymion.delvare>
References: <001601cefaf3$940d0040$bc2700c0$%han@samsung.com>
	<002801cefaf4$69243d70$3b6cb850$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <002801cefaf4$69243d70$3b6cb850$%han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: 'Wolfram Sang' <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Jingoo Han,

On Tue, 17 Dec 2013 15:51:28 +0900, Jingoo Han wrote:
> Use devm_request_region() to make cleanup paths simpler.

You need to include <linux/ioport.h> for this function.

> Signed-off-by: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> ---
>  drivers/i2c/busses/i2c-isch.c |    5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-isch.c b/drivers/i2c/busses/i2c-isch.c
> index 8c38aaa..fb02df2 100644
> --- a/drivers/i2c/busses/i2c-isch.c
> +++ b/drivers/i2c/busses/i2c-isch.c
> @@ -275,7 +275,8 @@ static int smbus_sch_probe(struct platform_device *dev)
>  	if (!res)
>  		return -EBUSY;
>  
> -	if (!request_region(res->start, resource_size(res), dev->name)) {
> +	if (!devm_request_region(&dev->dev, res->start, resource_size(res),
> +				 dev->name)) {
>  		dev_err(&dev->dev, "SMBus region 0x%x already in use!\n",
>  			sch_smba);
>  		return -EBUSY;
> @@ -294,7 +295,6 @@ static int smbus_sch_probe(struct platform_device *dev)
>  	retval = i2c_add_adapter(&sch_adapter);
>  	if (retval) {
>  		dev_err(&dev->dev, "Couldn't register adapter!\n");
> -		release_region(res->start, resource_size(res));
>  		sch_smba = 0;
>  	}
>  
> @@ -307,7 +307,6 @@ static int smbus_sch_remove(struct platform_device *pdev)
>  	if (sch_smba) {
>  		i2c_del_adapter(&sch_adapter);
>  		res = platform_get_resource(pdev, IORESOURCE_IO, 0);
> -		release_region(res->start, resource_size(res));
>  		sch_smba = 0;
>  	}

"res" becomes useless in the remove function as you removed the only
use of it. So you can simplify this function further.

-- 
Jean Delvare
