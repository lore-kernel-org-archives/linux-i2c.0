From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH 0/4] i2c: Introduce i2c listeners
Date: Wed, 4 Jun 2008 17:10:59 -0700
Message-ID: <200806041710.59338.david-b@pacbell.net>
References: <20080604201334.19636f30@hyperion.delvare>
	<20080604233335.13459512@hyperion.delvare>
	<9e4733910806041611l41832e07p4f55424be0ef5ea0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <9e4733910806041611l41832e07p4f55424be0ef5ea0-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: Jon Smirl <jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Linux I2C <i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Wednesday 04 June 2008, Jon Smirl wrote:
> > The driver's probe function is, by definition of the device driver
> > model, called on an existing device. So the probe function cannot
> > decide whether the device should be created or not - it's too late at
> > this point.
> 
> I don't believe this is has to be true although usually it is. A

For driver model conformant subsystems, it's always true.


> driver is passed in information from the bus core on the probe
> function.

That is, a bus-specific struct wrapping a "struct device" instance.


> It then looks at that information and decides if it wants to 
> bind. Drivers return true/false if they want to bind.

Wrong.  The probe returns zero if it bound, else negative errno.
Those functions don't return booleans.


> If they return 
> false the device structure is destroyed (or reused for the next probe
> call).

No.  The struct device is not destroyed at that time for ANY
driver model code I've seen in Linux.  Destroying it would
prevent driver modules from binding to that device when they
get loaded later.

 
> There is nothing in the model that requires an actual device to be
> present for a probe call to happen.

Well, a "struct device" must be present, but there might not
be hardware backing it.  Each particular bus infrastructure
instantiates those structs in bus-specific ways.


> A perfectly valid reason for 
> refusing to bind would be not having hardware present at the address.

True.


> This is how older ISA drivers are loaded that predate PNP.

Depends somewhat on what flavor of PNP you mean too.


> They search 
> for the hardware in the probe function. That's probably why it is
> called "probe" but that predates my involvement in Linux.

And that legacy model is something that's getting removed
everywhere practical.  Such "legacy drivers" don't support
hotplugging or most of the other mechanisms defined by the
driver model, since they have the driver creating the
device structs (instead of bus infrastructure).

You're right that this is why the name probe() remains.
I prefer the bind()/unbind() names too.

- Dave

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
