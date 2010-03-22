From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH 1/3] i2c/pxa: remove unused macro
Date: Mon, 22 Mar 2010 22:04:11 +0100
Message-ID: <20100322210411.GD10157@pengutronix.de>
References: <20100224110044.GB15181@pengutronix.de> <1267009306-17227-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1267009306-17227-1-git-send-email-u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Eric Miao <eric.y.miao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Roel Kluin <roel.kluin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Ben,

On Wed, Feb 24, 2010 at 12:01:44PM +0100, Uwe Kleine-K=F6nig wrote:
> Commit
>=20
> 	beea494 ([ARM] Remove EEPROM slave emulation from i2c-pxa driver.)
>=20
> removed all uses of eedbg, so the definition can go, too.
>=20
> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> Acked-by: Russell King <rmk+kernel-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
> Cc: Eric Miao <eric.y.miao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Cc: Roel Kluin <roel.kluin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Acked-by: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
ping

Uwe
> ---
>  drivers/i2c/busses/i2c-pxa.c |    2 --
>  1 files changed, 0 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/i2c/busses/i2c-pxa.c b/drivers/i2c/busses/i2c-px=
a.c
> index 7647a20..b3c6c9d 100644
> --- a/drivers/i2c/busses/i2c-pxa.c
> +++ b/drivers/i2c/busses/i2c-pxa.c
> @@ -216,8 +216,6 @@ static void i2c_pxa_show_state(struct pxa_i2c *i2=
c, int lno, const char *fname)
>  #define decode_ICR(val) do { } while (0)
>  #endif
> =20
> -#define eedbg(lvl, x...) do { if ((lvl) < 1) { printk(KERN_DEBUG "" =
x); } } while(0)
> -
>  static void i2c_pxa_master_complete(struct pxa_i2c *i2c, int ret);
>  static irqreturn_t i2c_pxa_handler(int this_irq, void *dev_id);
> =20
> --=20
> 1.6.6.2

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
