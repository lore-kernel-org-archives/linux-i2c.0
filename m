From: "Mohandass, Divagar" <divagar.mohandass@intel.com>
Subject: RE: [PATCH 1/3] dt-bindings: add "size" property.
Date: Mon, 7 Aug 2017 09:08:02 +0000
Message-ID: <7B8CE47BD58441468D2BB13285B50E6031DB615E@BGSMSX107.gar.corp.intel.com>
References: <1501173789-25959-1-git-send-email-divagar.mohandass@intel.com>
 <1501173789-25959-2-git-send-email-divagar.mohandass@intel.com>
 <20170803202734.rqyoiqhqvonvvtca@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:38568 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752331AbdHGJIH (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 7 Aug 2017 05:08:07 -0400
In-Reply-To: <20170803202734.rqyoiqhqvonvvtca@rob-hp-laptop>
Content-Language: en-US
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>, "wsa@the-dreams.de" <wsa@the-dreams.de>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Mani, Rajmohan" <rajmohan.mani@intel.com>

>-----Original Message-----
>From: Rob Herring [mailto:robh@kernel.org]
>Sent: Friday, August 04, 2017 1:58 AM
>To: Mohandass, Divagar <divagar.mohandass@intel.com>
>Cc: mark.rutland@arm.com; wsa@the-dreams.de;
>devicetree@vger.kernel.org; linux-i2c@vger.kernel.org; linux-
>kernel@vger.kernel.org; Mani, Rajmohan <rajmohan.mani@intel.com>
>Subject: Re: [PATCH 1/3] dt-bindings: add "size" property.
>
>On Thu, Jul 27, 2017 at 10:13:07PM +0530, divagar.mohandass@intel.com
>wrote:
>> From: Divagar Mohandass <divagar.mohandass@intel.com>
>
>Please improve the subject. Add size to what?

I will update the title to say 'add eeprom "size" property' in the next version.

>
>>
>> This adds "size" as optional property for i2c eeproms.
>>
>> "size" should be mentioned in byte and it should refer to the eeprom
>> size. This will be read by the driver and used to calculating the
>> number of bytes in read/write calls.
>>
>> Signed-off-by: Divagar Mohandass <divagar.mohandass@intel.com>
>> ---
>>  Documentation/devicetree/bindings/eeprom/eeprom.txt | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/eeprom/eeprom.txt
>> b/Documentation/devicetree/bindings/eeprom/eeprom.txt
>> index 5696eb5..1436569 100644
>> --- a/Documentation/devicetree/bindings/eeprom/eeprom.txt
>> +++ b/Documentation/devicetree/bindings/eeprom/eeprom.txt
>> @@ -32,6 +32,8 @@ Optional properties:
>>
>>    - read-only: this parameterless property disables writes to the
>> eeprom
>>
>> +  - size: total eeprom size in bytes
>> +
>
>This should be implied by the compatible string of the eeprom. Why do you
>need this?

This eeprom "size" property is optional for at24 driver, 
In the at24 driver size information is passed as part of the i2c_device_id' 
driver_data during initial probe. If you want to use an existing ID for an 
eeprom for a different size, there is no way to override it currently. 
By introducing an optional size device property, we can reuse IDs for chips of
different sizes.

This is also consistent with the implementation in the at25 driver.

>
>Rob
