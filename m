From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v3 05/11] dt-bindings: i3c: Document core bindings
Date: Wed, 28 Mar 2018 11:42:07 -0500
Message-ID: <CAL_JsqKKf_Ob6AUvO5xgEFzSWakYDuPPzVKe4taoN1kzw3b1fQ@mail.gmail.com>
References: <20180323110020.19080-1-boris.brezillon@bootlin.com>
 <20180323110020.19080-6-boris.brezillon@bootlin.com> <20180326071946.dtrhhxx3iwwymk73@rob-hp-laptop>
 <20180328101922.22a7039d@bbrezillon>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180328101922.22a7039d@bbrezillon>
Sender: linux-kernel-owner@vger.kernel.org
To: Boris Brezillon <boris.brezillon@bootlin.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, Linux I2C <linux-i2c@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, Przemyslaw Sroka <psroka@cadence.com>, Arkadiusz Golec <agolec@cadence.com>, Alan Douglas <adouglas@cadence.com>, Bartosz Folta <bfolta@cadence.com>, Damian Kos <dkos@cadence.com>, Alicja Jurasik-Urbaniak <alicja@cadence.com>, Cyprian Wronka <cwronka@cadence.com>, Suresh Punnoose <sureshp@cadence.com>, Rafal Ciepiela <rafalc@cadence.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Nishanth Menon <nm@ti.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>
List-Id: linux-i2c@vger.kernel.org

On Wed, Mar 28, 2018 at 3:19 AM, Boris Brezillon
<boris.brezillon@bootlin.com> wrote:
> Hi Rob,
>
> On Mon, 26 Mar 2018 17:24:58 -0500
> Rob Herring <robh@kernel.org> wrote:
>
>> > +
>> > +I3C devices
>> > +===========
>> > +
>> > +All I3C devices are supposed to support DAA (Dynamic Address Assignment), and
>> > +are thus discoverable. So, by default, I3C devices do not have to be described
>> > +in the device tree.
>> > +This being said, one might want to attach extra resources to these devices,
>> > +and those resources may have to be described in the device tree, which in turn
>> > +means we have to describe I3C devices.
>> > +
>> > +Another use case for describing an I3C device in the device tree is when this
>> > +I3C device has a static address and we want to assign it a specific dynamic
>> > +address before the DAA takes place (so that other devices on the bus can't
>>
>> static is I2C address and dynamic is an I3C address. That could be
>> clearer throughout.
>
> I'll clarify that.
>
>>
>> > +take this dynamic address).
>> > +
>> > +The I3C device should be names <device-type>@<static-address>,<i3c-pid>,
>>
>> s/static-address/static-i2c-address/
>
> Okay.
>
>>
>> > +where device-type is describing the type of device connected on the bus
>> > +(gpio-controller, sensor, ...).
>> > +
>> > +Required properties
>> > +-------------------
>> > +- reg: contains 3 cells
>> > +  + first cell : encodes the I2C address. Should be 0 if the device does not
>> > +            have one (0 is not a valid I3C address).
>>
>> Change here to "encodes the static I2C address".
>>
>> 0 is not a valid I2C address?
>
> According to [1] it is reserved, and it's reserved in the I3C spec
> anyway (see "Table 9 I3C Slave Address Restrictions" in the I3C spec).

Sorry, what I meant was s/I3C/I2C/. The first cell is I2C address and
0 is not valid.

>> > +
>> > +  + second and third cells: should encode the ProvisionalID. The second cell
>> > +                       contains the manufacturer ID left-shifted by 1.
>> > +                       The third cell contains ORing of the part ID
>> > +                       left-shifted by 16, the instance ID left-shifted
>> > +                       by 12 and the extra information. This encoding is
>> > +                       following the PID definition provided by the I3C
>> > +                       specification.
>
> One extra question for you: should I refer to the I3C_DEV(),
> I3C_DEV_WITH_STATIC_ADDR() and I2C_DEV() macros in the bindings doc?
> And if I do, should I use them my example?

Well, I don't want to see "device@I3C_DEV(...)" for unit-addresses.
You can use them for reg property, but it's somewhat pointless to use
it in one place and not the other.

Rob
