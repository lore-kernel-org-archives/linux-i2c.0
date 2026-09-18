Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A22C44C2253;
	Fri, 18 Sep 2026 12:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789734260; cv=none; b=d6/GsuESp4Ovci5WSbzEIoYa/4Prf0OLOS3F9J8vn1A8E4P1uFn/G5fuToOXmUrBDVObl2rg18JHwTHZwBWNo2ViveHtLDzkxaKe/SPmFGxo+6n9nlQ5aF5lUr+7si/h3cY1QK2XwER/+UEOhQ2WuO9wUr6YSAaH6xrpd9rFkGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789734260; c=relaxed/simple;
	bh=3k+hWk5f2tHJeOQ7UWno3yvLAaRuFV4mj+fn7vnj9tQ=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Ymx4IJVL0HNMpX8JZiPPGkoiJxuqBXEBwpAj6hwuiR8ZtZSXtz9gMTfFlrHJzuidCk12EQOVqgHcvzLspED1zsJD8kkG+tFqiPC23ETIYnzSjClCuScUyXm1tf4otaT7omiMhlVfgt/Ax42/beopzxEAH5Vqy3cgXXdgsv7Q5QA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D3Fpqe9p; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D3Fpqe9p"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789734258; x=1821270258;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=3k+hWk5f2tHJeOQ7UWno3yvLAaRuFV4mj+fn7vnj9tQ=;
  b=D3Fpqe9pR5ajvOKTP8k/B4KMyyGk+f1qLXgz1J/Wkzr4VA8TV+ZFDSaD
   1Kv0sSZ+8XG3KGQDQX+g0M8eEf6dxH3rfifvWB2mubEw4TUwT+Pcrufek
   tO5pWtB0Huo67YM1g+XpDlrwhJdHy5HTx4cQsZya1mx0ILtwEU9yAqF9I
   /ojEsX3ETB3UCB79MoshXwVYqZc827+XthEGHai/LaEn7yWQvF+cwezQV
   mC5vcjY35x00a9o9mwsrHs6ZmV0KZt/2cR9DS1s0dNJPOihhX3yHbW61I
   c966H87DsdFtLpqRdP+urG/Nc8wSHAIC4u+BcyJEIo5kC70QyLw5aSuiC
   Q==;
X-CSE-ConnectionGUID: vTwknmn9TBK2AAvdARM88Q==
X-CSE-MsgGUID: W72ljIj6Q4qeyGvyJm5diA==
X-IronPort-AV: E=McAfee;i="6800,10657,11908"; a="77800069"
X-IronPort-AV: E=Sophos;i="6.27,108,1787036400"; 
   d="scan'208";a="77800069"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2026 05:24:17 -0700
X-CSE-ConnectionGUID: iNN8gsc8StmpDSZuvofpRA==
X-CSE-MsgGUID: eQ1i3vfpQu2ql/krm3d6Og==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,108,1787036400"; 
   d="scan'208";a="276344375"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.223])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2026 05:24:13 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 18 Sep 2026 15:24:10 +0300 (EEST)
To: Benedikt Niedermayr <benedikt.niedermayr@siemens.com>
cc: andi.shyti@kernel.org, Hans de Goede <hansg@kernel.org>, 
    baocheng.su@siemens.com, tobias.schaffner@siemens.com, 
    LKML <linux-kernel@vger.kernel.org>, linux-i2c@vger.kernel.org, 
    platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH 1/2] i2c: i2c-nct6126: add support for NCT6126D Super
 I/O
In-Reply-To: <20260820111940.2434594-2-benedikt.niedermayr@siemens.com>
Message-ID: <07eec660-edb8-a60a-5dcd-d295733ac4d0@linux.intel.com>
References: <20260820111940.2434594-1-benedikt.niedermayr@siemens.com> <20260820111940.2434594-2-benedikt.niedermayr@siemens.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 20 Aug 2026, Benedikt Niedermayr wrote:

