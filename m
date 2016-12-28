From: Luis Oliveira <Luis.Oliveira@synopsys.com>
Subject: Re: [PATCH v5 6/7] i2c: designware: enable SLAVE in platform module
Date: Wed, 28 Dec 2016 16:41:55 +0000
Message-ID: <c41db9e0-756d-6697-a845-0d5b1efcaedc@synopsys.com>
References: <cover.1482934380.git.lolivei@synopsys.com>
 <ea8b611c3b7c2af8088e2dbc16554af5c8aed368.1482934380.git.lolivei@synopsys.com>
 <1482939844.9552.165.camel@linux.intel.com>
 <20e47113-efd7-787c-b2f8-39e9fd8b83d2@synopsys.com>
 <1482942696.9552.172.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1482942696.9552.172.camel@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Luis Oliveira <Luis.Oliveira@synopsys.com>, wsa@the-dreams.de, robh+dt@kernel.org, mark.rutland@arm.com, jarkko.nikula@linux.intel.com, mika.westerberg@linux.intel.com, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Ramiro.Oliveira@synopsys.com, Joao.Pinto@synopsys.com, CARLOS.PALMINHA@synopsys.com
List-Id: linux-i2c@vger.kernel.org

On 28-Dec-16 16:31, Andy Shevchenko wrote:
> On Wed, 2016-12-28 at 15:53 +0000, Luis Oliveira wrote:
>> On 28-Dec-16 15:44, Andy Shevchenko wrote:
>>> On Wed, 2016-12-28 at 14:43 +0000, Luis Oliveira wrote:
>>>> - Slave mode selected in platform module (devicetree support only)
>>>> - Check for ACPI - not supported in SLAVE mode:
>>>>   - Changed the ifndef style to the use of ACPI_HANDLE that
>>>> returns
>>>> NULL
>>>>     if the device was not enumerated from ACPI namespace.
>>>
>>> I'm not sure what is wrong with ACPI?
>>
>> I dont have a way to test it. Just that.
> 
> Okay, can you provide an excerpt to see how it will look like in DTS?

Yes, it looks like this now:

	i2c@0x2000 {
			compatible = "snps,designware-i2c";
			#address-cells = <1>;
			#size-cells = <0>;
			reg = <0x2000 0x100>;
			clock-frequency = <400000>;
			clocks = <&i2cclk>;
			interrupts = <0>;

			eeprom@64 {
				compatible = "linux,slave-24c02";
				reg = <0x40000064>;
			};
	};
> 
>  
>>>> -	dev->functionality = I2C_FUNC_10BIT_ADDR |
>>>> DW_IC_DEFAULT_FUNCTIONALITY;
>>>> -
>>>> -	i2c_dw_configure_master(pdev);
>>>> +	if (ACPI_HANDLE(&pdev->dev) == NULL) {
>>>
>>> I don't think you need this at all.
>>
>> This is to avoid the use of the "ifdef" style I used before.
> 
> My point is to drop it completely.
> 
>>>
>>>> +		device_for_each_child_node(&pdev->dev, child) {
>>>
>>> This is resource agnostic.
>>>
>>>> +			fwnode_property_read_u32(child, "reg",
>>>> &reg);
>>>
>>> This is as well.
>>
>> Are you suggesting I use of_ functions?
> 
> Nope. See above.
> 
> 
