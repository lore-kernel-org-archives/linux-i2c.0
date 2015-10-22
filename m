From: Dustin Byford <dustin@cumulusnetworks.com>
Subject: [PATCH v4 0/2] i2c: acpi: scan ACPI enumerated I2C mux channels
Date: Thu, 22 Oct 2015 02:17:40 -0700
Message-ID: <1445505462-27915-1-git-send-email-dustin@cumulusnetworks.com>
References: <1439510358-16664-1-git-send-email-dustin@cumulusnetworks.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-pa0-f48.google.com ([209.85.220.48]:35161 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964999AbbJVJSF (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Thu, 22 Oct 2015 05:18:05 -0400
Received: by pasz6 with SMTP id z6so82089988pas.2
        for <linux-i2c@vger.kernel.org>; Thu, 22 Oct 2015 02:18:00 -0700 (PDT)
In-Reply-To: <1439510358-16664-1-git-send-email-dustin@cumulusnetworks.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, Mika Westerberg <mika.westerberg@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Jean Delvare <jdelvare@suse.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, rjw@rjwysocki.net, "Puustinen, Ismo" <ismo.puustinen@intel.com>

The following series adds support for describing ACPI enumerated I2C mux
ports like this (added as Documentation/acpi/i2c-muxes.txt):

+------+   +------+
| SMB1 |-->| MUX0 |--CH00--> i2c client A (0x50)
|      |   | 0x70 |--CH01--> i2c client B (0x50)
+------+   +------+

Device (SMB1)
{
    Name (_HID, ...)
    Device (MUX0)
    {
        Name (_HID, ...)
        Name (_CRS, ResourceTemplate () {
            I2cSerialBus (0x70, ControllerInitiated, I2C_SPEED,
                          AddressingMode7Bit, "^SMB1", 0x00,
                          ResourceConsumer,,)
        }

        Device (CH00)
        {
            Name (_ADR, 0)

            Device (CLIA)
            {
                Name (_HID, ...)
                Name (_CRS, ResourceTemplate () {
                    I2cSerialBus (0x50, ControllerInitiated, I2C_SPEED,
                                  AddressingMode7Bit, "^CH00", 0x00,
                                  ResourceConsumer,,)
                }
            }
        }

        Device (CH01)
        {
            Name (_ADR, 1)

            Device (CLIB)
            {
                Name (_HID, ...)
                Name (_CRS, ResourceTemplate () {
                    I2cSerialBus (0x50, ControllerInitiated, I2C_SPEED,
                                  AddressingMode7Bit, "^CH01", 0x00,
                                  ResourceConsumer,,)
                }
            }
        }
    }
}

v4:
- Moved the acpi_preset_companion() stub to a separate patch.
- Moved ACPI companion set from i2c-core to i801, ismt, and designware
  drivers.  With a minor rearrangement it was much easier to verify the
  drivers are all consistent (hopefully a little extra churn is warranted)

I was able to test i801 and ismt myself, but I could use some help making
sure the designware driver is OK since I don't have the hardware.

v3:
- Correct to and cc list (sorry git-send-email trouble again)

v2:
- Drop duplicate patch already submitted by Andy Shevchenko (i2c / ACPI:
  Rework I2C device scanning)
- Whitespace cleanup suggested by Mika
- Implement a acpi_preset_companion() stub for when CONFIG_ACPI is not set.
- Instead of special casing I2C muxes with regards to enumerating client
  devices, make sure adap->dev always has an ACPI companion.

I based this on linux-pm/bleeding-edge, but now it depends on Andy's change
(i2c / ACPI: Rework I2C device scanning) and I don't know where the rest of
his patch set is going.  Let me know if there's a more appropriate branch
and I'll be happy to rebase.

Thanks,

		--Dustin

Dustin Byford (2):
  acpi: add acpi_preset_companion() stub
  i2c: add ACPI support for I2C mux ports

 Documentation/acpi/i2c-muxes.txt            | 58 +++++++++++++++++++++++++++++
 drivers/i2c/busses/i2c-designware-pcidrv.c  |  1 +
 drivers/i2c/busses/i2c-designware-platdrv.c |  6 ++-
 drivers/i2c/busses/i2c-i801.c               |  9 ++---
 drivers/i2c/busses/i2c-ismt.c               |  8 +---
 drivers/i2c/i2c-core.c                      |  4 +-
 drivers/i2c/i2c-mux.c                       |  8 ++++
 include/linux/acpi.h                        |  6 +++
 8 files changed, 84 insertions(+), 16 deletions(-)
 create mode 100644 Documentation/acpi/i2c-muxes.txt

-- 
2.1.4
