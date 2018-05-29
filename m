From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Subject: RE: [PATCH 0/6] Fix R-Car I2C data byte sent twice issue
Date: Tue, 29 May 2018 18:08:14 +0000
Message-ID: <TY1PR01MB17708BA7883CA4CE7454E2BEC06D0@TY1PR01MB1770.jpnprd01.prod.outlook.com>
References: <1527600796-25901-1-git-send-email-fabrizio.castro@bp.renesas.com>
 <20180529171957.y2ctsptsnjw6ykag@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20180529171957.y2ctsptsnjw6ykag@ninjato>
Content-Language: en-US
Sender: stable-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, Chris Paterson <Chris.Paterson2@renesas.com>, Biju Das <biju.das@bp.renesas.com>, "stable@vger.kernel.org" <stable@vger.kernel.org>, Ben Hutchings <ben.hutchings@codethink.co.uk>
List-Id: linux-i2c@vger.kernel.org

Hello Wolfram,

Thank you for your feedback!

> -----Original Message-----
> From: Wolfram Sang [mailto:wsa@the-dreams.de]
> Sent: 29 May 2018 18:20
> To: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>; linux-i2c@vger.kerne=
l.org; Chris Paterson <Chris.Paterson2@renesas.com>;
> Biju Das <biju.das@bp.renesas.com>; stable@vger.kernel.org; Ben Hutchings=
 <ben.hutchings@codethink.co.uk>
> Subject: Re: [PATCH 0/6] Fix R-Car I2C data byte sent twice issue
>
>
> > this series fixes an issue with the I2C driver of the Renesas R-Car and
> > RZ/G1 family of chips. The issue is clearly visible with the CIP kernel
> > (4.4) running on a iwg20d board from iWave due to the way the bq32000
> > driver/device is interacting with the I2C driver/controller.
> > In the stable kernel (4.4) there is no support for the iwg20d, I tried
> > to replicate the same problem on a Koelsch board with no success, but
> > the problem is there.
>
> For the record, this patchset was developed on a Lager board (R-Car H2)
> but the issue was known to be present on other Gen2 SoCs, too. This was
> a nasty race condition. IIRC I was able to reproduce the issue only with
> the first transfer after boot (for whatever reason). And fixing it,
> together with another issue (double address byte), needed all this
> refactoring.

Thank you for the information, I may give it a try.

>
> I might try to recap how this double data byte problem was triggered.
> This is somewhere on my todo-list anyhow. Just to check if the same
> problem is still present with Gen3 SoCs. No promises, but I'll see what
> I can do.

Thanks,
Fab




Renesas Electronics Europe Ltd, Dukes Meadow, Millboard Road, Bourne End, B=
uckinghamshire, SL8 5FH, UK. Registered in England & Wales under Registered=
 No. 04586709.
