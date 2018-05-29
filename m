From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Subject: RE: [PATCH 0/6] Fix R-Car I2C data byte sent twice issue
Date: Tue, 29 May 2018 18:52:09 +0000
Message-ID: <TY1PR01MB1770DD97E8044C4E9B989537C06D0@TY1PR01MB1770.jpnprd01.prod.outlook.com>
References: <1527600796-25901-1-git-send-email-fabrizio.castro@bp.renesas.com>
 <20180529171957.y2ctsptsnjw6ykag@ninjato>
 <20180529172541.nrbvlkolhmlzpavx@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20180529172541.nrbvlkolhmlzpavx@ninjato>
Content-Language: en-US
Sender: stable-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, Chris Paterson <Chris.Paterson2@renesas.com>, Biju Das <biju.das@bp.renesas.com>, "stable@vger.kernel.org" <stable@vger.kernel.org>, Ben Hutchings <ben.hutchings@codethink.co.uk>
List-Id: linux-i2c@vger.kernel.org

Hello Wolfram,

Thank you for your feedback.

> -----Original Message-----
> From: Wolfram Sang [mailto:wsa@the-dreams.de]
> Sent: 29 May 2018 18:26
> To: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>; linux-i2c@vger.kerne=
l.org; Chris Paterson <Chris.Paterson2@renesas.com>;
> Biju Das <biju.das@bp.renesas.com>; stable@vger.kernel.org; Ben Hutchings=
 <ben.hutchings@codethink.co.uk>
> Subject: Re: [PATCH 0/6] Fix R-Car I2C data byte sent twice issue
>
>
> > the first transfer after boot (for whatever reason). And fixing it,
> > together with another issue (double address byte), needed all this
> > refactoring.
>
> If you want this double address problem fixed, too, you need more
> patches of this series up to commit 52df445f29b7 ("i2c: rcar: revoke
> START request early").

I'll send a new series to fix the double address byte issue.

With respect to the changelog for commit 52df445f29b7 ("i2c: rcar: revoke
START request early"), in particular:
"This patch improves the situation but sadly does not completely fix it.
It is still to be researched if we can do better given this HW design."
This is still the best we can do so far, isn't it?

Thanks,
Fab





Renesas Electronics Europe Ltd, Dukes Meadow, Millboard Road, Bourne End, B=
uckinghamshire, SL8 5FH, UK. Registered in England & Wales under Registered=
 No. 04586709.
