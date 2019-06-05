From: Jeffrey Hugo <jhugo@codeaurora.org>
Subject: Re: [PATCH 7/8] usb: dwc3: qcom: Start USB in 'host mode' on the
 SDM845
Date: Wed, 5 Jun 2019 08:07:54 -0600
Message-ID: <d9ba98e6-3caf-62fc-45ca-944cb718b7e4@codeaurora.org>
References: <20190604104455.8877-1-lee.jones@linaro.org>
 <20190604104455.8877-7-lee.jones@linaro.org>
 <20190605070029.GN22737@tuxbook-pro> <20190605083454.GO4797@dell>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190605083454.GO4797@dell>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>, Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: balbi@kernel.org, wsa+renesas@sang-engineering.com, gregkh@linuxfoundation.org, linus.walleij@linaro.org, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, david.brown@linaro.org, alokc@codeaurora.org, kramasub@codeaurora.org, linux-i2c@vger.kernel.org, linux-gpio@vger.kernel.org, linux-arm-msm@vger.kernel.org, andy.gross@linaro.org, jlhugo@gmail.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-i2c@vger.kernel.org

On 6/5/2019 2:34 AM, Lee Jones wrote:
> On Wed, 05 Jun 2019, Bjorn Andersson wrote:
> 
>> On Tue 04 Jun 03:44 PDT 2019, Lee Jones wrote:
>>
>>> When booting with Device Tree, the current default boot configuration
>>> table option, the request to boot via 'host mode' comes from the
>>> "dr_mode" property.
>>
>> This has been the default on the MTP, but this is changing as this is
>> causing issues when connected downstream from a hub (the typical
>> development case for the primary USB port of a phone like device) and
>> more importantly we don't have support for the PMIC blocks that control
>> VBUS.
> 
> My point is not about which mode is currently chosen.  It's more about
> the capability of choosing which mode is appropriate for a given
> system via DT.
> 
>> Once these issues are resolved the dr_mode would be "otg".
> 
> OTG doesn't work on this H/W, so we need to specify "host" mode.

How have you made that determination?

> 
>>> A property of the same name can be used inside
>>> ACPI tables too.  However it is missing from the SDM845's ACPI tables
>>> so we have to supply this information using Platform Device Properites
>>> instead.
>>>
>>
>> Afaict this would install a fall-back property, so in the case that we
>> have specified dr_mode in DT (or ACPI) that would take precedence. So
> 
> That's correct.
> 
>> the commit message should reflect that this redefines the default choice
>> to be "host", rather than "otg".
> 
> No problem. >
>> Which is in conflict with what's described for dr_mode in
>> Documentation/devicetree/bindings/usb/generic.txt
> 
> This implementation only affects ACPI based platforms.  When booting
> with DT, the description in that DT related document is still
> accurate.
> 
>> And this driver is used on a range of different Qualcomm platforms, so I
>> don't think this is SDM845 specific.
> 
> ACPI based platforms?
> 
> All the ones I've seen use the XHCI USB driver directly ("PNP0D10").
>   
>>> Signed-off-by: Lee Jones <lee.jones@linaro.org>
>>> ---
>>>   drivers/usb/dwc3/dwc3-qcom.c | 12 ++++++++++++
>>>   1 file changed, 12 insertions(+)
>>>
>>> diff --git a/drivers/usb/dwc3/dwc3-qcom.c b/drivers/usb/dwc3/dwc3-qcom.c
>>> index 349bf549ee44..f21fdd6cdd1a 100644
>>> --- a/drivers/usb/dwc3/dwc3-qcom.c
>>> +++ b/drivers/usb/dwc3/dwc3-qcom.c
>>> @@ -468,6 +468,11 @@ static const struct acpi_device_id dwc3_qcom_acpi_match[] = {
>>>   };
>>>   MODULE_DEVICE_TABLE(acpi, dwc3_qcom_acpi_match);
>>>   
>>> +static const struct property_entry dwc3_qcom_acpi_properties[] = {
>>> +	PROPERTY_ENTRY_STRING("dr_mode", "host"),
>>> +	{}
>>> +};
>>> +
>>>   static int dwc3_qcom_probe(struct platform_device *pdev)
>>>   {
>>>   	struct device_node	*np = pdev->dev.of_node, *dwc3_np;
>>> @@ -603,6 +608,13 @@ static int dwc3_qcom_probe(struct platform_device *pdev)
>>>   			goto platform_unalloc;
>>>   		}
>>>   
>>> +		ret = platform_device_add_properties(qcom->dwc3,
>>> +						     dwc3_qcom_acpi_properties);
>>> +		if (ret < 0) {
>>> +			dev_err(&pdev->dev, "failed to add properties\n");
>>> +			goto platform_unalloc;
>>> +		}
>>> +
>>>   		ret = platform_device_add(qcom->dwc3);
>>>   		if (ret) {
>>>   			dev_err(&pdev->dev, "failed to add device\n");
> 


-- 
Jeffrey Hugo
Qualcomm Datacenter Technologies as an affiliate of Qualcomm 
Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
