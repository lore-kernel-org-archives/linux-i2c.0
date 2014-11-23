From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [4/5] i2c: davinci: use bus recovery infrastructure
Date: Sun, 23 Nov 2014 21:36:34 +0100
Message-ID: <20141123203634.GG4431@pengutronix.de>
References: <1416477788-5544-5-git-send-email-grygorii.strashko@ti.com>
 <20141121190744.GB4431@pengutronix.de>
 <546F9382.40102@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <546F9382.40102-l0cyMroinI0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>, Santosh Shilimkar <ssantosh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Murali Karicheri <m-karicheri2-l0cyMroinI0@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hello Grygorii,

On Fri, Nov 21, 2014 at 09:33:22PM +0200, Grygorii Strashko wrote:
> On 11/21/2014 09:07 PM, Uwe Kleine-K=F6nig wrote:
> > On Thu, Nov 20, 2014 at 12:03:07PM +0200, Grygorii Strashko wrote:
> > Just another general comment about the driver that doesn't influenc=
e the
> > correctness of this patch: The i2c-davinci driver is quite quick to
> > reset the bus. I wonder how often this reset triggers. Is the bus i=
n
> > question less "stable" than others?
>=20
> In comparison to ..? :)
In comparison to other bus drivers in other SoCs. I know this might be
hard to answer. I just wonder where the reason for this has to be
located. Strange hardware? Software bug? Or is this SoC just operating
with strange slaves more often than others?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
