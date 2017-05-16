From: Joakim Tjernlund <Joakim.Tjernlund@infinera.com>
Subject: Re: [PATCHv2] i2c-mpc: Correct I2C reset procedure
Date: Tue, 16 May 2017 15:13:33 +0000
Message-ID: <1494947612.7509.24.camel@infinera.com>
References: <20170511122033.22471-1-joakim.tjernlund@infinera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-bn3nam01on0054.outbound.protection.outlook.com ([104.47.33.54]:39072
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751974AbdEPPNj (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Tue, 16 May 2017 11:13:39 -0400
In-Reply-To: <20170511122033.22471-1-joakim.tjernlund@infinera.com>
Content-Language: en-US
Content-ID: <D535F25443C21941B4931C90467BDCFB@infinera.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: "wsa@the-dreams.de" <wsa@the-dreams.de>, "oss@buserror.net" <oss@buserror.net>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>

On Thu, 2017-05-11 at 14:20 +0200, Joakim Tjernlund wrote:
> Current I2C reset procedure is broken in two ways:
> 1) It only generate 1 START instead of 9 STARTs and STOP.
> 2) It leaves the bus Busy so every I2C xfer after the first
>    fixup calls the reset routine again, for every xfer there after.
>=20
> This fixes both errors.

Ping?

>=20
> Signed-off-by: Joakim Tjernlund <joakim.tjernlund@infinera.com>
> ---
>=20
>  v2 -  Remove io barrier call.
>  drivers/i2c/busses/i2c-mpc.c | 23 +++++++++++++++--------
>  1 file changed, 15 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/i2c/busses/i2c-mpc.c b/drivers/i2c/busses/i2c-mpc.c
> index 8393140..6b5e6ce4 100644
> --- a/drivers/i2c/busses/i2c-mpc.c
> +++ b/drivers/i2c/busses/i2c-mpc.c
> @@ -104,23 +104,30 @@ static irqreturn_t mpc_i2c_isr(int irq, void *dev_i=
d)
>  /* Sometimes 9th clock pulse isn't generated, and slave doesn't release
>   * the bus, because it wants to send ACK.
>   * Following sequence of enabling/disabling and sending start/stop gener=
ates
> - * the 9 pulses, so it's all OK.
> + * the 9 pulses, each with a START then ending with STOP, so it's all OK=
.
>   */
>  static void mpc_i2c_fixup(struct mpc_i2c *i2c)
>  {
>  	int k;
> -	u32 delay_val =3D 1000000 / i2c->real_clk + 1;
> -
> -	if (delay_val < 2)
> -		delay_val =3D 2;
> +	unsigned long flags;
> =20
>  	for (k =3D 9; k; k--) {
>  		writeccr(i2c, 0);
> -		writeccr(i2c, CCR_MSTA | CCR_MTX | CCR_MEN);
> +		writeb(0, i2c->base + MPC_I2C_SR); /* clear any status bits */
> +		writeccr(i2c, CCR_MEN | CCR_MSTA); /* START */
> +		readb(i2c->base + MPC_I2C_DR); /* init xfer */
> +		udelay(15); /* let it hit the bus */
> +		local_irq_save(flags); /* should not be delayed further */
> +		writeccr(i2c, CCR_MEN | CCR_MSTA | CCR_RSTA); /* delay SDA */
>  		readb(i2c->base + MPC_I2C_DR);
> -		writeccr(i2c, CCR_MEN);
> -		udelay(delay_val << 1);
> +		if (k !=3D 1)
> +			udelay(5);
> +		local_irq_restore(flags);
>  	}
> +	writeccr(i2c, CCR_MEN); /* Initiate STOP */
> +	readb(i2c->base + MPC_I2C_DR);
> +	udelay(15); /* Let STOP propagate */
> +	writeccr(i2c, 0);
>  }
> =20
>  static int i2c_wait(struct mpc_i2c *i2c, unsigned timeout, int writing)
