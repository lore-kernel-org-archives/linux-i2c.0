From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: RFC: Add documentation on upgrading clients
Date: Tue, 3 Jun 2008 18:26:32 +0200
Message-ID: <20080603182632.7a6b23b0@hyperion.delvare>
References: <20080603111922.GA11500@fluff.org.uk>
	<200806031329.10290.laurentp@cse-semaphore.com>
	<20080603134637.GB8391@fluff.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080603134637.GB8391-elnMNo+KYs3pIgCt6eIbzw@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Ben,

On Tue, 3 Jun 2008 14:46:37 +0100, Ben Dooks wrote:
> On Tue, Jun 03, 2008 at 01:29:06PM +0200, Laurent Pinchart wrote:
> 
> Thanks, here's the next version, and I have included the example
> driver post-editing at the end of the file. Also found a couple of
> items that I forgot to add.
> 
> V2:
> 
> Upgrading I2C Drivers to the new 2.6 Driver Model
> =================================================

That's a good idea, thanks for doing this.

> 
> Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
> 
> Introduction
> ------------
> 
> This guide outlines how to alter existing Linux 2.6 client drivers from
> the old to the new new binding methods.
> 
> 
> Example old-style driver
> ------------------------
> 
>  
> struct example_state {
> 	struct i2c_client	client;
> 	....
> };
> 
> static struct i2c_driver example_driver;
> 
> static unsigned short ignore[] = { I2C_CLIENT_END };
> static unsigned short normal_addr[] = { OUR_ADDR, I2C_CLIENT_END };
> 
> static struct i2c_client_address_data addr_data = {
> 	.normal_i2c		= normal_addr,
> 	.probe			= ignore,
> 	.ignore			= ignore,
> };

You could make the example slightly shorter with:

I2C_CLIENT_INSMOD;

> 
> static int example_attach(struct i2c_adapter *adap, int addr, int kind)
> {
> 	struct example_state *state;
> 	struct device *dev = &adap->dev;
> 	int ret;
> 
> 	state = kzalloc(sizeof(struct example_state), GFP_KERNEL);
> 	if (state == NULL) {
> 		dev_err(dev, "failed to create our state\n");
> 		return -ENOMEM;
> 	}
> 
> 	example->i2c_client.addr    = addr;

example->client.addr, same below and again later in the document.

> 	example->i2c_client.flags   = 0;
> 	example->i2c_client.adapter = adap;
> 
> 	i2c_set_clientdata(&state->i2c_client, state);
> 	strlcpy(client->i2c_client.name, example_driver.driver.name,

It's a bad example, driver name != client name. Just use "example" as
the client name. Would save you a forward declaration as well.

> 		I2C_NAME_SIZE);
> 	
> 	ret = i2c_attach_client(&state->i2c_client);
> 	if (ret < 0) {
> 		dev_err(dev, "failed to attach client\n");
> 		kfree(state);
> 		return ret;
> 	}
> 
> 	dev = &state->i2c_client.dev;

Doesn't seem terribly useful given that you skip all the code that
would use it.

> 
> 	/* rest of the initialisation goes here. */
> 
> 	return 0;
> }
> 
> static int example_remove(struct i2c_client *client)

example_detach

> {
> 	struct example_state *state = i2c_get_clientdata(client);
> 
> 	i2c_detach_client(client);
> 	kfree(state);
> 	return 0;
> }
> 
> static int example_attach_adapter(struct i2c_adapter *adap)
> {
> 	return i2c_probe(adap, &addr_data, example_attach);
> }
> 
> static struct i2c_driver example_driver = {
>  	.driver		= {
> 		.owner		= THIS_MODULE,
> 		.name		= "example",
> 	},
> 	.attach_adapter = example_attach_adapter,
> 	.detach_client	= example_detach,
> 	.suspend	= example_suspend,
> 	.resume		= example_resume,
> };
> 
> 
> Updating the client
> -------------------
> 
> The new style binding model will check against a list of
> supported devices and their associated address supplied by
> the code registering the busses. This means that the driver
> .attach_adapter and .detach_adapter methods can be removed,
> along with the addr_data, as follows
> 
> - static struct i2c_driver example_driver;
> 
> - static unsigned short ignore[] = { I2C_CLIENT_END };
> - static unsigned short normal_addr[] = { OUR_ADDR, I2C_CLIENT_END };
> 
> - static struct i2c_client_address_data addr_data = {
> -	.normal_i2c		= normal_addr,
> -	.probe			= ignore,
> - 	.ignore			= ignore,
> - };
> 
> - static int example_attach_adapter(struct i2c_adapter *adap)
> - {
> - 	return i2c_probe(adap, &addr_data, example_attach);
> - }
> 
>  static struct i2c_driver example_driver = {
> -	.attach_adapter = example_attach_adapter,
> -	.detach_client	= example_detach,
>  }
> 
> Add the probe and remove methods to the i2c_driver, as so:
> 
>  static struct i2c_driver example_driver = {
> +	.probe		= example_probe,
> +	.remove		= example_remove,
>  }
> 
> Change the example_attach method to accept the new parameters
> which include the i2c_client that it will be working with:
> 
> - static int example_attach(struct i2c_adapter *adap, int addr, int kind)
> + static int example_probe(struct i2c_client *i2c_client,

The client is typically named client, not i2c_client.

> +			   const struct i2c_device_id *id)
> 
> Change the name of example_attach to example_probe to align it with the
> i2c_driver entry names. The rest of the probe routine will now need to be
> changed as the i2c_client has already been setup for use.
> 
> Remove the  setting of address and adapter, they are now not needed.
> 
> -	example->i2c_client.addr    = addr;
> -	example->i2c_client.flags   = 0;
> -	example->i2c_client.adapter = adap;
> 
> Also remove the strlcpy, as the i2c_client's name is already filled
> in by the caller.
> 
> -	strlcpy(client->i2c_client.name, example_driver.driver.name,
> -		I2C_NAME_SIZE);

