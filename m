From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] i2c-designware: Manually set RESTART bit between messages
Date: Wed, 3 Jul 2013 22:15:11 +0200
Message-ID: <20130703201510.GB2958@katana>
References: <1371798328-31931-1-git-send-email-chiaue.ee.chew@intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wzJLGUyc3ArbnUjN"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1371798328-31931-1-git-send-email-chiaue.ee.chew-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Chew Chiau Ee <chiaue.ee.chew-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Christian Ruppert <christian.ruppert-ux6zf3SgZrrQT0dZR+AlfA@public.gmane.org>, Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--wzJLGUyc3ArbnUjN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


CCing Mika and Christian.

On Fri, Jun 21, 2013 at 03:05:28PM +0800, Chew Chiau Ee wrote:
> From: Chew, Chiau Ee <chiau.ee.chew-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
>=20
> If both IC_EMPTYFIFO_HOLD_MASTER_EN and IC_RESTART_EN are set to 1, the
> Designware I2C controller doesn't generate RESTART unless user specifical=
ly
> requests it by setting RESTART bit in IC_DATA_CMD register.
>=20
> Since IC_EMPTYFIFO_HOLD_MASTER_EN setting can't be detected from hardware
> register, we must always manually set the restart bit between messages.
>=20
> Signed-off-by: Chew, Chiau Ee <chiau.ee.chew-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

How come restart has worked before? Or did it not?

> ---
>  drivers/i2c/busses/i2c-designware-core.c |   14 ++++++++++++++
>  1 files changed, 14 insertions(+), 0 deletions(-)
>=20
> diff --git a/drivers/i2c/busses/i2c-designware-core.c b/drivers/i2c/busse=
s/i2c-designware-core.c
> index 3de5494..9348439 100644
> --- a/drivers/i2c/busses/i2c-designware-core.c
> +++ b/drivers/i2c/busses/i2c-designware-core.c
> @@ -403,6 +403,7 @@ i2c_dw_xfer_msg(struct dw_i2c_dev *dev)
>  	u32 addr =3D msgs[dev->msg_write_idx].addr;
>  	u32 buf_len =3D dev->tx_buf_len;
>  	u8 *buf =3D dev->tx_buf;
> +	bool need_restart =3D false;
> =20
>  	intr_mask =3D DW_IC_INTR_DEFAULT_MASK;
> =20
> @@ -430,6 +431,14 @@ i2c_dw_xfer_msg(struct dw_i2c_dev *dev)
>  			/* new i2c_msg */
>  			buf =3D msgs[dev->msg_write_idx].buf;
>  			buf_len =3D msgs[dev->msg_write_idx].len;
> +
> +			/* If both IC_EMPTYFIFO_HOLD_MASTER_EN and
> +			 * IC_RESTART_EN are set, we must manually
> +			 * set restart bit between messages.
> +			 */
> +			if ((dev->master_cfg & DW_IC_CON_RESTART_EN) &&
> +					(dev->msg_write_idx > 0))
> +				need_restart =3D true;
>  		}
> =20
>  		tx_limit =3D dev->tx_fifo_depth - dw_readl(dev, DW_IC_TXFLR);
> @@ -448,6 +457,11 @@ i2c_dw_xfer_msg(struct dw_i2c_dev *dev)
>  			    buf_len =3D=3D 1)
>  				cmd |=3D BIT(9);
> =20
> +			if (need_restart) {
> +				cmd |=3D BIT(10);
> +				need_restart =3D false;
> +			}
> +
>  			if (msgs[dev->msg_write_idx].flags & I2C_M_RD) {
> =20
>  				/* avoid rx buffer overrun */
> --=20
> 1.7.4.4
>=20

--wzJLGUyc3ArbnUjN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJR1IZOAAoJEBQN5MwUoCm2J98QAIwj2N31th3WcAsnBqKhUisT
nMrEv2oF+tjCpoMfY1OLfv5j6Yj1kFfyxCRLpuJSnm+Q2j9NaDXKk9L/MrHt2igK
XNbMHUfzE7e7a5LR3wy1ZPVvQ7vBpN2HcLfnWoL3OfpYkAnDWfd2X99V+2gN4ILC
wm779OdIxi4QQWr7YbEAxYtdY1TJlUg9Adx5zsg4yALmdonwnBDB6JHC935GzFxT
j8wH0RIZ3Aldauafsr9SsjXsagwiYppRnM/bF0ljm3kz0bZCLY6sH7bHxP8VOm8+
rK2ddTZ8cP9wzh2RxteLInPmrqBFY2e1sStDx028wGw9s54Z0uoO6gZvhpRpuVZ2
L8uBwQMPjd6VscJQaLO1ibJRupDGixHi9LGmqh0GLIOFN6Uvhb5H8V9MXfaSArNA
y5QVVZBbydoujQJ4Obl0PkHjjxUqLVazmEHzUw/Va6DUwgmgS78Maet/RtG1bBYc
Y5+t6YmtB+NVp6fDEy1R5TN4EXOrOB96wv44QtdY49vsz6AKpzzMLlNyRhq7gk7R
dhJtfiK9qW9KCUoAMyIi+isULZVdbpj7ZA/dPvzstczWTUFqsj7KlYc22zBWIqJw
Y9NgcI/WycsbyMD3k7Jc3/pQ5Ddauv2Blz/xWm3DVzUeEwz8gDpL62uYoZsJqe82
ZlR4Sfz1oz9EJri3I8nc
=vmkD
-----END PGP SIGNATURE-----

--wzJLGUyc3ArbnUjN--
