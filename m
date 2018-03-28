From: Boris Brezillon <boris.brezillon@bootlin.com>
Subject: Re: [PATCH v3 05/11] dt-bindings: i3c: Document core bindings
Date: Wed, 28 Mar 2018 19:28:07 +0200
Message-ID: <20180328192807.174b794d@bbrezillon>
References: <20180323110020.19080-1-boris.brezillon@bootlin.com>
        <20180323110020.19080-6-boris.brezillon@bootlin.com>
        <20180326071946.dtrhhxx3iwwymk73@rob-hp-laptop>
        <20180328101922.22a7039d@bbrezillon>
        <CAL_JsqKKf_Ob6AUvO5xgEFzSWakYDuPPzVKe4taoN1kzw3b1fQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAL_JsqKKf_Ob6AUvO5xgEFzSWakYDuPPzVKe4taoN1kzw3b1fQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Wolfram Sang <wsa@the-dreams.de>, Linux I2C <linux-i2c@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, Przemyslaw Sroka <psroka@cadence.com>, Arkadiusz Golec <agolec@cadence.com>, Alan Douglas <adouglas@cadence.com>, Bartosz Folta <bfolta@cadence.com>, Damian Kos <dkos@cadence.com>, Alicja Jurasik-Urbaniak <alicja@cadence.com>, Cyprian Wronka <cwronka@cadence.com>, Suresh Punnoose <sureshp@cadence.com>, Rafal Ciepiela <rafalc@cadence.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Nishanth Menon <nm@ti.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>
List-Id: linux-i2c@vger.kernel.org

On Wed, 28 Mar 2018 11:42:07 -0500
Rob Herring <robh@kernel.org> wrote:


> >>  
> >> > +where device-type is describing the type of device connected on the bus
> >> > +(gpio-controller, sensor, ...).
> >> > +
> >> > +Required properties
> >> > +-------------------
> >> > +- reg: contains 3 cells
> >> > +  + first cell : encodes the I2C address. Should be 0 if the device does not
> >> > +            have one (0 is not a valid I3C address).  
> >>
> >> Change here to "encodes the static I2C address".
> >>
> >> 0 is not a valid I2C address?  
> >
> > According to [1] it is reserved, and it's reserved in the I3C spec
> > anyway (see "Table 9 I3C Slave Address Restrictions" in the I3C spec).  
> 
> Sorry, what I meant was s/I3C/I2C/. The first cell is I2C address and
> 0 is not valid.

Okay, got it now :-).
> 
> >> > +
> >> > +  + second and third cells: should encode the ProvisionalID. The second cell
> >> > +                       contains the manufacturer ID left-shifted by 1.
> >> > +                       The third cell contains ORing of the part ID
> >> > +                       left-shifted by 16, the instance ID left-shifted
> >> > +                       by 12 and the extra information. This encoding is
> >> > +                       following the PID definition provided by the I3C
> >> > +                       specification.  
> >
> > One extra question for you: should I refer to the I3C_DEV(),
> > I3C_DEV_WITH_STATIC_ADDR() and I2C_DEV() macros in the bindings doc?
> > And if I do, should I use them my example?  
> 
> Well, I don't want to see "device@I3C_DEV(...)" for unit-addresses.

That wouldn't work anyway.

> You can use them for reg property, but it's somewhat pointless to use
> it in one place and not the other.

Not sure I follow you. These macros have been added to ease definitions
of reg, but you'll still have to manually define the unit-address
manually. Are you saying I should not use them in dts files or just that
I should not mention it in the doc. If this is the former, then patch 6
should be dropped.

-- 
Boris Brezillon, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
