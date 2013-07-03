From: "Christoph G. Baumann" <cb-/RsSufbtIHM@public.gmane.org>
Subject: Re: [PATCH] i2c: i2c_mxs: Set ACK_MODE bit
Date: Wed, 3 Jul 2013 15:34:12 +0200 (CEST)
Message-ID: <886382023.618771.1372858452205.open-xchange@email.1und1.de>
References: <1372780860-12972-1-git-send-email-fabio.estevam@freescale.com> <20130702181115.GR27010@pengutronix.de> <51D31FD1.4080002@freescale.com> <201307031520.53637.marex@denx.de>
Reply-To: "Christoph G. Baumann" <cb-/RsSufbtIHM@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <201307031520.53637.marex-ynQEQJNshbs@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Cc: kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hello Marek,

> > No, I haven't. I saw the report from Christoph in the linux-arm-ker=
nel
> > mailing list:
> > http://marc.info/?l=3Dlinux-arm-kernel&m=3D137277422127826&w=3D2
> >
> > And thought it could be nice if we could get it fixed for mx23 and =
mx28.
>
> How/when does this error manifest on the scope/LA?

the problem turned up when Uwe Kleine-K=C3=B6nig worked on implementing=
 SMBus and
I2C_M_RECV_LEN support for i.MX28 (my employer commissioned Pengutronix=
 in that
case). The receiving of such messages stops after the first (length inf=
ormation)
byte.
Maybe Uwe can comment on that.



Regards
Christoph
