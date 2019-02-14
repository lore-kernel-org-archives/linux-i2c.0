From: Ray Jui <ray.jui@broadcom.com>
Subject: Re: [PATCH v4 6/8] dt-bindings: i2c: iproc: add "brcm,iproc-nic-i2c"
 compatible string
Date: Thu, 14 Feb 2019 09:36:06 -0800
Message-ID: <723faefb-d13d-caf0-3bbd-9e3e698436a4@broadcom.com>
References: <20190204231554.87666-1-ray.jui@broadcom.com>
 <20190204231554.87666-7-ray.jui@broadcom.com> <20190213211807.GA20560@bogus>
 <6de51a50-cd7c-dbf8-15d8-8d2fd441d831@broadcom.com>
 <CAL_Jsq+aH=SGD+NJWNaWKnZm3Y396ro7E_Px_Ud3NnzOYB+eGQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAL_Jsq+aH=SGD+NJWNaWKnZm3Y396ro7E_Px_Ud3NnzOYB+eGQ@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Wolfram Sang <wsa@the-dreams.de>, Mark Rutland <mark.rutland@arm.com>, Linux I2C <linux-i2c@vger.kernel.org>, devicetree@vger.kernel.org, "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" <bcm-kernel-feedback-list@broadcom.com>, Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
List-Id: linux-i2c@vger.kernel.org



On 2/14/2019 6:02 AM, Rob Herring wrote:
> On Wed, Feb 13, 2019 at 4:09 PM Ray Jui <ray.jui@broadcom.com> wrote:
>>
>>
>>
>> On 2/13/2019 1:18 PM, Rob Herring wrote:
>>> On Mon, Feb 04, 2019 at 03:15:52PM -0800, Ray Jui wrote:
>>>> From: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
>>>>
>>>> Update iProc I2C binding document to add new compatible string
>>>> "brcm,iproc-nic-i2c". Optional property "brcm,ape-hsls-addr-mask" is
>>>> also added that allows configuration of the host view into the APE's
>>>> address for "brcm,iproc-nic-i2c"
>>>>
>>>> Signed-off-by: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
>>>> Signed-off-by: Ray Jui <ray.jui@broadcom.com>
>>>> ---
>>>>  Documentation/devicetree/bindings/i2c/brcm,iproc-i2c.txt | 5 ++++-
>>>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/i2c/brcm,iproc-i2c.txt b/Documentation/devicetree/bindings/i2c/brcm,iproc-i2c.txt
>>>> index d3a3620b1f06..02e82d20239e 100644
>>>> --- a/Documentation/devicetree/bindings/i2c/brcm,iproc-i2c.txt
>>>> +++ b/Documentation/devicetree/bindings/i2c/brcm,iproc-i2c.txt
>>>> @@ -3,7 +3,7 @@ Broadcom iProc I2C controller
>>>>  Required properties:
>>>>
>>>>  - compatible:
>>>> -    Must be "brcm,iproc-i2c"
>>>> +    Must be "brcm,iproc-i2c" or "brcm,iproc-nic-i2c"
>>>>
>>>>  - reg:
>>>>      Define the base and range of the I/O address space that contain the iProc
>>>> @@ -24,6 +24,9 @@ Optional properties:
>>>>      Should contain the I2C interrupt. If unspecified, driver will fall back to
>>>>      polling mode
>>>>
>>>> +- brcm,ape-hsls-addr-mask:
>>>> +    Required for "brcm,iproc-nic-i2c". Host view of address mask into the
>>>> +    'APE' co-processor
>>>
>>> What's the data type and size? What are valid values?
>>
>> It's an unsigned u32 mask value. An example of a valid value is for
>> example 0x03400000. Do you want any of these added to the paragraph above?
> 
> Yes. Bindings should define constraints.

Okay will do! Thanks.

> 
> Rob
> 
