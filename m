From: Rodolfo Giometti <giometti@enneenne.com>
Subject: Re: [PATCH] i2c: Add support for NXP PCA984x family.
Date: Mon, 11 Dec 2017 14:29:09 +0100
Message-ID: <f2bd4153-871f-0f71-2825-6225f0ec19d5@enneenne.com>
References: <20171211111022.30333-1-adrian.fiergolski@cern.ch>
 <dd092e72-dc8a-7847-ae4d-aaa65fe6b3d7@enneenne.com>
 <38777c0b-fc81-3af5-e96d-d0ab1bb83d85@axentia.se>
 <d49bb560-0481-b449-b911-6d4d802a4cbd@cern.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from smtpweb130.aruba.it ([62.149.158.130]:53411 "EHLO
        smtpweb130.aruba.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751688AbdLKNgT (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Mon, 11 Dec 2017 08:36:19 -0500
In-Reply-To: <d49bb560-0481-b449-b911-6d4d802a4cbd@cern.ch>
Content-Language: en-US
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Adrian Fiergolski <Adrian.Fiergolski@cern.ch>
Cc: Peter Rosin <peda@axentia.se>, linux-i2c@vger.kernel.org, giometti@linux.it

On 11/12/17 14:15, Adrian Fiergolski wrote:
> On 11.12.2017 at 13:51, Peter Rosin wrote:
>> On 2017-12-11 12:25, Rodolfo Giometti wrote:
>>> On 11/12/17 12:10, Adrian Fiergolski wrote:
>>>> This patch exetends the current i2c-mux-pca954x driver and adds suuport for
>>>> a newer PCA984x family of the I2C switches and multiplexers from NXP.
>>>> In probe function, the patch supports device ID function, introduced in the
>>>> new family, and checks it against configuration provided by the
>>>> devicetree. Moreover, it also performs software reset which is now
>>>> available for the new devices.
>>>> The reset of the code remains common with the legacy PCA954x devices.
>>>>
>>>> Signed-off-by: Adrian Fiergolski <adrian.fiergolski@cern.ch>
>>>> ---
>>>>    .../{i2c-mux-pca954x.txt => i2c-mux-pca9x4x.txt}   |   5 +-
>>>>    arch/arm/configs/aspeed_g4_defconfig               |   2 +-
>>>>    arch/arm/configs/aspeed_g5_defconfig               |   2 +-
>>>>    arch/arm/configs/multi_v7_defconfig                |   2 +-
>>>>    arch/arm/configs/pxa_defconfig                     |   2 +-
>>>>    arch/arm/configs/tegra_defconfig                   |   2 +-
>>>>    arch/arm64/configs/defconfig                       |   2 +-
>>>>    arch/powerpc/configs/85xx-hw.config                |   2 +-
>>>>    drivers/i2c/muxes/Kconfig                          |   6 +-
>>>>    drivers/i2c/muxes/Makefile                         |   2 +-
>>>>    drivers/i2c/muxes/i2c-mux-pca9541.c                |   4 +-
>>>>    .../muxes/{i2c-mux-pca954x.c => i2c-mux-pca9x4x.c} | 295 ++++++++++++++++-----
>>>>    .../linux/platform_data/{pca954x.h => pca9x4x.h}   |  15 +-
>>>>    13 files changed, 246 insertions(+), 95 deletions(-)
>>>>    rename Documentation/devicetree/bindings/i2c/{i2c-mux-pca954x.txt => i2c-mux-pca9x4x.txt} (91%)
>>>>    rename drivers/i2c/muxes/{i2c-mux-pca954x.c => i2c-mux-pca9x4x.c} (56%)
>>>>    rename include/linux/platform_data/{pca954x.h => pca9x4x.h} (80%)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/i2c/i2c-mux-pca954x.txt b/Documentation/devicetree/bindings/i2c/i2c-mux-pca9x4x.txt
>>>> similarity index 91%
>>>> rename from Documentation/devicetree/bindings/i2c/i2c-mux-pca954x.txt
>>>> rename to Documentation/devicetree/bindings/i2c/i2c-mux-pca9x4x.txt
>>>> index aa097045a10e..cf9a075ca1dd 100644
>>>> --- a/Documentation/devicetree/bindings/i2c/i2c-mux-pca954x.txt
>>>> +++ b/Documentation/devicetree/bindings/i2c/i2c-mux-pca9x4x.txt
>>>> @@ -1,10 +1,11 @@
>>>> -* NXP PCA954x I2C bus switch
>>>> +* NXP PCA9x4x I2C bus switch
>>>>    
>>>>    Required Properties:
>>>>    
>>>>      - compatible: Must contain one of the following.
>>>>        "nxp,pca9540", "nxp,pca9542", "nxp,pca9543", "nxp,pca9544",
>>>> -    "nxp,pca9545", "nxp,pca9546", "nxp,pca9547", "nxp,pca9548"
>>>> +    "nxp,pca9545", "nxp,pca9546", "nxp,pca9547", "nxp,pca9548",
>>>> +    "nxp,pca9846", "nxp,pca9847", "nxp,pca9848", "nxp,pca9849"
>>>>    
>>>>      - reg: The I2C address of the device.
>>>>    
>>>> diff --git a/arch/arm/configs/aspeed_g4_defconfig b/arch/arm/configs/aspeed_g4_defconfig
>>>> index d23b9d56a88b..a461ad3cf63d 100644
>>>> --- a/arch/arm/configs/aspeed_g4_defconfig
>>>> +++ b/arch/arm/configs/aspeed_g4_defconfig
>>>> @@ -116,7 +116,7 @@ CONFIG_I2C=y
>>>>    CONFIG_I2C_CHARDEV=y
>>>>    CONFIG_I2C_MUX=y
>>>>    CONFIG_I2C_MUX_PCA9541=y
>>>> -CONFIG_I2C_MUX_PCA954x=y
>>>> +CONFIG_I2C_MUX_PCA9x4x=y
>>> Nak.
>>>
>>> I'm not sure you should break backward compatibility. You should keep the
>>> CONFIG_I2C_MUX_PCA954x configuration setting and the current name convention.
>> Right, definitely avoid the mass rename. In addition to the pointless
>> churn, pca9x4x is just plain wrong since it matches e.g. pca9745 which
>> has nothing whatsoever to do with this driver.
>>
>> I'll add more comments once the rename noise is gone.
>>
>> Cheers,
>> Peter
>>
> Thanks for comments.
> What do you suggest then ? I could keep CONFIG_I2C_MUX_PCA954x, but
> then, since there is a common source, if enabled, the PCA985x family
> support would be provided as well anyway. I could try to move PCA985x
> features to a separate file which would be included by i2c-mux-pca954x.c
> if a dedicated CONFIG_I2C_MUX_PCA984x is enabled, but it doesn't seem to
> be an elegant solution to me.
> 
> I understand, that your main concern regards CONFIG_I2C_MUX_PCA954x
> only. The fact that internal data types and files have been renamed to a
> more generic and actual pca9x5x style is fine, right ?

None. Just drop the mass rename and add support for the new family. Also don't 
forget to mention the new support into documentation/configuration files.

Ciao,

Rodolfo

-- 

HCE Engineering                      e-mail: giometti@hce-engineering.it
GNU/Linux Solutions                          giometti@enneenne.com
Linux Device Driver                          giometti@linux.it
Embedded Systems                     phone:  +39 349 2432127
UNIX programming                     skype:  rodolfo.giometti
Cosino Project - the quick prototyping embedded system - www.cosino.it
Freelance ICT Italia - Consulente ICT Italia - www.consulenti-ict.it
