From: Rob Herring <robh+dt@kernel.org>
Subject: Re: DT connectors, thoughts
Date: Thu, 21 Jul 2016 14:21:52 -0500
Message-ID: <CAL_JsqLgFK5UO3gYewTbPkZgicBsgyx6fBod3NSCAr6Uh3nYLA@mail.gmail.com>
References: <577ACE0D.9050700@gmail.com> <20160718142037.GS16769@voom.fritz.box>
 <442C02A9-582D-4FD8-8F05-7A6FCD5B6BCA@konsulko.com> <20160721134208.GD12120@voom.fritz.box>
 <A1018E27-B604-4DD5-ADBA-95EF76F6DDAC@konsulko.com> <CAL_JsqLc0N8o2Nc_dEcZChJqWyN3UtZEgzLd=j6dR=1y3xOvdA@mail.gmail.com>
 <2C63DCA2-385A-4EE3-A957-F1DBEF7929F8@konsulko.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2C63DCA2-385A-4EE3-A957-F1DBEF7929F8@konsulko.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pantelis Antoniou <pantelis.antoniou@konsulko.com>
Cc: David Gibson <david@gibson.dropbear.id.au>, Frank Rowand <frowand.list@gmail.com>, Stephen Boyd <stephen.boyd@linaro.org>, Mark Brown <broonie@kernel.org>, Grant Likely <grant.likely@secretlab.ca>, Mark Rutland <mark.rutland@arm.com>, Matt Porter <mporter@konsulko.com>, Koen Kooi <koen@dominion.thruhere.net>, Guenter Roeck <linux@roeck-us.net>, Marek Vasut <marex@denx.de>, Wolfram Sang <wsa@the-dreams.de>, devicetree <devicetree@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

On Thu, Jul 21, 2016 at 2:15 PM, Pantelis Antoniou
<pantelis.antoniou@konsulko.com> wrote:
> Hi Rob,
>
>> On Jul 21, 2016, at 22:09 , Rob Herring <robh+dt@kernel.org> wrote:
>>
>> On Thu, Jul 21, 2016 at 9:14 AM, Pantelis Antoniou
>> <pantelis.antoniou@konsulko.com> wrote:
>>> Hi David,
>>>
>>>> On Jul 21, 2016, at 16:42 , David Gibson <david@gibson.dropbear.id=
=2Eau> wrote:
>>>>
>>>> On Wed, Jul 20, 2016 at 11:59:44PM +0300, Pantelis Antoniou wrote:
>>>>> Hi David,
>>>>>
>>>>> Spent some time looking at this, and it looks like it=E2=80=99s g=
oing to the right direction.
>>>>>
>>>>> Comments inline.
>>>>>
>>>>>> On Jul 18, 2016, at 17:20 , David Gibson <david@gibson.dropbear.=
id.au> wrote:
>>>>>>
>>>>>> Hi,
>>>>>>
>>>>>> Here's some of my thoughts on how a connector format for the DT =
could
>>>>>> be done.  Sorry it's taken longer than I hoped - I've been prett=
y
>>>>>> swamped in my day job.
>>>>>>
>>>>>> This is pretty early thoughts, but gives an outline of the appro=
ach I
>>>>>> prefer.
>>
>> [...]
>>
>>>>>>            i2c: i2c@... {
>>>>>>            };
>>>>>>            intc: intc@... {
>>>>>>                    #interrupt-cells =3D <2>;
>>>>>>            };
>>>>>>    };
>>>>>>
>>>>>>    connectors {
>>>>>>            widget1 {
>>>>>>                    compatible =3D "foo,widget-socket";
>>>>>>                    w1_irqs: irqs {
>>>>>>                            interrupt-controller;
>>>>>>                            #address-cells =3D <0>;
>>>>>>                            #interrupt-cells =3D <1>;
>>>>>>                            interrupt-map-mask =3D <0xffffffff>;
>>>>>>                            interrupt-map =3D <
>>>>>>                                    0 &intc 7 0
>>>>>>                                    1 &intc 8 0
>>>>>>> ;
>>>>>>                    };
>>>>>
>>>>> This is fine. We need an interrupt controller node.
>>>>
>>>> Actually I think we only need an interrupt nexus, not an interrupt
>>>> controller (in IEEE1275 terminology).  (An interrupt controller wo=
uld
>>>> generally require it's own driver, to ack/mask irqs, whereas this =
just
>>>> demonstrates the routing to an existing interrupt controller).  Wh=
ich
>>>> makes that example slightly incorrect (it shouldn't have the
>>>> interrupt-controller property).
>>>
>>> Hmm, as far as I can tell we only have a concept of an interrupt co=
ntroller
>>> in the kernel. An interrupt nexus is something new. We should get b=
y without
>>> a driver but hacking the interrupt lookup path at DT.
>>
>> Interrupt nexus is the interrupt-map property which is fully
>> supported. I'd expect we'll end up with a gpio nexus (i.e. gpio-map)
>> for connector gpios, too.
>>
>
> Is interrupt-map enough to cover all our cases? On all the cases that=
 I see it
> used is in the context of PCI or some sort of bus.

I think it should be. IIRC, one of the ARM, Ltd. boards uses it in a
non-PCI context.

> Is the example above well defined? As far as I can tell interrupt-con=
troller is not
> needed.

interrupt-controller should actually be dropped as that is supposed to
be mutually exclusive to interrupt-map, but I think the kernel doesn't
care.

Rob
