From: "Elliott, Robert (Persistent Memory)" <elliott@hpe.com>
Subject: RE: [PATCH v3 2/2] i2c, i2c_imc: Add DIMM bus code
Date: Mon, 2 May 2016 19:49:33 +0000
Message-ID: <94D0CD8314A33A4D9D801C0FE68B40296392DA39@G9W0745.americas.hpqcorp.net>
References: <cover.1461891499.git.luto@kernel.org>
 <01cb3ac1d5c76f61890e258a20758c7f75fb161a.1461891499.git.luto@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from g4t3426.houston.hp.com ([15.201.208.54]:34675 "EHLO
	g4t3426.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754821AbcEBTti convert rfc822-to-8bit (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Mon, 2 May 2016 15:49:38 -0400
In-Reply-To: <01cb3ac1d5c76f61890e258a20758c7f75fb161a.1461891499.git.luto@kernel.org>
Content-Language: en-US
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Andy Lutomirski <luto@kernel.org>, Wolfram Sang <wsa@the-dreams.de>, Christoph Hellwig <hch@infradead.org>
Cc: Boaz Harrosh <boaz@plexistor.com>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Rui Wang <ruiv.wang@gmail.com>, Jean Delvare <jdelvare@suse.de>, Alun Evans <alun@badgerous.net>, Robert Elliott <Elliott@hp.com>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, Mauro Carvalho Chehab <m.chehab@samsung.com>, Paul Bolle <pebolle@tiscali.nl>, Tony Luck <tony.luck@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Guenter Roeck <linux@roeck-us.net>



> -----Original Message-----
> From: Andy Lutomirski [mailto:luto@kernel.org]
> Sent: Thursday, April 28, 2016 8:03 PM
> To: Wolfram Sang <wsa@the-dreams.de>; Christoph Hellwig <hch@infradead.org>
> Cc: Boaz Harrosh <boaz@plexistor.com>; One Thousand Gnomes
> <gnomes@lxorguk.ukuu.org.uk>; Rui Wang <ruiv.wang@gmail.com>; Jean Delvare
> <jdelvare@suse.de>; Alun Evans <alun@badgerous.net>; Robert Elliott
> <Elliott@hp.com>; linux-i2c@vger.kernel.org; Mauro Carvalho Chehab
> <m.chehab@samsung.com>; Paul Bolle <pebolle@tiscali.nl>; Tony Luck
> <tony.luck@intel.com>; linux-kernel@vger.kernel.org; Guenter Roeck
> <linux@roeck-us.net>; Andy Lutomirski <luto@kernel.org>
> Subject: [PATCH v3 2/2] i2c, i2c_imc: Add DIMM bus code
> 
> Add i2c_scan_dimm_bus to declare that a particular i2c_adapter
> contains DIMMs.  This will probe (and autoload modules!) for useful
> SMBUS devices that live on DIMMs.  i2c_imc calls it.
> 
> As more SMBUS-addressable DIMM components become supported, this
> code can be extended to probe for them.
> 
> Signed-off-by: Andy Lutomirski <luto@kernel.org>
> ---
>  drivers/i2c/busses/Kconfig    |   5 ++
>  drivers/i2c/busses/Makefile   |   4 ++
>  drivers/i2c/busses/dimm-bus.c | 107
> ++++++++++++++++++++++++++++++++++++++++++
>  drivers/i2c/busses/i2c-imc.c  |   3 ++
>  include/linux/i2c/dimm-bus.h  |  20 ++++++++
>  5 files changed, 139 insertions(+)
>  create mode 100644 drivers/i2c/busses/dimm-bus.c
>  create mode 100644 include/linux/i2c/dimm-bus.h
> 
> diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
> index 3c05de897566..10aa87872408 100644
> --- a/drivers/i2c/busses/Kconfig
> +++ b/drivers/i2c/busses/Kconfig
> @@ -152,9 +152,14 @@ config I2C_ISMT
>  	  This driver can also be built as a module.  If so, the module will
> be
>  	  called i2c-ismt.
> 
> +config I2C_DIMM_BUS
> +       tristate
> +       default n
> +
>  config I2C_IMC
>  	tristate "Intel iMC (LGA 2011) SMBus Controller"
>  	depends on PCI && X86
> +	select I2C_DIMM_BUS
>  	help
>  	  If you say yes to this option, support will be included for the
> Intel
>  	  Integrated Memory Controller SMBus host controller interface.  This
> diff --git a/drivers/i2c/busses/Makefile b/drivers/i2c/busses/Makefile
> index ab3cdf1b3ca1..093591935bc8 100644
> --- a/drivers/i2c/busses/Makefile
> +++ b/drivers/i2c/busses/Makefile
> @@ -25,6 +25,10 @@ obj-$(CONFIG_I2C_SIS96X)	+= i2c-sis96x.o
>  obj-$(CONFIG_I2C_VIA)		+= i2c-via.o
>  obj-$(CONFIG_I2C_VIAPRO)	+= i2c-viapro.o
> 
> +# DIMM busses
> +obj-$(CONFIG_I2C_DIMM_BUS)	+= dimm-bus.o
> +obj-$(CONFIG_I2C_IMC)		+= i2c-imc.o
> +
>  # Mac SMBus host controller drivers
>  obj-$(CONFIG_I2C_HYDRA)		+= i2c-hydra.o
>  obj-$(CONFIG_I2C_POWERMAC)	+= i2c-powermac.o
> diff --git a/drivers/i2c/busses/dimm-bus.c b/drivers/i2c/busses/dimm-bus.c
> new file mode 100644
> index 000000000000..d41c1095c093
> --- /dev/null
> +++ b/drivers/i2c/busses/dimm-bus.c
> @@ -0,0 +1,107 @@
> +/*
> + * Copyright (c) 2013-2016 Andrew Lutomirski <luto@amacapital.net>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2
> + * as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#include <linux/i2c.h>
> +#include <linux/bug.h>
> +#include <linux/module.h>
> +#include <linux/i2c/dimm-bus.h>
> +
> +static bool probe_addr(struct i2c_adapter *adapter, int addr)
> +{
> +	/*
> +	 * So far, all known devices that live on DIMMs can be safely
> +	 * and reliably detected by trying to read a byte at address
> +	 * zero.  (The exception is the SPD write protection control,
> +	 * which can't be probed and requires special hardware and/or
> +	 * quick writes to access, and has no driver.)
> +	 */

If the bus is in the middle of any other kind of access or sequence of
accesses, it's hard to predict what this will do.

If it's a 512 byte SPD EEPROM and the last page select was to page 1,
this will read byte 256 rather than byte 0.  The thread needs to do
its own set page 0 write to ensure it knows what it is reading.

> +	union i2c_smbus_data dummy;
> +
> +	return i2c_smbus_xfer(adapter, addr, 0, I2C_SMBUS_READ, 0,
> +			      I2C_SMBUS_BYTE_DATA, &dummy) >= 0;
> +}
> +
> +/**
> + * i2c_scan_dimm_bus() - Scans an SMBUS segment known to contain DIMMs
> + * @adapter: The SMBUS adapter to scan
> + *
> + * This function tells the DIMM-bus code that the adapter is known to
> + * contain DIMMs.  i2c_scan_dimm_bus will probe for devices known to
> + * live on DIMMs.
> + *
> + * Do NOT call this function on general-purpose system SMBUS segments
> + * unless you know that the only things on the bus are DIMMs.
> + * Otherwise is it very likely to mis-identify other things on the
> + * bus.
> + *
> + * Callers are advised not to set adapter->class = I2C_CLASS_SPD to
> + * avoid having two separate mechanisms trying to automatically claim
> + * devices on the bus.
> + */
> +void i2c_scan_dimm_bus(struct i2c_adapter *adapter)
> +{
> +	struct i2c_board_info info = {};
> +	int slot;
> +
> +	/*
> +	 * We probe with "read byte data".  If any DIMM SMBUS driver can't
> +	 * support that access type, this function should be updated.
> +	 */
> +	if (WARN_ON(!i2c_check_functionality(adapter,
> +					     I2C_FUNC_SMBUS_READ_BYTE_DATA)))
> +		return;
> +
> +	/*
> +	 * Addresses on DIMMs use the three low bits to identify the slot
> +	 * and the four high bits to identify the device type.  Known
> +	 * devices are:
> +	 *
> +	 *  - 0x50 - 0x57: SPD (Serial Presence Detect) EEPROM
> +	 *  - 0x30 - 0x37: SPD WP control -- not easy to probe
> +	 *  - 0x18 - 0x1f: TSOD (Temperature Sensor on DIMM)

In DDR4, you might also encounter:
* 0x10 - 0x17 NVDIMM controller (pre-standard)
* 0x40 - 0x47 NVDIMM controller (JESD245 Byte Addressable Energy Backed Interface)
* 0x58 - 0x5F Registering Clock Driver (RCD) (JEDEC DDR4RCD01)

> +	 *
> +	 * There's no point in trying to probe the SPD WP control: we'd
> +	 * want to probe using quick reads, which i2c-imc doesn't
> +	 * support, we don't have a driver for it, we can't really use
> +	 * it without special hardware (it's not a normal i2c slave --
> +	 * see the JEDEC docs), and using it risks bricking the DIMM
> +	 * it's on anyway.

You do need to write to 0x36 and 0x37 a lot while accessing
SPD EEPROMs in DDR4:
* 0x36 selects SPD page 0 (bytes 0-255) on all DIMMs
* 0x37 selects SPD page 1 (bytes 256-511) on all DIMMs

Since the page selects are broadcast, you cannot have independent threads
talking to different DIMM SPD EEPROMs unless they're very coordinated.

> +	 *
> +	 * NB: There's no need to save the return value from
> +	 * i2c_new_device, as the core code will unregister it for us
> +	 * when the adapter is removed.  If users want to bind a
> +	 * different driver, nothing stops them from unbinding the
> +	 * drivers we request here.
> +	 */
> +	for (slot = 0; slot < 8; slot++) {
> +		/* If there's no SPD, then assume there's no DIMM here. */
> +		if (!probe_addr(adapter, 0x50 | slot))
> +			continue;
> +
> +		strcpy(info.type, "spd");
> +		info.addr = 0x50 | slot;
> +		i2c_new_device(adapter, &info);
> +
> +		if (probe_addr(adapter, 0x18 | slot)) {
> +			/* This is a temperature sensor. */
> +			strcpy(info.type, "jc42");

JC-42 is the name of a JEDEC committee.  TSE2004av is "the family of" 
"Serial Presence Detect (SPD) EEPROMs and Temperature Sensor (TS) as
used for memory module applications" in DDR4, defined by JEDEC
standard No. 21-C section 4.1.6.  The earlier TSE2002av only supported
256 bytes of SPD EEPROM.  Since the driver is already called jc42.c,
maybe add a comment with the actual standards references.
