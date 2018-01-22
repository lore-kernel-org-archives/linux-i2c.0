From: Biju Das <biju.das@bp.renesas.com>
Subject: RE: [PATCH 0/2] Use demuxer for i2c1 and i2c5
Date: Mon, 22 Jan 2018 11:55:54 +0000
Message-ID: <KL1PR06MB170270EA30591C7636941361B8EC0@KL1PR06MB1702.apcprd06.prod.outlook.com>
References: <1516620563-7965-1-git-send-email-biju.das@bp.renesas.com>
 <20180122114026.uqozk4cbhfrjwqmd@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from relmlor4.renesas.com ([210.160.252.174]:64969 "EHLO
        relmlie3.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751028AbeAVLz7 (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Mon, 22 Jan 2018 06:55:59 -0500
In-Reply-To: <20180122114026.uqozk4cbhfrjwqmd@katana>
Content-Language: en-US
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Chris Paterson <Chris.Paterson2@renesas.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>

> Subject: Re: [PATCH 0/2] Use demuxer for i2c1 and i2c5
>
> On Mon, Jan 22, 2018 at 11:29:21AM +0000, Biju Das wrote:
> > We have observed that on iWave RZ/G1E boards, randomly HDMI slave
> > device is holding data line after a soft reboot.
> >
> > We applied demuxer patch for i2c1 and using an oscilloscope verified
> > that i2c recovery works on the failure condition.
>
> Do you really need the demuxer for that?

How do i2c-bus gets details of gpio lines associated with i2c bus for bus r=
ecovery?

For eg:- i2c1 scl line --> gpio0 11
                I2c1 sda line --> gpio0 12

> I posted and just merged bus recovery to the i2c-rcar driver. Did you tes=
t that?
> In theory, this should be enough.

On top of renesas-dev branch, I am using the below i2c-rcar driver related =
patches.

https://www.mail-archive.com/linux-renesas-soc@vger.kernel.org/msg22278.htm=
l






Renesas Electronics Europe Ltd, Dukes Meadow, Millboard Road, Bourne End, B=
uckinghamshire, SL8 5FH, UK. Registered in England & Wales under Registered=
 No. 04586709.
