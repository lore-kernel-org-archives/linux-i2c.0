From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH] i2c: Keep client->driver and client->dev.driver
	in sync
Date: Sun, 9 Mar 2008 07:23:21 -0800
Message-ID: <200803090823.22013.david-b@pacbell.net>
References: <20080308214911.5344eba9@hyperion.delvare>
	<200803081312.36524.david-b@pacbell.net>
	<20080309111626.1d531cd4@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080309111626.1d531cd4-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Content-Disposition: inline
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
Cc: Linux I2C <i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Sunday 09 March 2008, Jean Delvare wrote:
> Hi David,
> 
> On Sat, 8 Mar 2008 13:12:36 -0800, David Brownell wrote:
> > The only issue I have is that code which the driver probe()
> > calls may expect client->driver to be set, but it won't be...
> > 
> > While I'd rather see client->driver vanish, in this case I'd
> > just suggest leaving the early assignment, and nulling it out
> > on error (instead of assigning it on success).
> 
> Oh well, that's exactly what Hans' patch did originally, I changed it
> to make the code more simple, but if you think it is better that way,
> I'll revert this change of mine. Here you go:

Yeah, this has much less chance to break something inadvertently.

- Dave


> From: Hans Verkuil <hverkuil-qWit8jRvyhVmR6Xm/wNWPw@public.gmane.org>
> 
> Ensure that client->driver is set to NULL if the probe() returns an
> error (this keeps client->driver and client->dev.driver in sync).
> 
> Signed-off-by: Hans Verkuil <hverkuil-qWit8jRvyhVmR6Xm/wNWPw@public.gmane.org>
> Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
> ---
>  drivers/i2c/i2c-core.c |    6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> --- linux-2.6.25-rc4.orig/drivers/i2c/i2c-core.c	2008-03-08 17:57:52.000000000 +0100
> +++ linux-2.6.25-rc4/drivers/i2c/i2c-core.c	2008-03-09 11:03:53.000000000 +0100
> @@ -90,12 +90,16 @@ static int i2c_device_probe(struct devic
>  {
>  	struct i2c_client	*client = to_i2c_client(dev);
>  	struct i2c_driver	*driver = to_i2c_driver(dev->driver);
> +	int status;
>  
>  	if (!driver->probe)
>  		return -ENODEV;
>  	client->driver = driver;
>  	dev_dbg(dev, "probe\n");
> -	return driver->probe(client);
> +	status = driver->probe(client);
> +	if (status)
> +		client->driver = NULL;
> +	return status;
>  }
>  
>  static int i2c_device_remove(struct device *dev)
> 
> 
> 
> -- 
> Jean Delvare
> 



_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
