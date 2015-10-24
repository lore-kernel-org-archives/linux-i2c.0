From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: ACPI I2C device-driver matching issue
Date: Sat, 24 Oct 2015 17:32:29 +0200
Message-ID: <2863037.enS8LjaQhU@vostro.rjw.lan>
References: <CAE7DoPbODXiUcsxMD1qRXCvX_o0evf6KsK2qu65g9uxnw5GNAw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <CAE7DoPbODXiUcsxMD1qRXCvX_o0evf6KsK2qu65g9uxnw5GNAw@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Ben Gardner <gardner.ben@gmail.com>
Cc: Linux I2C <linux-i2c@vger.kernel.org>, linux-acpi@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>
List-Id: linux-i2c@vger.kernel.org

CC: Mika

On Thursday, October 22, 2015 01:05:42 PM Ben Gardner wrote:
> Hi all,
> 
> I have a custom Baytrail board with a M24C02 EEPROM attached to I2C bus 3.
> I am using coreboot/SeaBIOS, so I have complete control over the ACPI tables.
> I am using Linux 4.2.3.
> 
> I have defined a EEPROM device on I2C3 using I2cSerialBus() and it
> shows up as expected.
> 
> Scope (\_SB.PCI0.I2C3) {
>   Device (EEP0) {
>     Name (_CID, Package() { "24c02" })
>     Name (_CRS, ResourceTemplate () {
>       I2cSerialBus (0x0057, ControllerInitiated, 400000,
>         AddressingMode7Bit, "\\_SB.PCI0.I2C3", 0x00,
>         ResourceConsumer,,)
>     })
>   }
> }
> 
> Everything is nearly working, except that acpi_i2c_add_device() is
> using the ACPI name to match the driver, which is "24C02:00".
> The "at42" driver supports the device with the "24c02" alias.
> i2c_match_id() in i2c-core.c uses strcmp() to match the device.
> That obviously doesn't match, as "24c02" != "24C02:00".
> 
> When I modified acpi_i2c_add_device() to truncate at the colon and
> convert it to lower case, it matches and works.
> 
> 
> What is the right way to declare a I2C device in ACPI so that it
> matches existing drivers?
> 
> 
> For reference only, I included the change I made to get it to work below.
> (Copy/pasted into gmail, so tabs are lost.)
> 
> Thanks,
> Ben Gardner
> 
> diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
> index c83e4d1..64caddc 100644
> --- a/drivers/i2c/i2c-core.c
> +++ b/drivers/i2c/i2c-core.c
> @@ -144,7 +144,13 @@ static acpi_status
> acpi_i2c_add_device(acpi_handle handle, u32 level,
>                 return AE_OK;
> 
>         adev->power.flags.ignore_parent = true;
> -       strlcpy(info.type, dev_name(&adev->dev), sizeof(info.type));
> +       {
> +               const char *dn = dev_name(&adev->dev);
> +               int idx;
> +               for (idx = 0; idx < sizeof(info.type) - 1 && dn[idx]
> && dn[idx] != ':'; idx++)
> +                       info.type[idx] = tolower(dn[idx]);
> +       }
>         if (!i2c_new_device(adapter, &info)) {
>                 adev->power.flags.ignore_parent = false;
>                 dev_err(&adapter->dev,
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
