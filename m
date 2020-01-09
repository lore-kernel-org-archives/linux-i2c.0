From: Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: [PATCH v3 0/5] Support running driver's probe for a device powered off
Date: Thu,  9 Jan 2020 17:45:24 +0200
Message-ID: <20200109154529.19484-1-sakari.ailus@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>, "Rafael J. Wysocki" <rafael@kernel.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, rajmohan.mani@intel.com, Tomasz Figa <tfiga@chromium.org>
List-Id: linux-i2c@vger.kernel.org

Hi all,

These patches enable calling (and finishing) a driver's probe function
without powering on the respective device on busses where the practice is
to power on the device for probe. While it generally is a driver's job to
check the that the device is there, there are cases where it might be
undesirable. (In this case it stems from a combination of hardware design
and user expectations; see below.) The downside with this change is that
if there is something wrong with the device, it will only be found at the
time the device is used. In this case (the camera sensors + EEPROM in a
sensor) I don't see any tangible harm from that though.

An indication both from the driver and the firmware is required to allow
the device's power state to remain off during probe (see the first patch).


The use case is such that there is a privacy LED next to an integrated
user-facing laptop camera, and this LED is there to signal the user that
the camera is recording a video or capturing images. That LED also happens
to be wired to one of the power supplies of the camera, so whenever you
power on the camera, the LED will be lit, whether images are captured from
the camera --- or not. There's no way to implement this differently
without additional software control (allowing of which is itself a
hardware design decision) on most CSI-2-connected camera sensors as they
simply have no pin to signal the camera streaming state.

This is also what happens during driver probe: the camera will be powered
on by the I²C subsystem calling dev_pm_domain_attach() and the device is
already powered on when the driver's own probe function is called. To the
user this visible during the boot process as a blink of the privacy LED,
suggesting that the camera is recording without the user having used an
application to do that. From the end user's point of view the behaviour is
not expected and for someone unfamiliar with internal workings of a
computer surely seems quite suspicious --- even if images are not being
actually captured.

v2 can be found here:

<URL:https://patchwork.kernel.org/cover/11114255/>

since v2:

- Remove extra CONFIG_PM ifdefs; these are not needed.

- Move the checks for power state hints from drivers/base/dd.c to
  drivers/i2c/i2c-base-core.c; these are I²C devices anyway.

- Move the probe_low_power field from struct device_driver to struct
  i2c_driver.

since v1:

- Rename probe_powered_off struct device field as probe_low_power and
  reflect the similar naming to the patches overall.

- Work with CONFIG_PM disabled, too.

Rajmohan Mani (1):
  media: i2c: imx319: Support probe while the device is off

Sakari Ailus (4):
  i2c: Allow driver to manage the device's power state during probe
  ACPI: Add a convenience function to tell a device is suspended in
    probe
  ov5670: Support probe whilst the device is in a low power state
  at24: Support probing while off

 drivers/acpi/device_pm.c    | 35 +++++++++++++++++++++++++++++++++++
 drivers/i2c/i2c-core-base.c | 15 ++++++++++++---
 drivers/media/i2c/imx319.c  | 23 ++++++++++++++---------
 drivers/media/i2c/ov5670.c  | 23 ++++++++++++++---------
 drivers/misc/eeprom/at24.c  | 31 +++++++++++++++++++++----------
 include/linux/acpi.h        |  5 +++++
 include/linux/i2c.h         |  3 +++
 7 files changed, 104 insertions(+), 31 deletions(-)

-- 
2.20.1
