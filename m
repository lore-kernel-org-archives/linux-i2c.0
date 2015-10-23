From: Dustin Byford <dustin@cumulusnetworks.com>
Subject: [PATCH v5 0/2] i2c: acpi: scan ACPI enumerated I2C mux channels
Date: Fri, 23 Oct 2015 12:27:05 -0700
Message-ID: <1445628427-29244-1-git-send-email-dustin@cumulusnetworks.com>
References: <1439510358-16664-1-git-send-email-dustin@cumulusnetworks.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1439510358-16664-1-git-send-email-dustin@cumulusnetworks.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, Mika Westerberg <mika.westerberg@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Jean Delvare <jdelvare@suse.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, rjw@rjwysocki.net
Cc: linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, "Puustinen, Ismo" <ismo.puustinen@intel.com>
List-Id: linux-i2c@vger.kernel.org

v5:
- rebased on i2c/for-next (Jarkko, Wolfram)
- include acpi.h in designware drivers (Mika)
- remove return from void stub function (Mika)
- add acks and tested-by from Mika

v4:
- Moved the acpi_preset_companion() stub to a separate patch.
- Moved ACPI companion set from i2c-core to i801, ismt, and designware
  drivers.  With a minor rearrangement it was much easier to verify the
  drivers are all consistent (hopefully a little extra churn is warranted)

v3:
- Correct to and cc list (sorry git-send-email trouble again)

v2:
- Drop duplicate patch already submitted by Andy Shevchenko (i2c / ACPI:
  Rework I2C device scanning)
- Whitespace cleanup suggested by Mika
- Implement a acpi_preset_companion() stub for when CONFIG_ACPI is not set.
- Instead of special casing I2C muxes with regards to enumerating client
  devices, make sure adap->dev always has an ACPI companion.

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

Thanks,

		--Dustin

Dustin Byford (2):
  acpi: add acpi_preset_companion() stub
  i2c: add ACPI support for I2C mux ports

 Documentation/acpi/i2c-muxes.txt            | 58 +++++++++++++++++++++++++++++
 drivers/i2c/busses/i2c-designware-pcidrv.c  |  2 +
 drivers/i2c/busses/i2c-designware-platdrv.c |  1 +
 drivers/i2c/busses/i2c-i801.c               |  9 ++---
 drivers/i2c/busses/i2c-ismt.c               |  8 +---
 drivers/i2c/i2c-core.c                      |  4 +-
 drivers/i2c/i2c-mux.c                       |  8 ++++
 include/linux/acpi.h                        |  5 +++
 8 files changed, 81 insertions(+), 14 deletions(-)
 create mode 100644 Documentation/acpi/i2c-muxes.txt

-- 
2.1.4
