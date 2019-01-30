From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH] mfd: Fix I2C_DESIGNWARE_PLATFORM dependencies
Date: Wed, 30 Jan 2019 13:09:27 +0000
Message-ID: <20190130130927.GD4701@dell>
References: <20190121141128.5283-1-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190121141128.5283-1-jarkko.nikula@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>, Hans de Goede <hdegoede@redhat.com>, Rajmohan Mani <rajmohan.mani@intel.com>, linux-i2c@vger.kernel.org, Stable <stable@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

On Mon, 21 Jan 2019, Jarkko Nikula wrote:

> INTEL_SOC_PMIC, INTEL_SOC_PMIC_CHTWC and MFD_TPS68470 select the
> I2C_DESIGNWARE_PLATFORM without its dependencies making it possible to see
> warning and build error like below:
> 
> WARNING: unmet direct dependencies detected for I2C_DESIGNWARE_PLATFORM
>   Depends on [n]: I2C [=y] && HAS_IOMEM [=y] && (ACPI [=y] && COMMON_CLK [=n] || !ACPI [=y])
>   Selected by [y]:
>   - MFD_TPS68470 [=y] && HAS_IOMEM [=y] && ACPI [=y] && I2C [=y]=y
> 
> /usr/bin/ld: drivers/i2c/busses/i2c-designware-platdrv.o: in function `dw_i2c_plat_resume':
> i2c-designware-platdrv.c:(.text+0x62): undefined reference to `i2c_dw_prepare_clk'
> /usr/bin/ld: drivers/i2c/busses/i2c-designware-platdrv.o: in function `dw_i2c_plat_suspend':
> i2c-designware-platdrv.c:(.text+0x9a): undefined reference to `i2c_dw_prepare_clk'
> /usr/bin/ld: drivers/i2c/busses/i2c-designware-platdrv.o: in function `dw_i2c_plat_probe':
> i2c-designware-platdrv.c:(.text+0x41c): undefined reference to `i2c_dw_prepare_clk'
> /usr/bin/ld: i2c-designware-platdrv.c:(.text+0x438): undefined reference to `i2c_dw_read_comp_param'
> /usr/bin/ld: i2c-designware-platdrv.c:(.text+0x545): undefined reference to `i2c_dw_probe'
> /usr/bin/ld: i2c-designware-platdrv.c:(.text+0x727): undefined reference to `i2c_dw_probe_slave'
> 
> Fix this by making above options to depend on I2C_DESIGNWARE_PLATFORM
> being built-in. I2C_DESIGNWARE_PLATFORM is a visible symbol with
> dependencies so in general the select should be avoided.
> 
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Fixes: acebcff9eda8 ("mfd: intel_soc_pmic: Select designware i2c-bus driver")
> Fixes: de85d79f4aab ("mfd: Add Cherry Trail Whiskey Cove PMIC driver")
> Fixes: 9bbf6a15ce19 ("mfd: Add support for TPS68470 device")
> Cc: Stable <stable@vger.kernel.org> # v4.14+
> Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
> ---
>  drivers/mfd/Kconfig | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
