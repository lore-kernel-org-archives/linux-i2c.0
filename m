From: Biju Das <biju.das-kTT6dE0pTRh9uiUsa/gSgQ@public.gmane.org>
Subject: RE: [PATCH 0/2] Use demuxer for i2c1 and i2c5
Date: Mon, 22 Jan 2018 14:03:28 +0000
Message-ID: <KL1PR06MB170262934FD5C3B9D422A134B8EC0@KL1PR06MB1702.apcprd06.prod.outlook.com>
References: <1516620563-7965-1-git-send-email-biju.das@bp.renesas.com>
 <20180122114026.uqozk4cbhfrjwqmd@katana>
 <KL1PR06MB170270EA30591C7636941361B8EC0@KL1PR06MB1702.apcprd06.prod.outlook.com>
 <20180122122204.n25jf2rtaoxmi2yq@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20180122122204.n25jf2rtaoxmi2yq@katana>
Content-Language: en-US
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Chris Paterson <Chris.Paterson2-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

> Subject: Re: [PATCH 0/2] Use demuxer for i2c1 and i2c5

[>]
> > How do i2c-bus gets details of gpio lines associated with i2c bus for b=
us
> recovery?
>
> As you can see in the code, you don't need GPIOs if you can control SDA a=
nd SCL
> directly. The I2C IP can do this.

I agree. Thanks for correcting me.

> > On top of renesas-dev branch, I am using the below i2c-rcar driver rela=
ted
> patches.
> >
> > https://www.mail-archive.com/linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org/msg2227
> > 8.html
>
> Those should be enough. They are not?

Yes. I have tested without demuxer patches, I confirm, it can recover the b=
us.




Renesas Electronics Europe Ltd, Dukes Meadow, Millboard Road, Bourne End, B=
uckinghamshire, SL8 5FH, UK. Registered in England & Wales under Registered=
 No. 04586709.
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
