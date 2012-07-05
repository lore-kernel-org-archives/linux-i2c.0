From: Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: Fwd: Hid over I2C and ACPI interaction
Date: Thu, 05 Jul 2012 15:20:05 +0800
Message-ID: <1341472805.1682.127.camel@rui.sh.intel.com>
References: <CAN+gG=GnMX8Gu6w9za2QrjoVrmORncFgq-+hhmHvxtOPEB=nDw@mail.gmail.com>
	 <4FF52C70.9010601@intel.com> <1341471717.1682.125.camel@rui.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1341471717.1682.125.camel-fuY85erJQUO75v1z/vFq2g@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: benjamin.tissoires-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, jkosina-AlSwsSmVLrQ@public.gmane.org, chatty-rXV5z7KbLFk@public.gmane.org, jj_ding-9cfG7bMpBgR9nmWX13WWKA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hah, seems I forgot to reply to Benjamin.

On =E5=9B=9B, 2012-07-05 at 15:01 +0800, Zhang Rui wrote:
> > -------- Original Message --------
> > Subject: Hid over I2C and ACPI interaction
> > Date: Wed, 4 Jul 2012 15:46:35 +0200
> > From: Benjamin Tissoires <benjamin.tissoires-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> > To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Ben Dooks <ben-linux@fluff.o=
rg>, Wolfram=20
> > Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Len Brown <lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,=20
> > <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,=20
> > <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
> > CC: Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>, St=C3=A9phane Chatty <chatty@ena=
c.fr>, JJ Ding=20
> > <jj_ding-9cfG7bMpBgR9nmWX13WWKA@public.gmane.org>
> >=20
> > Hi Guys,
> >=20
> > I'm the co-author and the maintainer of the hid-multitouch driver. =
To
> > support even more devices, I started the implementation of the HID
> > over I2C protocol specification which is introduced by Win8. I'm qu=
ite
> > comfortable with the hid and the I2C part, but I'm blocked with the
> > interaction with the ACPI for the pnp part.
> >=20
> > I wanted to have your advice/help on this problem. I've add in the
> > recipients list the maintainers of i2c and ACPI, sorry for the nois=
e
> > if you don't feel concerned about this.
> >=20
> > So, let's go deeper in the problem ;-)
> > Microsoft's spec asks the OEM to fill the ACPI DSDT to provide the
> > following scope in the ASL layout:
> >=20
> > >>>>>>>>> begin of ASL
> > Scope (\_SB) {
> > //--------------------
> > //  General Purpose I/O, ports 0...127
> > //--------------------
> >=20
> > Device(HIDI2C_DEVICE1) {
> >      Name(_ADR,0)
> >      Name (_HID, "MSFT1234=E2=80=9D)
> >      Name (_CID, "PNP0C50")
> >      Name (_UID, 3)
> >=20
> >      Method(_CRS, 0x0, NotSerialized)
> >      {
> >          Name (RBUF, ResourceTemplate ()
> >          {
> >          // Address 0x07 on I2C-X (OEM selects this address)
> >         //IHV SPECIFIC I2C3 =3D I2C Controller; TGD0 =3D GPIO Contr=
oller;
> >          I2CSerialBus (0x07, ControllerInitiated,
> > 100000,AddressingMode7Bit, "\\_SB.I2C3",,,,)
> >          GpioInt(Level, ActiveLow, Exclusive, PullUp, 0, "\\_SB. TG=
D0",
> > 0 , ResourceConsumer, , ) {40}
> >          })
> >       Return(RBUF)
> >       }
> >=20
> >       Method(_DSM, 0x4, NotSerialized)
> >       {
> >          // BreakPoint
> >          Store ("Method _DSM begin", Debug)
> >=20
> >          // DSM UUID
> >          switch(ToBuffer(Arg0))
> >          {	=09
> >              // ACPI DSM UUID for HIDI2C
> >              case(ToUUID("3CDFF6F7-4267-4555-AD05-B30A3D8938DE"))
> >              {
> >                   // DSM function which returns the HID Descriptor
> > Address (skipped)
> >              }
> >=20
> >              default
> >              {
> >                  // No other GUIDs supported
> >                  Return(Buffer(One) { 0x00 })
> >              }
> >          }
> >      }
> > }
> > <<<<<<<<< end of ASL
> >=20
> yep, this is an ACPI enumerated I2C controller.
>=20
> > Summary:
> > - a HID over I2C device has to present the Compatibility ID "PNP0C5=
0"
> > - in the _CRS block, the address, the adapter and the gpioInt are
> > defined (or referenced)
> > - it presents a Device Specific Method (_DSM) which returns the HID
> > Descriptor register address. This register is our entry point for
> > retrieving the information about our hid device (so it's mandatory =
to
> > obtain it).
> >=20
> > Where am I:
> > - I've written a first layer on top of i2c that retrieves the hid
> > register (currently the address 0x0001 is hardcoded), then get the
> > report desccriptors and the input events, and forward all this stuf=
f
> > to the hid layer.
> > - It's working with a custom emulated HID over i2c touchpad, while
> > waiting for the one a manufacturer should send to me.
> > - The detection and the addition to the adapter is done by adding t=
he
> > address in the lists and the name through the i2c "->detect" callba=
ck
> > (which is not very good, because I don't have the interrupt line
> > there).
> > - I've written a first acpi implementation that rely on the
> > DEVICE_ACPI_HANDLE macro to get the ACPI handle of the device (if
> > available).
> > - I'm not able to do some tests with the ACPI, as I don't know how =
to
> > implement this DSDT on my computer (I'm missing the I2C part), and =
the
> > manufacturer returned the mainboard with the right DSDT to the OEM.
> >=20
> > My questions:
> > - will the current acpi implementation handle I2C devices?
>=20
> you still need to write your own device driver for the device.
>=20
> > - it seems to me that the .archdata field is left blank during the =
i2c
> > device initialization in all paths I've seen. Is that true?
> > - who puts the name int the struct i2c_board_info? (for hot-plugged
> > i2c devices).
> >=20
> > - finally, what is the best way of handling ACPI for those I2C devi=
ces:
> >    1) everything is fine, I should have the ACPI handle in .archdat=
a.
> >    2) someone has to implement the handling of I2C in the pnpACPI l=
ayer
> > (by adding I2CSerialBus handling and creating there the i2c slave).
> >    3) I should create an acpi driver which handles "PNP0C50" and wh=
ich
> > creates the i2c slaves.
> >=20
> exactly.
>=20
> As this I2C controller uses the GPIO interrupt, we need an ACPI GPIO
> controller driver for interrupts first.
> I already have such a patch in hand, but have not release it for some
> reason.
> Second, you need to write your own PNP I2C controller driver, to
> enumerate the I2C controller via ACPI, AND enumerate the I2C slave
> devices under this controller to I2C bus. I also have a similar drive=
r
> for SPI controller and SD/MMC controller.
> Third, you need a I2C slave device driver to handle the I2C slave dev=
ice
> in I2C bus.
>=20
> here is a BKM I wrote, hope it helps.
>=20
> And also any comments are welcome. :)
>=20
> From 0a0fa4ff7b4b06c6560de94a78b15c6adfd86e34 Mon Sep 17 00:00:00 200=
1
> From: Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> Date: Mon, 26 Dec 2011 10:42:04 +0800
>=20
>  As many SoC IP blocks are not hardware self-enumerable, the
>  firmware, aka, ACPI tables, is responsible for
>  enumerating/reserving/assigning system resources to these
>  devices. This tutorial talks about how to enumerate these
>  devices via ACPI namespace.
>=20
> Signed-off-by: Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> ---
>  Documentation/acpi/acpi-device-probing.txt |  466
> ++++++++++++++++++++++++++++
>  1 file changed, 466 insertions(+)
>  create mode 100644 Documentation/acpi/acpi-device-probing.txt
>=20
> diff --git a/Documentation/acpi/acpi-device-probing.txt
> b/Documentation/acpi/acpi-device-probing.txt
> new file mode 100644
> index 0000000..82efbf3
> --- /dev/null
> +++ b/Documentation/acpi/acpi-device-probing.txt
> @@ -0,0 +1,466 @@
> +
> +HOWTO enumerate devices via ACPI
> +
> +Copyright (c) 2011-2012 Intel Corporation
> +
> +Contrast to hardware self-enumerable devices(e.g. USB, PCI) on PC
> platform,
> +many SoC IP blocks can not be self enumerated.
> +We used to introduce platform specific code for these devices.
> +But now, with ACPI 5.0, there is no requirement for the hardware to =
be
> +self-discoverable, enumerable or re-locatable, as the firmware is
> responsible
> +for enumerating/reserving/assigning system resources (such as addres=
s
> ranges or
> +interrupts) to the device.
> +
> +This document will show how to enumerate and configure a device via
> ACPI.
> +If you want to get more details about why and when we need this,
> +please refer to ACPI spec 5.0 and
> +Intel Architecture Platform Compatibility Definition.
> +
> +Note that although these are ACPI devices, we prefer to use PnP driv=
ers
> for them,
> +this is because:
> +1. all the non-ACPI-predefined Devices are exported as PnP devices a=
s
> well
> +2. PnP bus is a well designed bus. Probing via PnP layer saves a lot=
 of
