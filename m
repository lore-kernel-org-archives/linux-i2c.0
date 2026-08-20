Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BC293803D9
	for <linux-i2c@vger.kernel.org>; Thu, 20 Aug 2026 15:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787240054; cv=none; b=e0363pXCkDTbiBVF50w/evxZ19SAQd9FYc7XpYr6OwuRvPfYOLAzKTWRVzBwpnplcVFSc5BeV3pzPs5pEctiFTRyNUhCgRx0oqfhT5e16piHohXuglxJKLg5iLBFT9Wa7fKRgUSCLlentWet6pqdRi2sNAOQzZDZihRsVr5hct0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787240054; c=relaxed/simple;
	bh=5YsDBFTVYKHCQzaO7gHWGDpWj++qvTuQmQX9hyV6AR0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hX7BhpLv4ywVUeNT3TGfIpZBr5/uB7x7gHTF3rNgFbXPN1tEPzEC+hJwz1MEJue/KScndGyJ/5JXMgfNHHjEmHVBi5jiMM8jHDYw0KiJofvBL65+C5ZkgQoDAHFpMID0lX/XhP5n9h0RwdYVXOBe9M1ThArfJeaFtR1WIuuv3GU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qglseeqo; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qglseeqo"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-c9e607d81fcso13629a12.2
        for <linux-i2c@vger.kernel.org>; Thu, 20 Aug 2026 08:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787240049; x=1787844849; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:sender:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5znNbAH16/TBzbwQiSkkDcvy4h4+4PD18XhUKyFr/No=;
        b=qglseeqoLi5PXZQ4tuYt7PvL7+bs+7IrDn7VEWQEcBIcJmwb5/iQATYAcR02Zqmjc6
         z+h+zOgc6vjs9B+KA4nOKdP2j5dlwIKWGjBLJ+Cmf2DHxQYYbzw3P5ZwauxB2orlTgns
         KP1JHcWw8ypxcJHBo3xx9ZQUONASQSMgagUSzXIU1P97qe6XzTzkfbUda4ZsHqgeAzaB
         q32RnEhFITfR8w6GCkC3cvfDS/cWQsyH+uSMDcyW4upTSDuWJ8+FXYBrkjrMNZJvs5gC
         ePWhMGpN2lXCbAMR3kBX2bZtYV7l0zlBO+EZp8TQ6cZr4KoRm8hvHEzIEROEsaLGN5yr
         0e4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787240049; x=1787844849;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5znNbAH16/TBzbwQiSkkDcvy4h4+4PD18XhUKyFr/No=;
        b=r2iu5zAduKRrN1atxPUbn2LEkUXHL+bLiwRp/ZJa0wJTldwEB077c1BWDzdPG1rDVX
         yTnGrFiq64U04bBFHWiw+dW17BlVzAZz1xBVoLqx0xFSNtpzNB9sscN+JqqqfjJNgSTU
         W04RDYetuPXNFWTS7CjakPy18BdZyGTnJfTrKy7DW/qF4Rh4zRvQxIdNnoBme0863wN5
         boTVISp+xKovSY+wEcjKqkVDWifdrmzMbRY774N/ALIrykgc/Hh92iY+WDUWQHNSE2M+
         x1sBUC/4xqhSh0hyFy4eHEUYR0uX+HKCd4AeHSQ6LoWZo7g+t2YeZYZzN6YJq9D/YBTp
         y6Vw==
X-Forwarded-Encrypted: i=1; AHgh+Rqjptse5vzfceZ8nZ7NXfpUjUutrRoj+4Uyprit9knFvtwzQOTDxDxWNShOGwZ7MjvIkDjIDsh7AvI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzE6ZQSAFuRrUpBEntHwNnIVvrykx3liH8ZX/5IzPQQvjoLGrkT
	EWzieyI9bYSjLWkMBUInE/7u4Y/CdMIcL0dPYLrNn3/zWTYXqwD5/0hw
X-Gm-Gg: AR+sD10e+9KYSY4Lyyrl0h9E4xLwW1gJLpe2aLIhZMw2bzuyD3I0o0ORtyHMGYpSWd9
	jdz5Yg0tQyJwGez6px5mDsqYypcrKAnF1XcMkf3doSnbTVDb8IpOY2YxpD5bwfYeabPzhPFqxod
	ZzXCezVg2mbedJRdybP0ld+RJw24UW7Cuc8HhDKJHplIIcEvcGF+CNGX73Tr34zBo0PTl2gduew
	Sna4uEYUcxoR8YqegcXk3H4cPJZVZdLyDpjy/7kgdBrv5dHq8/uCvzrSquhB2/lSve8IacqEQdq
	fsPpGKgWv82O/Y9GZmsq7qcWOnDf4ZPie4BF0F23xKVKFLTbaxnKXTpoarumKOJ4khOkJE2EtS4
	u/Vi3pVGyGyaEjYHbZFICIG5bgwMixzVQGISPMAHr6x7zDCUaIiun5SyZap/lhKF9v9QOAPckJ8
	bhODeFFDDts13E1KFG7Gfs1L1wX8m0Gy9KYt3cip1QkRcWK9dm/i75wqsnWQJXHezZgiCZm4PQg
	w==
X-Received: by 2002:a05:6a21:a45:b0:3cc:9288:99aa with SMTP id adf61e73a8af0-3cd00a7d648mr28254730637.0.1787240049078;
        Thu, 20 Aug 2026 08:34:09 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327bf14376asm18452242eec.24.2026.08.20.08.34.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 08:34:08 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Thu, 20 Aug 2026 08:34:07 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Stephen Horvath <linux@stevetech.au>
Cc: Andi Shyti <andi.shyti@kernel.org>, linux-hwmon@vger.kernel.org,
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
	Stephen Horvath <s.horvath@outlook.com.au>
Subject: Re: [PATCH RFC] hwmon: Add Support for PMIC5000 Power Management ICs
Message-ID: <6b8bf838-011f-46b9-a2a8-379de9cceddf@roeck-us.net>
References: <20260819-pmic5000-v1-1-e5e0ddcf0863@stevetech.au>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260819-pmic5000-v1-1-e5e0ddcf0863@stevetech.au>

