From: wenpan <wenpan@hisilicon.com>
Subject: Re: [PATCH v2] i2c: hibvt: add Hisilicon BVT I2C controller driver
Date: Mon, 25 Jul 2016 15:28:04 +0800
Message-ID: <b964a669-8c78-5551-4fbc-c61f504bab15@hisilicon.com>
References: <1468316448-15256-1-git-send-email-wenpan@hisilicon.com>
 <20160716201555.GA6559@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from szxga03-in.huawei.com ([119.145.14.66]:30418 "EHLO
	szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751589AbcGYIQi (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Mon, 25 Jul 2016 04:16:38 -0400
In-Reply-To: <20160716201555.GA6559@rob-hp-laptop>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: wsa@the-dreams.de, mark.rutland@arm.com, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, howell.yang@hisilicon.com, xuejiancheng@hisilicon.com, wenpan@hisilicom.com

Hi Rob,

On 2016/7/17 4:15, Rob Herring wrote:
> On Tue, Jul 12, 2016 at 05:40:48PM +0800, Pan Wen wrote:
>> add Hisilicon BVT I2C controller driver support.
>>
>> Signed-off-by: Pan Wen <wenpan@hisilicon.com>
>> ---
>> change log
>> v2:
>> 1)Fixed a compile error.
>> 2)Dropped the clock-names property.
>>  .../devicetree/bindings/i2c/i2c-hibvt.txt          |  23 +
>>  drivers/i2c/busses/Kconfig                         |  10 +
>>  drivers/i2c/busses/Makefile                        |   1 +
>>  drivers/i2c/busses/i2c-hibvt.c                     | 736 +++++++++++++++++++++
>>  4 files changed, 770 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/i2c/i2c-hibvt.txt
>>  create mode 100644 drivers/i2c/busses/i2c-hibvt.c
>>
>> diff --git a/Documentation/devicetree/bindings/i2c/i2c-hibvt.txt b/Documentation/devicetree/bindings/i2c/i2c-hibvt.txt
>> new file mode 100644
>> index 0000000..9b88afe
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/i2c/i2c-hibvt.txt
>> @@ -0,0 +1,23 @@
>> +Hisilicon BVT I2C master controller
>> +
>> +Required properties:
>> +- compatible: should be "hisilicon,hibvt-i2c".
> 
> Needs a SoC specific compatible string.
>

OK. Thanks for your comments. I will add a SoC specific compatible string in next version.

Thanks,
Pan.

>> +- reg: physical base address of the controller and length of memory mapped.
>> +     region.
>> +- interrupts: interrupt number to the cpu.
>> +- clocks: phandles to input clocks.
>> +
>> +Optional properties:
>> +- clock-frequency: Desired I2C bus frequency in Hz, otherwise defaults to 100000.
>> +
>> +Other properties:
>> +see Documentation/devicetree/bindings/i2c/i2c.txt.
>> +
>> +Examples:
>> +i2c_bus0: i2c@12110000 {
>> +	compatible = "hisilicon,hibvt-i2c";
>> +	reg = <0x12110000 0x100>;
>> +	interrupts = <20>;
>> +	clocks = <&crg_ctrl HI3516CV300_APB_CLK>;
>> +	clock-frequency = <100000>;
>> +};
> 
> .
> 
