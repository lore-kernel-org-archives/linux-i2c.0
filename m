From: Pantelis Antoniou <pantelis.antoniou@konsulko.com>
Subject: Re: portable device tree connector -- problem statement
Date: Tue, 5 Jul 2016 21:04:40 +0300
Message-ID: <BAC6B4B6-37E3-4A35-83D4-76BCE43F92D5@konsulko.com>
References: <577ACE0D.9050700@gmail.com> <20160705083152.GM6247@sirena.org.uk>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wm0-f43.google.com ([74.125.82.43]:38409 "EHLO
	mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752079AbcGESEr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Tue, 5 Jul 2016 14:04:47 -0400
Received: by mail-wm0-f43.google.com with SMTP id r201so163239771wme.1
        for <linux-i2c@vger.kernel.org>; Tue, 05 Jul 2016 11:04:46 -0700 (PDT)
In-Reply-To: <20160705083152.GM6247@sirena.org.uk>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Frank Rowand <frowand.list@gmail.com>, Rob Herring <robh+dt@kernel.org>, David Gibson <david@gibson.dropbear.id.au>, Stephen Boyd <stephen.boyd@linaro.org>, Grant Likely <grant.likely@secretlab.ca>, Mark Rutland <mark.rutland@arm.com>, Matt Porter <mporter@konsulko.com>, Koen Kooi <koen@dominion.thruhere.net>, Guenter Roeck <linux@roeck-us.net>, Marek Vasut <marex@denx.de>, Wolfram Sang <wsa@the-dreams.de>, devicetree <devicetree@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-i2c@vger.kernel.org

Hi Mark,

> On Jul 5, 2016, at 11:31 , Mark Brown <broonie@kernel.org> wrote:
>=20
> On Mon, Jul 04, 2016 at 01:58:53PM -0700, Frank Rowand wrote:
>=20
>> On the other hand, I have no previous detailed knowledge of the beag=
le
>> family.
>=20
> This is in no way specific to the BeagleBones, there's plenty of othe=
r
> boards out there with similar setups like the Raspberry Pi and its
> derivatives. =20
>=20

There are a lot of custom vendor boards that use it.
We need to handle custom board too.

>>    - for bones with the same pinout:
>>      - the pins are routed to different function blocks on the
>>        SOC because different bones may have different SOCs?
>>        - the different functional blocks are compatible or not?
>=20
> This is the general case, there will be a substantial level of
> compatibility between different base boards by virtue of the pinouts
> being the same but obviously there will be some variation in the
> specifics (and even where that exists it may not be enough to be visi=
ble
> at the DT level for the most part).  That said there will doubtless b=
e
> some plug in modules that want to rely on the specifics of a given ba=
se
> board rather than remain compatible with general users of the interfa=
ce.

Even for plug in modules that need a specific board it is typical that =
new
SoCs/boards appear in the future that are backwards compatible.

Regards

=E2=80=94 Pantelis
