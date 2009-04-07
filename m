From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: Re: [GIT PULL] i2c updates for 2.6.30
Date: Tue, 7 Apr 2009 22:20:29 +0200
Message-ID: <10f740e80904071320t2fdd073bs51f3a8abf0f60e36@mail.gmail.com>
References: <20090328213950.1c788471@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090328213950.1c788471-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Sat, Mar 28, 2009 at 22:39, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org> wrote:
> Please pull the i2c subsystem updates for Linux 2.6.30 from:

> Wolfram Sang (4):
> =C2=A0 =C2=A0 =C2=A0i2c-algo-pca: Rework waiting for a free bus

This one introduced:

drivers/i2c/algos/i2c-algo-pca.c:197: warning: 'state' is used
uninitialized in this function

Probably

        while (pca_status(adap) !=3D 0xf8) {

should become

        while ((state =3D pca_status(adap)) !=3D 0xf8) {

again.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-=
m68k.org

In personal conversations with technical people, I call myself a hacker=
=2E But
when I'm talking to journalists I just say "programmer" or something li=
ke that.
							    -- Linus Torvalds
