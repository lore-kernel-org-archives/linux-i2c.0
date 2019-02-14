From: Ray Jui <ray.jui@broadcom.com>
Subject: Re: [PATCH v4 3/8] dt-bindings: i2c: iproc: make 'interrupts'
 optional
Date: Thu, 14 Feb 2019 09:36:42 -0800
Message-ID: <e17b1cd0-8ffb-d014-bcce-57a3ca227506@broadcom.com>
References: <20190204231554.87666-1-ray.jui@broadcom.com>
 <20190204231554.87666-4-ray.jui@broadcom.com> <20190213211651.GA10705@bogus>
 <796d9a96-f3f9-cb9a-faa3-4baf0e72da65@broadcom.com>
 <CAL_JsqK+QLRp7LqkMzQCXdLPaJU3fbiNWU_uyuPFJ4qDkP=siA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAL_JsqK+QLRp7LqkMzQCXdLPaJU3fbiNWU_uyuPFJ4qDkP=siA@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Wolfram Sang <wsa@the-dreams.de>, Mark Rutland <mark.rutland@arm.com>, Linux I2C <linux-i2c@vger.kernel.org>, devicetree@vger.kernel.org, "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" <bcm-kernel-feedback-list@broadcom.com>, Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
List-Id: linux-i2c@vger.kernel.org



On 2/14/2019 6:16 AM, Rob Herring wrote:
> On Wed, Feb 13, 2019 at 4:06 PM Ray Jui <ray.jui@broadcom.com> wrote:
>>
>> Hi Rob,
>>
>> On 2/13/2019 1:16 PM, Rob Herring wrote:
>>> On Mon, Feb 04, 2019 at 03:15:49PM -0800, Ray Jui wrote:
>>>> In prep for the introduction of polling mode into the driver, update the
>>>> binding document to make the 'interrupts' property optional
>>>>
>>>> Signed-off-by: Ray Jui <ray.jui@broadcom.com>
>>>> Signed-off-by: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
>>>> ---
>>>>  .../devicetree/bindings/i2c/brcm,iproc-i2c.txt         | 10 +++++++---
>>>>  1 file changed, 7 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/i2c/brcm,iproc-i2c.txt b/Documentation/devicetree/bindings/i2c/brcm,iproc-i2c.txt
>>>> index 81f982ccca31..d3a3620b1f06 100644
>>>> --- a/Documentation/devicetree/bindings/i2c/brcm,iproc-i2c.txt
>>>> +++ b/Documentation/devicetree/bindings/i2c/brcm,iproc-i2c.txt
>>>> @@ -9,9 +9,6 @@ Required properties:
>>>>      Define the base and range of the I/O address space that contain the iProc
>>>>      I2C controller registers
>>>>
>>>> -- interrupts:
>>>> -    Should contain the I2C interrupt
>>>> -
>>>>  - clock-frequency:
>>>>      This is the I2C bus clock. Need to be either 100000 or 400000
>>>>
>>>> @@ -21,6 +18,13 @@ Required properties:
>>>>  - #size-cells:
>>>>      Always 0
>>>>
>>>> +Optional properties:
>>>> +
>>>> +- interrupts:
>>>> +    Should contain the I2C interrupt. If unspecified, driver will fall back to
>>>> +    polling mode
>>>
>>> What determines when you want to use polling mode? I'm not sure DT
>>> is the best way to control this unless it's really a property of
>>> the h/w. Driver behavior is really outside the scope of the DT. u-boot
>>> would use polling even if an interrupt is specified, for example.
>>>
>> It's tied to the particular revision of the I2C controller, i.e., the
>> iProc NIC i2c controller does not have interrupt line wired. In this
>> case, the behavior is determined by the DT compatible string of the
>> iProc I2C device. I thought that it makes sense to now move the
>> 'interrupts' property to be under "Optional" than "Required" which is
>> basically what this change is.
> 
> Okay, please put this detail into the commit msg.

Will do! Thanks.

> 
> Rob
> 
