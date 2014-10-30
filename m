From: Ezequiel Garcia <ezequiel.garcia-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 2/2] DT: i2c: Add binding document for IMG I2C SCB
Date: Thu, 30 Oct 2014 15:03:29 -0300
Message-ID: <54527D71.2040901@imgtec.com>
References: <1414612641-4259-1-git-send-email-ezequiel.garcia@imgtec.com>	<1414612641-4259-3-git-send-email-ezequiel.garcia@imgtec.com> <CAL1qeaEzg5Qh9B62zFkbnhRgC9Ewxs7xkvwNdOO5t6bZd-HV-A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAL1qeaEzg5Qh9B62zFkbnhRgC9Ewxs7xkvwNdOO5t6bZd-HV-A-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andrew Bresticker <abrestic-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Cc: James Hartley <james.hartley-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>, James Hogan <james.hogan-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Andrew,

On 10/29/2014 08:32 PM, Andrew Bresticker wrote:
> Hi Ezequiel,
> 
>> From: James Hogan <james.hogan-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
>>
>> Introduce a devicetree binding for Imagination Technologies
>> I2C SCB controller.
>>
>> Signed-off-by: James Hogan <james.hogan-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
> 
> This should have your S-o-B as well.
> 

Sure, although I haven't written a single line of this file and
I'm not sure what's the value of having my S-o-B in addition
to James Hogan's.

>> diff --git a/Documentation/devicetree/bindings/i2c/i2c-img-scb.txt b/Documentation/devicetree/bindings/i2c/i2c-img-scb.txt
> 
>> @@ -0,0 +1,14 @@
>> +IMG Serial Control Bus (SCB) I2C Controller
>> +
>> +Required Properties:
>> +- compatible: "img,scb-i2c"
> 
> Is there no difference between the controller present on TZ1090 and Pistachio?
> 

As James Hogan explained, the revision register should be enough to
distinguish different IP block revisions. So for now no need for different
compatibles.

>> +- reg: Physical base address and length of controller registers
>> +- interrupts: Interrupt number used by the controller
>> +- clocks : Clock specifier to the SCB clock node
> 
> On Pistachio there are two clocks per controller, the I2C operating
> clock and I2C "system" clock (which I assume is the system interface
> gate clock).  There should also be a "clock-names" property with an
> entry for each clock.
> 

Right.

>> +- clock-frequency: The I2C bus frequency in Hz
>> +- bus-delay : Bus delay in ms
> 
> Probably should list #address-cells and #size-cells here as well.
> 

OK.

>> +Optional properties:
>> +- linux,i2c-index: Can be used to override the I2C bus number. This is useful
>> +  when some of the I2C adapters are used by other non-Linux cores so would get
>> +  numbered incorrectly by default.
> 
> I don't think this is necessary.  Aliases can be used to set the
> adapter number instead.
> 

Yes, just did a quick test and adding the following:

        aliases {
                i2c2 = &i2c0;
                i2c3 = &i2c1;
        };

Is enough to get the devices numbered:

$ ls /sys/class/i2c-adapter/*   
/sys/class/i2c-adapter/i2c-2@  /sys/class/i2c-adapter/i2c-3@

> Also, it's generally good to include an example node.
> 

Ah, forgot about that.

I'll cook a v2. Thanks a lot for the review.
-- 
Ezequiel
