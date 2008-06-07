From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH 0/4] i2c: Add detection capability to new-style
 drivers
Date: Sat, 7 Jun 2008 09:35:15 +0200
Message-ID: <20080607093515.3eecca4c@hyperion.delvare>
References: <20080606145212.76f95d52@hyperion.delvare>
	<Pine.LNX.4.58.0806061550510.10290@shell4.speakeasy.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <Pine.LNX.4.58.0806061550510.10290-13q4cmjDBaTP3RPoUHIrnuTW4wlIGRCZ@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Trent Piepho <xyzzy-zY4eFNvK5D+xbKUeIHjxjQ@public.gmane.org>
Cc: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>, Linux I2C <i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Trent,

On Fri, 6 Jun 2008 16:17:03 -0700 (PDT), Trent Piepho wrote:
> On Fri, 6 Jun 2008, Jean Delvare wrote:
> > The mechanism behind the device detection callback is as follows:
> > * When a new-style i2c_driver is added, for each existing i2c_adapter,
> >   address_data (those format is the same as what i2c_probe() is already
> >   using for legacy drivers) is processed by i2c-core. For each relevant
> >   address, the detect callback will be called, with a pointer to an
> >   empty struct i2c_board_info address as the last parameter. The detect
> >   callback will attempt to identify a supported device at the given
> >   address, and if successful, it will fill the struct i2c_board_info
> >   with the parameters required to instantiate a new-style i2c device.
> 
> Isn't the detect callback going to be the same for almost every driver?

Depends on what you call "the same". Basically every detect callback
will check whether the underlying adapter supports all the bus
transactions they need, then read many register values and compare what
it gets with well-known (device and driver specific) values, and from
there it will decide if it recognized a device it supports, and what
device that is.

However, each driver will read different register values, and compare
them to different constants. Just look at the detect callbacks of the
lm90, f75375s and lm75 drivers which I have posted, you'll see that the
code is very different. That's definitely not something we easily can
put in data structures and let i2c-core operate on.

One thing that pretty much all detect function will have in common is
the allocation of a fake i2c_client structure, to be able to use
i2c_smbus_read_*() functions. I am not totally satisfied with the
current implementation, because allocating a temporary structure
dynamically for every detect call looks inefficient. But having it on
the stack isn't an option, it's too large.

We could have i2c-core allocate it once and for all (detections are
serialized anyway) and pass it to the detect callbacks, but I a am bit
reluctant to make the existence of this fake i2c_client official,
because it looks like a hack.

The alternatives I can think of are:
* Calling i2c_smbus_xfer directly - but this will result in even more
  code duplication in the detect callbacks.
* Duplicating i2c_smbus_read_byte_data() and i2c_smbus_read_word_data()
  (the only callbacks which I expect to be used in a detect callback)
  with new prototypes which do not involve i2c_client. This might
  however become confusing for the driver authors.

None of these solutions make me totally happy, but I guess that the
most reasonable one is the second one (have i2c-core allocate
i2c_client and pass it to detect callbacks.) Maybe if we document
properly that the only thing one is allowed to do with this i2c_client
is call i2c_smbus_read_byte_data() and i2c_smbus_read_word_data(), it's
acceptable. I welcome comments and ideas on this problem.

> It seems like you could have the i2c core do the detection.  Take the "to
> be probed" addresses listed by the driver, do a standard i2c probe on them,

If by "standard i2c probe" you mean issuing an SMBus quick command to
verify if a device is present at all, that's already the case.

> and pass a device to the driver's probe function if something is detected.
> The probe function is of course free to return ENODEV if it has some
> additional way to check for device presence.  If an address is on the force
> list, then the device is created and passed to the driver's probe without
> the core doing any kind of i2c probe.  The driver can do a non-standard
> probe if it has one and return ENODEV if nothing is there.

I've said it several times before and I'll repeat it until everybody
gets it: 1* probe can't be called before the i2c device is created with
a name, and the i2c device can't get its name (in the context of device
auto-detection) before it has been detected, and 2* returning -ENODEV
in a probe function does NOT destroy the device, so we cannot use this
mechanism to validate the creation of a detected device.

So, no, calling probe directly before calling detect, cannot work,
unless you diverge from the standard device driver model once again (but
David will kill you, and I'll help him!)

> > * When a new i2c_adapter is added, for each existing new-style
> >   i2c_driver, the same happens.
> 
> It would nice if there was a no-probe option when creating an i2c_adapter.

This is the default. Probing (actually, detecting) only happens from
drivers which share a class bit with the i2c_adapter. If an i2c_adapter
doesn't define any class then it never gets probed. This is a
significant improvement compared to the previous situation where the
class check was left to the legacy drivers, and not all of them were
checking properly.

> > * When it gets a filled struct i2c_board_info from a detect callback,
> >   i2c-core will instantiate it. If a new-style driver exists for the
> >   device, it will be able to bind with the device.
> > * We keep track of the devices created that way, in a per-driver list.
> > * When a new-style i2c_driver is removed, all devices that originate
> >   from it are destroyed.
> 
> Is it necessary to remove the devices?  They are still there after all.
> It's perfectly normal to have devices with no drivers loaded for them on
> other busses.

What if I the auto-detection fails and and I want to unload and reload
the driver with the proper force parameter? If the devices aren't
destroyed by the driver which created them, then only a reboot will let
me do that. Not good.

Anyway, I don't think it is generally acceptable to have a situation
which is different before and after loading and unloading a driver.
Drivers should always clean up after themselves, as much as possible
and reasonable.

> > * When an i2c_adapter is removed, all devices on it that were created
> >   as the result of calling a detect callback, are destroyed.
> 
> Shouldn't all devices on it, no matter how they were created, be removed?
> Or is that the case?

Yes it is the case. But we must remove the references to them from all
i2c_driver client lists (otherwise we will access i2c_client structs
which have been already freed) so we already have to walk these lists.
Removing the devices at this point is cheap. And I tend to think it's
cleaner to destroy the devices in the same way they were created. But
I'm not insisting, we can remove the call to i2c_unregister_device()
from i2c_do_del_adapter() is you and others feel it's redundant.

Thanks,
-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