> This adds support for an i2c master driver for the NCT6126D Super I/O
> chips SMBUs controller. The NCT6126D exposes an SMBus master controller
> inside Logical Device B (the Hardware Monitor / SB-TSI block).
> 
> The I/O base address is discovered dynamically and is expected to be
> programmed by the BIOS into LD B CR62h (MSB) and CR63h (LSB).
> 
> TODO: Explain handling of the CR30h register.
> 
> The SMBus master controller shares the same CR30h register with the
> Hardware Monitor (logical device B), which is currently used by the
> nct6775 driver. The nct6775 driver force overrides the CR30h register
> to 0x01, if not already set by the bios.
> This driver in turn is more defensive and will not probe the chip if the
> CR30h register is not set to 0x01.
> 
> Signed-off-by: Benedikt Niedermayr <benedikt.niedermayr@siemens.com>
> ---
>  MAINTAINERS                      |   5 +
>  drivers/i2c/busses/Kconfig       |  11 +
>  drivers/i2c/busses/Makefile      |   1 +
>  drivers/i2c/busses/i2c-nct6126.c | 473 +++++++++++++++++++++++++++++++
>  4 files changed, 490 insertions(+)
>  create mode 100644 drivers/i2c/busses/i2c-nct6126.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 8014b9f8253e..760d7a088629 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -19315,6 +19315,11 @@ F:	drivers/nubus/
>  F:	include/linux/nubus.h
>  F:	include/uapi/linux/nubus.h
>  
> +NUVOTON NCT6126D I2C/SMBUS DRIVER
> +M:	Benedikt Niedermayr <benedikt.niedermayr@siemens.com>
> +S:	Maintained
> +F:	drivers/i2c/busses/i2c-nct6126.c
> +
>  NUVOTON NCT6694 MFD DRIVER
>  M:	Ming Yu <tmyu0@nuvoton.com>
>  S:	Supported
> diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
> index d35456994280..9dd265abdfbc 100644
> --- a/drivers/i2c/busses/Kconfig
> +++ b/drivers/i2c/busses/Kconfig
> @@ -258,6 +258,17 @@ config I2C_NFORCE2
>  	  This driver can also be built as a module.  If so, the module
>  	  will be called i2c-nforce2.
>  
> +config I2C_NCT6126
> +	tristate "Nuvoton NCT6126D SMBus master"
> +	depends on X86 && HAS_IOPORT
> +	help
> +	  If you say yes to this option, support will be included for the
> +	  SMBus master controller embedded in the Nuvoton NCT6126D Super-I/O
> +	  chip (Logical Device B).
> +
> +	  This driver can also be built as a module. If so, the module
> +	  will be called i2c-nct6126.
> +
>  config I2C_NVIDIA_GPU
>  	tristate "NVIDIA GPU I2C controller"
>  	depends on PCI
> diff --git a/drivers/i2c/busses/Makefile b/drivers/i2c/busses/Makefile
> index 3755c54b3d82..69042afb1f04 100644
> --- a/drivers/i2c/busses/Makefile
> +++ b/drivers/i2c/busses/Makefile
> @@ -20,6 +20,7 @@ obj-$(CONFIG_I2C_I801)		+= i2c-i801.o
>  obj-$(CONFIG_I2C_ISCH)		+= i2c-isch.o
>  obj-$(CONFIG_I2C_ISMT)		+= i2c-ismt.o
>  obj-$(CONFIG_I2C_NFORCE2)	+= i2c-nforce2.o
> +obj-$(CONFIG_I2C_NCT6126)	+= i2c-nct6126.o
>  obj-$(CONFIG_I2C_NVIDIA_GPU)	+= i2c-nvidia-gpu.o
>  obj-$(CONFIG_I2C_PIIX4)		+= i2c-piix4.o
>  obj-$(CONFIG_I2C_SIS5595)	+= i2c-sis5595.o
> diff --git a/drivers/i2c/busses/i2c-nct6126.c b/drivers/i2c/busses/i2c-nct6126.c
> new file mode 100644
> index 000000000000..ce71883744e8
> --- /dev/null
> +++ b/drivers/i2c/busses/i2c-nct6126.c
> @@ -0,0 +1,473 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * i2c-nct6126 - i2c adapter driver for the Nuvoton NCT6126D Super-I/O chip.
> + *
> + * The NCT6126D exposes an SMBus master controller inside Logical Device B
> + * (the Hardware Monitor / SB-TSI block). Its I/O base address is programmed
> + * by BIOS into LD B CR62h (MSB) and CR63h (LSB).
> + *
> + * Inspired by nct6775-platform.c and gpio-f7188x.c.
> + *
> + * Copyright (c) Siemens AG, 2026
> + *
> + * Author: Benedikt Niedermayr <benedikt.niedermayr@siemens.com>
> + */
> +
> +#define DRVNAME "i2c-nct6126"
> +#define pr_fmt(fmt) DRVNAME ": " fmt
> +
> +#include <linux/delay.h>
> +#include <linux/i2c.h>
> +#include <linux/init.h>
> +#include <linux/io.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/string.h>
> +
> +/*
> + * Super-I/O configuration space
> + */
> +#define SIO_LDSEL		0x07	/* Logical Device Select */
> +#define SIO_DEVID		0x20	/* CR20/CR21: 16-bit chip ID */
> +#define SIO_UNLOCK_KEY		0x87	/* Enter extended function mode */
> +#define SIO_LOCK_KEY		0xAA	/* Exit extended function mode */
> +
> +/* Accepted chip IDs */
> +#define SIO_NCT6126D_A_ID	0xD283	/* NCT6126D, A version */
> +#define SIO_NCT6126D_B_ID	0xD284	/* NCT6126D, B version */
> +
> +/* Logical Device B: Hardware Monitor + SB-TSI / SMBus master */
> +#define SIO_LD_HM_SMBUS		0x0B
> +#define SIO_LDB_ENABLE		0x30	/* bit0: block active (CR30) */
> +#define SIO_LDB_SMBUS_BASE	0x62	/* CR62 = MSB, CR63 = LSB */
> +
> +/* SMBus base address constraints */
> +#define SMBUS_BASE_MIN		0x100
> +#define SMBUS_BASE_MAX		0xFFE
> +
> +/*
> + * SMBus controller register offsets (base + offset)
> + * All registers are accessed directly at smbus_base + offset.
> + */
> +#define NCT6126D_SMWRSIZE	0x01
> +#define NCT6126D_SMCMD		0x02
> +#define NCT6126D_SMIDX		0x03
> +#define NCT6126D_SMCTL		0x04
> +#define NCT6126D_SMADDR		0x05
> +#define NCT6126D_ERROR_STS	0x09
> +#define NCT6126D_SMCTL3		0x0e
> +#define NCT6126D_SMBUS_REGION_SIZE	0x20

