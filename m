From: Yixun Lan <yixun.lan@amlogic.com>
Subject: Re: [PATCH 1/5] dt-bindings: i2c: update documentation for the
 Meson-AXG
Date: Fri, 17 Nov 2017 21:47:14 +0800
Message-ID: <dc339e2a-d8ab-7412-0c9e-bf4d052fc17e@amlogic.com>
References: <20171117080236.32504-1-yixun.lan@amlogic.com>
 <20171117080236.32504-2-yixun.lan@amlogic.com>
 <03c9ea24-5f8d-f5dd-6e96-f53f56db530c@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-sh2.amlogic.com ([58.32.228.45]:6204 "EHLO
        mail-sh2.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933663AbdKQNrR (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Fri, 17 Nov 2017 08:47:17 -0500
In-Reply-To: <03c9ea24-5f8d-f5dd-6e96-f53f56db530c@baylibre.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Neil Armstrong <narmstrong@baylibre.com>, Wolfram Sang <wsa@the-dreams.de>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, Kevin Hilman <khilman@baylibre.com>
Cc: yixun.lan@amlogic.com, Jerome Brunet <jbrunet@baylibre.com>, Carlo Caione <carlo@caione.org>, Jian Hu <jian.hu@amlogic.com>, linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

Hi Neil


On 11/17/17 21:02, Neil Armstrong wrote:
> On 17/11/2017 09:02, Yixun Lan wrote:
>> From: Jian Hu <jian.hu@amlogic.com>
>>
>> Update the doc to explicitly add Meson-AXG to support list
>>
>> Signed-off-by: Jian Hu <jian.hu@amlogic.com>
>> Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
>> ---
>>  Documentation/devicetree/bindings/i2c/i2c-meson.txt | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/Documentation/devicetree/bindings/i2c/i2c-meson.txt b/Documentation/devicetree/bindings/i2c/i2c-meson.txt
>> index 611b934c7e10..3097d2b44dad 100644
>> --- a/Documentation/devicetree/bindings/i2c/i2c-meson.txt
>> +++ b/Documentation/devicetree/bindings/i2c/i2c-meson.txt
>> @@ -2,6 +2,7 @@ Amlogic Meson I2C controller
>>  
>>  Required properties:
>>   - compatible: must be "amlogic,meson6-i2c" or "amlogic,meson-gxbb-i2c"
>> +						"amlogic,meson-axg-i2c"
> 
> Hi Yixun, Jian,
> 
> Maybe you should reformat by using :
> - compatible: must be :
> 	"amlogic,meson6-i2c" for Meson8 and compatible SoCs
> 	"amlogic,meson-gxbb-i2c" for GXBB and compatible SoCs
> 	"amlogic,meson-axg-i2c"for AXG and compatible SoCs
> 
> Neil
> 
sure, we can do this.
thanks for the review
>>   - reg: physical address and length of the device registers
>>   - interrupts: a single interrupt specifier
>>   - clocks: clock for the device
>>
> 
> .
> 