On Wed, Aug 19, 2026 at 11:37:45PM +1000, Stephen Horvath wrote:
> Add support for sensors present on PMIC5000 (JEDEC JESD301) compliant
> power management ICs. These chips are commonly found on DDR5 memory
> modules.
> 
> Tested against PMIC5100 chips, but only features present in the
> PMIC5000 (JESD301-1) specification have been implemented.
> 
> Signed-off-by: Stephen Horvath <linux@stevetech.au>
> ---
> Hi maintainers, I wrote this over the past couple days and I'm looking
> for feedback.
> 
> Here's a few concerns I have:
> - I'm not too experienced with kernel development.
> - I don't think there's a good way to auto-detect PMIC5000 chips 
> 	standalone, would it be reasonable to instantiate it from
> 	spd5118?
> - I'm unsure what to do with temperatures below 85°C, I'd rather not
> 	return 85 as that would make it seem hotter than it is, but
> 	returning -EOPNOTSUPP seems wrong.
> - Toggling between current and power seems like it's a bit of a hack,
> 	is that okay, or should I just pick one and drop the other?
> - Does this belong in HWMON, or should it be part of the regulator
> 	subsystem?

It depends on its functionality. Is this just for monitoring, or are the voltages
controllable ?


> ---
>  .../devicetree/bindings/trivial-devices.yaml       |   2 +
>  Documentation/hwmon/index.rst                      |   1 +
>  Documentation/hwmon/pmic5000.rst                   | 103 +++
>  drivers/hwmon/Kconfig                              |  12 +
>  drivers/hwmon/Makefile                             |   1 +
>  drivers/hwmon/pmic5000.c                           | 896 +++++++++++++++++++++
>  6 files changed, 1015 insertions(+)
> 
> 
> ---
> base-commit: 75f2c0b3690702c90863c2e138cb5520670845ea
> change-id: 20260819-pmic5000-3840f8a9ade1
> 
> Best regards,
> --  
> Stephen Horvath <linux@stevetech.au>
> 
> diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
> index 2de8eb09cb7d..86e76be7d41b 100644
> --- a/Documentation/devicetree/bindings/trivial-devices.yaml
> +++ b/Documentation/devicetree/bindings/trivial-devices.yaml
> @@ -194,6 +194,8 @@ properties:
>            - isil,isl29030
>              # Intersil ISL76682 Ambient Light Sensor
>            - isil,isl76682
> +            # JEDEC JESD301 (PMIC5000) Power Management IC
> +          - jedec,pmic5000
>              # JEDEC JESD300 (SPD5118) Hub and Serial Presence Detect
>            - jedec,spd5118
>              # Kandou KB9002 PCIe 5.0 retimer
> diff --git a/Documentation/hwmon/index.rst b/Documentation/hwmon/index.rst
> index d979e6d6e9f2..4bb518d1927c 100644
> --- a/Documentation/hwmon/index.rst
> +++ b/Documentation/hwmon/index.rst
> @@ -226,6 +226,7 @@ Hardware Monitoring Kernel Drivers
>     peci-cputemp
>     peci-dimmtemp
>     pmbus
> +   pmic5000
>     powerz
>     powr1220
>     prom21-xhci
> diff --git a/Documentation/hwmon/pmic5000.rst b/Documentation/hwmon/pmic5000.rst
> new file mode 100644
> index 000000000000..e7d864088ba5
> --- /dev/null
> +++ b/Documentation/hwmon/pmic5000.rst
> @@ -0,0 +1,103 @@
> +.. SPDX-License-Identifier: GPL-2.0-or-later
> +
> +Kernel driver pmic5000
> +=====================
> +
> +Supported chips:
> +
> +  * PMIC5000 (JEDEC JESD301) compliant power management chips
> +
> +    JEDEC standard download:
> +	https://www.jedec.org/standards-documents/docs/jesd301-1a03
> +	(account required)
> +
> +
> +    Prefix: 'pmic5000'
> +
> +Author:
> +	Stephen Horvath <linux@stevetech.au>
> +
> +
> +Description
> +-----------
> +
> +This driver implements support for PMIC5000 (JEDEC JESD301) compliant power
> +management chips, which are used on many DDR5 memory modules.
> +
> +The driver does not auto-detect PMIC5000 compliant chips, and must be
> +instantiated manually or via device tree. The address of these chips are
> +usually between (inclusive) 0x48 and 0x4F.
> +
> +
> +Hardware monitoring sysfs entries
> +---------------------------------
> +
> +======================= ==================================
> +in0_enable		Whether SWA is enabled (RO)

Does that enable the voltage or its monitoriong ? The enable attribute is
only to enable monitoring, not to enable the voltage. If this is a
controllable voltage, the driver should be a regulator driver, as Sashiko
suggested.

