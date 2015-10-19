From: Dustin Byford <dustin@cumulusnetworks.com>
Subject: [PATCH v2 0/1] i2c: acpi: scan ACPI enumerated I2C mux channels
Date: Mon, 19 Oct 2015 02:01:51 -0700
Message-ID: <1445245312-6816-1-git-send-email-dustin@cumulusnetworks.com>
References: <1439510358-16664-1-git-send-email-dustin@cumulusnetworks.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-pa0-f54.google.com ([209.85.220.54]:35977 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751819AbbJSJCN (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Mon, 19 Oct 2015 05:02:13 -0400
Received: by pacfv9 with SMTP id fv9so89561417pac.3
        for <linux-i2c@vger.kernel.org>; Mon, 19 Oct 2015 02:02:12 -0700 (PDT)
In-Reply-To: <1439510358-16664-1-git-send-email-dustin@cumulusnetworks.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, rjw@rjwysocki.net, andriy.shevchenko@linux.intel.com

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
 drivers/i2c/i2c-core.c           | 14 ++++++++--
 drivers/i2c/i2c-mux.c            |  8 ++++++
 include/linux/acpi.h             |  6 +++++
 4 files changed, 84 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/acpi/i2c-muxes.txt

-- 
2.1.4
