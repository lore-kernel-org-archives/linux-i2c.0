From: Andrew Armenia <andrew-Lwj1yN59in/Ib2jZbfQ/kQ@public.gmane.org>
Subject: Re: [PATCH 3/3] i2c-piix4: support AMD auxiliary SMBus controller
Date: Fri, 15 Jun 2012 09:43:40 -0400
Message-ID: <CA+jCKRVsMNf7Yj7fP4c6+4ff__v5qsea7rYYqHv25XFBi8v9yg@mail.gmail.com>
References: <20120613094739.360967aa@endymion.delvare> <1339606749-4578-1-git-send-email-andrew@asquaredlabs.com>
 <1339606749-4578-4-git-send-email-andrew@asquaredlabs.com> <20120615103153.3ea7c009@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120615103153.3ea7c009-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Fri, Jun 15, 2012 at 4:31 AM, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org> wrot=
e:
> Hi Andrew,
>
> For next time... When you post or repost a patch series, please alway=
s
> start a new discussion thread (don't use Reply), otherwise discussion
> threading becomes very hard to follow, both in e-mail clients and
> online list archives.
>
> On Wed, 13 Jun 2012 12:59:09 -0400, Andrew Armenia wrote:
>> Some AMD chipsets, such as the SP5100, have an auxiliary SMBus
>> controller with a second set of registers. This patch adds
>> support for this auxiliary controller.
>>
>> Tested on ASUS KCMA-D8 motherboard.
>>
>> Signed-off-by: Andrew Armenia <andrew-Lwj1yN59in/Ib2jZbfQ/kQ@public.gmane.org>
>> ---
>> =A0Documentation/i2c/busses/i2c-piix4 | =A0 13 +++++--
>> =A0drivers/i2c/busses/Kconfig =A0 =A0 =A0 =A0 | =A0 =A06 +++-
>> =A0drivers/i2c/busses/i2c-piix4.c =A0 =A0 | =A0 69 +++++++++++++++++=
+++++++++++++++++--
>> =A03 files changed, 82 insertions(+), 6 deletions(-)
>
> A few issues remaining in this patch:
>
>> diff --git a/Documentation/i2c/busses/i2c-piix4 b/Documentation/i2c/=
busses/i2c-piix4
>> index 475bb4a..474779e 100644
>> --- a/Documentation/i2c/busses/i2c-piix4
>> +++ b/Documentation/i2c/busses/i2c-piix4
>> @@ -8,12 +8,17 @@ Supported adapters:
>> =A0 =A0 =A0Datasheet: Only available via NDA from ServerWorks
>> =A0 =A0* ATI IXP200, IXP300, IXP400, SB600, SB700 and SB800 southbri=
dges
>> =A0 =A0 =A0Datasheet: Not publicly available
>> + =A0 =A0SB700 register reference available at:
>> + =A0 =A0http://support.amd.com/us/Embedded_TechDocs/43009_sb7xx_rrg=
_pub_1.00.pdf
>> + =A0* AMD SP5100 (SB700 derivative found on some server mainboards)
>> + =A0 =A0Datasheet: Publicly available at the AMD website
>> + =A0 =A0http://support.amd.com/us/Embedded_TechDocs/44413.pdf
>> =A0 =A0* AMD Hudson-2
>> =A0 =A0 =A0Datasheet: Not publicly available
>> =A0 =A0* Standard Microsystems (SMSC) SLC90E66 (Victory66) southbrid=
ge
>> =A0 =A0 =A0Datasheet: Publicly available at the SMSC website http://=
www.smsc.com
>>
>> -Authors:
>> +Authors:
>
> Never include white-space changes in a non-cleanup patch, they make
> review and backporting harder.
>
>> =A0 =A0 =A0 Frodo Looijaard <frodol-B0qZmFHriGg@public.gmane.org>
>> =A0 =A0 =A0 Philip Edelbrock <phil-KXOFo5pg7o1l57MIdRCFDg@public.gmane.org>
>>
>> @@ -32,7 +37,7 @@ Description
>>
>> =A0The PIIX4 (properly known as the 82371AB) is an Intel chip with a=
 lot of
>> =A0functionality. Among other things, it implements the PCI bus. One=
 of its
>> -minor functions is implementing a System Management Bus. This is a =
true
>> +minor functions is implementing a System Management Bus. This is a =
true
>> =A0SMBus - you can not access it on I2C levels. The good news is tha=
t it
>> =A0natively understands SMBus commands and you do not have to worry =
about
>> =A0timing problems. The bad news is that non-SMBus devices connected=
 to it can
>> @@ -68,6 +73,10 @@ this driver on those mainboards.
>> =A0The ServerWorks Southbridges, the Intel 440MX, and the Victory66 =
are
>> =A0identical to the PIIX4 in I2C/SMBus support.
>>
>> +The AMD SB700 and SP5100 chipsets implement two PIIX4-compatible SM=
Bus
>> +controllers. If your BIOS initializes the secondary controller, it =
will
>> +be detected by this driver as an "Auxiliary SMBus Host Controller".
>> +
>> =A0If you own Force CPCI735 motherboard or other OSB4 based systems =
you may need
>> =A0to change the SMBus Interrupt Select register so the SMBus contro=
ller uses
>> =A0the SMI mode.
>> diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
>> index 7244c8b..2e7530a 100644
>> --- a/drivers/i2c/busses/Kconfig
>> +++ b/drivers/i2c/busses/Kconfig
>> @@ -133,7 +133,7 @@ config I2C_PIIX4
>> =A0 =A0 =A0 =A0 =A0 ATI IXP300
>> =A0 =A0 =A0 =A0 =A0 ATI IXP400
>> =A0 =A0 =A0 =A0 =A0 ATI SB600
>> - =A0 =A0 =A0 =A0 ATI SB700
>> + =A0 =A0 =A0 =A0 ATI SB700/SP5100
>> =A0 =A0 =A0 =A0 =A0 ATI SB800
>> =A0 =A0 =A0 =A0 =A0 AMD Hudson-2
>> =A0 =A0 =A0 =A0 =A0 Serverworks OSB4
>> @@ -143,6 +143,10 @@ config I2C_PIIX4
>> =A0 =A0 =A0 =A0 =A0 Serverworks HT-1100
>> =A0 =A0 =A0 =A0 =A0 SMSC Victory66
>>
>> + =A0 =A0 =A0 Some AMD chipsets contain two PIIX4-compatible SMBus
>> + =A0 =A0 =A0 controllers. This driver will attempt to use both cont=
rollers
>> + =A0 =A0 =A0 on the SB700/SP5100, if they have been initialized by =
the BIOS.
>> +
>> =A0 =A0 =A0 =A0 This driver can also be built as a module. =A0If so,=
 the module
>> =A0 =A0 =A0 =A0 will be called i2c-piix4.
>>
>> diff --git a/drivers/i2c/busses/i2c-piix4.c b/drivers/i2c/busses/i2c=
-piix4.c
>> index 8181963..85d3db9 100644
>> --- a/drivers/i2c/busses/i2c-piix4.c
>> +++ b/drivers/i2c/busses/i2c-piix4.c
>> @@ -21,11 +21,12 @@
>> =A0 =A0 Supports:
>> =A0 =A0 =A0 Intel PIIX4, 440MX
>> =A0 =A0 =A0 Serverworks OSB4, CSB5, CSB6, HT-1000, HT-1100
>> - =A0 =A0 ATI IXP200, IXP300, IXP400, SB600, SB700, SB800
>> + =A0 =A0 ATI IXP200, IXP300, IXP400, SB600, SB700/SP5100, SB800
>> =A0 =A0 =A0 AMD Hudson-2
>> =A0 =A0 =A0 SMSC Victory66
>>
>> - =A0 Note: we assume there can only be one device, with one SMBus i=
nterface.
>> + =A0 Note: we assume there can only be one device, with one or more
>> + =A0 SMBus interfaces.
>> =A0*/
>>
>> =A0#include <linux/module.h>
>> @@ -60,6 +61,7 @@
>> =A0#define SMBIOSIZE =A0 =A08
>>
>> =A0/* PCI Address Constants */
>> +#define SMBAUXBA =A0 =A0 0x058
>
> AFAICS this is SB700-specific, so this should either be clarified in
> the name, or maybe we don't even want a name. After all, register
> offset is hard-coded in piix4_setup_sb800.
>
>> =A0#define SMBBA =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x090
>> =A0#define SMBHSTCFG =A0 =A00x0D2
>> =A0#define SMBSLVC =A0 =A0 =A0 =A0 =A0 =A0 =A00x0D3
>> @@ -293,6 +295,43 @@ static int __devinit piix4_setup_sb800(struct p=
ci_dev *PIIX4_dev,
>> =A0 =A0 =A0 return piix4_smba;
>> =A0}
>>
>> +static int __devinit piix4_setup_aux(struct pci_dev *PIIX4_dev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 const stru=
ct pci_device_id *id,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned s=
hort base_reg_addr)
>> +{
>> + =A0 =A0 /* Set up auxiliary SMBus controllers found on some
>> + =A0 =A0 =A0* AMD chipsets e.g. SP5100 (SB700 derivative) */
>> +
>> + =A0 =A0 unsigned short piix4_smba;
>> +
>> + =A0 =A0 /* Read address of auxiliary SMBus controller */
>> + =A0 =A0 pci_read_config_word(PIIX4_dev, base_reg_addr, &piix4_smba=
);
>> + =A0 =A0 piix4_smba &=3D 0xffe0;
>
> You must check bit 0 first. You want the I/O base to be set AND
> decoding thereof enabled, otherwise the controller can't be used.
>
> Also, mask 0xffe0 is OK for the SB700 but not for the SB600 which onl=
y
> has bits 3:1 marked as reserved. Given that reserved bits are suppose=
d
> to be 0 anyway, I think it is OK to mask with 0xfff0 always.
>
>> +
>> + =A0 =A0 if (piix4_smba =3D=3D 0) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(&PIIX4_dev->dev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "Auxiliary SMBus base addr=
ess uninitialized");
>
> Missing trailing new line.
>
>> +
>
> Needless blank line.
>
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -ENODEV;
>> + =A0 =A0 }
>> +
>
>> + =A0 =A0 if (acpi_check_region(piix4_smba, SMBIOSIZE, piix4_driver.=
name))
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -ENODEV;
>> +
>> + =A0 =A0 if (!request_region(piix4_smba, SMBIOSIZE, piix4_driver.na=
me)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&PIIX4_dev->dev, "Auxiliary SMBus =
region 0x%x "
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "already in use!\n", piix4=
_smba);
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -EBUSY;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 dev_info(&PIIX4_dev->dev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 "Auxiliary SMBus Host Controller at 0x%x\n=
",
>> + =A0 =A0 =A0 =A0 =A0 =A0 piix4_smba
>> + =A0 =A0 );
>
> Undesirable line break.
>
>> +
>> + =A0 =A0 return piix4_smba;
>> +}
>> +
>> =A0static int piix4_transaction(struct i2c_adapter *piix4_adapter)
>> =A0{
>> =A0 =A0 =A0 int temp;
>> @@ -504,6 +543,7 @@ static DEFINE_PCI_DEVICE_TABLE(piix4_ids) =3D {
>> =A0MODULE_DEVICE_TABLE (pci, piix4_ids);
>>
>> =A0static struct i2c_adapter *piix4_main_adapter;
>> +static struct i2c_adapter *piix4_aux_adapter;
>>
>> =A0static int __devinit piix4_add_adapter(struct pci_dev *dev,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 unsigned short smba,
>> @@ -565,10 +605,28 @@ static int __devinit piix4_probe(struct pci_de=
v *dev,
>> =A0 =A0 =A0 else
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 retval =3D piix4_setup(dev, id);
>>
>> + =A0 =A0 /* if no main SMBus found, give up */
>> =A0 =A0 =A0 if (retval < 0)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return retval;
>>
>> - =A0 =A0 return piix4_add_adapter(dev, retval, &piix4_main_adapter)=
;
>> + =A0 =A0 /* try to register main SMBus adapter, give up if we can't=
 */
>> + =A0 =A0 retval =3D piix4_add_adapter(dev, retval, &piix4_main_adap=
ter);
>> + =A0 =A0 if (retval < 0)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return retval;
>> +
>> + =A0 =A0 /* check for auxiliary SMBus on some AMD chipsets */
>> + =A0 =A0 if (dev->vendor =3D=3D PCI_VENDOR_ID_ATI &&
>> + =A0 =A0 =A0 =A0 dev->device =3D=3D PCI_DEVICE_ID_ATI_SBX00_SMBUS &=
&
>> + =A0 =A0 =A0 =A0 dev->revision < 0x40) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 retval =3D piix4_setup_aux(dev, id, SMBAUX=
BA);
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (retval > 0) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* try to add the aux adap=
ter if it exists,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* piix4_add_adapter wil=
l clean up if this fails */
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 piix4_add_adapter(dev, ret=
val, &piix4_aux_adapter);
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 }
>> +
>> + =A0 =A0 return 0;
>> =A0}
>>
>> =A0static void __devinit piix4_adap_remove(struct i2c_adapter *adap)
>> @@ -590,6 +648,11 @@ static void __devexit piix4_remove(struct pci_d=
ev *dev)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 piix4_adap_remove(piix4_main_adapter);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 piix4_main_adapter =3D NULL;
>> =A0 =A0 =A0 }
>> +
>> + =A0 =A0 if (piix4_aux_adapter) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 piix4_adap_remove(piix4_aux_adapter);
>> + =A0 =A0 =A0 =A0 =A0 =A0 piix4_aux_adapter =3D NULL;
>> + =A0 =A0 }
>> =A0}
>>
>> =A0static struct pci_driver piix4_driver =3D {
>
> I've fixed them all, and applied your patch. The whole series with my
> changes incorporated is now visible at:
> http://khali.linux-fr.org/devel/linux-3/jdelvare-i2c/
>
> I would appreciate if you could test them and confirm I didn't break
> anything. Your patches will then be merged in kernel 3.6.
>
> Thanks,
> --
> Jean Delvare

I've just tested your updated patches and nothing seems broken. Thanks
for your patience with a first time submitter.

-Andrew
