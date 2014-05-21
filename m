From: =?utf-8?B?U8O2cmVu?= Brinkmann <soren.brinkmann-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] i2c: cadence: fix Kconfig dependency
Date: Wed, 21 May 2014 09:00:20 -0700
Message-ID: <78a702ca-5001-444a-b2df-a64de17ffcb6@BY2FFO11FD039.protection.gbl>
References: <1396811227-8851-1-git-send-email-wsa@the-dreams.de>
 <1396852656.682914397@f273.i.mail.ru> <20140407065657.GO29751@pengutronix.de>
 <1396854155.872298456@f287.i.mail.ru>
 <4c4d2ba5-f5f6-4589-8a48-6a88d1c16098@VA3EHSMHS046.ehs.local>
 <20140521082917.GG2708@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140521082917.GG2708@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Michal Simek <michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Cc: Alexander Shiyan <shc_work-JGs/UdohzUI@public.gmane.org>, Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Wolfram,

On Wed, 2014-05-21 at 10:29AM +0200, Wolfram Sang wrote:
> > I'd propose the below fix. The relaxed IO helpers are currently
> > available on ARM only and the clock notifier used, depends on
> > COMMON_CLK. I2C-related dependencies should be okay due to the loca=
tion in
> > Kconfig of this option.
>=20
> If somebody thinks an update is still needed, please resend against
> latest i2c-next. Thanks.
>=20

I think we're fine for now. Once the *_relaxed IO helpers are available
on all archs it makes sense to revisit the COMPILE_TEST option. Until
then we are restricted to ARM anyway and the additional Zynq restrictio=
n
doesn't make a big difference, IMHO.

@Michal: Do you have an update on the IO helpers?

	Thanks,
	S=C3=B6ren
