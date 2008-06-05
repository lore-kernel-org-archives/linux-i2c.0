From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH 0/4] i2c: Introduce i2c listeners
Date: Thu, 5 Jun 2008 10:49:14 +0200
Message-ID: <20080605104914.2dd622b2@hyperion.delvare>
References: <20080604201334.19636f30@hyperion.delvare>
	<200806041710.59338.david-b@pacbell.net>
	<9e4733910806041742va67401en608c8c4b8c4c11b9@mail.gmail.com>
	<200806041921.26293.david-b@pacbell.net>
	<9e4733910806042104l70cf8a30sc6329b1c3016c879@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <9e4733910806042104l70cf8a30sc6329b1c3016c879-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
Cc: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>, Linux I2C <i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Thu, 5 Jun 2008 00:04:00 -0400, Jon Smirl wrote:
> I don't think it is out of the scope of what already exists. The
> alternative is to add a new pre-probe() API which does the function of
> the original probe and then calls the current probe(). Why don't we
> just stick with probe() and use it like it was before we had things
> like ACPI?

You're thinking of probing the wrong way around, methinks. We want to
add something _before_ the current probe function, not after it. Adding
the actual hardware detection/identification after the driver model's
probe() implies that a device has already been created
(otherwise .probe() can't be called). Chicken and egg problem.

> Now that we've had this discussion it looks to me that the scan
> capability should be added to struct i2c_driver instead of being
> standalone.

After a good night of sleep I've reached the same conclusion. Given
that many drivers would have a new-style i2c driver and an i2c
listener, it's probably easier to merge both. I'll give it a try when I
get time, but as stated elsewhere in this thread, I wouldn't be too
surprised to hit a deadlock or two on the road.

> I guess what is a little strange to me is that the pre-probe()
> function is like a static driver function and probe() is an instance
> function. Are there other examples of static driver  functions? Which
> way you do it is a style question, they will both work.

I guess it depends on what you mean with a "static function" and
"instance function" for a non-object language ;) Put it simple terms,
the hardware detection function has to operate on addresses (i.e.
potential devices) while the device driver model's probe function
operates on actual devices. I fully agree with David that this function
should really be named .bind(), not .probe().

> Doesn't something like this work? (obviously this isn't complete)
> 
> for (address = start; address <= stop;) {
> 	make a new client
> 	for (; address <=stop; address++) {
> 		client->address = address;
> 		res = device_register(&client->dev);
> 		if (res != -ENODEV)
> 			break;
> 	}
> }
> delete the extra client

You don't seriously propose to scan all addresses on every I2C bus for
every i2c chip driver that we load, do you? This would be awfully slow
and dangerous. No way.

> Can these driver functions be eliminated?
> 	int (*attach_adapter)(struct i2c_adapter *);
> 	int (*detach_adapter)(struct i2c_adapter *);
> 	int (*detach_client)(struct i2c_client *);

This is exactly my goal with i2c_notifier (or any similar approach -
again I'm not claiming my proposal is the only way to go). Sorry if it
wasn't clear, maybe I should have mentioned it explicitly in patch 0/4.

-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
