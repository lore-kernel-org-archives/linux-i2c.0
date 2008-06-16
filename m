From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH 0/5] i2c: Add detection capability to new-style drivers
Date: Mon, 16 Jun 2008 22:12:57 +0200
Message-ID: <20080616221257.446a2145@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Linux I2C <i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
Cc: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi all,

This is an update of a patch set I posted 10 days ago. The main change
if that the detect callback is handed a dummy i2c_client structure
which can be used to call i2c_smbus_read_byte_data and friends. Almost
all detect callbacks will want to use one of these functions, and it's
more efficient to have i2c-core allocate and initialize this structure,
than have each callback do it on its own. This update also includes
better documentation, a few cleanups here and there, and one more
converted driver (eeprom).

This patch set is now part of my i2c tree, except for the changes to
the lm75 driver, which I can't easily include because they go on top of
patches which currently live in another tree. I want to push these
changes in kernel 2.6.27, and in order to do this safely, it needs to
get more testing. That's what linux-next is for.

* * * * *

The goal is to replace legacy i2c drivers. The functional differences
between legacy drivers and new-style ones are that legacy drivers get
notified when i2c adapters are created or deleted, they create their
own devices, and they can probe the hardware before they do so. There
are cases where we want to be able to do this (e.g. for hardware
monitoring devices on PC motherboards) so we can't just switch to
new-style everywhere. Still, legacy drivers are a pain to handle, they
cause headaches to developers because their locking model is weird, and
they duplicate a lot of code.

By implementing the needed functionality, almost unchanged, in a way
which is compatible with the new i2c device/driver binding model, my
hope is to be able to convert all legacy drivers to new-style drivers
in a matter of months. Without it, it would take years... or even never
happen at all. This patch set attempts to cover the device detection
part. The notification of additional/removal of adapters will be dealt
with later.

The mechanism behind the device detection callback is as follows:
* When a new-style i2c_driver is added, for each existing i2c_adapter,
  address_data (those format is the same as what i2c_probe() is already
  using for legacy drivers) is processed by i2c-core. For each relevant
  address, the detect callback will be called, with a pointer to an
  empty struct i2c_board_info address as the last parameter. The detect
  callback will attempt to identify a supported device at the given
  address, and if successful, it will fill the struct i2c_board_info
  with the parameters required to instantiate a new-style i2c device.
* When a new i2c_adapter is added, for each existing new-style
  i2c_driver, the same happens.
* When it gets a filled struct i2c_board_info from a detect callback,
  i2c-core will instantiate it. If a new-style driver exists for the
  device, it will be able to bind with the device.
* We keep track of the devices created that way, in a per-driver list.
* When a new-style i2c_driver is removed, all devices that originate
  from it are destroyed.
* When an i2c_adapter is removed, all devices on it that were created
  as the result of calling a detect callback, are destroyed.

So, drivers which currently implement both a new-style i2c_driver and a
legacy i2c_driver (or drivers which would be converted that way soon) can
instead implement a detect callback in their new-style i2c_driver.
There are two major advantages in doing so:
* All i2c drivers become new-style drivers. We get rid of legacy
  drivers altogether, allowing for long awaited cleanups in i2c-core.
* The code needed in each driver to implement a detect callback is way
  smaller than the code needed to implement a legacy driver, even when
  we were sharing as much code as possible between the new-style driver
  and the legacy driver. This is very visible in patches 3/5 and 4/5,
  which remove 65 lines of code per driver.

I would appreciate feedback on both the concept and the implementation.
David, I am particularly interested in your feedback, of course.

Patch 1/5 implements the mechanism, then patches 2/5, 3/5, 4/5 and 5/5
demonstrate its use in 3 hardware monitoring drivers (lm90, f75375s and
lm75) and the eeprom driver. The patches go on top of 2.6.26-rc6-git3
with additional dependencies listed in each patch. Testers welcome! For
testing, it's probably easier to just pick my i2c tree at:
  http://khali.linux-fr.org/devel/linux-2.6/
so that you don't have to deal with the various dependencies. Except
for the lm75 driver, for which you still have to download and apply
the patches individually.

Thanks,
-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
