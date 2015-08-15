From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [RFC v2 0/1] i2c: acpi: scan ACPI enumerated I2C mux channels
Date: Sat, 15 Aug 2015 22:22:32 +0200
Message-ID: <20150815202229.GA3463@katana>
References: <1439510358-16664-1-git-send-email-dustin@cumulusnetworks.com>
 <1439580693-5538-1-git-send-email-dustin@cumulusnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1439580693-5538-1-git-send-email-dustin@cumulusnetworks.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Dustin Byford <dustin@cumulusnetworks.com>, Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, rjw@rjwysocki.net, linux-acpi@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Fri, Aug 14, 2015 at 12:31:32PM -0700, Dustin Byford wrote:
> 
> (v2 corrects cc: list)

And adding Mika to the cc-list who is our I2C and ACPI expert.
Mika can you have a look at this and the other patches Dustin sent
recently to the i2c list?

Thanks,

   Wolfram

> 
> I would like to add support for scanning I2C devices connected to ACPI
> OF compatible muxes described in ASL like this:
> 
> Device (MUX0)
> {
>     Name (_ADR, 0x70)
>     Name (_HID, "PRP0001")
>     Name (_CRS, ResourceTemplate()
>     {
>         I2cSerialBus (0x70, ControllerInitiated, I2C_SPEED,
>                       AddressingMode7Bit, "^^SMB2", 0x00,
>                       ResourceConsumer,,)
>     })
>     Name (_DSD, Package ()
>     {
>         ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
>         Package () {
>             Package (2) { "compatible", "nxp,pca9548" },
>         }
>     })
> 
>     // MUX channels
>     Device (CH00) { Name (_ADR, 0x0) }
> }
> 
> Scope(MUX0.CH00)
> {
>     Device (TMP0) {
>         /* Temp sensor ASL, for example. */
>     }
> }
> 
> It seems like a reasonable way to describe a common I2C component and
> kernel support is almost there.
> 
> I had to:
> 
> 1) Find and set an ACPI companion for the "virtual" I2C adapters created
>    for each mux channel.
> 
> 2) Make sure to scan adap.dev when registering devices under each mux
>    channel.
> 
> At first, I was confused about why adap.dev->parent is used in
> acpi_i2c_register_devices().  I found b34bb1ee from 4/2013 (ACPI / I2C:
> Use parent's ACPI_HANDLE()), which offers an explanation.
> 
> This patch works well, but I'm not sure about the code to just fall back
> to using adap.dev when adap.dev->parent doesn't have an ACPI companion.
> Is there a more explicit check I can make to determine if the adapter
> represents a mux channel?
> 
> Any feedback would be welcome.  Thanks,
> 
>    --Dustin
> 
> Dustin Byford (1):
>   i2c: acpi: scan ACPI enumerated I2C mux channels
> 
>  drivers/i2c/i2c-core.c | 10 ++++++++++
>  drivers/i2c/i2c-mux.c  |  8 ++++++++
>  2 files changed, 18 insertions(+)
> 
> -- 
> 2.1.4
> 
