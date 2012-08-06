From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 1/1] i2c: Add default configuration into the Nomadik I2C
 driver.
Date: Mon, 6 Aug 2012 15:11:21 +0100
Message-ID: <20120806141120.GE10524@gmail.com>
References: <1344255947-10062-1-git-send-email-lee.jones@linaro.org>
 <CACRpkdZoJxyZX6SOcAvBP4NBmGyUEiyLH_n_RzSDTBsjS13zug@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CACRpkdZoJxyZX6SOcAvBP4NBmGyUEiyLH_n_RzSDTBsjS13zug@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, STEricsson_nomadik_linux@list.st.com, linus.walleij@stericsson.com, arnd@arndb.de, w.sang@pengutronix.de, srinidhi.kasagar@stericsson.com, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Mon, Aug 06, 2012 at 04:00:04PM +0200, Linus Walleij wrote:
> On Mon, Aug 6, 2012 at 2:25 PM, Lee Jones <lee.jones@linaro.org> wrot=
e:
>=20
> > At this moment in time there is only one known configuration for th=
e
> > Nomadik I2C driver. By not holding that configuration in the driver
> > adds some unnecessary overhead in platform code. The configuration
> > as already been removed from platform code, this patch checks for a=
ny
> > over-riding configurations. If there aren't any, the default is use=
d.
> >
> > Cc: linux-i2c@vger.kernel.org
> > Acked-by: srinidhi kasagar <srinidhi.kasagar@stericsson.com>
> > Acked-by: Linus Walleij <linus.walleij@linaro.org>
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
>=20
> This still does not apply for me on v3.6-rc1 what did you base
> this patch on?
>=20
> Applying: i2c: Add default configuration into the Nomadik I2C driver.
> error: patch failed: drivers/i2c/busses/i2c-nomadik.c:899
> error: drivers/i2c/busses/i2c-nomadik.c: patch does not apply
> Patch failed at 0001 i2c: Add default configuration into the Nomadik =
I2C driver.
> When you have resolved this problem run "git am --resolved".
> If you would prefer to skip this patch, instead run "git am --skip".
> To restore the original branch and stop patching run "git am --abort"=
=2E

Ah, my mistake.

I'll rebase to latest and re-submit.

--=20
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
