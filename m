From: Biju Das <biju.das@bp.renesas.com>
Subject: RE: [PATCH 0/2] Use demuxer for i2c1 and i2c5
Date: Tue, 23 Jan 2018 13:39:46 +0000
Message-ID: <KL1PR06MB1702A0E39B6D488E907BA7A9B8E30@KL1PR06MB1702.apcprd06.prod.outlook.com>
References: <1516620563-7965-1-git-send-email-biju.das@bp.renesas.com>
 <20180122114026.uqozk4cbhfrjwqmd@katana>
 <KL1PR06MB170270EA30591C7636941361B8EC0@KL1PR06MB1702.apcprd06.prod.outlook.com>
 <20180122122204.n25jf2rtaoxmi2yq@katana>
 <KL1PR06MB170262934FD5C3B9D422A134B8EC0@KL1PR06MB1702.apcprd06.prod.outlook.com>
 <20180122140824.ox2ljc3kvrkgipq7@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <20180122140824.ox2ljc3kvrkgipq7@ninjato>
Content-Language: en-US
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Chris Paterson <Chris.Paterson2@renesas.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

Hi,

> Subject: Re: [PATCH 0/2] Use demuxer for i2c1 and i2c5
>
>
> > > > On top of renesas-dev branch, I am using the below i2c-rcar driver
> > > > related
> > > patches.
> > > >
> > > > https://www.mail-archive.com/linux-renesas-soc@vger.kernel.org/msg
> > > > 2227
> > > > 8.html
> > >
> > > Those should be enough. They are not?
> >
> > Yes. I have tested without demuxer patches, I confirm, it can recover t=
he bus.
>
> That is great news! Thanks for the additional testing. I was a little wor=
ried that
> the 'bus stalled' detection might have failed for you, but it seems it wo=
rks for
> your case as well.
>
> With that put aside, it is still valid, to add the demuxer to the DTS fil=
e in case you
> want to switch to bitbanged GPIO at runtime for some reason. Only the com=
mit
> message would need updating then, however, because it is not relevant for=
 bus
> recovery.

Ok. I will fix the commit message and send v2.

Regards,
Biju



Renesas Electronics Europe Ltd, Dukes Meadow, Millboard Road, Bourne End, B=
uckinghamshire, SL8 5FH, UK. Registered in England & Wales under Registered=
 No. 04586709.