SZ_xx + include for it?

> +
> +/* Bit definitions */
> +#define NCT6126D_FIFO_NULL		BIT(0)
> +#define NCT6126D_FIFO_FULL		BIT(1)
> +#define NCT6126D_ERR_NACK		BIT(1)
> +#define NCT6126D_ERR_BER		BIT(2)
> +#define NCT6126D_ERR_TIMEOUT		BIT(4)
> +#define NCT6126D_ERR_ADNACK		BIT(5)
> +#define NCT6126D_RST			BIT(6)
> +#define NCT6126D_MANUAL_MODE		BIT(7)
> +#define NCT6126D_ACTIVE_MANUAL_MODE	BIT(2)

Add include for BIT()

> +
> +/* SMBus command codes */
> +#define NCT6126_CMD_READ_BYTE	0
> +#define NCT6126_CMD_WRITE_BYTE	8
> +
> +/* Timing / retry limits */
> +#define SMBUS_RW_LOOP_MAX	5
> +#define SMBUS_FIFO_WAIT_US	100
> +#define SMBUS_FIFO_MAX_CLEAR_TIME	0xff
> +
> +/*
> + * Super-I/O functions.
> + */
> +static inline int nct_superio_inb(int base, int reg)
> +{
> +	outb(reg, base);
> +	return inb(base + 1);
> +}
> +
> +static int nct_superio_inw(int base, int reg)
> +{
> +	int val;
> +
> +	outb(reg++, base);
> +	val = inb(base + 1) << 8;
> +	outb(reg, base);
> +	val |= inb(base + 1);
> +
> +	return val;
> +}
> +
> +static inline int nct_superio_enter(int base)
> +{
> +	if (!request_muxed_region(base, 2, DRVNAME)) {
> +		pr_err("SIO config port %#x already in use\n", base);
> +		return -EBUSY;
> +	}
> +
> +	/* Datasheet 7.1.1: key must be written twice */
> +	outb(SIO_UNLOCK_KEY, base);
> +	outb(SIO_UNLOCK_KEY, base);
> +
> +	return 0;
> +}
> +
> +static inline void nct_superio_select(int base, int ld)
> +{
> +	outb(SIO_LDSEL, base);
> +	outb(ld, base + 1);
> +}
> +
> +static inline void nct_superio_exit(int base)
> +{
> +	outb(SIO_LOCK_KEY, base);
> +	release_region(base, 2);
> +}
> +
> +struct nct6126_sio {
> +	int           addr;       /* SIO config port: 0x2e or 0x4e */
> +	unsigned long smbus_base; /* from LD B CR62/CR63 */
> +};
> +
> +struct nct6126_smbus {
> +	unsigned long    port_addr;
> +	struct i2c_adapter adap;

Inconsistent spacing.

> +};
> +
> +static int __init nct6126_find(int addr, struct nct6126_sio *sio)
> +{
> +	int err;
> +	u16 devid;
> +	u8  enable, msb, lsb;
> +	unsigned long base;

I think I see what you're trying to do here with that extra space, but it 
just lead to inconsistent spacing. Better approach would be to just use 
reverse-xmas tree order without extra spaces.

> +	err = nct_superio_enter(addr);

So your init func calls this function and then you immediately call 
nct_superio_enter() that performs writes to a random port? On any 
platform? I think that's a non-starter.

> +	if (err)
> +		return err;
> +
> +	/* Verify chip identity */
> +	devid = nct_superio_inw(addr, SIO_DEVID);
> +	if (devid != SIO_NCT6126D_A_ID && devid != SIO_NCT6126D_B_ID) {
> +		err = -ENODEV;
> +		goto out;
> +	}
> +
> +	/* Select Logical Device B (HM + SB-TSI/SMBus master) */
> +	nct_superio_select(addr, SIO_LD_HM_SMBUS);
> +
> +	/*
> +	 * Check CR30 bit 0: if clear, the block is not decoding its I/O
> +	 * range on the LPC bus.  Every inb() at the SMBus window would
> +	 * return 0xFF.  We do NOT write this bit: nct6775 owns CR30 and
> +	 * maintains it across suspend/resume.
> +	 */
> +	enable = nct_superio_inb(addr, SIO_LDB_ENABLE);
> +	if (!(enable & BIT(0))) {

Please name BIT(0) with a define.

> +		pr_info("LD B inactive (CR30 bit0=0): BIOS has not enabled the HM/SMBus block\n");
> +		err = -ENODEV;
> +		goto out;
> +	}
> +
> +	/*
> +	 * Read the SMBus master base address programmed by BIOS.
> +	 * Datasheet 19.7.1, 23.11: LD B CR62h (MSB) / CR63h (LSB).
> +	 * BIOS must program this.
> +	 */
> +	msb  = nct_superio_inb(addr, SIO_LDB_SMBUS_BASE);
> +	lsb  = nct_superio_inb(addr, SIO_LDB_SMBUS_BASE + 1);
> +	base = ((unsigned long)msb << 8) | lsb;
> +
> +	if (base < SMBUS_BASE_MIN || base > SMBUS_BASE_MAX || (base & 1)) {

!IS_ALIGNED() ? Don't forget to add include for it.

> +		pr_err("invalid SMBus base %#lx in LD B CR62/63\n", base);

Add include.

> +		err = -ENXIO;
> +		goto out;
> +	}
> +
> +	sio->addr = addr;
> +	sio->smbus_base = base;
> +	err = 0;
> +
> +	pr_info("Found nct6126d at %#x, SMBus base %#lx\n", addr, base);

Success path should be quiet.

> +
> +out:
> +	nct_superio_exit(addr);
> +	return err;
> +}
> +
> +/*
> + * SMBus
> + */
> +static int nct_smbus_err_check(u8 err_code)
> +{
> +	if (err_code & NCT6126D_ERR_ADNACK)
> +		return -ENXIO;
> +	if (err_code & NCT6126D_ERR_TIMEOUT)
> +		return -ETIMEDOUT;
> +	if (err_code & (NCT6126D_ERR_BER | NCT6126D_ERR_NACK))
> +		return -EXDEV;
> +	return 0;
> +}
> +
> +static void nct6126_smbus_init_config(struct nct6126_smbus *priv,
> +				      u8 slave_addr, u8 slave_reg)
> +{
> +	u8 val;
> +
> +	/* Reset SMBus controller */
> +	val = inb(priv->port_addr + NCT6126D_SMCTL);
> +	val |= NCT6126D_RST;
> +	outb(val, priv->port_addr + NCT6126D_SMCTL);
> +	outb(0,   priv->port_addr + NCT6126D_SMCTL);
> +
> +	/* 7-bit slave address; hardware expects it left-shifted by 1 */
> +	outb(slave_addr << 1, priv->port_addr + NCT6126D_SMADDR);
> +	outb(slave_reg,       priv->port_addr + NCT6126D_SMIDX);
> +}
> +
> +static int nct6126_smbus_enable_manual_mode(struct nct6126_smbus *priv)
> +{
> +	u8 val;
> +
> +	val = inb(priv->port_addr + NCT6126D_SMCTL);
> +	val |= NCT6126D_MANUAL_MODE;
> +	outb(val, priv->port_addr + NCT6126D_SMCTL);
> +
> +	val = inb(priv->port_addr + NCT6126D_SMCTL3);
> +	val |= NCT6126D_ACTIVE_MANUAL_MODE;
> +	outb(val, priv->port_addr + NCT6126D_SMCTL3);
> +
> +	/*
> +	 * Wait ~200 us for the slave to respond, then read the error
> +	 * status.  Per Nuvoton FAE: error must be checked after manual
> +	 * mode is activated due to the one-shot enable behaviour.
> +	 */
> +	usleep_range(200, 300);
> +	val = inb(priv->port_addr + NCT6126D_ERROR_STS);
> +
> +	return nct_smbus_err_check(val);
> +}
> +
> +static int nct6126_smbus_write8(struct nct6126_smbus *priv,
> +				u8 slave_addr, u8 slave_reg, u8 *data)
> +{
> +	int loop_cnt;
> +	int err;
> +
> +	if (!request_muxed_region(priv->port_addr,
> +				  NCT6126D_SMBUS_REGION_SIZE, DRVNAME))
> +		return -EBUSY;
> +
> +	nct6126_smbus_init_config(priv, slave_addr, slave_reg);
> +
> +	outb(1,                      priv->port_addr + NCT6126D_SMWRSIZE);
> +	outb(NCT6126_CMD_WRITE_BYTE, priv->port_addr + NCT6126D_SMCMD);
> +
> +	loop_cnt = SMBUS_RW_LOOP_MAX;
> +	while ((inb(priv->port_addr + NCT6126D_SMCTL3) & NCT6126D_FIFO_FULL) &&
> +	       --loop_cnt)
> +		usleep_range(SMBUS_FIFO_WAIT_US, SMBUS_FIFO_WAIT_US * 2);

linux/iopoll.h would have something for you.

> +
> +	if (loop_cnt == 0) {
> +		err = -ETIMEDOUT;
> +		goto out;
> +	}
> +
> +	outb(*data, priv->port_addr);
> +	err = nct6126_smbus_enable_manual_mode(priv);
> +
> +out:
> +	release_region(priv->port_addr, NCT6126D_SMBUS_REGION_SIZE);
> +	return err;
> +}
> +
> +static int nct6126_smbus_read8(struct nct6126_smbus *priv,
> +			       u8 slave_addr, u8 slave_reg, u8 *data)
> +{
> +	int loop_cnt;
> +	int err;
> +
> +	if (!request_muxed_region(priv->port_addr,
> +				  NCT6126D_SMBUS_REGION_SIZE, DRVNAME))
> +		return -EBUSY;
> +
> +	nct6126_smbus_init_config(priv, slave_addr, slave_reg);
> +
> +	outb(0, priv->port_addr + NCT6126D_SMWRSIZE);
> +	outb(NCT6126_CMD_READ_BYTE, priv->port_addr + NCT6126D_SMCMD);
> +
> +	err = nct6126_smbus_enable_manual_mode(priv);
> +	if (err)
> +		goto out;
> +
> +	loop_cnt = SMBUS_RW_LOOP_MAX;
> +	while ((inb(priv->port_addr + NCT6126D_SMCTL3) & NCT6126D_FIFO_NULL) &&
> +	       --loop_cnt)
> +		usleep_range(SMBUS_FIFO_WAIT_US, SMBUS_FIFO_WAIT_US * 2);

linux/iopoll.h can do this as well.

> +	if (loop_cnt == 0) {
> +		err = -ETIMEDOUT;
> +		goto out;
> +	}
> +
> +	*data = inb(priv->port_addr);
> +
> +	/* Drain any residual FIFO entries */
> +	loop_cnt = SMBUS_FIFO_MAX_CLEAR_TIME;
> +	while (!(inb(priv->port_addr + NCT6126D_SMCTL3) & NCT6126D_FIFO_NULL) &&
> +	       --loop_cnt)
> +		inb(priv->port_addr);
> +
> +	err = (loop_cnt == 0) ? -ETIMEDOUT : 0;
> +
> +out:
> +	release_region(priv->port_addr, NCT6126D_SMBUS_REGION_SIZE);
> +	return err;
> +}
> +
> +/*
> + * i2c_algorithm
> + */
> +static int nct6126_smbus_xfer(struct i2c_adapter *adap, u16 addr, u16 flags,
> +			      char read_write, u8 cmd, int size,
> +			      union i2c_smbus_data *data)
> +{
> +	struct nct6126_smbus *priv = i2c_get_adapdata(adap);
> +
> +	if (!priv)
> +		return -ENODEV;
> +
> +	if (read_write == I2C_SMBUS_READ)
> +		return nct6126_smbus_read8(priv, addr, cmd, &data->byte);
> +	else
> +		return nct6126_smbus_write8(priv, addr, cmd, &data->byte);
> +}
> +
> +static u32 nct6126_functionality(struct i2c_adapter *adap)
> +{
> +	return I2C_FUNC_I2C | I2C_FUNC_SMBUS_BYTE | I2C_FUNC_SMBUS_BYTE_DATA;
> +}
> +
> +static const struct i2c_algorithm nct6126_algo = {
> +	.smbus_xfer    = nct6126_smbus_xfer,
> +	.functionality = nct6126_functionality,
> +};
> +
> +static int nct6126_smbus_probe(struct platform_device *pdev)
> +{
> +	struct nct6126_sio   *sio = dev_get_platdata(&pdev->dev);
> +	struct nct6126_smbus *priv;
> +	struct i2c_adapter   *adap;
> +	int err;
> +
> +	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	priv->port_addr = sio->smbus_base;
> +
> +	adap              = &priv->adap;
> +	adap->owner       = THIS_MODULE;
> +	adap->class       = I2C_CLASS_HWMON;
> +	adap->algo        = &nct6126_algo;
> +	adap->dev.parent  = &pdev->dev;
> +	adap->nr          = -1;
> +	strscpy(adap->name, DRVNAME, sizeof(adap->name));
> +	i2c_set_adapdata(adap, priv);
> +
> +	err = i2c_add_adapter(adap);
> +	if (err) {
> +		dev_err(&pdev->dev, "failed to add i2c adapter: %d\n", err);
> +		return err;
> +	}
> +
> +	platform_set_drvdata(pdev, priv);
> +	return 0;
> +}
> +
> +static void nct6126_smbus_remove(struct platform_device *pdev)
> +{
> +	struct nct6126_smbus *priv = platform_get_drvdata(pdev);
> +
> +	i2c_del_adapter(&priv->adap);
> +}
> +
> +static struct platform_driver nct6126_smbus_driver = {
> +	.driver = {
> +		.name = DRVNAME,
> +	},
> +	.probe  = nct6126_smbus_probe,
> +	.remove = nct6126_smbus_remove,
> +};
> +
> +#define MAX_PDEVS 1
> +static struct platform_device *nct6126_pdevs[MAX_PDEVS];
> +static int nct6126_pdevs_cnt;

