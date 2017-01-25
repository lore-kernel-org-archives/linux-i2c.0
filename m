From: Andreas Klinger <ak-n176/SwNRljddJNmlsFzeA@public.gmane.org>
Subject: [PATCH v4 0/3] iio: distance: srf08: add IIO driver for us ranger
Date: Wed, 25 Jan 2017 20:06:09 +0100
Message-ID: <20170125190609.GA9246@andreas>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, knaack.h-Mmb7MZpHnFY@public.gmane.org, lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org, pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ktsai-GubuWUlQtMwciDkP5Hr2oA@public.gmane.org, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, trivial-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mranostay-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: ak-n176/SwNRljddJNmlsFzeA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

This patch series adds IIO driver support for srf08 ultrasonic ranger
devices.

The first patch add a trivial device tree binding for the device together
with a new vendor devantech.

The second patch is the IIO driver which in turn is using I2C to talk to
the device.

The third patch documents the added userspace ABI

Documentation about the sensor can be found here:

http://www.robot-electronics.co.uk/htm/srf08tech.html

Changes in v4:
Jonathan suggested to use the same units for the max_range attribute as
used for the distance raw value which is now changed in the driver. Thanks
for the review and detailed suggestions.

* Patch 2: "iio: distance: srf08: add IIO driver for us ranger"
  - changed units of max_range attribute to meter
  - changed max_range_available to print out min-, step- and max-value
    instead of each single value

* Patch 3: "iio: distance: srf08: add driver ABI documentation"
  - removed standard elements from documentation
  - changed documentation of max_range_available attribute

Changes in v3:
Thanks to the reviews of Jonathan, Rob and Lars.
Some changes to the driver were made:

* Patch 2: "iio: distance: srf08: add IIO driver for us ranger"
  - defaults values for sensitivity (gain) and max. range are set in
    probe()
  - while waiting for ultrasonic echo first wait as long as the physically
    measurement need as a function of the max. range and then wait in 
    smaller steps until the response can be read.
  - attributes are now called sensor_sensitivity instead of gain and
    sensor_max_range instead of range_mm
  - device-name is now "srf08"
  - config menu is now calles "Proximity and distance sensors" instead of a
    separate menu

* Patch 3: "iio: distance: srf08: add driver ABI documentation"
  - newly created to document the driver specific interfaces

Changes in v2:
Lots of updates thanks to Peters really fast review within 30 minutes 
after first submission of the driver.

* Patch 2: "iio: distance: srf08: add IIO driver for us ranger"
  - alphabetic order in Makefile
  - use of u8 while accessing registers 
  - avoid endianness problems with 16 bit values
  - missing return value checks
  - some explaining documentation added

Andreas Klinger (3):
  iio: distance: srf08: add trivial DT binding
  iio: distance: srf08: add IIO driver for us ranger
  iio: distance: srf08: add driver ABI documentation

 .../ABI/testing/sysfs-bus-iio-distance-srf08       |  22 ++
 .../devicetree/bindings/i2c/trivial-devices.txt    |   1 +
 .../devicetree/bindings/vendor-prefixes.txt        |   1 +
 drivers/iio/proximity/Kconfig                      |  13 +-
 drivers/iio/proximity/Makefile                     |   1 +
 drivers/iio/proximity/srf08.c                      | 398 +++++++++++++++++++++
 6 files changed, 435 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-distance-srf08
 create mode 100644 drivers/iio/proximity/srf08.c

-- 
2.1.4
