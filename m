From: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: Re: [PATCH] i2c: Simplify i2c_device_probe
Date: Wed, 4 Jun 2008 00:43:59 +0100
Message-ID: <20080603234359.GF11277@trinity.fluff.org>
References: <20080603202954.64d5971c@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20080603202954.64d5971c-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Linux I2C <i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Tue, Jun 03, 2008 at 08:29:54PM +0200, Jean Delvare wrote:
> i2c_driver.id_table is mandatory now, so we can simplify
> i2c_device_probe() a bit.
> 
> Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
> ---
>  drivers/i2c/i2c-core.c |    9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)
> 
> --- linux-2.6.26-rc4.orig/drivers/i2c/i2c-core.c	2008-06-03 10:57:55.000000000 +0200
> +++ linux-2.6.26-rc4/drivers/i2c/i2c-core.c	2008-06-03 16:38:37.000000000 +0200
> @@ -101,19 +101,14 @@ static int i2c_device_probe(struct devic
>  {
>  	struct i2c_client	*client = to_i2c_client(dev);
>  	struct i2c_driver	*driver = to_i2c_driver(dev->driver);
> -	const struct i2c_device_id *id;
>  	int status;
>  
> -	if (!driver->probe)
> +	if (!driver->probe || !driver->id_table)
>  		return -ENODEV;
>  	client->driver = driver;
>  	dev_dbg(dev, "probe\n");
>  
> -	if (driver->id_table)
> -		id = i2c_match_id(driver->id_table, client);
> -	else
> -		id = NULL;
> -	status = driver->probe(client, id);
> +	status = driver->probe(client, i2c_match_id(driver->id_table, client));
>  	if (status)
>  		client->driver = NULL;
>  	return status;

Looks ok, will give it a test tommorow if possible.
 
> 
> -- 
> Jean Delvare

-- 
-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.


_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
