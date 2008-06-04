From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH 0/4] i2c: Introduce i2c listeners
Date: Wed, 4 Jun 2008 23:33:35 +0200
Message-ID: <20080604233335.13459512@hyperion.delvare>
References: <20080604201334.19636f30@hyperion.delvare>
	<9e4733910806041155n7551ac74lf29c8a32163ec09a@mail.gmail.com>
	<9e4733910806041228i330e145q439d3ee43494f4c4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <9e4733910806041228i330e145q439d3ee43494f4c4-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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

On Wed, 4 Jun 2008 15:28:54 -0400, Jon Smirl wrote:
> On 6/4/08, Jon Smirl <jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> > On 6/4/08, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org> wrote:
> >  > Hi all,
> >  >
> >  >  This patch set demonstrates a new concept which I would like to add to
> >  >  the i2c subsystem. It is named "i2c listeners" and is based on the
> >  >  following structure:
> 
> Could the existing API be used something like this?
> 
> Drivers register with i2c core using standard driver registration.
> Class and address ranges are exposed in a structure like PCI IDs. I2C
> can make up it's own ID structure equivalent to the PCI IDs one.

No, no, no. I've been repeating it many times already: I2C device
addresses are NOT IDs. If you're even thinking of going in this
direction, you're plain wrong, sorry. Many devices share the same
address, and many devices can use different addresses. The address is
really only one attribute of an I2C device, amongst many others. It's
not an identifier.

Please also realize that we _do_ have "IDs" for I2C devices by now. As
there are no standard numbers as PCI has, we use arbitrary strings
(typically the device name). That's what new-style drivers use for
device binding since kernel 2.6.26. And you can't have more than one ID
format for a given subsystem, and we don't want to break new-style
drivers, so thinking about a radically different form of IDs for the
i2c subsystem is a waste of time: it's simply not going to happen.

> When a new adapter/bus is created i2c core gets the event. Core then

Side question: why would i2c-core want events when adapters are
created, given that it does create them itself?

> scans the registered driver structures looking for class matches. When
> a match is encountered it repeatedly calls the driver's probe function
> with the addresses from the range. Driver returns true/false on each
> probe which triggers creation of the device.

The driver's probe function is, by definition of the device driver
model, called on an existing device. So the probe function cannot
decide whether the device should be created or not - it's too late at
this point.

One thing that we could consider though is merging i2c_listener into
i2c_driver. For some reason I had not considered it - but I somehow
expect funny locking issues if we do that.

> Why do drivers need the bus creation (attach/detach adapter) events?

Originally, to probe the adapters in search of devices to support. I
seem to remember that some V4L/DVB drivers do more than that in their
attach_adapter callback, but I need to take a closer look. And i2c-dev
deserves particular attention, as it needs to do bookkeeping of all
the adapters that are present. In fact we might have to implement
attach/detach adapter just for i2c-dev. More on that after I have read
the code again.

-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
