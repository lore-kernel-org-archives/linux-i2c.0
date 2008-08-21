From: David Miller <davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>
Subject: [PATCH 0/6]: Infrastructure for Sparc PCF I2C support.
Date: Thu, 21 Aug 2008 02:43:13 -0700 (PDT)
Message-ID: <20080821.024313.48896997.davem@davemloft.net>
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
To: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


This series of patches implements versious pieces of infrastructure that
I need for a pcf8584 based I2C bus driver I've written.  It uses the
PCF algo code and works quite well for the few I2C devices I've tested
so far.

Once I work out some details with the powerpc folks wrt. sparc support
for the drivers/of/of_i2c.c code, I can post the i2c-sunpcf.c driver
itself for inclusion.

The first patch fixes the PCF callbacks so that the ->waitforpin()
method can get at the bus driver private information.  The only other
user of the PCF algo layer is an ISA driver, i2c-elektor, which only
supports a single device so this interface limitation was not noticed.

The second patch addresses a synchronization issue that exists on
sparc64 systems with I2C busses.  Often the system firwmare shares the
I2C bus with the running kernel, in order to implement writes to the
EEPROM on the motherboard.  Thus, when firmware properties are set,
that call into the firmware can program the same I2C bus.  In my
Sun pcf8584 driver I will take a mutex which is also taken by the firmware
call in question, to ensure that two entities don't try to program the
I2C bus at the same time.  From PCF algo's perspective, these are just
two hooks called around the entirety of pcf_xfer().

The third patch is a simple type fix in a debugging message of PCF algo.

The fourth patch allows a PCF algo bus driver to request that support
for SMBUS quick support not be advertised.  This will disable automatic
probing sequences done by some I2C client drivers.  We absolutely do not
want this on sparc systems, where the openfirmware device tree tells us
exactly where all I2C bus devices are located.

The fifth patch adds "bus" addressing to the I2C layer.  Some variants
of the Sun pcf8584 controllers support an auxiliary register that
allows selecting a completely different I2C bus segment.  In the openfirmware
device tree, I2C client device addresses indicate which bus the device
is on.  I strove to implement this in the simplest way possible, with
full transparent backwards and forwards compatibility, for both I2C
userspace and existing drivers.

The sixth and final patch adds bus addressing support to the PCF algo
code.

Signed-off-by: David S. Miller <davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
