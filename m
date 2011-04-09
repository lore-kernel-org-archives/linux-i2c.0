From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH -next reresend] i2c: designware-pcidrv depends on PCI
Date: Sat, 9 Apr 2011 13:34:49 +0200
Message-ID: <BANLkTikX_rG+6Eg4owary1YRGRG8NzyrGQ@mail.gmail.com>
References: <20110408083215.6b3b0bfe.randy.dunlap@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <20110408083215.6b3b0bfe.randy.dunlap@oracle.com>
Sender: linux-next-owner@vger.kernel.org
To: Randy Dunlap <randy.dunlap@oracle.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Baruch Siach <baruch@tkos.co.il>, linux-i2c@vger.kernel.org, linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, khali@linux-fr.org, ben-linux@fluff.org
List-Id: linux-i2c@vger.kernel.org

On Fri, Apr 8, 2011 at 17:32, Randy Dunlap <randy.dunlap@oracle.com> wr=
ote:
> From: Randy Dunlap <randy.dunlap@oracle.com>
>
> i2c-designware-pcidrv is a PCI driver and should depend on PCI.
> Fixes these build errors:
>
> drivers/i2c/busses/i2c-designware-pcidrv.c:256: error: implicit decla=
ration of function 'pci_request_region'
> drivers/i2c/busses/i2c-designware-pcidrv.c:338: error: implicit decla=
ration of function 'pci_release_region'
>
> Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
> Cc: Baruch Siach <baruch@tkos.co.il>
> ---
> =C2=A0drivers/i2c/busses/Kconfig | =C2=A0 =C2=A01 +
> =C2=A01 file changed, 1 insertion(+)
>
> Does anybody merge i2c patches???

Yes please, it's been there since Mar 17, reported several times, and p=
robably
masking other build failures.

> --- linux-next-20110316.orig/drivers/i2c/busses/Kconfig
> +++ linux-next-20110316/drivers/i2c/busses/Kconfig
> @@ -359,6 +359,7 @@ config I2C_DESIGNWARE_PLATFORM
>
> =C2=A0config I2C_DESIGNWARE_PCI
> =C2=A0 =C2=A0 =C2=A0 =C2=A0tristate "Synopsys DesignWare PCI"
> + =C2=A0 =C2=A0 =C2=A0 depends on PCI
> =C2=A0 =C2=A0 =C2=A0 =C2=A0help
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0If you say yes to this option, supp=
ort will be included for the
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Synopsys DesignWare I2C adapter. On=
ly master mode is supported.

Gr{oetje,eeting}s,

=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-=
m68k.org

In personal conversations with technical people, I call myself a hacker=
=2E But
when I'm talking to journalists I just say "programmer" or something li=
ke that.
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0=C2=A0 -- Linus Torvalds
