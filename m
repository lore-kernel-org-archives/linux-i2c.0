From: Peter Rosin <peda@axentia.se>
Subject: Re: [PATCH] i2c: Add support for NXP PCA984x family.
Date: Mon, 11 Dec 2017 13:51:30 +0100
Message-ID: <38777c0b-fc81-3af5-e96d-d0ab1bb83d85@axentia.se>
References: <20171211111022.30333-1-adrian.fiergolski@cern.ch>
 <dd092e72-dc8a-7847-ae4d-aaa65fe6b3d7@enneenne.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-db5eur01on0135.outbound.protection.outlook.com ([104.47.2.135]:37849
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753082AbdLKMvh (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 11 Dec 2017 07:51:37 -0500
In-Reply-To: <dd092e72-dc8a-7847-ae4d-aaa65fe6b3d7@enneenne.com>
Content-Language: en-US
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Rodolfo Giometti <giometti@enneenne.com>, Adrian Fiergolski <adrian.fiergolski@cern.ch>, linux-i2c@vger.kernel.org
Cc: giometti@linux.it

On 2017-12-11 12:25, Rodolfo Giometti wrote:
> On 11/12/17 12:10, Adrian Fiergolski wrote:
>> This patch exetends the current i2c-mux-pca954x driver and adds suuport for
>> a newer PCA984x family of the I2C switches and multiplexers from NXP.
>> In probe function, the patch supports device ID function, introduced in the
>> new family, and checks it against configuration provided by the
>> devicetree. Moreover, it also performs software reset which is now
>> available for the new devices.
>> The reset of the code remains common with the legacy PCA954x devices.
>>
>> Signed-off-by: Adrian Fiergolski <adrian.fiergolski@cern.ch>
>> ---
>>   .../{i2c-mux-pca954x.txt => i2c-mux-pca9x4x.txt}   |   5 +-
>>   arch/arm/configs/aspeed_g4_defconfig               |   2 +-
>>   arch/arm/configs/aspeed_g5_defconfig               |   2 +-
>>   arch/arm/configs/multi_v7_defconfig                |   2 +-
>>   arch/arm/configs/pxa_defconfig                     |   2 +-
>>   arch/arm/configs/tegra_defconfig                   |   2 +-
>>   arch/arm64/configs/defconfig                       |   2 +-
>>   arch/powerpc/configs/85xx-hw.config                |   2 +-
>>   drivers/i2c/muxes/Kconfig                          |   6 +-
>>   drivers/i2c/muxes/Makefile                         |   2 +-
>>   drivers/i2c/muxes/i2c-mux-pca9541.c                |   4 +-
>>   .../muxes/{i2c-mux-pca954x.c => i2c-mux-pca9x4x.c} | 295 ++++++++++++++++-----
>>   .../linux/platform_data/{pca954x.h => pca9x4x.h}   |  15 +-
>>   13 files changed, 246 insertions(+), 95 deletions(-)
>>   rename Documentation/devicetree/bindings/i2c/{i2c-mux-pca954x.txt => i2c-mux-pca9x4x.txt} (91%)
>>   rename drivers/i2c/muxes/{i2c-mux-pca954x.c => i2c-mux-pca9x4x.c} (56%)
>>   rename include/linux/platform_data/{pca954x.h => pca9x4x.h} (80%)
>>
>> diff --git a/Documentation/devicetree/bindings/i2c/i2c-mux-pca954x.txt b/Documentation/devicetree/bindings/i2c/i2c-mux-pca9x4x.txt
>> similarity index 91%
>> rename from Documentation/devicetree/bindings/i2c/i2c-mux-pca954x.txt
>> rename to Documentation/devicetree/bindings/i2c/i2c-mux-pca9x4x.txt
>> index aa097045a10e..cf9a075ca1dd 100644
>> --- a/Documentation/devicetree/bindings/i2c/i2c-mux-pca954x.txt
>> +++ b/Documentation/devicetree/bindings/i2c/i2c-mux-pca9x4x.txt
>> @@ -1,10 +1,11 @@
>> -* NXP PCA954x I2C bus switch
>> +* NXP PCA9x4x I2C bus switch
>>   
>>   Required Properties:
>>   
>>     - compatible: Must contain one of the following.
>>       "nxp,pca9540", "nxp,pca9542", "nxp,pca9543", "nxp,pca9544",
>> -    "nxp,pca9545", "nxp,pca9546", "nxp,pca9547", "nxp,pca9548"
>> +    "nxp,pca9545", "nxp,pca9546", "nxp,pca9547", "nxp,pca9548",
>> +    "nxp,pca9846", "nxp,pca9847", "nxp,pca9848", "nxp,pca9849"
>>   
>>     - reg: The I2C address of the device.
>>   
>> diff --git a/arch/arm/configs/aspeed_g4_defconfig b/arch/arm/configs/aspeed_g4_defconfig
>> index d23b9d56a88b..a461ad3cf63d 100644
>> --- a/arch/arm/configs/aspeed_g4_defconfig
>> +++ b/arch/arm/configs/aspeed_g4_defconfig
>> @@ -116,7 +116,7 @@ CONFIG_I2C=y
>>   CONFIG_I2C_CHARDEV=y
>>   CONFIG_I2C_MUX=y
>>   CONFIG_I2C_MUX_PCA9541=y
>> -CONFIG_I2C_MUX_PCA954x=y
>> +CONFIG_I2C_MUX_PCA9x4x=y
> 
> Nak.
> 
> I'm not sure you should break backward compatibility. You should keep the 
> CONFIG_I2C_MUX_PCA954x configuration setting and the current name convention.

Right, definitely avoid the mass rename. In addition to the pointless
churn, pca9x4x is just plain wrong since it matches e.g. pca9745 which
has nothing whatsoever to do with this driver.

I'll add more comments once the rename noise is gone.

Cheers,
Peter
