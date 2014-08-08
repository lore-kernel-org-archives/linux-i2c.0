From: Julia Lawall <julia.lawall-L2FTfq7BK8M@public.gmane.org>
Subject: Re: [PATCH 1/14] i2c: mpc: delete unneeded test before of_node_put
Date: Fri, 8 Aug 2014 12:27:03 +0200 (CEST)
Message-ID: <alpine.DEB.2.10.1408081226400.2348@hadrien>
References: <1407492475-26283-1-git-send-email-Julia.Lawall@lip6.fr> <20140808102536.GZ1933@pengutronix.de>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-1811163182-1407493623=:2348"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140808102536.GZ1933-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: =?ISO-8859-15?Q?Uwe_Kleine-K=F6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, kernel-janitors-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1811163182-1407493623=:2348
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT



On Fri, 8 Aug 2014, Uwe Kleine-König wrote:

> Hello,
>
> On Fri, Aug 08, 2014 at 12:07:42PM +0200, Julia Lawall wrote:
> > From: Julia Lawall <Julia.Lawall-L2FTfq7BK8M@public.gmane.org>
> >
> > Of_node_put supports NULL as its argument, so the initial test is not
> > necessary.
> >
> > Suggested by Uwe Kleine-König.
> Thanks for picking up my suggestion.
>
> > The semantic patch that fixes this problem is as follows:
> > (http://coccinelle.lip6.fr/)
> >
> > // <smpl>
> > @@
> > expression e;
> > @@
> >
> > -if (e)
> >    of_node_put(e);
> > // </smpl>
> >
>
> I added devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org to Cc. Maybe they want to comment the
> series? If it's acceptable the logical next step is to add the patch to
> the collection of semantic patches, right?

Yes, I will do that.

julia
--8323329-1811163182-1407493623=:2348--
