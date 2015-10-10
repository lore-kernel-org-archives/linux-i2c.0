From: Dustin Byford <dustin@cumulusnetworks.com>
Subject: [PATCH 0/2] i2c: acpi: scan ACPI enumerated I2C mux channels
Date: Fri,  9 Oct 2015 17:41:45 -0700
Message-ID: <1444437707-19027-1-git-send-email-dustin@cumulusnetworks.com>
References: <1439580693-5538-1-git-send-email-dustin@cumulusnetworks.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1439580693-5538-1-git-send-email-dustin@cumulusnetworks.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, rjw@rjwysocki.net
List-Id: linux-i2c@vger.kernel.org

Two patches ready from my RFC.  The first, from Mika scans more of the ACPI
namespace looking for I2C connections.  It's not strictly a dependency of
the other patch but they are easy to review together.  I was able to test
this by overriding my DSDT and moving I2C resource macros around in the
device hierarchy.

The next adds support for describing I2C mux ports like this (added as
Documentation/acpi/i2c-muxes.txt):

+------+   +------+
| SMB1 |-->| MUX0 |--CH00--> i2c client A (0x50)
|      |   | 0x70 |--CH01--> i2c client B (0x50)
+------+   +------+

Device(SMB1)
{
    Name (_HID, ...)
    Device(MUX0)
    {
        Name (_HID, ...)
        Name (_CRS, ResourceTemplate () {
            I2cSerialBus (0x70, ControllerInitiated, I2C_SPEED,
                          AddressingMode7Bit, "^SMB1", 0x00,
                          ResourceConsumer,,)
        }

        Device(CH00)
        {
            Name (_ADR, 0)

            Device(CLIA)
            {
                Name (_HID, ...)
                Name (_CRS, ResourceTemplate () {
                    I2cSerialBus (0x50, ControllerInitiated, I2C_SPEED,
                                  AddressingMode7Bit, "^CH00", 0x00,
                                  ResourceConsumer,,)
                }
            }
        }

        Device(CH01)
        {
            Name (_ADR, 1)

            Device(CLIB)
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

Dustin Byford (2):
  i2c: scan entire ACPI namespace for I2C connections
  i2c: add ACPI support for I2C mux ports

 Documentation/acpi/i2c-muxes.txt | 58 +++++++++++++++++++++++++
 drivers/i2c/i2c-core.c           | 94 ++++++++++++++++++++++++++++++----------
 drivers/i2c/i2c-mux.c            |  8 ++++
 3 files changed, 138 insertions(+), 22 deletions(-)
 create mode 100644 Documentation/acpi/i2c-muxes.txt

-- 
2.1.4
