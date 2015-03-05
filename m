From: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Subject: Re: [PATCH] i2c: pca954x: Defer probing due to reset GPIO
Date: Thu, 05 Mar 2015 12:23:25 +0200
Message-ID: <2152277.WaU4Vccoeu@avalon>
References: <1425480268-7322-1-git-send-email-laurent.pinchart@ideasonboard.com> <20150305085353.GS7865@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150305085353.GS7865-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Uwe =?ISO-8859-1?Q?Kleine=2DK=F6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Uwe,

On Thursday 05 March 2015 09:53:53 Uwe Kleine-K=F6nig wrote:
> On Wed, Mar 04, 2015 at 04:44:28PM +0200, Laurent Pinchart wrote:
> > If a reset GPIO is specified but not available we must defer probin=
g, as
> > the device could be held in reset. Use devm_gpiod_request_optional(=
) to
> > handle this automatically.
> >=20
> > Signed-off-by: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
>=20
> I sent the same patch with a slightly different motivation two weeks
> ago: http://article.gmane.org/gmane.linux.drivers.i2c/21972

And I've even acked it... Well, I guess it means I really like the patc=
h ;-)=20
Let's get your version merged.

--=20
Regards,

Laurent Pinchart
