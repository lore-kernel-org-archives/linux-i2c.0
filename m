From: Laine Jaakko EXT <ext-jaakko.laine@vaisala.com>
Subject: RE: [PATCH] i2c: xiic: Support disabling multi-master in DT
Date: Thu, 2 Apr 2020 06:16:49 +0000
Message-ID: <AM0PR06MB5185F8F51316FCD5213F0ABED4C60@AM0PR06MB5185.eurprd06.prod.outlook.com>
References: <20200218135627.24739-1-ext-jaakko.laine@vaisala.com>
 <CAKfKVtFf+VpinkOGsBFZ2-_PKvx-C1L7G7_uhY2RCvV5dy6L_w@mail.gmail.com>
 <AM0PR06MB5185E501349E06428093B62FD4F70@AM0PR06MB5185.eurprd06.prod.outlook.com>
 <20200401143254.GA2409@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-eopbgr10082.outbound.protection.outlook.com ([40.107.1.82]:32412
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725789AbgDBGQx (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 2 Apr 2020 02:16:53 -0400
In-Reply-To: <20200401143254.GA2409@ninjato>
Content-Language: en-US
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Shubhrajyoti Datta <shubhrajyoti.datta@gmail.com>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "michal.simek@xilinx.com" <michal.simek@xilinx.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

> > The multi-master -binding is documented here as boolean and encodes a
> > Boolean by either existing or not existing in device tree. It is also
> > used in other drivers so I couldn't do much about it missing meaning
> > False.
> > https://github.com/torvalds/linux/blob/master/Documentation/devicetree/=
bindings/i2c/i2c.txt
> > I originally had a custom device tree entry where the default was for
> > multi-master to be enabled before I noticed the pre-existing binding.
> >=20
> > Maybe if the multi-master binding was changed from Boolean to for
> > example a string property (multi-master =3D "ON" / multi-master =3D
> > "OFF"), code could still just check the existence with
> > "of_property_read_bool()" first, where property missing means "OFF"
> > and property existing means "ON"(like before) if there is no text
> > associated. Xiic driver would then only disable multimaster, if device
> > tree explicitly contains multi-master =3D "OFF".
> >=20
> > This should be able to maintain driver backwards compatibility with
> > old device trees, but requires binding documentation change and all
> > drivers should likely be updated to also accept the new style of
> > multi-master property to be consistent. This is also not as clean as
> > the old Boolean property in my opinion.
>
> I agree. I don't want to change the old "multi-master" binding like
> above because that would be quite intrusive for other drivers and
> confusing when trying to understand the binding.
>
> My best bet is to introduce another binding "single-master" which says
> clearly that we are the only bus master on that bus.
>
> Both bindings missing means then "unclear".
>
> I think this matches reality best.
>
> Opinions?

I agree that this sounds like the best option if original binding can't be =
used, even though it can also be a bit confusing to have 2 similar bindings=
.
How would both bindings existing simultaneously be interpreted? Maybe both =
existing simultaneously should be considered as an invalid configuration, s=
o that it would be enough to just check the one you need? The other option =
would be to treat both existing similarly to neither existing, which would =
require the driver to always check both if checking one.

Should the new single-master binding also be a general binding for all I2C =
drivers or a binding just defined for the XIIC driver? Having it as a gener=
al binding for all drivers could help with similar issues rising later with=
 some other driver. It seems possible that a similar issue could happen wit=
h some other driver implementing multi-master support, but I have no experi=
ence with using or testing them.

- Jaakko
