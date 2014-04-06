From: =?utf-8?B?U8O2cmVu?= Brinkmann <soren.brinkmann-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] i2c: cadence: fix Kconfig dependency
Date: Sun, 6 Apr 2014 15:13:18 -0700
Message-ID: <e1274f35-df56-4e76-8e0d-c83a8b59f059@AM1EHSMHS009.ehs.local>
References: <1396811227-8851-1-git-send-email-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1396811227-8851-1-git-send-email-wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Wolfram,

On Sun, 2014-04-06 at 09:07PM +0200, Wolfram Sang wrote:
> During development, the driver first really needed to depend on
> COMMON_CLK only. Later, it was switched to writel_relaxed, but it was
> forgotten to update the dependencies, so build errors occured:
>=20
> config: make ARCH=3Di386 allyesconfig
>=20
> All error/warnings:
>=20
>    drivers/i2c/busses/i2c-cadence.c: In function 'cdns_i2c_clear_bus_=
hold':
> >> drivers/i2c/busses/i2c-cadence.c:168:3: error: implicit declaratio=
n
> >> of function 'writel_relaxed' [-Werror=3Dimplicit-function-declarat=
ion]
>=20
> Use a very safe dependency for now.

Thanks for taking care of this. Looks like the '_relaxed' IO helpers ar=
e
only available on ARM. I'll give that a try and might send a patch
eventually. I suspect 'ARM && COMMON_CLK' would work and be a little
less restrictive.

	Thanks,
	S=C3=B6ren
