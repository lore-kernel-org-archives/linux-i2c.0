From: Frank Rowand <frowand.list@gmail.com>
Subject: Re: Portable Device Tree Connector -- conceptual
Date: Fri, 1 Jul 2016 14:12:00 -0700
Message-ID: <5776DCA0.2020406@gmail.com>
References: <5775B2FD.2000103@gmail.com>
 <199EAB87-47DA-4213-BE60-43C2E062AAD5@konsulko.com>
 <57769AF3.2040301@gmail.com>
 <BA83424E-093C-4D73-89E9-392BF1A1ADCB@konsulko.com>
 <5776B4C6.4060200@gmail.com>
 <C358BE2B-42EB-4029-ABC7-FBA9E8F8FCAF@konsulko.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-pf0-f178.google.com ([209.85.192.178]:36749 "EHLO
	mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752233AbcGAVMM (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Fri, 1 Jul 2016 17:12:12 -0400
In-Reply-To: <C358BE2B-42EB-4029-ABC7-FBA9E8F8FCAF@konsulko.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Pantelis Antoniou <pantelis.antoniou@konsulko.com>
Cc: Rob Herring <robh+dt@kernel.org>, David Gibson <david@gibson.dropbear.id.au>, Stephen Boyd <stephen.boyd@linaro.org>, Mark Brown <broonie@kernel.org>, Grant Likely <grant.likely@secretlab.ca>, Mark Rutland <mark.rutland@arm.com>, Matt Porter <mporter@konsulko.com>, Koen Kooi <koen@dominion.thruhere.net>, Guenter Roeck <linux@roeck-us.net>, Marek Vasut <marex@denx.de>, Wolfram Sang <wsa@the-dreams.de>, devicetree <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-i2c@vger.kernel.org

On 07/01/16 12:49, Pantelis Antoniou wrote:
> Hi Frank,
>=20
>> On Jul 1, 2016, at 21:21 , Frank Rowand <frowand.list@gmail.com> wro=
te:
>>
>> On 07/01/16 09:56, Pantelis Antoniou wrote:
>>> Hi Frank,
>>>
>>>> On Jul 1, 2016, at 19:31 , Frank Rowand <frowand.list@gmail.com> w=
rote:
>>>>
>>>> On 07/01/16 03:59, Pantelis Antoniou wrote:
>>>>> Hi Frank,
>>>>>
>>>>> Comments inline.
>>>>>
>>>>>> On Jul 1, 2016, at 03:02 , Frank Rowand <frowand.list@gmail.com>=
 wrote:

< snip >

>>>>> Your example works as long as you assume that there=E2=80=99s no =
pinmuxing
>>>>> related to the configuration of the spi controller when routed ou=
t
>>>>> to the connector pins.
>>>>
>>>> No.  Pinmuxing is part of the host board dts.
>>>>
>>>
>>> It is part of the host board DTS yes, but the connector must have
>>> a way to set the pinmux configuration according what the detected
>>> expansion board expects.
>>>
>>>> The physical connector does not change the way that pinmuxing
>>>> works.  It is just the same as if there were wires physically
>>>> connected (soldered) between the daughter board and the main
>>>> board.
>>>>
>>>
>>> The physical properties of the pin of the connector do not change.
>>>
>>> However the routing of functions in the SoC do change.
>>>
>>> By default most of the pins on the connector are HiZ or set to inpu=
t when
>>> no expansion board is connected. The only fixed function pins that =
are
>>> known and configured by the host board dts are those that are used =
by
>>> the host board=E2=80=99s identification scheme (i.e. I2C EEPROM, se=
t of GPIO inputs
>>> etc).=20
>>>
>>> When an expansion board is connected upon boot and probing of the t=
he expansion
>>> board manager device it will use a method that is using the configu=
red detection
>>> pins to identify it.
>>>
>>> After getting the ID it is going to find a corresponding overlay to=
 apply.
>>>
>>> This overlay will have to configure each pin accordingly.
>>>
>>> It is perfectly for a pin on a connector to be a GPIO output for ex=
pansion
>>> board A, I2C bus SDA for board B, etc...
>>>
>>> So there has to be a way to get the pinmux configuration according =
to the
>>> required connection function on each pin in use.
>>
>> Again, this is exactly the same concept as if the daughter board was=
 soldered
>> directly to the host board with no connector involved.  The pinmux
>> configuration has nothing to do with the physical connector, it is a=
lready
>> described by the pinmux information in the host board .dtb.  The con=
nector
>> node in the host .dtb does not need to duplicate any of that informa=
tion.
>>
>> There already is a pinmux mechanism in place to choose which of the
>> possible alternative uses of a set of pins is in use at any point
>> in time.  The choice of active functionality can be changed at
>> any time.
>>
>> The pinmux configuration is already in place in the host board .dtb.
>> The host board .dtb connector node only provides a mapping to what
>> other nodes have hardware blocks that have signals that are routed
>> to the physical connector.  There is no need for the connector node
>> to be concerned with any of the details of those other nodes -- the
>> other nodes already specify the details.
>>
>=20
> The mechanism to choose which of the possible alternative uses is
> geared to select between a different set of configuration settings
> for the same device. I.e. =E2=80=9Cdefault=E2=80=9D -> working config=
uration, =E2=80=9Cpowersave=E2=80=9D ->
> put the pins in power save mode, etc.

Doesn't pinmuxing also support the case where one set of pins (or two
overlapping sets of pins) is used by two different hardware blocks and
the user wants to change which block is currently using the pins?

=46or instance, a headphone jack might normally supply audio, but the
user might want to change the jack to supply an RS-232 console.


>=20
> I get what you=E2=80=99re saying but the details about pinmuxing are =
the killer.
>=20
> Can you please spend some time and come up with an example which we c=
an
> use as a basis for discussion?

Example above.  Putting the headphone jack on the daughter board should=
 be
the same as if the headphone jack is on the host board from the perspec=
tive
of pinmux.

< snip >
