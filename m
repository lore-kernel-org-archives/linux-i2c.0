From: Christopher Covington <cov@codeaurora.org>
Subject: Re: [PATCH v4 1/2] i2c: qup: add ACPI support
Date: Thu, 30 Jun 2016 14:50:44 -0400
Message-ID: <57756A04.3030301@codeaurora.org>
References: <1465409985-17113-1-git-send-email-austinwc@codeaurora.org>
 <4749471.m1cxc4jj96@wuerfel> <577503F2.90204@codeaurora.org>
 <4043322.Uc6lMkrL43@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:55960 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751537AbcF3Sus (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Thu, 30 Jun 2016 14:50:48 -0400
In-Reply-To: <4043322.Uc6lMkrL43@wuerfel>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org, Austin Christ <austinwc@codeaurora.org>, wsa@the-dreams.de, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, timur@codeaurora.org, rruigrok@codeaurora.org, Philip Elcan <pelcan@codeaurora.org>, Sricharan R <sricharan@codeaurora.org>, Stephen Boyd <sboyd@codeaurora.org>

Hi Arnd,

On 06/30/2016 07:52 AM, Arnd Bergmann wrote:
> On Thursday, June 30, 2016 7:35:14 AM CEST Christopher Covington wrote:
>> Hi Arnd,
>>
>> On 06/08/2016 05:02 PM, Arnd Bergmann wrote:
>>> On Wednesday, June 8, 2016 12:19:44 PM CEST Austin Christ wrote:
>>>> +               ret = device_property_read_u32(qup->dev,
>>>> +                               "src-clock-hz", &src_clk_freq);
>>>> +               if (ret) {
>>>> +                       dev_warn(qup->dev, "using default src-clock-hz %d",
>>>> +                               DEFAULT_SRC_CLK);
>>>> +                       src_clk_freq = DEFAULT_SRC_CLK;
>>>> +               }
>>>>
>>>
>>> Where is this property documented?
>>
>> We plan on submitting documentation via dsd@acpica.org to
>> https://github.com/ahs3/dsd once it is operational. As I understand it
>> the project is brand new. It may take several months to begin accepting
>> submissions. In the mean time, we could potentially include
>> documentation in a reply to this thread, the cover of the next series, a
>> wiki page on codeaurora.org, a file in Documentation (perhaps to be
>> replaced by ACPICA style imports of the OS-neutral DSD project or a git
>> submodule) or potentially other means. Please let us know what you think
>> is sufficient.
> 
> As you are reusing part of the DT binding, it seems appropriate to put
> the documentation for this into the binding documentation in the kernel.

My understanding is that in the device tree case, the input/source clock
frequency is assumed to be run-time managed through Global Clock
Controller (GCC) code and the common clock framework.

drivers/i2c/busses/i2c-qup.c:1549

src_clk_freq = clk_get_rate(qup->clk);

So a given I2C device tree entry points to the GCC device tree entry,
but there isn't an explicit, fixed input/source clock frequency value.

arch/arm64/boot/dts/qcom/msm8916.dtsi:310

blsp_i2c2: i2c@78b6000 {
        compatible = "qcom,i2c-qup-v2.2.1";
        reg = <0x78b6000 0x1000>;
        interrupts = <GIC_SPI 96 0>;
        clocks = <&gcc GCC_BLSP1_AHB_CLK>,
                <&gcc GCC_BLSP1_QUP2_I2C_APPS_CLK>;
        clock-names = "iface", "core";
        pinctrl-names = "default", "sleep";
        pinctrl-0 = <&i2c2_default>;
        pinctrl-1 = <&i2c2_sleep>;
        #address-cells = <1>;
        #size-cells = <0>;
        status = "disabled";
};

On the other hand, when ACPI is in use, the driver assumes a fixed
input/source clock frequency value, which it tries to look up as a
device property.

(I'm out of my depth here, so somebody please correct me if I've
described this wrong.)

Thanks,
Cov

-- 
Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
