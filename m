From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: [PATCH 1/3] i2c: uniphier: add UniPhier FIFO-less I2C driver
Date: Fri, 23 Oct 2015 19:52:51 +0900
Message-ID: <CAK7LNATy0zL5fv2ypk3_ECCpFye2yJ_94Tx0c=ZE-Ptnn=8gEg@mail.gmail.com>
References: <1438243942-26401-1-git-send-email-yamada.masahiro@socionext.com>
	<1438243942-26401-2-git-send-email-yamada.masahiro@socionext.com>
	<20151022205908.GA1516@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20151022205908.GA1516@katana>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>, Anders Berg <anders.berg@avagotech.com>, Max Schwarz <max.schwarz@online.de>, David Box <david.e.box@linux.intel.com>, Wei Yan <sledge.yanwei@huawei.com>, Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>, Andrew Bresticker <abrestic@chromium.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Kamal Dasu <kdasu.kdev@gmail.com>, Laurentiu Palcu <laurentiu.palcu@intel.com>, Baruch Siach <baruch@tkos.co.il>, Xudong Chen <xudong.chen@mediatek.com>, Lee Jones <lee.jones@linaro.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Neelesh Gupta <neelegup@linux.vnet.ibm.com>, Sachin Kamat <sachin.kamat@samsung.com>, Ray Jui <rjui@broadcom.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: linux-i2c@vger.kernel.org

Hi Wolfram,


Thanks for your review!

2015-10-23 5:59 GMT+09:00 Wolfram Sang <wsa@the-dreams.de>:
> On Thu, Jul 30, 2015 at 05:12:20PM +0900, Masahiro Yamada wrote:
>> Add support for on-chip I2C controller used on old UniPhier SoCs
>> such as PH1-LD4, PH1-sLD8, etc..  This adapter is so simple that
>> it has no FIFO in it.
>>
>> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>
> Finally! Mostly looking good.
>
>> +static u32 uniphier_i2c_functionality(struct i2c_adapter *adap)
>> +{
>> +     return I2C_FUNC_I2C;
>> +}
>
> No I2C_FUNC_SMBUS_EMUL? But check if SMBUS_QUICK is supported by your
> adapter.

Added in v2.


>> +     regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +     if (!regs) {
>> +             dev_err(dev, "failed to get memory resource");
>> +             return -EINVAL;
>> +     }
>
> This 'if'-block can go. devm_ioremap_resource will check it for you.
>

Fixed in v2.

Thanks!


-- 
Best Regards
Masahiro Yamada