In fact, the 3 items before are in the exact same case: they have
already been set by the caller.

> 
> The i2c_set_clientdata is now:
> 
> -	i2c_set_clientdata(&state->i2c_client, state);
> +	i2c_set_clientdata(i2c_client, state);
> 
> The call to i2c_attach_client is no longer needed, if the probe
> routine exits successfully, then the driver will be automatically
> attached by the core. Change the probe routine as so:
> 
> -	ret = i2c_attach_client(&state->i2c_client);
> -	if (ret < 0) {
> -		dev_err(dev, "failed to attach client\n");
> -		kfree(state);
> -		return ret;
> -	}
> 
> 

Doubled blank line.

> Remove the storage of  'struct i2c_client' from the 'struct example_state'

Doubled space.

> as we are provided with the i2c_client in our example_probe. Instead we
> store a pointer to it for when it is needed.
> 
> struct example_state {
> -	struct i2c_client	client;
> +	struct i2c_client	*client;
> 
> It is also necessary to change the temporary dev pointer to point into
> the new i2c client as so:
> 
> -	struct device *dev = &adap->dev;
> + 	struct device *dev = &i2c_client->dev;

This is an implementation detail, many drivers don't use a local
pointer for that, and it's IMHO rather confusing to present this as if
an adapter had turned into a client. I think you can simply omit this,
it's not worth insisting on.

> 
> And remove the change aftre our client is attached, as the driver no

Typo: after.

> longer needs to register a new client structure with the core:
> 
> -	dev = &state->i2c_client.dev;
> 
> In the probe routine, ensure that the new state has the client stored
> in it:
> 
> static int example_probe(struct i2c_client *i2c_client,
> 			 const struct i2c_device_id *id)
> {
> 	struct example_state *state;
>  	struct device *dev = &i2c_client->dev;
> 	int ret;
> 
> 	state = kzalloc(sizeof(struct example_state), GFP_KERNEL);
> 	if (state == NULL) {
> 		dev_err(dev, "failed to create our state\n");
> 		return -ENOMEM;
> 	}
> 
> +	state->client = i2c_client;
> 
> Update the remove method to delete the i2c_detach_client call.
> 
> static int example_remove(struct i2c_client *client)
> {
> 	struct example_state *state = i2c_get_clientdata(client);
> 
> -	i2c_detach_client(client);
> 
> 
> 
> Our driver should now look like this:
> 
> struct example_state {
> 	struct i2c_client	client;

*client

> 	....
> };
> 
> static int example_probe(struct i2c_client *i2c_client,

*client

> 		         const struct i2c_device_id *id)
> {
> 	struct example_state *state;
> 	struct device *dev = &i2c_client->dev;
> 	int ret;
> 
> 	state = kzalloc(sizeof(struct example_state), GFP_KERNEL);
> 	if (state == NULL) {
> 		dev_err(dev, "failed to create our state\n");
> 		return -ENOMEM;
> 	}
> 
> 	state->client = i2c_client;
> 	i2c_set_clientdata(i2c_client, state);
> 
> 	/* rest of the initialisation goes here. */
> 
> 	return 0;
> }
> 
> static int example_remove(struct i2c_client *client)
> {
> 	struct example_state *state = i2c_get_clientdata(client);
> 
> 	kfree(state);
> 	return 0;
> }
> 
> static struct i2c_driver example_driver = {
>  	.driver		= {
> 		.owner		= THIS_MODULE,
> 		.name		= "example",
> 	},
> 	.probe		= example_probe,
> 	.remove		= example_remove,
> 	.suspend	= example_suspend,
> 	.resume		= example_resume,
> };

-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
