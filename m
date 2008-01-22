From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: i2c_new_device is losing error codes
Date: Tue, 22 Jan 2008 15:30:14 +0100
Message-ID: <20080122153014.67a55fb1@hyperion.delvare>
References: <9e4733910801211611u6d729fc2nee4914ca049bcd0d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <9e4733910801211611u6d729fc2nee4914ca049bcd0d-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Jon Smirl <jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Linux I2C <i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Jon,

On Mon, 21 Jan 2008 19:11:23 -0500, Jon Smirl wrote:
> i2c_new_device() is not propagating error codes up. Callers will need
> to be fixed to use PTR_ERR() to recover the errors.
> 
> struct i2c_client *
> i2c_new_device(struct i2c_adapter *adap, struct i2c_board_info const *info)
> {
> 	struct i2c_client	*client;
> 	int			status;
> 
> 	client = kzalloc(sizeof *client, GFP_KERNEL);
> 	if (!client)
> --should return -ENOMEM;
> 		return NULL;
> 
> 	client->adapter = adap;
> 
> 	client->dev.platform_data = info->platform_data;
> 	device_init_wakeup(&client->dev, info->flags & I2C_CLIENT_WAKE);
> 
> 	client->flags = info->flags & ~I2C_CLIENT_WAKE;
> 	client->addr = info->addr;
> 	client->irq = info->irq;
> 
> 	strlcpy(client->name, info->type, sizeof(client->name));
> 
> 	/* a new style driver may be bound to this device when we
> 	 * return from this function, or any later moment (e.g. maybe
> 	 * hotplugging will load the driver module).  and the device
> 	 * refcount model is the standard driver model one.
> 	 */
> 	status = i2c_attach_client(client);
> --error status is not propagated up
> 	if (status < 0) {
> 		kfree(client);
> 		client = NULL;
> 	}
> 	return client;
> }
> EXPORT_SYMBOL_GPL(i2c_new_device);

That's an implementation decision. The PTR_ERR() mechanism is not
mandatory to use, I guess we didn't see a benefit in using it for this
function. I can't think of a recoverable error this function could
return, and if all errors are unrecoverable there's little point in
being able to distinguish between then, is there? If you have a use
case where the actual error code returned by i2c_new_device() would
lead the caller to do something different, please present it to us and
we'll discuss it.

-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