Why all this complexity to store one pointer? Why isn't NULL/not NULL 
check adequate for this purpose?

> +
> +static int __init nct6126_device_add(const struct nct6126_sio *sio)
> +{
> +	struct platform_device *pdev;
> +	int err;
> +
> +	pdev = platform_device_alloc(DRVNAME, 0);
> +	if (!pdev)
> +		return -ENOMEM;
> +
> +	err = platform_device_add_data(pdev, sio, sizeof(*sio));
> +	if (err) {
> +		pr_err("platform data allocation failed\n");
> +		goto err_put;
> +	}
> +
> +	err = platform_device_add(pdev);
> +	if (err) {
> +		pr_err("platform device registration failed\n");
> +		goto err_put;
> +	}
> +
> +	nct6126_pdevs[nct6126_pdevs_cnt++] = pdev;
> +	return 0;
> +
> +err_put:
> +	platform_device_put(pdev);
> +	return err;
> +}
> +
> +static int __init nct6126_smbus_init(void)
> +{
> +	struct nct6126_sio sio;
> +	int err;
> +
> +	if (nct6126_find(0x2e, &sio) && nct6126_find(0x4e, &sio))
> +		return -ENODEV;
> +
> +	err = platform_driver_register(&nct6126_smbus_driver);
> +	if (err)
> +		return err;
> +
> +	err = nct6126_device_add(&sio);
> +	if (err)
> +		goto err_unreg_driver;
> +
> +	return 0;
> +
> +err_unreg_driver:
> +	platform_driver_unregister(&nct6126_smbus_driver);
> +	return err;
> +}
> +
> +static void __exit nct6126_smbus_exit(void)
> +{
> +	while (nct6126_pdevs_cnt > 0)
> +		platform_device_unregister(nct6126_pdevs[--nct6126_pdevs_cnt]);
> +
> +	platform_driver_unregister(&nct6126_smbus_driver);
> +}
> +
> +module_init(nct6126_smbus_init);
> +module_exit(nct6126_smbus_exit);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("Benedikt Niedermayr <benedikt.niedermayr@siemens.com>");
> +MODULE_DESCRIPTION("SMBus master driver for Nuvoton NCT6126D Super-I/O");
> 

-- 
 i.

