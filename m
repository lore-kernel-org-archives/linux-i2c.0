From: Ben Gardner <gardner.ben@gmail.com>
Subject: ACPI I2C device-driver matching issue
Date: Thu, 22 Oct 2015 13:05:42 -0500
Message-ID: <CAE7DoPbODXiUcsxMD1qRXCvX_o0evf6KsK2qu65g9uxnw5GNAw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-io0-f171.google.com ([209.85.223.171]:34740 "EHLO
	mail-io0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754935AbbJVSFm (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Thu, 22 Oct 2015 14:05:42 -0400
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Linux I2C <linux-i2c@vger.kernel.org>
Cc: linux-acpi@vger.kernel.org

Hi all,

I have a custom Baytrail board with a M24C02 EEPROM attached to I2C bus 3.
I am using coreboot/SeaBIOS, so I have complete control over the ACPI tables.
I am using Linux 4.2.3.

I have defined a EEPROM device on I2C3 using I2cSerialBus() and it
shows up as expected.

Scope (\_SB.PCI0.I2C3) {
  Device (EEP0) {
    Name (_CID, Package() { "24c02" })
    Name (_CRS, ResourceTemplate () {
      I2cSerialBus (0x0057, ControllerInitiated, 400000,
        AddressingMode7Bit, "\\_SB.PCI0.I2C3", 0x00,
        ResourceConsumer,,)
    })
  }
}

Everything is nearly working, except that acpi_i2c_add_device() is
using the ACPI name to match the driver, which is "24C02:00".
The "at42" driver supports the device with the "24c02" alias.
i2c_match_id() in i2c-core.c uses strcmp() to match the device.
That obviously doesn't match, as "24c02" != "24C02:00".

When I modified acpi_i2c_add_device() to truncate at the colon and
convert it to lower case, it matches and works.


What is the right way to declare a I2C device in ACPI so that it
matches existing drivers?


For reference only, I included the change I made to get it to work below.
(Copy/pasted into gmail, so tabs are lost.)

Thanks,
Ben Gardner

diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index c83e4d1..64caddc 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -144,7 +144,13 @@ static acpi_status
acpi_i2c_add_device(acpi_handle handle, u32 level,
                return AE_OK;

        adev->power.flags.ignore_parent = true;
-       strlcpy(info.type, dev_name(&adev->dev), sizeof(info.type));
+       {
+               const char *dn = dev_name(&adev->dev);
+               int idx;
+               for (idx = 0; idx < sizeof(info.type) - 1 && dn[idx]
&& dn[idx] != ':'; idx++)
+                       info.type[idx] = tolower(dn[idx]);
+       }
        if (!i2c_new_device(adapter, &info)) {
                adev->power.flags.ignore_parent = false;
                dev_err(&adapter->dev,
