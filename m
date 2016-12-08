From: "M'boumba Cedric Madianga" <cedric.madianga@gmail.com>
Subject: Re: [PATCH v5 5/5] ARM: configs: Add I2C support for STM32 defconfig
Date: Thu, 8 Dec 2016 09:47:18 +0100
Message-ID: <CAOAejn1SgqmDLcamtWFriShCMfO5S+DDOUu6WOfUgaE+46edcg@mail.gmail.com>
References: <1481185563-8735-1-git-send-email-cedric.madianga@gmail.com>
 <1481185563-8735-6-git-send-email-cedric.madianga@gmail.com> <daf6b0b4-9bd1-d3eb-a759-ed64eee990f2@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <daf6b0b4-9bd1-d3eb-a759-ed64eee990f2@st.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Alexandre Torgue <alexandre.torgue@st.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, Rob Herring <robh+dt@kernel.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Patrice Chotard <patrice.chotard@st.com>, linux@armlinux.org.uk, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Hi Alex,

2016-12-08 9:38 GMT+01:00 Alexandre Torgue <alexandre.torgue@st.com>:
> Hi Cedric,
>
> On 12/08/2016 09:26 AM, M'boumba Cedric Madianga wrote:
>>
>> Signed-off-by: M'boumba Cedric Madianga <cedric.madianga@gmail.com>
>> ---
>>  arch/arm/configs/stm32_defconfig | 3 +++
>>  1 file changed, 3 insertions(+)
>>
> Can you change the commit header by ARM: configs: stm32: Add I2C support
Ok, I will use this typo in the next version

>
> Thx
> alex
>
>
>
>
>
>> diff --git a/arch/arm/configs/stm32_defconfig
>> b/arch/arm/configs/stm32_defconfig
>> index e7b56d4..9494eaf 100644
>> --- a/arch/arm/configs/stm32_defconfig
>> +++ b/arch/arm/configs/stm32_defconfig
>> @@ -52,6 +52,9 @@ CONFIG_SERIAL_NONSTANDARD=y
>>  CONFIG_SERIAL_STM32=y
>>  CONFIG_SERIAL_STM32_CONSOLE=y
>>  # CONFIG_HW_RANDOM is not set
>> +CONFIG_I2C=y
>> +CONFIG_I2C_CHARDEV=y
>> +CONFIG_I2C_STM32F4=y
>>  # CONFIG_HWMON is not set
>>  # CONFIG_USB_SUPPORT is not set
>>  CONFIG_NEW_LEDS=y
>>
>
