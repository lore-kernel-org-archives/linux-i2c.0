From: Pantelis Antoniou <pantelis.antoniou@konsulko.com>
Subject: Re: portable device tree connector -- problem statement
Date: Tue, 5 Jul 2016 21:07:34 +0300
Message-ID: <FAEEC972-73C1-49DF-8F2E-BC89EFF64E5D@konsulko.com>
References: <577ACE0D.9050700@gmail.com> <20160705083152.GM6247@sirena.org.uk> <577BC30C.10105@gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <577BC30C.10105@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Frank Rowand <frowand.list@gmail.com>
Cc: Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>, David Gibson <david@gibson.dropbear.id.au>, stephen.boyd@linaro.org, Grant Likely <grant.likely@secretlab.ca>, Mark Rutland <mark.rutland@arm.com>, Matt Porter <mporter@konsulko.com>, Koen Kooi <koen@dominion.thruhere.net>, Guenter Roeck <linux@roeck-us.net>, marex@denx.de, Wolfram Sang <wsa@the-dreams.de>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Hi Frank,

> On Jul 5, 2016, at 17:24 , Frank Rowand <frowand.list@gmail.com> wrot=
e:
>=20
> On 07/05/16 01:31, Mark Brown wrote:
>> On Mon, Jul 04, 2016 at 01:58:53PM -0700, Frank Rowand wrote:
>>=20
>>> On the other hand, I have no previous detailed knowledge of the bea=
gle
>>> family.
>>=20
>> This is in no way specific to the BeagleBones, there's plenty of oth=
er
>> boards out there with similar setups like the Raspberry Pi and its
>> derivatives.
>=20
> Yes, absolutely.  I'm just picking on the beaglebones because that is
> what Pantelis has recently used for examples.  (He has mentioned othe=
r
> connector types and expansion boards in his presentations.)
>=20
> And we need to think beyond beaglebone, pi, arduino, and grove=20
> type of connectors.
>=20
> Some other connectors that are obvious are pci and possibly usb.
>=20

Yes, in fact a growing number of platforms come with discoverable
PCI/USB boards which provide the busses and interfaces that
non-discoverable boards are plugged in.

Think an i2c-bus on pci-e boards on which a number of I2C peripherals
are located. The Vendor/Product IDs are the same for all these
expansions boards since the h/w designers do not want to spend money
on even a dip-switch or EEPROM for the IDs.

>=20
>>>    - for bones with the same pinout:
>>>      - the pins are routed to different function blocks on the
>>>        SOC because different bones may have different SOCs?
>>>        - the different functional blocks are compatible or not?
>>=20
>> This is the general case, there will be a substantial level of
>> compatibility between different base boards by virtue of the pinouts
>> being the same but obviously there will be some variation in the
>> specifics (and even where that exists it may not be enough to be vis=
ible
>> at the DT level for the most part).  That said there will doubtless =
be
>> some plug in modules that want to rely on the specifics of a given b=
ase
>> board rather than remain compatible with general users of the interf=
ace.
>>=20
>=20

Regards

=97 Pantelis
