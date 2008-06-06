From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH 0/4] i2c: Add detection capability to new-style drivers
Date: Fri, 6 Jun 2008 14:52:12 +0200
Message-ID: <20080606145212.76f95d52@hyperion.delvare>
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

This is an update of the patch set named "i2c: Introduce i2c listeners"
which I posted 2 days ago. The only change if that the detect callback
is no longer in a separate i2c_listener structure, but instead is added
to struct i2c_driver (for new-style drivers only.) This makes things
much more simple.

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
  and the legacy driver. This is very visible in patches 3/4 and 4/4,
  which remove 50 lines of code per driver.

I would appreciate feedback on both the concept and the implementation.
David, I am particularly interested in your feedback, of course.

Patch 1/4 implements the mechanism, then patches 2/4, 3/4 and 4/4
demonstrate its use in 3 hardware monitoring drivers (lm90, f75375s and
lm75, respectively.) The patches go on top of 2.6.26-rc4 with some
additional dependencies listed in each patch. Testers welcome!

-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
