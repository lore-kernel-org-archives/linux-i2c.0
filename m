From: Andrea Merello <andrea.merello-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH RFC] I2C: i2c-smbus: add device tree support
Date: Mon, 18 Apr 2016 15:35:33 +0200
Message-ID: <CAN8YU5PpXfPRBXD+Khe4wMWpxgyvZeBQOOV4oFxkCS=epCyoQQ@mail.gmail.com>
References: <1460536591-12573-1-git-send-email-andrea.merello@gmail.com> <20160414161012.GA20532@rob-hp-laptop>
Reply-To: andrea.merello-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160414161012.GA20532@rob-hp-laptop>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: jdelvare-l3A5Bk7waGM@public.gmane.org, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Thu, Apr 14, 2016 at 6:10 PM, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> On Wed, Apr 13, 2016 at 10:36:31AM +0200, Andrea Merello wrote:
>> According to Documentation/i2c/smbus-protocol, a smbus controller driver
>> that wants to hook-in smbus extensions support, can call
>> i2c_setup_smbus_alert(). There are very few drivers that are currently
>> doing this.
>>
>> However the i2c-smbus module can also work with any
>> smbus-extensions-unaware I2C controller, as long as we provide an extra
>> IRQ line connected to the I2C bus ALARM signal.
>>
>> This patch makes it possible to go this way via DT. Note that the DT node
>> will indeed describe a (little) piece of HW, that is the routing of the
>> ALARM signal to an IRQ line (so it seems a fair DT use to me, but RFC).
>>
>> Note that AFAICT, by design, i2c-smbus module pretends to be an I2C slave
>> with address 0x0C (that is the alarm response address), and IMHO this is
>> quite consistent with usage in the DT as a I2C child node.
>>
>> Signed-off-by: Andrea Merello <andrea.merello-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>>
>> diff --git a/Documentation/devicetree/bindings/i2c/i2c-smbus.txt b/Documentation/devicetree/bindings/i2c/i2c-smbus.txt
>> new file mode 100644
>> index 0000000..da83127
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/i2c/i2c-smbus.txt
>> @@ -0,0 +1,20 @@
>> +* i2c-smbus extensions
>> +
>> +Required Properties:
>> +  - compatible: Must contain "smbus_alert"
>> +  - interrupts: The irq line for smbus ALERT signal
>> +  - reg: I2C slave address. Set to 0x0C (alert response address).
>> +
>> +Note: The i2c-smbus module registers itself as a slave I2C device. Whenever
>> +a smbus controller directly support smbus extensions (and its driver supports
>> +this), there is no need to add anything special to the DT. Otherwise, for using
>> +i2c-smbus with any smbus-extensions-unaware I2C controllers, you need to
>> +route the smbus ALARM signal to an extra IRQ line, thus you need to describe
>> +this in the DT.
>
> Seems like you are designing the binding around how the module is
> currently designed and creating a virtual device that doesn't exist.

Yes, I actually stayed close to the original module design, but the current
module design seems the result of reasonable rationale and it didn't
appeared completely unreasonable for me even for DT.. Said that, my
bindings didn't completely convinced me too, but while I agree that we
have not a real I2C slave, I'm not completely convinced that there is no
any real HW "device" to describe in the DT (see below).

> A "smbalert-gpios" property in the controller node would be sufficient
> here. Alternatively, an interrupt and standardized interrupt-names value
> could be used.

Hmm, IMHO this way is not closer to the real HW. We are adding an
interrupt property inside the I2C controller node, but that's not how the
HW really is: the I2C controller is completely unaware of it (and it isn't
its driver that handles it). If the I2C controller had that wire, then its
driver could hook the i2c-smbus module by itself, without any extra DT
prop.

I don't see the point here. IMHO it isn't definitely about the I2C controller.
The smbus-alert thing here is exactly what the I2C controller has _not_
(and we are "emulating" it with external HW).

> Another option would be add a boolean property to each child node
> smbalert capable and the childrens' interrupt properties would all be
> the shared interrupt.

That's seems closer to the real HW, because at least the slave devices
really have that wire..

However I'm unsure whether the boolean property is enough: maybe
there is some I2C slave that has both a regular INT line (handled by the
I2C slave driver) and a smbus ALERT line (handled by the common
i2c-smbus module)... Adding another interrupt property in the slave node
seems also not good to me, because the I2C slave drivers must be made
aware of it (to get the right one). Maybe we could introduce a new
property like "alert-interrupt" in the slave nodes, that is caught by
common I2C layer code..

This could be nearly-OK to me, but there is a bunch of things because of
which I'm still not 100% convinced that offloading this "smbalert" thing on
every slave DT node is really right:

- The alert line is not properly an interrupt. It's something that should
go to the smalert pin of the I2C controller. But sometimes there is some
HW (in my case a NOT and an OR logic, but it can be simply a wire) that
_translates_ this signal to a interrupt signal. This can be as simple as a
_connection_ but _logically_ this connection is changing the semantic.
So I'd say we _have_ a (doesn't matter if it's as simple as a PCB track)
piece of HW  that is in charge of this (and to which our DT property may
belongs).. (And you can see the the i2c-smbus module as its driver).

- Let's consider this example: I change the I2C controller with one that has
the ALERT pin and manages the i2c-smbus by itself.. So I will have to
delete the "alert-interrupt" property from all slave nodes.. IMHO this smells
like something not good, or at least weird, doesn't it ?

- I admit that we often use the DT nodes to describe things that are
not really about how a device _is_, rather are about how the device is
connected (regular interrupts, for example). But at least in this case
the driver for the device needs to know this information and it's
reasonable to let it access from the device node (and none else needs
this). In the i2c-smbus case, on the other hand, our property is not related
to the slave device itself, it's maybe related to how the device is connected,
but it's also about how the BUS _is_, and the slave's driver don't care
about it. It's indeed a property that should be caught by the common I2C
code (that will instantiate the i2c-smbus module). This IMHO could be a
symptom that this property shouldn't be in the I2C slave nodes. I'd say I
can't really see any strong point for which it has to stay in the slaves' DT
nodes..

Does all this make any sense in your opinion?

I'm thinking about a dedicated DT node for the i2c-smbus "extra
hardware" with the interrupt property, and referenced by phandle in some
way from the I2C bus...

Andrea

> Rob
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
