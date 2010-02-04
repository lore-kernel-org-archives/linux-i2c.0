From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: bjdooks' git - current state of i2c-next
Date: Wed, 3 Feb 2010 16:14:12 -0800
Message-ID: <20100204001412.GM22747@atomide.com>
References: <20100203023902.GA2794@fluff.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20100203023902.GA2794-elnMNo+KYs3pIgCt6eIbzw@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

* Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org> [100202 18:31]:
> Current state of next-i2c branch, which should be the start
> of the next merge window pull as long as there are no objections

Can you also please merge the 16-bit register support for i2c-omap?

The subject is "[v2,I2C-OMAP] Add support for 16-bit registers"

It's been tested in linux-omap tree for several weeks. Available
in mbox format at:

http://patchwork.kernel.org/patch/72295/

Regards,

Tony

=20
> The following changes since commit 1a45dcfe2525e9432cb4aba461d4994fc2=
befe42:
>   Linus Torvalds (1):
>         Merge branch 'for-linus' of git://git.kernel.dk/linux-2.6-blo=
ck
>=20
> are available in the git repository at:
>=20
>   git://git.fluff.org/bjdooks/linux.git next-i2c
>=20
> Jean-Hugues Deschenes (3):
>       i2c-designware: Use local version of readl & writel
>       i2c-designware: Check component type register
>       i2c-designware: Allow mixed endianness accesses
>=20
> Richard R=C3=B6jfors (1):
>       i2c: Add support for Xilinx XPS IIC Bus Interface
>=20
> Uwe Kleine-K=C3=B6nig (1):
>       i2c/imx: don't add probe function to the driver struct
>=20
> Wolfgang Grandegger (3):
>       i2c-mpc: use __devinit[data] for initialization functions and d=
ata
>       i2c-mpc: add support for the MPC512x processors from Freescale
>       powerpc: doc/dts-bindings: update doc of FSL I2C bindings
>=20
> srinidhi kasagar (1):
>       i2c: Add support for Ux500/Nomadik I2C controller
>=20
>  Documentation/powerpc/dts-bindings/fsl/i2c.txt |   30 +-
>  drivers/i2c/busses/Kconfig                     |   24 +-
>  drivers/i2c/busses/Makefile                    |    2 +
>  drivers/i2c/busses/i2c-designware.c            |  116 ++-
>  drivers/i2c/busses/i2c-imx.c                   |    1 -
>  drivers/i2c/busses/i2c-mpc.c                   |  198 +++--
>  drivers/i2c/busses/i2c-nomadik.c               |  959 ++++++++++++++=
++++++++++
>  drivers/i2c/busses/i2c-xiic.c                  |  823 ++++++++++++++=
++++++
>  include/linux/i2c-xiic.h                       |   43 ++
>  9 files changed, 2068 insertions(+), 128 deletions(-)
>  create mode 100644 drivers/i2c/busses/i2c-nomadik.c
>  create mode 100644 drivers/i2c/busses/i2c-xiic.c
>  create mode 100644 include/linux/i2c-xiic.h
>=20
> --=20
> Ben (ben-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, http://www.fluff.org/)
>=20
>   'a smiley only costs 4 bytes'
> --
> To unsubscribe from this list: send the line "unsubscribe linux-i2c" =
in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
