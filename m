From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH v3 6/6] Cleanup
Date: Tue, 29 Jan 2013 10:31:51 +0100
Message-ID: <20130129103151.21262d1d@endymion.delvare>
References: <20130124083043.57f91a3d@endymion.delvare>
	<1359408070-31832-1-git-send-email-amaury.decreme@gmail.com>
	<1359408070-31832-7-git-send-email-amaury.decreme@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1359408070-31832-7-git-send-email-amaury.decreme-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Amaury =?ISO-8859-1?B?RGVjcuptZQ==?= <amaury.decreme-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, nelson-bExrPSV3DA0@public.gmane.org, mhoffman-xQSgfq/1h4JiLUuM0BA3LQ@public.gmane.org, amalysh-S0/GAf8tV78@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Mon, 28 Jan 2013 22:21:10 +0100, Amaury Decr=EAme wrote:
> This patch corrects checkpatch errors.
>=20
> The changes has also been removed as it has less meaning with version
> control tools.
>=20
> Signed-off-by: Amaury Decr=EAme <amaury.decreme-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>  drivers/i2c/busses/i2c-sis630.c | 210 ++++++++++++++++++++----------=
----------
>  1 file changed, 106 insertions(+), 104 deletions(-)

OK, this one needs a little more work to preserve code readability, see
below. As the 5 other patches are OK, please do not resend them, only
resend this one.

> diff --git a/drivers/i2c/busses/i2c-sis630.c b/drivers/i2c/busses/i2c=
-sis630.c
> index 424545b..0376318 100644
> --- a/drivers/i2c/busses/i2c-sis630.c
> +++ b/drivers/i2c/busses/i2c-sis630.c
> (...)
> @@ -150,9 +131,10 @@ static inline void sis630_write(u8 reg, u8 data)
>  	outb(data, smbus_base + reg);
>  }
> =20
> -static int sis630_transaction_start(struct i2c_adapter *adap, int si=
ze, u8 *oldclock)
> +static int sis630_transaction_start(struct i2c_adapter *adap, int si=
ze,
> +								u8 *oldclock)

The most common practice is to align the beginning of the second line
with the opening parenthesis of the first. Like this:

static int sis630_transaction_start(struct i2c_adapter *adap, int size,
				    u8 *oldclock)

This is believed to be easier to read. Please do that everywhere it
applies and your patch will be good to go.

> (...)
> +			} else if ((i - 1) % 8 =3D=3D 7 || i =3D=3D len) {
> +				dev_dbg(&adap->dev,
> +					"trans_wait len=3D%d i=3D%d\n", len, i);
> +				if (i > 8) {
> +					dev_dbg(&adap->dev,
> +					"clear smbary_sts len=3D%d i=3D%d\n", len,

Indentation is wrong here.

--=20
Jean Delvare
