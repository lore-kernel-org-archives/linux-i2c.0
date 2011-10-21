From: Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: Re: [PATCH v2] i2c: mxs: Let i2c-mxs be built for MX23
Date: Fri, 21 Oct 2011 16:59:52 -0200
Message-ID: <4EA1C128.106@freescale.com>
References: <1319221664-3018-1-git-send-email-fabio.estevam@freescale.com> <20111021184822.GJ15299@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20111021184822.GJ15299-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: =?ISO-8859-1?Q?Uwe_Kleine-K=F6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, shawn.guo-KZfg59tc24xl57MIdRCFDg@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Uwe,

On 10/21/2011 4:48 PM, Uwe Kleine-K=F6nig wrote:
> On Fri, Oct 21, 2011 at 04:27:44PM -0200, Fabio Estevam wrote:
>> MX23 and MX28 share the same I2C block, so let i2c-mxs be built for =
MX23 too.
>>
>> Signed-off-by: Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
> arch/arm/mach-mxs/devices/platform-mxs-i2c.c doesn't support i.MX23 y=
et,
> but still I think the change is correct.

Yes, I know. I plan to submit the I2C arch/arm/mach-mxs related patches=
 next week.=20
=20
> Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>

Thanks,

=46abio Estevam
