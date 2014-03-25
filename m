From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH v3] i2c: new bus driver for efm32
Date: Tue, 25 Mar 2014 10:07:00 +0100
Message-ID: <20140325090700.GL23076@pengutronix.de>
References: <1395414236-22647-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <20140324170131.GB7524@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140324170131.GB7524@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Andy Whitcroft <apw-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>, Joe Perches <joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hello,

On Mon, Mar 24, 2014 at 06:01:31PM +0100, Wolfram Sang wrote:
> And checkpatch said:
>=20
> WARNING: braces {} are not necessary for any arm of this statement
> #345: FILE: drivers/i2c/busses/i2c-efm32.c:239:
> +		if (cur_msg->flags & I2C_M_RD) {
> ...
hmm the whole block reads:

        case REG_STATE_STATE_DATA:
                if (cur_msg->flags & I2C_M_RD) {
                        efm32_i2c_recv_next_byte(ddata);
                } else {
                        /* wait for Ack or Nack of slave */
                }
                break;

so just removing the braces does the wrong thing. Is this a false
positive checkpatch warning? Andy? Joe?

I can make it:

		if (cur_msg->flags & I2C_M_RD)
			efm32_i2c_recv_next_byte(ddata);
		/* in the write case wait for Ack or Nack of slave */

but I consider the version above more readable.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
