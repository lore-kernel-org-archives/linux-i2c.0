From: Dustin Byford <dustin-qUQiAmfTcIp+XZJcv9eMoEEOCMrvLtNR@public.gmane.org>
Subject: [RFC PATCH 0/1] i2c: scan ACPI enumerated I2C mux channels
Date: Thu, 13 Aug 2015 16:59:17 -0700
Message-ID: <1439510358-16664-1-git-send-email-dustin@cumulusnetworks.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


I would like to add support for scanning I2C devices connected to ACPI
OF compatible muxes described in ASL like this:

Device (MUX0)
{
    Name (_ADR, 0x70)
    Name (_HID, "PRP0001")
    Name (_CRS, ResourceTemplate()
    {
        I2cSerialBus (0x70, ControllerInitiated, I2C_SPEED,
                      AddressingMode7Bit, "^^SMB2", 0x00,
                      ResourceConsumer,,)
    })
    Name (_DSD, Package ()
    {
        ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
        Package () {
            Package (2) { "compatible", "nxp,pca9548" },
        }
    })

    // MUX channels
    Device (CH00) { Name (_ADR, 0x0) }
}

Scope(MUX0.CH00)
{
    Device (TMP0) {
        /* Temp sensor ASL, for example. */
    }
}

It seems like a reasonable way to describe a common I2C component and
kernel support is almost there.

I had to:

1) Find and set an ACPI companion for the "virtual" I2C adapters created
   for each mux channel.

2) Make sure to scan adap.dev when registering devices under each mux
   channel.

At first, I was confused about why adap.dev->parent is used in
acpi_i2c_register_devices().  I found b34bb1ee from 4/2013 (ACPI / I2C:
Use parent's ACPI_HANDLE()), which offers an explanation.

This patch works well, but I'm not sure about the code to just fall back
to using adap.dev when adap.dev->parent doesn't have an ACPI companion.
Is there a more explicit check I can make to determine if the adapter
represents a mux channel?

Any feedback would be welcome.  Thanks,

   --Dustin

Dustin Byford (1):
  i2c: acpi: scan ACPI enumerated I2C mux channels

 drivers/i2c/i2c-core.c | 10 ++++++++++
 drivers/i2c/i2c-mux.c  |  8 ++++++++
 2 files changed, 18 insertions(+)

-- 
2.1.4
