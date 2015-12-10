From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH 2/2] i2c: designware: Allow build Baytrail semaphore
 support when IOSF_MBI=m
Date: Thu, 10 Dec 2015 14:59:38 +0200
Message-ID: <1449752378.30729.89.camel@linux.intel.com>
References: <1449748124-20744-1-git-send-email-jarkko.nikula@linux.intel.com>
	 <1449748124-20744-2-git-send-email-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:21965 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750923AbbLJNBd (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Thu, 10 Dec 2015 08:01:33 -0500
In-Reply-To: <1449748124-20744-2-git-send-email-jarkko.nikula@linux.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>, linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>, Mika Westerberg <mika.westerberg@linux.intel.com>, David Box <david.e.box@linux.intel.com>

On Thu, 2015-12-10 at 13:48 +0200, Jarkko Nikula wrote:
> I believe i2c-designware-baytrail.c doesn't have strict dependency
> that
> Intel SoC IOSF Sideband support must be always built-in in order to
> be
> able to compile support for Intel Baytrail I2C bus sharing HW
> semaphore.
>=20
> Redefine build dependencies so that CONFIG_IOSF_MBI=3Dy is required
> only
> when CONFIG_I2C_DESIGNWARE_PLATFORM is built-in.
>=20
> Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
> ---
> Hi David. Can you ack/nak this patch as I'm not fully familiar with
> this
> HW semaphore can there be problems when IOSF_MBI is built as a
> module.


> At least I'm getting similar sensible looking "punit semaphore
> acquired/held for x ms" debug messages when I modprobe/rmmod
> i2c_designware_platform independently is the CONFIG_IOSF_MBI=3Dy or =3D=
m.
> ---
> =C2=A0drivers/i2c/busses/Kconfig | 4 +++-
> =C2=A01 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
> index 69c46fe13777..76f4d024def0 100644
> --- a/drivers/i2c/busses/Kconfig
> +++ b/drivers/i2c/busses/Kconfig
> @@ -490,7 +490,9 @@ config I2C_DESIGNWARE_PCI
> =C2=A0
> =C2=A0config I2C_DESIGNWARE_BAYTRAIL
> =C2=A0	bool "Intel Baytrail I2C semaphore support"
> -	depends on I2C_DESIGNWARE_PLATFORM && IOSF_MBI=3Dy && ACPI
> +	depends on ACPI
> +	depends on (I2C_DESIGNWARE_PLATFORM=3Dm && IOSF_MBI) || \
> +		=C2=A0=C2=A0=C2=A0(I2C_DESIGNWARE_PLATFORM=3Dy && IOSF_MBI=3Dy)

Would it be more readable in the following way

depends on ACPI
depends on I2C_DESIGNWARE_PLATFORM
depends on IOSF_MBI if=C2=A0I2C_DESIGNWARE_PLATFORM=3Dm
depends on IOSF_MBI=3Dy if=C2=A0I2C_DESIGNWARE_PLATFORM=3Dy

> =C2=A0	help
> =C2=A0	=C2=A0=C2=A0This driver enables managed host access to the PMI=
C I2C
> bus on select
> =C2=A0	=C2=A0=C2=A0Intel BayTrail platforms using the X-Powers AXP288=
 PMIC.
> It allows

--=20
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