> +in0_input		SWA Voltage (RO)
> +in0_min			Minimum SWA Voltage (RO)
> +in0_max			Maximum SWA Voltage (RO)
> +in0_min_alarm		SWA Voltage low alarm
> +in0_max_alarm		SWA Voltage high alarm
> +
> +in1_enable		Whether SWB is enabled (RO)
> +in1_input		SWB Voltage (RO)
> +in1_min			Minimum SWB Voltage (RO)
> +in1_max			Maximum SWB Voltage (RO)
> +in1_min_alarm		SWB Voltage low alarm
> +in1_max_alarm		SWB Voltage high alarm
> +
> +in2_enable		Whether SWC is enabled (RO)
> +in2_input		SWC Voltage (RO)
> +in2_min			Minimum SWC Voltage (RO)
> +in2_max			Maximum SWC Voltage (RO)
> +in2_min_alarm		SWC Voltage low alarm
> +in2_max_alarm		SWC Voltage high alarm
> +
> +in3_enable		Whether SWD is enabled (RO)
> +in3_input		SWD Voltage (RO)
> +in3_min			Minimum SWD Voltage (RO)
> +in3_max			Maximum SWD Voltage (RO)
> +in3_min_alarm		SWD Voltage low alarm
> +in3_max_alarm		SWD Voltage high alarm
> +
> +in5_input		VIN_Bulk Voltage (RO)
> +in5_max			Maximum VIN_Bulk Voltage (RO)
> +in5_max_alarm		VIN_Bulk Voltage high alarm
> +
> +in6_input		VIN_Mgmt Voltage (RO)
> +in6_max			Maximum VIN_Mgmt Voltage (RO)
> +in6_max_alarm		VIN_Mgmt Voltage high alarm
> +
> +in7_input		VBias Voltage (RO)
> +in8_input		VOUT_1.8V Voltage (RO)
> +in9_input		VOUT_1.0V Voltage (RO)
> +
> +temp1_input		Temperature (RO)
> +temp1_max		Maximum temperature (RO)
> +temp1_max_alarm		Temperature high alarm
> +
> +power1_input 		SWA Wattage (RO)
> +power2_input 		SWB Wattage (RO)
> +power3_input 		SWC Wattage (RO)
> +power4_input 		SWD Wattage (RO)
> +
> +curr1_input		SWA Current (RO)
> +curr1_max		Maximum SWA Current (RO)
> +curr1_max_alarm		SWA Current high alarm
> +
> +curr2_input		SWB Current (RO)
> +curr2_max		Maximum SWB Current (RO)
> +curr2_max_alarm		SWB Current high alarm
> +
> +curr3_input		SWC Current (RO)
> +curr3_max		Maximum SWC Current (RO)
> +curr3_max_alarm		SWC Current high alarm
> +
> +curr4_input		SWD Current (RO)
> +curr4_max		Maximum SWD Current (RO)
> +curr4_max_alarm		SWD Current high alarm
> +
> +update_interval		Update interval in milliseconds (RW), Allowed values: 1, 2, 4, 8
> +
> +======================= ==================================
> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> index 81a9a1d40eec..5ed5f9499c43 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -950,6 +950,18 @@ config SENSORS_JC42
>  	  This driver can also be built as a module. If so, the module
>  	  will be called jc42.
>  
> +config SENSORS_PMIC5000
> +	tristate "PMIC5000 Compliant Sensors"
> +	depends on I2C
> +	select REGMAP_I2C
> +	help
> +	  If you say yes here you get support for PMIC5000 (JEDEC JESD301)
> +	  compliant sensors. Such sensors are found on DDR5 memory
> +	  modules.
> +
> +	  This driver can also be built as a module. If so, the module
> +	  will be called pmic5000.
> +
>  config SENSORS_POLARFIRE_SOC_TVS
>  	tristate "PolarFire SoC (MPFS) temperature and voltage sensor"
>  	depends on POLARFIRE_SOC_SYSCONS || COMPILE_TEST
> diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
> index 0cad7e21634c..ac519123796f 100644
> --- a/drivers/hwmon/Makefile
> +++ b/drivers/hwmon/Makefile
> @@ -199,6 +199,7 @@ obj-$(CONFIG_SENSORS_NZXT_SMART2) += nzxt-smart2.o
>  obj-$(CONFIG_SENSORS_PC87360)	+= pc87360.o
>  obj-$(CONFIG_SENSORS_PC87427)	+= pc87427.o
>  obj-$(CONFIG_SENSORS_PCF8591)	+= pcf8591.o
> +obj-$(CONFIG_SENSORS_PMIC5000)	+= pmic5000.o
>  obj-$(CONFIG_SENSORS_POLARFIRE_SOC_TVS)  += tvs-mpfs.o
>  obj-$(CONFIG_SENSORS_POWERZ)	+= powerz.o
>  obj-$(CONFIG_SENSORS_POWR1220)  += powr1220.o
> diff --git a/drivers/hwmon/pmic5000.c b/drivers/hwmon/pmic5000.c
> new file mode 100644
> index 000000000000..d3f3126dd9c8
> --- /dev/null
> +++ b/drivers/hwmon/pmic5000.c
> @@ -0,0 +1,896 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Driver for Jedec PMIC5000 compliant sensors
> + *
> + * Copyright (c) 2026 Stephen Horvath
> + *
> + * Inspired by spd5118.c.
> + *
> + * PMIC5000 compliant sensors are typically used on DDR5 memory modules.
> + */
> +
> +#include <linux/bitops.h>
> +#include <linux/bits.h>
> +#include <linux/err.h>
> +#include <linux/hwmon.h>
> +#include <linux/i2c.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/pm.h>
> +#include <linux/regmap.h>
> +#include <linux/units.h>
> +
> +/* PMIC5000 registers. */
> +// clang-format off

No way. Are you serious ?

> +#define PMIC5000_REG_OVER_VOLT_IN	0x08
> +#define PMIC5000_REG_OVER_CURRENT	0x09
> +	#define PMIC5000_HIGH_TEMP		BIT(7)
> +#define PMIC5000_REG_OVER_VOLTAGE	0x0A
> +#define PMIC5000_REG_UNDER_VOLTAGE	0x0B
> +#define PMIC5000_REG_SWA_POWER		0x0C
> +#define PMIC5000_REG_SWB_POWER		0x0D
> +#define PMIC5000_REG_SWC_POWER		0x0E
> +#define PMIC5000_REG_SWD_POWER		0x0F
> +#define PMIC5000_REG_OUTPUT_SELECT	0x1A
> +	#define PMIC5000_OUTPUT_SELECT		BIT(1)
> +#define PMIC5000_REG_THRES_AND_SEL	0x1B
> +	#define PMIC5000_VIN_MGMT_THRESH	BIT(5)
> +	#define PMIC5000_CURR_OR_PWR		BIT(6)
> +	#define PMIC5000_VIN_BULK_THRESH	BIT(7)
> +#define PMIC5000_REG_SWA_CURR_WARN	0x1C
> +#define PMIC5000_REG_SWB_CURR_WARN	0x1D
> +#define PMIC5000_REG_SWC_CURR_WARN	0x1E
> +#define PMIC5000_REG_SWD_CURR_WARN	0x1F
> +#define PMIC5000_REG_SWA_VOLT_SET	0x21
> +#define PMIC5000_REG_SWA_THRESH		0x22
> +#define PMIC5000_REG_SWB_VOLT_SET	0x23
> +#define PMIC5000_REG_SWB_THRESH		0x24
> +#define PMIC5000_REG_SWC_VOLT_SET	0x25
> +#define PMIC5000_REG_SWC_THRESH		0x26
> +#define PMIC5000_REG_SWD_VOLT_SET	0x27
> +#define PMIC5000_REG_SWD_THRESH		0x28
> +#define PMIC5000_REG_SW_VOLT_RANGE	0x2B
> +	#define PMIC5000_SWD_RANGE		BIT(0)
> +	#define PMIC5000_SWC_RANGE		BIT(3)
> +	#define PMIC5000_SWB_RANGE		BIT(4)
> +	#define PMIC5000_SWA_RANGE		BIT(5)
> +#define PMIC5000_REG_REGULATOR_CONTROL	0x2F
> +	#define PMIC5000_SWD_CONTROL		BIT(3)
> +	#define PMIC5000_SWC_CONTROL		BIT(4)
> +	#define PMIC5000_SWB_CONTROL		BIT(5)
> +	#define PMIC5000_SWA_CONTROL		BIT(6)
> +#define PMIC5000_REG_ADC_CONFIG		0x30
> +	#define PMIC5000_ADC_SELECT_MASK	GENMASK(6, 3)
> +	#define PMIC5000_ADC_ENABLE		BIT(7)
> +#define PMIC5000_REG_ADC_VOLTAGE	0x31
> +#define PMIC5000_REG_TEMPERATURE	0x33
> +#define PMIC5000_REG_REVISION		0x3B
> +#define PMIC5000_REG_VENDOR		0x3C
> +
> +

