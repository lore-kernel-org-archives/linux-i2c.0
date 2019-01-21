From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: Re: linux-next: Tree for Jan 18 (i2c-designware-platdrv.c)
Date: Mon, 21 Jan 2019 15:36:21 +0200
Message-ID: <018b454e-ecd8-0ebe-40cc-ab64d3deea00@linux.intel.com>
References: <20190118152404.41ecbe4e@canb.auug.org.au>
 <590dd86f-93ce-16c3-932e-c5ce53035ab2@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <590dd86f-93ce-16c3-932e-c5ce53035ab2@infradead.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Randy Dunlap <rdunlap@infradead.org>, Stephen Rothwell <sfr@canb.auug.org.au>, Linux Next Mailing List <linux-next@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Baruch Siach <baruch@tkos.co.il>, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Hi

On 1/18/19 6:27 PM, Randy Dunlap wrote:
> On 1/17/19 8:24 PM, Stephen Rothwell wrote:
>> Hi all,
>>
>> Changes since 20190117:
>>
> 
> on i386 or x86_64:
> 
> ld: drivers/i2c/busses/i2c-designware-platdrv.o: in function `dw_i2c_plat_resume':
> i2c-designware-platdrv.c:(.text+0x4b): undefined reference to `i2c_dw_prepare_clk'
> ld: drivers/i2c/busses/i2c-designware-platdrv.o: in function `dw_i2c_plat_suspend':
> i2c-designware-platdrv.c:(.text+0x95): undefined reference to `i2c_dw_prepare_clk'
> ld: drivers/i2c/busses/i2c-designware-platdrv.o: in function `dw_i2c_plat_probe':
> i2c-designware-platdrv.c:(.text+0x63f): undefined reference to `i2c_dw_prepare_clk'
> ld: i2c-designware-platdrv.c:(.text+0x686): undefined reference to `i2c_dw_read_comp_param'
> ld: i2c-designware-platdrv.c:(.text+0x7b7): undefined reference to `i2c_dw_probe_slave'
> ld: i2c-designware-platdrv.c:(.text+0x7c1): undefined reference to `i2c_dw_probe'
> 
> 
> probably related to:
> 
> WARNING: unmet direct dependencies detected for I2C_DESIGNWARE_PLATFORM
>    Depends on [n]: I2C [=y] && HAS_IOMEM [=y] && (ACPI [=y] && COMMON_CLK [=n] || !ACPI [=y])
>    Selected by [y]:
>    - MFD_TPS68470 [=y] && HAS_IOMEM [=y] && ACPI [=y] && I2C [=y]=y
> 
Thanks, this is due CONFIG_MFD_TPS68470 which selects the 
I2C_DESIGNWARE_PLATFORM but not the dependencies. There are two others 
in drivers/mfd/Kconfig. I'll send a patch changing them to depend on 
I2C_DESIGNWARE_PLATFORM=y.

-- 
Jarkko