> work
> +   for the device driver, e.g. getting & parsing ACPI resources.
> +
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> +1. Understand device definition in ACPI namespace
> +   [Case study 1] SD/MMC controller
> +2. Driver for a leaf device
> +   2.1 Make a list of supported PnP ids
> +   2.2 Implement .probe/.remove callbacks for the PnP driver
> +   2.3 Fill in the pnp_driver structure
> +   2.4 Register the PnP driver
> +3. Driver for a master device on a non-self-enumerable bus
> +   [Case Study 2] SPI controller and its slave device
> +   3.1 Probe the master device
> +   3.2 Walk ACPI namesapce to get the child devices of the master
> device
> +   3.3 Register these child devices as slave devices
> +   3.4 Write slave device driver
> +4. Misc
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> +
> +--------------------------------------------------------------------=
---------
> +1. Understand device definition in ACPI namespace
> +--------------------------------------------------------------------=
---------
> +
> +To enumerate a device in ACPI namespace, we need to find out and
> understand
> +HOW the device is defined in ACPI namespace first.
> +
> +[Case study 1 ] SD/MMC Controller
> +
> +Here is an ASL example code for SD/MMC controller definition in ACPI
> namespace.
> +
> +        Device (EMMC)
> +        {
> +            Name (_ADR, Zero)
> +            /* I use PNPXXXX, an arbitrary string, here, as PnP id i=
s
> device specific */
> +            Name (_HID, "PNPXXXX")
> +            Name (_CID, "PNPXXXX")
> +            Name (_UID, 4)
> +
> +            Method (_CRS, 0, NotSerialized)
> +            {
> +                Name (RBUF, ResourceTemplate ()
> +                {
> +                    Memory32Fixed (ReadWrite,
> +                        0xFFA50000,         // Address Base
> +                        0x00000100,         // Address Length
> +                        )
> +                    Interrupt (ResourceConsumer, Level, ActiveLow,
> Exclusive, ,, )
> +                    {
> +                        0x0000001b,
> +                    }
> +                })
> +                Return (RBUF)
> +            }
> +
> +            Method (_STA, 0, NotSerialized)
> +            {
> +                Return (0x0F)
> +            }
> +        }
> +
> +_ADR : the address of this device on its parent bus. Useless in this
> case.
> +_HID : the PnP id for this device.
> +_CID : the compatible PnP id. use this as the PnP id if _HID doesn't
> exist.
> +_CRS : the system resources currently allocated to this device.
> +       the Memory32Fixed part shows an Mem space for the device,
> +       and the Interrupt part shows the device interrupt.
> +_STA : the current status of the device, e.g. it's
> enabled/disabled/removed.
> +
> +By reading this example ASL code, we should know that there is a SD/=
MMC
> controller
> +on this platform, it's mem space base address is 0xFFA50000, length =
is
> 0x00000100,
> +and the irq for this device is 0x1b.
> +
> +In Chapter 2, we will use this piece of ASL code as an example to
> +show how to probe the SD/MMC controller via ACPI namespace.
> +
> +--------------------------------------------------------------------=
---------
> +2 Driver for a leaf device
> +--------------------------------------------------------------------=
---------
> +
> +2.1 Make a list of supported pnp ids.
> +
> +Use the string in _HID or _CID objects as the PnP ids so that the
> device can
> +be attached to the driver successfully.
> +
> +In this case,
> +struct pnp_device_id sdhci_pnp_ids[] =3D {
> +        { .id =3D "PNPXXXX",
> +          .driver_data =3D (unsigned long)&sdhci_mfd_pdata },
> +        { },
> +};
> +
> +2.2 Implement the .probe and .remove callback of PnP driver.
> +
> +If you're not clear about what should be done in the driver, you can
> consult
> +some similar driver, for example, drivers/mmc/host/sdhci-pci.c shows
> how
> +to probe a PCI SD/MMC controller, this helps us understand what shou=
ld
> be done
> +in the .probe/.remove callback.
> +
> +By reading the sdhci-pci .probe function, we know that the .probe
> callback
> +needs to
> +a) alloc a sdhci host.
> +b) fill the sdhci host structure with necessary resources got from
> +   PCI configure space, including irq and mem space for the sdhci ho=
st.
> +c) register the sdhci host.
> +And then, driver/mmc/host/sdhci.c, the SDHCI interface driver will
> handle
> +everything for us.
> +
> +So, basically, we need to do the same work in sdhci_pnp_probe callba=
ck,
> +except that we need to get the information from ACPI namesapce inste=
ad.
> +
> +To get the resources in _CRS, we do not need Linux ACPICA APIs as Pn=
P
> layer
> +has done this for us already.
> +
> +pnp_irq() returns the device irq, which equals the "Interrupt" part =
in
> _CRS method.
> +pnp_get_resource(, IORESOURCE_MEM, 0) returns the first Mem space ba=
se
> address
> +and length of this device, which equals the "Memory32Fixed" Part of =
the
> _CRS.
> +
> +the code below shows how to use the PnP APIs to get ACPI resources a=
nd
> +register a sdhci host in the .probe callback.
> +
> +static int __devinit
> +sdhci_pnp_probe(struct pnp_dev *pdev, const struct pnp_device_id
> *dev_id)
> +{
> +...
> +	pnp_disable_dev(pdev);
> +	ret =3D pnp_activate_dev(pdev);
> +...
> +	iomem =3D pnp_get_resource(pdev, IORESOURCE_MEM, 0);
> +...
> +	host =3D sdhci_alloc_host(&pdev->dev, sizeof(struct sdhci_pnp_dev))=
;
> +...
> +	host->irq =3D pnp_irq(pdev, 0);
> +...
> +        if (!request_mem_region(iomem->start, resource_size(iomem),
> +                        mmc_hostname(host->mmc))) {
> +...
> +        host->ioaddr =3D ioremap_nocache(iomem->start,
> resource_size(iomem));
> +...
> +	ret =3D sdhci_add_host(host);
> +...
> +	pnp_set_drvdata(pdev, sdhci);
> +...
> +}
> +
> +Once the .probe callback is done, we just need to release the resour=
ces
> and
> +unregister the host in the .remove callback.
> +
> +static void sdhci_pnp_remove(struct pnp_dev * pdev)
> +{
> +	struct sdhci_pnp_dev *sdhci =3D pnp_get_drvdata(pdev);
> +	struct resources *iomem =3D pnp_get_resource(pdev, IORESOURCE_MEM, =
0);
> +...
> +	sdhci_remove_host(sdhci->host, dead);
> +	sdhci_free_host(sdhci->host);
> +	iounmap(sdhci->host->ioaddr);
> +	release_mem_region(iomem->start, resource_size(iomem));
> +	pnp_set_drvdata(pdev, NULL);
> +	pnp_disable_dev(pdev);
> +}
> +
> +2.3 Fill in the pnp_driver structure
> +
> +Next step is to fill in the pnp_driver structure with PnP ids and
> +.probe/.remove callbacks finished in section 2.1 and 2.2
> +
> +static struct pnp_driver sdhci_pnp_driver =3D {
> +        .name =3D         DRIVER_NAME,
> +        .id_table =3D     sdhci_pnp_ids,
> +        .probe =3D        sdhci_pnp_probe,
> +        .remove =3D       __devexit_p(sdhci_pnp_remove),
> +};
> +
> +Note that .name and .id_table cannot be NULL.
> +
> +2.4 Register the PnP driver
> +
> +Now we can register this PnP driver to the driver model.
> +
> +static int __init sdhci_pnp_init(void)
> +{
> +	return pnp_register_driver(&sdhci_pnp_driver);
> +}
> +
> +module_init(sdhci_pnp_init);
> +
> +
> +--------------------------------------------------------------------=
---------
> +3 Driver for a master device on a non-self-enumerable bus
> +--------------------------------------------------------------------=
---------
> +In some cases, enumerating via ACPI brings new requirements in the
> driver.
> +For example, the driver for a master device on a non-self-enumerable
> bus is
> +responsible for enumerating the slave devices on this bus as well,
> which are
> +described as child devices of this master device in ACPI namespace.
> +
> +Taking SPI bus for example,
> +
> +-------------------------------------------------------------------
> +PNP/ACPI layer
> +
> +   spi-acpi driver
> +         |
> +         |-----------------|
> +         |                 |
> +         |                 |
> +         V                 V
> +   register itself    register its children
> +   as a master        as slave devices
> +   device                  |
> +         |                 |
> +---------|-----------------|---------------------------------------
> +         |                 |
> +         |                 |
> +         |                 |
> +         V                 V
> +     --------------      -----------
> +     |   SPI      |      |  SPI    |
> +     |   master   |      |  slave  |
> +     --------------      -----------
> +                           ^
> +                           |
> +                           |
> +                           V
> +                         -----------------------------
> +                         |  SPI slave driver driver  |
> +                         -----------------------------
> +SPI Bus layer
> +-------------------------------------------------------------------
> +
> +The figure above shows the components needed to make a SPI slave dev=
ice
> work
> +a) an PNP/ACPI driver to probe the SPI master and its slaves.
> +b) a SPI slave device driver for the SPI slave device.
> +
> +[Case Study 2] SPI controller and its slave device
> +
> +This piece of ASL code shows the definition of a SPI controller and =
its
> slave device,
> +MAX3110, in ACPI namespace.
> +
> +Device (SPI1) {
> +	Name (_ADR, 0)
> +	Name (_HID, "PNPYYYY")
> +	Name (_CID, "PNPYYYY")
> +	Name (_UID, 1)
> +
> +	Method (_CRS, 0x0, NotSerialized) {
> +		Name (RBUF, ResourceTemplate ()
> +		{
> +			Memory32Fixed (ReadWrite, 0xff128400, 0x00000400)
> +			Interrupt(ResourceConsumer, Level, ActiveHigh, Exclusive, , , )
> {0x09}
> +		})
> +		Return (RBUF)
> +	}
> +
> +	Method (_STA, 0x0, NotSerialized) {
> +		Return(0xf)
> +	}
> +
> +	Device(MAX0)
> +	{
> +		Name(_HID, "PNPZZZZ")          // Max3110 serial port
> +		Name(_DDN, "Max3110 serial port")
> +		Method(_CRS, 0x0, NotSerialized)
> +		{
> +			// SpiSerial Bus Connection Descriptor
> +			Name(UBUF, ResourceTemplate () {
> +				SPISerialBus(
> +				1,                 // Device selection
> +				PolarityHigh,                       // Device selection polarity
> +				ThreeWireMode,                       // wiremode
> +				8,                   // databit len
> +				ControllerInitiated,                       // slave mode
> +				1000,                       // Connection speed
> +				ClockPolarityHigh,                       // Clock polarity
> +				ClockPhaseFirst,                     // clock phase
> +				"\\_SB.SPI1",           // ResourceSource: SPI bus controller na=
me
> +				0,                      // ResourceSourceIndex
> +				ResourceConsumer,                       // Resource usage
> +				,                       // DescriptorName: creates name for offs=
et
> of resource descriptor
> +				)                      // Vendor Data
> +				// OUT pin, BT_EN pin Core GPIO 74
> +				GpioIo(Exclusive, PullDefault, 0, 0, IoRestrictionOutputOnly, "\
> \_SB.GPIS", ) {0x4A}
> +			})
> +
> +			Return (UBUF)
> +		}
> +	}
> +}
> +
> +By reading the ASL code, we can see that
> +a) There is a SPI controller on this platform.
> +   with IRQ 0x09, and a 0x400 bytes Memory space started from
> 0xff128400.
> +b) a MAX3110 device is connect to a SPI controller.
> +   all the information required for probing a SPI slave device is
> described
> +   in the "SPISerailBus" part of the MAX0._CRS method.
> +
> +We will talk about how to probe these two devices in this chapter.
> +
> +3.1 Probe the master device
> +
> +Please follow the Chapter 2 to probe the SPI master device.
> +
> +static int __devinit
> +dw_spi_pnp_probe(struct pnp_dev *pdev, const struct pnp_device_id
> *dev_id)
> +{
> +...
> +	dws->paddr =3D pnp_mem_start(pdev, 0);
> +	dws->iolen =3D pnp_mem_len(pdev, 0);
> +	dws->irq =3D pnp_irq(pdev, 0);
> +	dws->parent_dev =3D &pdev->dev;
> +	dws->bus_num =3D index++;
> +	dws->num_cs =3D 4;
> +	dws->regs =3D ioremap_nocache((unsigned long)dws->paddr,
> +				dws->iolen);
> +...
> +	ret =3D dw_spi_mid_init(dws);
> +...
> +	ret =3D dw_spi_add_host(dws);
> +...
> +}
> +
> +3.2 Walk ACPI namespace to probe all its child devices.
> +
> +As MAX3110 can not be enumerated automatically, we introduce
> +dw_spi_pnp_slaves_register() to find the MAX3110 device in ACPI
> namespace
> +
> +static int __devinit dw_spi_pnp_slaves_register(struct dw_spi_pnp*
> dwpnp)
> +{
> +	...
> +	struct acpi_device *adev;
> +	adev =3D dwpnp->pdev->data;
> +
> +	/*
> +	 * find spi child devices given in ACPI namespace, one lower level
> only
> +	 */
> +	status =3D acpi_walk_namespace(ACPI_TYPE_DEVICE, adev->handle, 1,
> +				     spi_slave_register, NULL,
> +				     spi_slave_info, NULL);
> +	...
> +}
> +
> +3.3 Register its child devices as slave devices
> +
> +As spi_slave_register is invoked for each SPI1 child device,
> +we introduce spi_slave_fill_resourcetry and try to register
> +SPI slave devices in spi_slave_register.
> +
> +acpi_status __init spi_slave_register(acpi_handle spi_slave_handle, =
u32
> level,
> +				      void* data, void** return_value)
> +{
> +	...
> +	struct spi_board_info *spi_slave_info;
> +	...
> +	status =3D acpi_walk_resources(spi_slave_handle, METHOD_NAME__CRS,
> +				     spi_slave_fill_resource, data);
> +	...
> +	/* register SPI slave device */
> +	ret =3D spi_register_board_info(spi_slave_info, 1);
> +	...
> +}
> +
> +acpi_status __devinit spi_slave_fill_resource(struct acpi_resource
> *resource, void* data)
> +{
> +	struct spi_board_info *spi_slave_info;
> +	struct acpi_resource_spi_serialbus *spi_resource;
> +	...
> +	  	spi_resource =3D &resource->data.spi_serial_bus;
> +	  	spi_slave_info->chip_select =3D spi_resource->device_selection;
> +	  	spi_slave_info->max_speed_hz =3D spi_resource->connection_speed;
> +	  	spi_slave_info->mode =3D (spi_resource->clock_phase ? SPI_CPHA :=
 0) |
> +	  		(spi_resource->clock_polarity ? SPI_CPOL : 0) |
> +	  		(spi_resource->device_polarity ? SPI_CS_HIGH : 0) |
> +	  		(spi_resource->wire_mode ? SPI_3WIRE : 0);
> +	...
> +}
> +
> +3.4 Write the slave device driver
> +
> +After 3.3 is done, the MAX3110 device is an slave device in the SPI
> bus,
> +but to make it work properly, we still need a SPI slave device drive=
r.
> +
> +Note that this is a general SPI drivers independent of ACPI.
> +
> +We will not go into details of the slave device driver here as
> +this piece of code is bus/device specific.
> +
> +--------------------------------------------------------------------=
---------
> +4 Misc
> +--------------------------------------------------------------------=
---------
> +
> +4.1 Note
> +
> +As ACPI 5.0 is still in heavily developing, if you are unable to fin=
d
> out all the
> +required information for probing a device in ACPI namespace, it is
> possible
> +that the ASL code is not well written.
> +Please contact Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> with the acpidump out=
put
> of your
> +platform attached if you suspect it's an BIOS problem.
> +
> +4.2 Some important ACPICA APIs for device driver implementation:
> +
> +-- acpi_status
> +   acpi_walk_namespace(acpi_object_type type,
> +		       acpi_handle start_object,
> +		       u32 max_depth,
> +		       acpi_walk_callback pre_order_visit,
> +		       acpi_walk_callback post_order_visit,
> +		       void *context, void **return_value);
> +Traverse ACPI namespace subtree rooted at start_object, go down
> max_depth level
> +at most. Call pre_order_visit when the proper node with type is foun=
d
> the first
> +time, call post_order_visit is the node is previously visited. Conte=
xt
> and
> +return_value is passed down during the traverse.
> +
> +And the prototype of acpi_walk_callback:
> +typedef
> +acpi_status(*acpi_walk_callback) (acpi_handle object,
> +				  u32 nesting_level,
> +				  void *context, void **return_value);
> +
> +-- acpi_status
> +   acpi_get_handle(acpi_handle parent,
> +   		   acpi_string pathname, acpi_handle * ret_handle);
> +Try to get handle with specified pathname under node parent. Usually
> used to
> +check whether a particular node is available or not.
> +
> +-- acpi_status
> +   acpi_get_object_info(acpi_handle object,
> +		        struct acpi_device_info **return_buffer);
> +Get acpi_device_info from object handle. Useful for retrieving ACPI
> object
> +name, type, and status etc.
> +
> +-- acpi_status
> +   acpi_walk_resources(acpi_handle device,
> +		       char *name,
> +	    	       acpi_walk_resource_callback user_function, void *contex=
t);
> +Traverse resource node specified by name(e.g. METHOD_NAME__CRS) in A=
CPI
> +namespace subtree rooted at device. Call user_function for each entr=
y
> in
> +acpi_resource list. The list may containe acpi_resource entries with
> various
> +types. So it is important to handle the interested resource type
> properly.
> +The acpi_resource with ACPI_RESOURCE_TYPE_END_TAG indicates
> end-of-list.
> +
> +And the prototype of acpi_walk_resource_callback:
> +typedef
> +acpi_status(*acpi_walk_resource_callback) (struct acpi_resource *
> resource,
> +					   void *context);
> +
> +More ACPICA external interfaces available in include/acpi/acpixf.h
