From: wenpan <wenpan@hisilicon.com>
Subject: Re: [PATCH] i2c: hibvt: add Hisilicon BVT I2C controller driver
Date: Sat, 25 Jun 2016 15:53:05 +0800
Message-ID: <c28b42aa-f9dd-a13b-59d7-71b97f81cea1@hisilicon.com>
References: <1466585726-28467-1-git-send-email-wenpan@hisilicon.com>
 <20160622102509.GD25837@leverpostej>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from szxga03-in.huawei.com ([119.145.14.66]:64680 "EHLO
	szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751081AbcFYHxb (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Sat, 25 Jun 2016 03:53:31 -0400
In-Reply-To: <20160622102509.GD25837@leverpostej>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Mark Rutland <mark.rutland@arm.com>
Cc: wsa@the-dreams.de, robh+dt@kernel.org, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, howell.yang@hisilicon.com, xuejiancheng@hisilicon.com



Hi Mark,

On 2016/6/22 18:25, Mark Rutland wrote:
> On Wed, Jun 22, 2016 at 04:55:26PM +0800, Pan Wen wrote:
>> add Hisilicon BVT I2C controller driver support.
>>
>> Signed-off-by: Pan Wen <wenpan@hisilicon.com>
>> ---
>>  .../devicetree/bindings/i2c/i2c-hibvt.txt          |  24 +
>>  drivers/i2c/busses/Kconfig                         |  10 +
>>  drivers/i2c/busses/Makefile                        |   1 +
>>  drivers/i2c/busses/i2c-hibvt.c                     | 736 +++++++++++++++++++++
>>  4 files changed, 771 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/i2c/i2c-hibvt.txt
>>  create mode 100644 drivers/i2c/busses/i2c-hibvt.c
>>
>> diff --git a/Documentation/devicetree/bindings/i2c/i2c-hibvt.txt b/Documentation/devicetree/bindings/i2c/i2c-hibvt.txt
>> new file mode 100644
>> index 0000000..3aa2cee
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/i2c/i2c-hibvt.txt
>> @@ -0,0 +1,24 @@
>> +Hisilicon BVT I2C master controller
>> +
>> +Required properties:
>> +- compatible: should be "hisilicon,hibvt-i2c".
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
>> +	clock-names = "apb_pclk";
>> +	clock-frequency = <100000>;
>> +};
> 
> The clock-names property was not described above, and the driver doesn't
> appear to use it.
> 
> Please explciitly describe the clock-names you expect, and use them in
> the driver. If there is a single clock, then you can simply drop the
> clock-names property from the example.
> 
> Thanks,
> Mark.
> 

OK. Thanks for your comments. I will drop the clock-names property from the example in next version.

Thanks,

Pan.

>> +	i2c->clk = devm_clk_get(&pdev->dev, NULL);
>> +	if (IS_ERR(i2c->clk)) {
>> +		dev_err(i2c->dev, "cannot get clock\n");
>> +		return -ENOENT;
>> +	}
>> +	clk_prepare_enable(i2c->clk);
> 
> .
> 
