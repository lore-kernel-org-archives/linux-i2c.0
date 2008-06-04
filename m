From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH 0/4] i2c: Introduce i2c listeners
Date: Wed, 4 Jun 2008 20:13:34 +0200
Message-ID: <20080604201334.19636f30@hyperion.delvare>
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

This patch set demonstrates a new concept which I would like to add to
the i2c subsystem. It is named "i2c listeners" and is based on the
following structure:

/**
 * struct i2c_listener - Be informed of adapter addition and removal
 * @class: What kind of i2c device the listener may instantiate
 * @attach_adapter: Called after adapter addition (unimplemented)
 * @detach_adapter: Called before adapter removal (unimplemented)
 * @address_data: The I2C addresses to probe, ignore or force
 * @detect: Callback for device detection
 * @clients: List of detected clients we created
 *
 * The @detect callback returns an i2c_board_info structure for device
 * creation if the detection was successful, NULL otherwise.
 *
 * The @clients list is handled by i2c-core.
 */
struct i2c_listener {
	unsigned int class;

	int (*attach_adapter)(struct i2c_adapter *);
	int (*detach_adapter)(struct i2c_adapter *);

	const struct i2c_client_address_data *address_data;
	int (*detect)(struct i2c_adapter *, int address, int kind,
		      struct i2c_board_info *);
	struct list_head clients;

	struct list_head list;
};

The goal is to replace legacy i2c drivers. The functional differences
between legacy drivers and new-style ones are that legacy drivers get
notified when i2c adapters are created or deleted, they create their
own devices, and they can probe the hardware before they do so. There
are cases where we want to be able to do this (e.g. for hardware
monitoring devices on PC motherboards) so we can't just switch to
new-style everywhere. Still, legacy drivers are a pain to handle, they
cause headaches to developers because their locking model is weird, and
they duplicate a lot of code.

By implementing the needed functionality, almost unchanged, outside of
the drivers, my hope is to be able to convert all legacy drivers to
new-style drivers in a matter of months. Without it, it would take
years... or even never happen at all.

There are two distinct parts in i2c_listener: the notification
callbacks, and the device detection callback. The notification
callbacks are exactly the same as what legacy i2c drivers already have.
I did not implement them yet, as I have no immediate need for them, but
I suspect I will have to for the V4L/DVB drivers (if not I'll just
remove them.) The device detection part is implemented in patch 1/4.

The mechanism behind the device detection callback is as follows:
* When a new i2c_notifier is added, for each existing i2c_adapter,
  address_data (those format is the same as what i2c_probe() is already
  using for legacy drivers) is processed by i2c-core. For each relevant
  address, the detect callback will be called, with a pointer to an
  empty struct i2c_board_info address as the last parameter. The detect
  callback will attempt to detect a supported device at the given
  address, and if successful, it will fill the struct i2c_board_info
  with the parameters required to instantiate a new-style i2c device.
* When a new i2c_adapter is added, for each existing i2c_notifier, the
  same happens.
* When it gets a filled struct i2c_board_info from a detect callback,
  i2c-core will instantiate it. If a new-style driver exists for the
  device, it will be able to bind with the device.
* We keep track of the devices created that way, in a per-listener list.
* When an i2c_listener is removed, all devices that originate from it
  are destroyed.
* When an i2c_adapter is removed, all devices on it that were created
  by an i2c_listener are destroyed.

So, drivers which currently implement both a new-style i2c_driver and a
legacy i2c_driver (or drivers which would be converted that way soon) can
instead implement a new-style i2c_driver and an i2c_listener. There are
two major advantages in doing so:
* All i2c drivers become new-style drivers. We get rid of legacy
  drivers altogether, allowing for long awaited cleanups in i2c-core.
* The code needed in each driver to implement an i2c_listener is way
  smaller than the code needed to implement a legacy driver, even when
  we were sharing as much code as possible between the new-style driver
  and the legacy driver. This is very visible in patches 3/4 and 4/4,
  which remove ~35 lines of code per driver.

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
