From: Ezequiel Garcia <ezequiel.garcia-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v5 2/2] DT: i2c: Add binding document for IMG I2C SCB
Date: Tue, 11 Nov 2014 17:39:47 -0300
Message-ID: <54627413.2030901@imgtec.com>
References: <1415647816-16415-1-git-send-email-ezequiel.garcia@imgtec.com>	<1415647816-16415-3-git-send-email-ezequiel.garcia@imgtec.com> <CAL1qeaHG=zVgA+LOQWcaYndyPJPq6Qs18b4Vorj8zXhj8tSeyw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAL1qeaHG=zVgA+LOQWcaYndyPJPq6Qs18b4Vorj8zXhj8tSeyw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andrew Bresticker <abrestic-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, James Hartley <james.hartley-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, James Hogan <james.hogan-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org



On 11/10/2014 05:22 PM, Andrew Bresticker wrote:
> Hi Ezequiel, James,
> 
> On Mon, Nov 10, 2014 at 11:30 AM, Ezequiel Garcia
> <ezequiel.garcia-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org> wrote:
>> From: James Hogan <james.hogan-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
>>
>> Introduce a devicetree binding for Imagination Technologies
>> I2C SCB controller.
>>
>> Signed-off-by: James Hogan <james.hogan-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
>> Signed-off-by: Ezequiel Garcia <ezequiel.garcia-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
> 
>> diff --git a/Documentation/devicetree/bindings/i2c/i2c-img-scb.txt b/Documentation/devicetree/bindings/i2c/i2c-img-scb.txt
>> new file mode 100644
>> index 0000000..3a5cd1f
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/i2c/i2c-img-scb.txt
>> @@ -0,0 +1,29 @@
>> +IMG Serial Control Bus (SCB) I2C Controller
>> +
>> +Required Properties:
>> +- compatible: "img,scb-i2c"
>> +- reg: Physical base address and length of controller registers
>> +- interrupts: Interrupt number used by the controller
>> +- clocks : Should contain a clock specifier for each entry in clock-names
>> +- clock-names : Should contain the following entries:
>> +                "scb", for the SCB core clock.
>> +                "sys", for the system clock.
>> +- clock-frequency: The I2C bus frequency in Hz
>> +- #address-cells: Should be <1>
>> +- #size-cells: Should be <0>
>> +
>> +Optional Properties
>> +- img,bus-delay : Bus delay in ms, defaults to 0.
> 
> Maybe this is a dumb question, but what delay does this correspond to
> in hardware?  In what situations would we use a non-zero value?
> 

I'm not sure when would we need a non-zero value. The TRM I have here
mentions the bus delay parameter models the delay in the internal Clock
Enable Generation block, and which affects the values that should be
written to obtain a specified clock enable rate.

After re-reading the code that configures the clock generation, I think
we can use some more comments :)
-- 
Ezequiel
