From: Dustin Byford <dustin@cumulusnetworks.com>
Subject: [PATCH v3 0/1] i2c: acpi: scan ACPI enumerated I2C mux channels
Date: Mon, 19 Oct 2015 15:28:59 -0700
Message-ID: <1445293740-28537-1-git-send-email-dustin@cumulusnetworks.com>
References: <1439510358-16664-1-git-send-email-dustin@cumulusnetworks.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1439510358-16664-1-git-send-email-dustin@cumulusnetworks.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, rjw@rjwysocki.net, andriy.shevchenko@linux.intel.com
List-Id: linux-i2c@vger.kernel.org

The following patch adds support for describing ACPI enumerated I2C mux ports
like this (added as Documentation/acpi/i2c-muxes.txt):

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

Dustin Byford (1):
  i2c: add ACPI support for I2C mux ports

 Documentation/acpi/i2c-muxes.txt | 58 ++++++++++++++++++++++++++++++++++++++++
 drivers/i2c/i2c-core.c           | 15 +++++++++--
 drivers/i2c/i2c-mux.c            |  8 ++++++
 include/linux/acpi.h             |  6 +++++
 4 files changed, 85 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/acpi/i2c-muxes.txt

-- 
2.1.4