Please run checkpatch --strict on your patches and fix what it reports.

> +/* 125 mA multiplier */
> +#define PMIC5000_CURR_UNIT		125
> +/* 125 mW multiplier */
> +#define PMIC5000_POWER_UNIT		(125 * MILLIWATT_PER_WATT)
> +/* mV multipliers */
> +#define PMIC5000_VOLT_UNIT		15
> +#define PMIC5000_VINBULK_UNIT		70
> +#define PMIC5000_VBIAS_UNIT		25
> +// clang-format on
> +
> +struct pmic5000_data {
> +	struct regmap *regmap;
> +	struct mutex mode_lock;
> +	struct mutex adc_lock;

Explain why those are needed on top of the hwmon subsystem lock.

> +};
> +
> +static const char *const pmic5000_power_labels[] = { "SWA", "SWB", "SWC",
> +						     "SWD" };
> +
> +static const char *const pmic5000_voltage_labels[] = {
> +	"SWA",	    "SWB",	"SWC",	 "SWD",	      NULL,
> +	"VIN_Bulk", "VIN_Mgmt", "VBias", "VOUT_1.8V", "VOUT_1.0V"
> +};
> +
> +/* hwmon */
> +
> +static int pmic5000_check_regulator_enabled(struct regmap *regmap, int channel)

Pretty clear indication that this should be a regulator driver.

