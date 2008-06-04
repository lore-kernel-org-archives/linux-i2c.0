From: "Jon Smirl" <jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 0/4] i2c: Introduce i2c listeners
Date: Wed, 4 Jun 2008 19:11:11 -0400
Message-ID: <9e4733910806041611l41832e07p4f55424be0ef5ea0@mail.gmail.com>
References: <20080604201334.19636f30@hyperion.delvare>
	<9e4733910806041155n7551ac74lf29c8a32163ec09a@mail.gmail.com>
	<9e4733910806041228i330e145q439d3ee43494f4c4@mail.gmail.com>
	<20080604233335.13459512@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080604233335.13459512-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
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
Cc: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>, Linux I2C <i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On 6/4/08, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org> wrote:
> On Wed, 4 Jun 2008 15:28:54 -0400, Jon Smirl wrote:
>  > On 6/4/08, Jon Smirl <jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>  > > On 6/4/08, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org> wrote:
>  > >  > Hi all,
>  > >  >
>  > >  >  This patch set demonstrates a new concept which I would like to add to
>  > >  >  the i2c subsystem. It is named "i2c listeners" and is based on the
>  > >  >  following structure:
>  >
>  > Could the existing API be used something like this?
>  >
>  > Drivers register with i2c core using standard driver registration.
>  > Class and address ranges are exposed in a structure like PCI IDs. I2C
>  > can make up it's own ID structure equivalent to the PCI IDs one.
>
>
> No, no, no. I've been repeating it many times already: I2C device
>  addresses are NOT IDs. If you're even thinking of going in this
>  direction, you're plain wrong, sorry. Many devices share the same
>  address, and many devices can use different addresses. The address is
>  really only one attribute of an I2C device, amongst many others. It's
>  not an identifier.

I know these aren't identifiers, I'm proposing that they be ranges of
address to scan. The driver model doesn't force these to be IDs, but
in most cases they are IDs. To the driver model it's just a pointer to
a struct, no interpretation is done of the structure. It's the PCI bus
driver that interprets these structs as identifiers. In our case the
bus driver is inside i2c core and it interprets the structs as address
ranges and then calls the probe function sequentially with the
different value.

I shouldn't have compared this to PCI IDs, I was just thinking of it
as data that gets processed by i2c core. PCI IDs are an example of
data that is processed by the PCI core. Their meaning as ids is
supplied by PCI core, not the kernel driver framework.

>  Please also realize that we _do_ have "IDs" for I2C devices by now. As
>  there are no standard numbers as PCI has, we use arbitrary strings
>  (typically the device name). That's what new-style drivers use for
>  device binding since kernel 2.6.26. And you can't have more than one ID
>  format for a given subsystem, and we don't want to break new-style
>  drivers, so thinking about a radically different form of IDs for the
>  i2c subsystem is a waste of time: it's simply not going to happen.
>
>
>  > When a new adapter/bus is created i2c core gets the event. Core then
>
>
> Side question: why would i2c-core want events when adapters are
>  created, given that it does create them itself?

I used 'event' as a generic term for meaning the driver core was aware
that the adapter was created.

>  > scans the registered driver structures looking for class matches. When
>  > a match is encountered it repeatedly calls the driver's probe function
>  > with the addresses from the range. Driver returns true/false on each
>  > probe which triggers creation of the device.
>
>
> The driver's probe function is, by definition of the device driver
>  model, called on an existing device. So the probe function cannot
>  decide whether the device should be created or not - it's too late at
>  this point.

I don't believe this is has to be true although usually it is. A
driver is passed in information from the bus core on the probe
function. It then looks at that information and decides if it wants to
bind. Drivers return true/false if they want to bind. If they return
false the device structure is destroyed (or reused for the next probe
call).

There is nothing in the model that requires an actual device to be
present for a probe call to happen. A perfectly valid reason for
refusing to bind would be not having hardware present at the address.
This is how older ISA drivers are loaded that predate PNP. They search
for the hardware in the probe function. That's probably why it is
called "probe" but that predates my involvement in Linux.

>  One thing that we could consider though is merging i2c_listener into
>  i2c_driver. For some reason I had not considered it - but I somehow
>  expect funny locking issues if we do that.

We are not far apart on this proposal if you combine the
class/address_data fields into i2c_driver and then use the existing
probe function instead of detect(). The i2c_client struct already has
an address field. A driver would then check to see if there was
hardware at the i2c_client.address and return false if it is not
there. i2c core would just reuse the i2c_client struct with the next
address and do another probe.

Operations on an adapter need to be serialized but I thought the
adapters already supported that. If they don't they need to be fixed
anyway because of the BKL removal.

>
>
>  > Why do drivers need the bus creation (attach/detach adapter) events?
>
>
> Originally, to probe the adapters in search of devices to support. I
>  seem to remember that some V4L/DVB drivers do more than that in their
>  attach_adapter callback, but I need to take a closer look. And i2c-dev
>  deserves particular attention, as it needs to do bookkeeping of all
>  the adapters that are present. In fact we might have to implement
>  attach/detach adapter just for i2c-dev. More on that after I have read
>  the code again.

I don't think believe devices should need attach/detach adapter
functions. If they do, there is probably some other way to achieve the
same effect without needing the functions. i2c-dev may need access to
some i2c core structures to avoid the need for these calls.

-- 
Jon Smirl
jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
