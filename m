From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH] i2c: imx: double check IIF in case interrupt lost
Date: Fri, 15 Aug 2014 09:18:14 +0200
Message-ID: <20140815071814.GD5134@pengutronix.de>
References: <1408004954-29418-1-git-send-email-b38611@freescale.com>
 <20140814094204.GW5134@pengutronix.de>
 <96d6e524bc524305904730df24bf878f@BLUPR03MB373.namprd03.prod.outlook.com>
 <20140814192702.GC5134@pengutronix.de>
 <01dba3477e664c88a65e276a1c77c3e2@BLUPR03MB373.namprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <01dba3477e664c88a65e276a1c77c3e2-GeMU99GfrrsHjcGqcGfFzOO6mTEJWrR4XA4E9RH9d+qIuWR1G4zioA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "fugang.duan-KZfg59tc24xl57MIdRCFDg@public.gmane.org" <fugang.duan-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: "wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org" <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hello,

On Fri, Aug 15, 2014 at 02:14:15AM +0000, fugang.duan-KZfg59tc24xl57MIdRCFDg@public.gmane.org wro=
te:
> I am sorry to tell you I don't have the reproduced platform for the i=
ssue since the
> Issue was found at one platform of customer of freescale, and I debug=
 the issue with
> Customer, at last generate the patch for customer platform, test fine=
=2E So I want to
Does the customer use the -rt patch?

> Submit the patch. In our platforms, it is not easy to reproduce the i=
ssue.
I tend to not want the patch in mainline. IMHO a wrong workaround that
fixes the issue only for 95% is worse than an unfixed driver.
Maybe when analysing more exact the outcome is that the patch is right,
but if there is a race condition somewhere in the code it might be that
there is still a bug. Not being able to reproduce the problem doesn't
necessarily imply that the introduced change is a real fix.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