> +{
> +	u32 regval;
> +	int err;
> +
> +	err = regmap_read(regmap, PMIC5000_REG_REGULATOR_CONTROL, &regval);
> +	if (err)
> +		return err;
> +	switch (channel) {
> +	case 0:
> +		return !!(regval & PMIC5000_SWA_CONTROL);
> +	case 1:
> +		return !!(regval & PMIC5000_SWB_CONTROL);
> +	case 2:
> +		return !!(regval & PMIC5000_SWC_CONTROL);
> +	case 3:
> +		return !!(regval & PMIC5000_SWD_CONTROL);
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +}
> +
> +static int pmic5000_read_temp(struct regmap *regmap, u32 attr, int channel,
> +			      long *val)
> +{
> +	int err;
> +	u32 regval;
> +
> +	if (channel != 0)
> +		return -EOPNOTSUPP;

Unnecessary check.

> +
> +	switch (attr) {
> +	case hwmon_temp_input: {
> +		err = regmap_read(regmap, PMIC5000_REG_TEMPERATURE, &regval);
> +		if (err)
> +			return err;
> +		regval >>= 5;
> +		/* Below 85°C */
> +		if (regval == 0)
> +			return -EOPNOTSUPP;
> +		/* 0b001 = 85°C, 0b010 = 95°C, etc. */
> +		*val = (75 + regval * 10) * MILLIDEGREE_PER_DEGREE;
> +		return 0;
> +	}
> +	case hwmon_temp_max: {
> +		err = regmap_read(regmap, PMIC5000_REG_THRES_AND_SEL, &regval);
> +		if (err)
> +			return err;
> +		regval &= 0x07;
> +		/* Reserved */
> +		if (regval == 0 || regval == 0x7)
> +			return -EOPNOTSUPP;
> +		*val = (75 + regval * 10) * MILLIDEGREE_PER_DEGREE;
> +		return 0;
> +	}
> +	case hwmon_temp_max_alarm: {
> +		err = regmap_read(regmap, PMIC5000_REG_OVER_CURRENT, &regval);
> +		if (err)
> +			return err;
> +		*val = !!(regval & PMIC5000_HIGH_TEMP);
> +		return 0;
> +	}
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +}
> +
> +static int pmic5000_read_curr(struct pmic5000_data *data, u32 attr, int channel,
> +			      long *val)
> +{
> +	struct regmap *regmap = data->regmap;
> +	int reg, err;
> +	int shift = 0;
> +	u32 regval;
> +
> +	if (attr == hwmon_curr_input) {
> +		mutex_lock(&data->mode_lock);

I don't see why this is needed on top of the hwmon subsystem lock.
Same for other usage of this lock.

> +		/* Select power measurements */
> +		err = regmap_update_bits(regmap, PMIC5000_REG_THRES_AND_SEL,
> +					 PMIC5000_CURR_OR_PWR, 0);
> +		if (err)
> +			goto error;
> +
> +		switch (channel) {
> +		case 0:
> +			reg = PMIC5000_REG_SWA_POWER;
> +			break;
> +		case 1:
> +			reg = PMIC5000_REG_SWB_POWER;
> +			break;
> +		case 2:
> +			reg = PMIC5000_REG_SWC_POWER;
> +			break;
> +		case 3:
> +			reg = PMIC5000_REG_SWD_POWER;
> +			break;
> +		default:
> +			err = -EOPNOTSUPP;
> +			goto error;
> +		}
> +	} else if (attr == hwmon_curr_max) {
> +		shift = 2;
> +		switch (channel) {
> +		case 0:
> +			reg = PMIC5000_REG_SWA_CURR_WARN;
> +			break;
> +		case 1:
> +			reg = PMIC5000_REG_SWB_CURR_WARN;
> +			break;
> +		case 2:
> +			reg = PMIC5000_REG_SWC_CURR_WARN;
> +			break;
> +		case 3:
> +			reg = PMIC5000_REG_SWD_CURR_WARN;
> +			break;
> +		default:
> +			return -EOPNOTSUPP;
> +		}
> +	} else if (attr == hwmon_curr_max_alarm && channel >= 0 &&
> +		   channel <= 3) {

Unnecessary channel checks (at least if the is_visible function does its job
and the info data is correct).

> +		err = regmap_read(regmap, PMIC5000_REG_OVER_CURRENT, &regval);
> +		if (err)
> +			return err;
> +		*val = regval >> (3 - channel) & 0x01;
> +		return 0;
> +	} else {
> +		return -EOPNOTSUPP;
> +	}
> +
> +	err = regmap_read(regmap, reg, &regval);
> +	if (err)
> +		goto error;
> +
> +	if (attr == hwmon_curr_input)
> +		mutex_unlock(&data->mode_lock);
> +
> +	*val = regval * PMIC5000_CURR_UNIT >> shift;
> +	return 0;
> +
> +error:
> +	if (attr == hwmon_curr_input)
> +		mutex_unlock(&data->mode_lock);
> +	return err;
> +}
> +
> +static int pmic5000_read_power(struct pmic5000_data *data, u32 attr,
> +			       int channel, long *val)
> +{
> +	struct regmap *regmap = data->regmap;
> +	int reg, err;
> +	u32 regval;
> +
> +	if (attr != hwmon_power_input)
> +		return -EOPNOTSUPP;
> +
> +	mutex_lock(&data->mode_lock);
> +	/* Select power measurements */
> +	err = regmap_update_bits(regmap, PMIC5000_REG_THRES_AND_SEL,
> +				 PMIC5000_CURR_OR_PWR, PMIC5000_CURR_OR_PWR);
> +	if (err)
> +		goto error;
> +
> +	switch (channel) {
> +	case 0:
> +		reg = PMIC5000_REG_SWA_POWER;
> +		break;
> +	case 1:
> +		reg = PMIC5000_REG_SWB_POWER;
> +		break;
> +	case 2:
> +		reg = PMIC5000_REG_SWC_POWER;
> +		break;
> +	case 3:
> +		reg = PMIC5000_REG_SWD_POWER;
> +		break;
> +	default:
> +		err = -EOPNOTSUPP;
> +		goto error;
> +	}
> +
> +	err = regmap_read(regmap, reg, &regval);
> +	if (err)
> +		goto error;
> +
> +	mutex_unlock(&data->mode_lock);
> +
> +	*val = regval * PMIC5000_POWER_UNIT;
> +	return 0;
> +
> +error:
> +	mutex_unlock(&data->mode_lock);
> +	return err;
> +}
> +
> +static int pmic5000_read_volt_thresholds(struct regmap *regmap, u32 attr,
> +					 int channel, long *val)
> +{
> +	int err;
> +	u32 set_reg, thresh_reg, range_bit;
> +	u32 set_regval, thresh_regval, range_regval;
> +	u32 volt_set;
> +	int base_volts[2];
> +
> +	switch (channel) {
> +	case 0:
> +		set_reg = PMIC5000_REG_SWA_VOLT_SET;
> +		thresh_reg = PMIC5000_REG_SWA_THRESH;
> +		range_bit = PMIC5000_SWA_RANGE;
> +		base_volts[0] = 800;
> +		base_volts[1] = 600;
> +		break;
> +	case 1:
> +		set_reg = PMIC5000_REG_SWB_VOLT_SET;
> +		thresh_reg = PMIC5000_REG_SWB_THRESH;
> +		range_bit = PMIC5000_SWB_RANGE;
> +		base_volts[0] = 800;
> +		base_volts[1] = 600;
> +		break;
> +	case 2:
> +		set_reg = PMIC5000_REG_SWC_VOLT_SET;
> +		thresh_reg = PMIC5000_REG_SWC_THRESH;
> +		range_bit = PMIC5000_SWC_RANGE;
> +		base_volts[0] = 800;
> +		base_volts[1] = 600;
> +		break;
> +	case 3:
> +		set_reg = PMIC5000_REG_SWD_VOLT_SET;
> +		thresh_reg = PMIC5000_REG_SWD_THRESH;
> +		range_bit = PMIC5000_SWD_RANGE;
> +		base_volts[0] = 1500;
> +		base_volts[1] = 2200;
> +		break;
> +	case 5:
> +	case 6: {

Why "{" ?

> +		err = regmap_read(regmap, PMIC5000_REG_THRES_AND_SEL,
> +				  &thresh_regval);
> +		if (err)
> +			return err;
> +		if (channel == 5) {
> +			if (thresh_regval & PMIC5000_VIN_BULK_THRESH)
> +				*val = 14500;
> +			else
> +				*val = 16000;
> +			return 0;
> +		} else {
> +			if (thresh_regval & PMIC5000_VIN_MGMT_THRESH)
> +				*val = 3800;
> +			else
> +				*val = 3700;
> +			return 0;
> +		}
> +	}
> +
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +
> +	err = regmap_read(regmap, set_reg, &set_regval);
> +	if (err)
> +		return err;
> +	err = regmap_read(regmap, thresh_reg, &thresh_regval);
> +	if (err)
> +		return err;
> +	err = regmap_read(regmap, PMIC5000_REG_SW_VOLT_RANGE, &range_regval);
> +	if (err)
> +		return err;
> +
> +	volt_set = range_regval & range_bit ? base_volts[1] : base_volts[0];
> +	volt_set += (set_regval >> 1) * 5;
> +
> +	switch (attr) {
> +	case hwmon_in_min:
> +		/* 10%, 12.5%, Reserved, Reserved */
> +		const int min_permilles[4] = { 100, 125, PERMILLE, PERMILLE };
> +		*val = volt_set - (min_permilles[(thresh_regval >> 2) & 0x03] *
> +				   volt_set / PERMILLE);
> +		return 0;
> +	case hwmon_in_max:
> +		/* 7.5%, 10%, 12.5%, Reserved */
> +		const int max_permilles[4] = { 75, 100, 125, PERMILLE };
> +		*val = volt_set + (max_permilles[(thresh_regval >> 4) & 0x03] *
> +				   volt_set / PERMILLE);
> +		return 0;
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +}
> +
> +static int pmic5000_read_adc_alarms(struct regmap *regmap, u32 attr,
> +				    int channel, long *val)
> +{
> +	int err;
> +	u32 regval;
> +
> +	if (channel >= 0 && channel <= 3) {

channel is always >= 0.

> +		switch (attr) {
> +		case hwmon_in_min_alarm: {
> +			err = regmap_read(regmap, PMIC5000_REG_UNDER_VOLTAGE,
> +					  &regval);
> +			if (err)
> +				return err;
> +			*val = regval >> (3 - channel) & 0x01;
> +			return 0;
> +		}
> +		case hwmon_in_max_alarm: {
> +			err = regmap_read(regmap, PMIC5000_REG_OVER_VOLTAGE,
> +					  &regval);
> +			if (err)
> +				return err;
> +			*val = regval >> (7 - channel) & 0x01;
> +			return 0;
> +		}
> +		}

Alignment.

> +	} else if (channel == 5 || channel == 6) {
> +		switch (attr) {
> +		case hwmon_in_max_alarm: {
> +			err = regmap_read(regmap, PMIC5000_REG_OVER_VOLT_IN,
> +					  &regval);
> +			if (err)
> +				return err;
> +			*val = regval >> (channel - 4) & 0x01;
> +			return 0;
> +		}
> +		}
> +	}
> +
> +	return -EOPNOTSUPP;
> +}
> +
> +static int pmic5000_read_adc(struct pmic5000_data *data, u32 attr, int channel,
> +			     long *val)
> +{
> +	struct regmap *regmap = data->regmap;
> +	int err, mult;
> +	u32 regval;
> +
> +	switch (attr) {
> +	case hwmon_in_enable:
> +		err = pmic5000_check_regulator_enabled(regmap, channel);
> +		if (err < 0)
> +			return err;
> +		*val = err;
> +		return 0;

The enable attribute is supposed to enable or disable monitoring.
It is not supposed to report regulator status.

> +	case hwmon_in_input:
> +		break;
> +	case hwmon_in_min:
> +	case hwmon_in_max:
> +		return pmic5000_read_volt_thresholds(regmap, attr, channel,
> +						     val);
> +	case hwmon_in_min_alarm:
> +	case hwmon_in_max_alarm:
> +		return pmic5000_read_adc_alarms(regmap, attr, channel, val);
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +
> +	/* Channel 4 is reserved */
> +	if (channel < 0 || channel > 9 || channel == 4)
> +		return -EOPNOTSUPP;

Then it should not be enabled by the is_visible function.
Also, channel is never < 0 or > 9.

> +
> +	switch (channel) {
 +	case 5:
> +		mult = PMIC5000_VINBULK_UNIT;
> +		break;
> +	case 7:
> +		mult = PMIC5000_VBIAS_UNIT;
> +		break;
> +	default:
> +		mult = PMIC5000_VOLT_UNIT;
> +		break;
> +	}
> +
> +	mutex_lock(&data->adc_lock);
> +
> +	err = regmap_update_bits(regmap, PMIC5000_REG_ADC_CONFIG,
> +				 PMIC5000_ADC_SELECT_MASK, channel << 3);
> +	if (err)
> +		goto error;
> +
> +	/*
> +	 * The host shall wait minimum of 9 ms delay after the input selection
> +	 * for ADC readout and the actual readout
> +	 *
> +	 * msleep may sleep for up to 20ms, which is fine.

No, it isn't fine.

Also, why wait if the channel was not changed ?

> +	 */
> +	msleep(9);
> +
> +	err = regmap_read(regmap, PMIC5000_REG_ADC_VOLTAGE, &regval);
> +	if (err)
> +		goto error;
> +
> +	mutex_unlock(&data->adc_lock);
> +
> +	*val = regval * mult;
> +	return 0;
> +
> +error:
> +	mutex_unlock(&data->adc_lock);
> +	return err;
> +}
> +
> +static int pmic5000_read_interval(struct regmap *regmap, u32 attr, long *val)
> +{
> +	unsigned int regval;
> +	int err;
> +
> +	if (attr != hwmon_chip_update_interval)
> +		return -EOPNOTSUPP;
> +
> +	err = regmap_read(regmap, PMIC5000_REG_ADC_CONFIG, &regval);
> +	if (err < 0)
> +		return err;
> +	*val = 1 << (regval & 0x03);

		BIT()

> +	return 0;
> +}
> +
> +static int pmic5000_read(struct device *dev, enum hwmon_sensor_types type,
> +			 u32 attr, int channel, long *val)
> +{
> +	struct pmic5000_data *data = dev_get_drvdata(dev);
> +	struct regmap *regmap = data->regmap;
> +
> +	switch (type) {
> +	case hwmon_chip:
> +		return pmic5000_read_interval(regmap, attr, val);
> +	case hwmon_temp:
> +		return pmic5000_read_temp(regmap, attr, channel, val);
> +	case hwmon_in:
> +		return pmic5000_read_adc(data, attr, channel, val);
> +	case hwmon_curr:
> +		return pmic5000_read_curr(data, attr, channel, val);
> +	case hwmon_power:
> +		return pmic5000_read_power(data, attr, channel, val);
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +}
> +
> +static int pmic5000_read_string(struct device *dev,
> +				enum hwmon_sensor_types type, u32 attr,
> +				int channel, const char **str)
> +{
> +	if (type == hwmon_curr && attr == hwmon_curr_label) {
> +		if (channel < 0 || channel > 3)
> +			return -EOPNOTSUPP;

Again, channel is never < 0, and unless is_visible and/or the configuration data is wrong
it should never be > 3.

> +		*str = pmic5000_power_labels[channel];
> +	} else if (type == hwmon_power && attr == hwmon_power_label) {
> +		if (channel < 0 || channel > 3)
> +			return -EOPNOTSUPP;
> +		*str = pmic5000_power_labels[channel];
> +	} else if (type == hwmon_in && attr == hwmon_in_label) {
> +		if (channel < 0 || channel > 9 || channel == 4)

Many more unencessary channel checks.

> +			return -EOPNOTSUPP;
> +		*str = pmic5000_voltage_labels[channel];
> +	} else {
> +		return -EOPNOTSUPP;
> +	}
> +
> +	return 0;
> +}
> +
> +static int pmic5000_write_interval(struct pmic5000_data *data, long val)
> +{
> +	struct regmap *regmap = data->regmap;
> +	u32 regval;
> +	int err;
> +
> +	switch (val) {
> +	case 1:
> +		regval = 0;
> +		break;
> +	case 2:
> +		regval = 1;
> +		break;
> +	case 4:
> +		regval = 2;
> +		break;
> +	case 8:
> +		regval = 3;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}

find_closest() would be more appropriate here. We don't usually expect users to know valid
update intervals.

> +
> +	mutex_lock(&data->adc_lock);
> +	err = regmap_update_bits(regmap, PMIC5000_REG_ADC_CONFIG, 0x03, regval);
> +	mutex_unlock(&data->adc_lock);

Another unnecessary lock.

> +	return err;
> +}
> +
> +static int pmic5000_write(struct device *dev, enum hwmon_sensor_types type,
> +			  u32 attr, int channel, long val)
> +{
> +	struct pmic5000_data *data = dev_get_drvdata(dev);
> +
> +	switch (type) {
> +	case hwmon_chip:
> +		return pmic5000_write_interval(data, val);
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +}
> +
> +static umode_t pmic5000_is_visible(const void *data,
> +				   enum hwmon_sensor_types type, u32 attr,
> +				   int channel)
> +{
> +	int ret;
> +	struct pmic5000_data *pmic_data = (struct pmic5000_data *)data;
> +	struct regmap *regmap = pmic_data->regmap;
> +
> +	switch (type) {
> +	case hwmon_chip:
> +		if (attr == hwmon_chip_update_interval)
> +			return 0644;
> +		break;
> +	case hwmon_temp:
> +		return 0444;
> +	case hwmon_in:
> +		if (channel == 4)
> +			return 0;
> +		if (channel >= 0 && channel <= 3 && (attr != hwmon_in_enable)) {
> +			ret = pmic5000_check_regulator_enabled(regmap, channel);
> +			if (!ret || ret < 0)
> +				return 0;
> +		}
> +		return 0444;
> +	case hwmon_power:
> +		if (channel >= 0 && channel <= 3) {
> +			ret = pmic5000_check_regulator_enabled(regmap, channel);
> +			if (!ret || ret < 0)
> +				return 0;
> +		}
> +		return 0444;
> +	case hwmon_curr:
> +		if (channel >= 0 && channel <= 3) {
> +			ret = pmic5000_check_regulator_enabled(regmap, channel);
> +			if (!ret || ret < 0)
> +				return 0;
> +		}
> +		return 0444;
> +	default:
> +		break;
> +	}
> +	return 0444;
> +}
> +
> +/*
> + * Bank and vendor id are 8-bit fields with seven data bits and odd parity.
> + * Vendor IDs 0 and 0x7f are invalid.
> + * See Jedec standard JEP106BJ for details and a list of assigned vendor IDs.
> + */
> +static bool pmic5000_vendor_valid(u8 bank, u8 id)
> +{
> +	if (parity8(bank) == 0 || parity8(id) == 0)
> +		return false;
> +
> +	id &= 0x7f;
> +	return id && id != 0x7f;
> +}
> +
> +static const struct hwmon_channel_info *pmic5000_info[] = {
> +	HWMON_CHANNEL_INFO(chip, HWMON_C_UPDATE_INTERVAL),
> +	HWMON_CHANNEL_INFO(temp,
> +			   HWMON_T_INPUT | HWMON_T_MAX | HWMON_T_MAX_ALARM),
> +	HWMON_CHANNEL_INFO(
> +		in,
> +		HWMON_I_ENABLE | HWMON_I_INPUT | HWMON_I_MIN | HWMON_I_MAX |
> +			HWMON_I_MIN_ALARM | HWMON_I_MAX_ALARM | HWMON_I_LABEL,
> +		HWMON_I_ENABLE | HWMON_I_INPUT | HWMON_I_MIN | HWMON_I_MAX |
> +			HWMON_I_MIN_ALARM | HWMON_I_MAX_ALARM | HWMON_I_LABEL,
> +		HWMON_I_ENABLE | HWMON_I_INPUT | HWMON_I_MIN | HWMON_I_MAX |
> +			HWMON_I_MIN_ALARM | HWMON_I_MAX_ALARM | HWMON_I_LABEL,
> +		HWMON_I_ENABLE | HWMON_I_INPUT | HWMON_I_MIN | HWMON_I_MAX |
> +			HWMON_I_MIN_ALARM | HWMON_I_MAX_ALARM | HWMON_I_LABEL,
> +		HWMON_I_INPUT,
> +		HWMON_I_INPUT | HWMON_I_MAX | HWMON_I_MAX_ALARM | HWMON_I_LABEL,
> +		HWMON_I_INPUT | HWMON_I_MAX | HWMON_I_MAX_ALARM | HWMON_I_LABEL,
> +		HWMON_I_INPUT | HWMON_I_LABEL, HWMON_I_INPUT | HWMON_I_LABEL,
> +		HWMON_I_INPUT | HWMON_I_LABEL),
> +	HWMON_CHANNEL_INFO(
> +		curr,
> +		HWMON_C_INPUT | HWMON_C_MAX | HWMON_C_MAX_ALARM | HWMON_C_LABEL,
> +		HWMON_C_INPUT | HWMON_C_MAX | HWMON_C_MAX_ALARM | HWMON_C_LABEL,
> +		HWMON_C_INPUT | HWMON_C_MAX | HWMON_C_MAX_ALARM | HWMON_C_LABEL,
> +		HWMON_C_INPUT | HWMON_C_MAX | HWMON_C_MAX_ALARM |
> +			HWMON_C_LABEL),
> +	HWMON_CHANNEL_INFO(power, HWMON_P_INPUT | HWMON_P_LABEL,
> +			   HWMON_P_INPUT | HWMON_P_LABEL,
> +			   HWMON_P_INPUT | HWMON_P_LABEL,
> +			   HWMON_P_INPUT | HWMON_P_LABEL),
> +	NULL
> +};
> +
> +static const struct hwmon_ops pmic5000_hwmon_ops = {
> +	.is_visible = pmic5000_is_visible,
> +	.read = pmic5000_read,
> +	.read_string = pmic5000_read_string,
> +	.write = pmic5000_write,
> +};
> +
> +static const struct hwmon_chip_info pmic5000_chip_info = {
> +	.ops = &pmic5000_hwmon_ops,
> +	.info = pmic5000_info,
> +};
> +
> +/* regmap */
> +
> +static bool pmic5000_writeable_reg(struct device *dev, unsigned int reg)
> +{
> +	switch (reg) {
> +	case PMIC5000_REG_OUTPUT_SELECT:
> +	case PMIC5000_REG_THRES_AND_SEL:
> +	case PMIC5000_REG_ADC_CONFIG:
> +		return true;
> +	default:
> +		return false;
> +	}
> +}
> +
> +static bool pmic5000_volatile_reg(struct device *dev, unsigned int reg)
> +{
> +	switch (reg) {
> +	case PMIC5000_REG_OVER_VOLT_IN:
> +	case PMIC5000_REG_OVER_CURRENT:
> +	case PMIC5000_REG_OVER_VOLTAGE:
> +	case PMIC5000_REG_UNDER_VOLTAGE:
> +	case PMIC5000_REG_SWA_POWER:
> +	case PMIC5000_REG_SWB_POWER:
> +	case PMIC5000_REG_SWC_POWER:
> +	case PMIC5000_REG_SWD_POWER:
> +	case PMIC5000_REG_ADC_VOLTAGE:
> +	case PMIC5000_REG_TEMPERATURE:
> +		return true;
> +	default:
> +		return false;
> +	}
> +}
> +
> +static const struct regmap_config pmic5000_regmap8_config = {
> +	.reg_bits = 8,
> +	.val_bits = 8,
> +	.max_register = 0x3f,
> +	.writeable_reg = pmic5000_writeable_reg,
> +	.volatile_reg = pmic5000_volatile_reg,
> +	.cache_type = REGCACHE_MAPLE,
> +};
> +
> +static int pmic5000_suspend(struct device *dev)
> +{
> +	struct pmic5000_data *data = dev_get_drvdata(dev);
> +	struct regmap *regmap = data->regmap;
> +	u32 regval;
> +	int err;
> +
> +	/*
> +	 * Make sure the configuration register in the regmap cache is current
> +	 * before bypassing it.
> +	 */
> +	err = regmap_read(regmap, PMIC5000_REG_ADC_CONFIG, &regval);
> +	if (err < 0)
> +		return err;
> +
> +	regcache_cache_bypass(regmap, true);
> +	regmap_update_bits(regmap, PMIC5000_REG_ADC_CONFIG, PMIC5000_ADC_ENABLE,
> +			   0);
> +	regcache_cache_bypass(regmap, false);
> +
> +	regcache_cache_only(regmap, true);
> +	regcache_mark_dirty(regmap);
> +
> +	return 0;
> +}
> +
> +static int pmic5000_resume(struct device *dev)
> +{
> +	struct pmic5000_data *data = dev_get_drvdata(dev);
> +	struct regmap *regmap = data->regmap;
> +
> +	regcache_cache_only(regmap, false);
> +	return regcache_sync(regmap);
> +}
> +
> +static DEFINE_SIMPLE_DEV_PM_OPS(pmic5000_pm_ops, pmic5000_suspend,
> +				pmic5000_resume);
> +
> +static int pmic5000_common_probe(struct device *dev, struct regmap *regmap)

Why pmic5000_common_probe() ? There is only one caller.

> +{
> +	unsigned int revision, vendor, bank;
> +	struct pmic5000_data *data;
> +	struct device *hwmon_dev;
> +	int err;
> +
> +	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	err = regmap_read(regmap, PMIC5000_REG_REVISION, &revision);
> +	if (err)
> +		return err;
> +
> +	err = regmap_read(regmap, PMIC5000_REG_VENDOR, &bank);
> +	if (err)
> +		return err;
> +	err = regmap_read(regmap, PMIC5000_REG_VENDOR + 1, &vendor);
> +	if (err)
> +		return err;
> +	if (!pmic5000_vendor_valid(bank, vendor))
> +		return -ENODEV;
> +
> +	data->regmap = regmap;
> +	mutex_init(&data->mode_lock);
> +	mutex_init(&data->adc_lock);
> +	dev_set_drvdata(dev, data);
> +
> +	hwmon_dev = devm_hwmon_device_register_with_info(
> +		dev, "pmic5000", data, &pmic5000_chip_info, NULL);
> +	if (IS_ERR(hwmon_dev))
> +		return PTR_ERR(hwmon_dev);
> +
> +	dev_info(dev, "DDR5 PMIC sensor: vendor 0x%02x:0x%02x revision %d.%d\n",
> +		 bank & 0x7f, vendor, ((revision >> 4) & 0x03) + 1,
> +		 ((revision >> 1) & 0x07) + 1);
> +
> +	/* Enable individual measurements and enable ADC */
> +	err = regmap_update_bits(regmap, PMIC5000_REG_OUTPUT_SELECT,
> +				 PMIC5000_OUTPUT_SELECT,
> +				 PMIC5000_OUTPUT_SELECT);
> +	if (err)
> +		return err;
> +	err = regmap_update_bits(regmap, PMIC5000_REG_ADC_CONFIG,
> +				 PMIC5000_ADC_ENABLE, PMIC5000_ADC_ENABLE);
> +	if (err)
> +		return err;
> +
> +	return 0;
> +}
> +
> +/* I2C */
> +
> +static int pmic5000_i2c_init(struct i2c_client *client)
> +{
> +	struct i2c_adapter *adapter = client->adapter;
> +
> +	/*
> +	 * Register accesses are 8-bit, so require byte-data transactions only.
> +	 * Requiring WORD_DATA here rejects otherwise valid adapters.
> +	 */
> +	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA))
> +		return -ENODEV;
> +
> +	return 0;
> +}
> +
> +static int pmic5000_i2c_probe(struct i2c_client *client)
> +{
> +	struct device *dev = &client->dev;
> +	struct regmap *regmap;
> +	int err;
> +
> +	err = pmic5000_i2c_init(client);
> +	if (err)
> +		return dev_err_probe(dev, err, "I2C capability check failed\n");
> +
> +	regmap = devm_regmap_init_i2c(client, &pmic5000_regmap8_config);
> +	if (IS_ERR(regmap))
> +		return dev_err_probe(dev, PTR_ERR(regmap),
> +				     "regmap init failed\n");
> +
> +	return pmic5000_common_probe(dev, regmap);
> +}
> +
> +static const struct i2c_device_id pmic5000_i2c_id[] = { { .name = "pmic5000" },
> +							{} };
> +MODULE_DEVICE_TABLE(i2c, pmic5000_i2c_id);
> +
> +static const struct of_device_id pmic5000_of_ids[] = {
> +	{
> +		.compatible = "jedec,pmic5000",

jedec,pmic5000 is not documented.

> +	},
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, pmic5000_of_ids);
> +
> +static struct i2c_driver pmic5000_i2c_driver = {
> +	.class		= I2C_CLASS_HWMON,
> +	.driver = {
> +		.name	= "pmic5000",
> +		.of_match_table = pmic5000_of_ids,
> +		.pm = pm_sleep_ptr(&pmic5000_pm_ops),
> +	},
> +	.probe		= pmic5000_i2c_probe,
> +	.id_table	= pmic5000_i2c_id,
> +};
> +
> +module_i2c_driver(pmic5000_i2c_driver);
> +
> +MODULE_AUTHOR("Stephen Horvath <linux@stevetech.au>");
> +MODULE_DESCRIPTION("PMIC5000 driver");
> +MODULE_LICENSE("GPL");
