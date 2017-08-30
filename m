From: "Mohandass, Divagar" <divagar.mohandass-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: [PATCH v2 1/3] dt-bindings: add eeprom "size" property
Date: Wed, 30 Aug 2017 03:57:13 +0000
Message-ID: <7B8CE47BD58441468D2BB13285B50E6031DE5F7A@BGSMSX107.gar.corp.intel.com>
References: <1502736119-32084-1-git-send-email-divagar.mohandass@intel.com>
 <1502736119-32084-2-git-send-email-divagar.mohandass@intel.com>
 <20170822091107.uubxhwilkutduou7@valkosipuli.retiisi.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170822091107.uubxhwilkutduou7-S+BSfZ9RZZmRSg0ZkenSGLdO1Tsj/99ntUK59QYPAWc@public.gmane.org>
Content-Language: en-US
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sakari Ailus <sakari.ailus-X3B1VOXEql0@public.gmane.org>
Cc: "robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "mark.rutland-5wv7dgnIgG8@public.gmane.org" <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org" <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Mani, Rajmohan" <rajmohan.mani-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Sakari,

Thanks for your review comments. Will address it in next patch version.

---
^Divagar

>-----Original Message-----
>From: Sakari Ailus [mailto:sakari.ailus-X3B1VOXEql0@public.gmane.org]
>Sent: Tuesday, August 22, 2017 2:41 PM
>To: Mohandass, Divagar <divagar.mohandass-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
>Cc: robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org; mark.rutland-5wv7dgnIgG8@public.gmane.org; wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org;
>devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-
>kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; Mani, Rajmohan <rajmohan.mani-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
>Subject: Re: [PATCH v2 1/3] dt-bindings: add eeprom "size" property
>
>Hi Divagar,
>
>On Tue, Aug 15, 2017 at 12:11:57AM +0530, Divagar Mohandass wrote:
>> This adds eeprom "size" as optional property for i2c eeproms.
>>
>> "size" should be mentioned in byte and it should refer to the eeprom
>> size. This will be read by the driver and used to calculating the
>> number of bytes in read/write calls.
>
>Instead of the three lines above, how about:
>
>The "size" property allows explicitly specifying the size of the EEPROM chip in
>bytes.
>
>>
>> Signed-off-by: Divagar Mohandass <divagar.mohandass-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
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
>>  Example:
>>
>>  eeprom@52 {
>> --
>> 1.9.1
>>
>
>--
>Regards,
>
>Sakari Ailus
>e-mail: sakari.ailus-X3B1VOXEql0@public.gmane.org
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
