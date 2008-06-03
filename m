From: Ben Dooks <ben-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: RFC: Add documentation on upgrading clients
Date: Tue, 3 Jun 2008 12:19:22 +0100
Message-ID: <20080603111922.GA11500@fluff.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
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
To: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

I would like to get people's opinions on adding
the following as Documentation/i2c/upgrading-clients.


Upgrading I2C Drivers to the new 2.6 Driver Model
=================================================

Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>

Introduction
------------

This guide outlines how to alter existing Linux 2.6 client drivers from
the old to the new new binding methods.


Example old-style driver
------------------------

 
struct example_state {
	struct i2c_client	client;
	....
};

static struct i2c_driver example_driver;

static unsigned short ignore[] = { I2C_CLIENT_END };
static unsigned short normal_addr[] = { OUR_ADDR, I2C_CLIENT_END };

static struct i2c_client_address_data addr_data = {
	.normal_i2c		= normal_addr,
	.probe			= ignore,
	.ignore			= ignore,
};

static int example_attach(struct i2c_adapter *adap, int addr, int kind)
{
	struct example_state *state;
	struct device *dev = &adap->dev;
	int ret;

	state = kzalloc(sizeof(struct example_state), GFP_KERNEL);
	if (state == NULL) {
		dev_err(dev, "failed to create our state\n");
		return -ENOMEM;
	}

	example->i2c_client.addr    = addr;
	example->i2c_client.flags   = 0;
	example->i2c_client.adapter = adap;

	i2c_set_clientdata(&state->i2c_client, state);
	strlcpy(client->i2c_client.name, example_driver.driver.name,
		I2C_NAME_SIZE);
	
	ret = i2c_attach_client(&state->i2c_client);
	if (ret < 0) {
		dev_err(dev, "failed to attach client\n");
		kfree(state);
		return ret;
	}

	dev = &state->i2c_client.dev;

	/* rest of the initialisation goes here. */

	return 0;
}

static int example_remove(struct i2c_client *client)
{
	struct example_state *state = i2c_get_clientdata(client);

	i2c_detach_client(client);
	kfree(state);
	return 0;
}

static int example_attach_adapter(struct i2c_adapter *adap)
{
	return i2c_probe(adap, &addr_data, example_attach);
}

static struct i2c_driver example_driver = {
 	.driver		= {
		.owner		= THIS_MODULE,
		.name		= "example",
	},
	.attach_adapter = example_attach_adapter,
	.detach_client	= example_detach,
	.suspend	= example_suspend,
	.resume		= example_resume,
};


Updating the client
-------------------

The new style binding model will check against a list of
supported devices and their associated address supplied by
the code registering the busses. This means that the driver
.attach_adapter and .detach_adapter methods can be removed,
along with the addr_data, as follows

- static struct i2c_driver example_driver;

- static unsigned short ignore[] = { I2C_CLIENT_END };
- static unsigned short normal_addr[] = { OUR_ADDR, I2C_CLIENT_END };

- static struct i2c_client_address_data addr_data = {
-	.normal_i2c		= normal_addr,
-	.probe			= ignore,
- 	.ignore			= ignore,
- };

- static int example_attach_adapter(struct i2c_adapter *adap)
- {
- 	return i2c_probe(adap, &addr_data, example_attach);
- }

 static struct i2c_driver example_driver = {
-	.attach_adapter = example_attach_adapter,
-	.detach_client	= example_detach,
 }

Add the probe and remove methods to the i2c_driver, as so:

 static struct i2c_driver example_driver = {
+	.probe		= simtec_pmu_probe,
+	.remove		= simtec_pmu_remove,
 }

Change the example_attach method to accept the new parameters
which include the i2c_client that it will be working with:

- static int example_attach(struct i2c_adapter *adap, int addr, int kind)
+ static int example_probe(struct i2c_client *i2c_client,
+			   const struct i2c_device_id *id)

Note, we change the name of example_attach to example_probe to
align it with the i2c_driver entry names. The rest of the probe routine
will now need to be changed as the i2c_client has already been setup
for use.

Remove the  setting of address and adapter, they are now not needed.

-	example->i2c_client.addr    = addr;
-	example->i2c_client.flags   = 0;
-	example->i2c_client.adapter = adap;

Also remove the strlcpy, as the i2c_client's name is already filled
in by the caller.

-	strlcpy(client->i2c_client.name, example_driver.driver.name,
-		I2C_NAME_SIZE);

The call to i2c_attach_client is no longer needed, if the probe
routine exits succssfully, then the driver has been attached. Change
the probe routine as so:

-	ret = i2c_attach_client(&state->i2c_client);
-	if (ret < 0) {
-		dev_err(dev, "failed to attach client\n");
-		kfree(state);
-		return ret;
-	}


Remove the storage of  'struct i2c_client' from the 'struct example_state'
as we are provided with the i2c_client in our example_probe. Instead we
store a pointer to it for when it is needed.

struct example_state {
-	struct i2c_client	client;
+	struct i2c_client	*client;

In the probe routine, ensure that the new state has the client stored
in it.

static int example_probe(struct i2c_client *i2c_client,
			 const struct i2c_device_id *id)
{
	struct example_state *state;
	struct device *dev = &adap->dev;
	int ret;

	state = kzalloc(sizeof(struct example_state), GFP_KERNEL);
	if (state == NULL) {
		dev_err(dev, "failed to create our state\n");
		return -ENOMEM;
	}

+	state->client = i2c_client;

Update the remove method to delete the i2c_detach_client call.

static int example_remove(struct i2c_client *client)
{
	struct example_state *state = i2c_get_clientdata(client);

-	i2c_detach_client(client);

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
