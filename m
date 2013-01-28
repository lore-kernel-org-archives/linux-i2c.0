From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH v2 2/6] Bugfix: clear sticky bits
Date: Mon, 28 Jan 2013 17:34:36 +0100
Message-ID: <20130128173436.39a9efff@endymion.delvare>
References: <1346204115-30293-1-git-send-email-amaury.decreme@gmail.com>
	<1357305215-17643-1-git-send-email-amaury.decreme@gmail.com>
	<1357305215-17643-3-git-send-email-amaury.decreme@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1357305215-17643-3-git-send-email-amaury.decreme-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Amaury =?ISO-8859-1?B?RGVjcuptZQ==?= <amaury.decreme-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: nelson-bExrPSV3DA0@public.gmane.org, mhoffman-xQSgfq/1h4JiLUuM0BA3LQ@public.gmane.org, amalysh-S0/GAf8tV78@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Fri,  4 Jan 2013 14:13:31 +0100, Amaury Decr=EAme wrote:
> The sticky bits must be cleared at the end of the transaction by writ=
ing
> a 1 to all fields.
>=20
> Datasheet:
> 	SMBus Status (SMB_STS)
> 	The following registers are all sticky bits and only can be
> 	cleared by writing a one to their corresponding fields.
>=20
> Signed-off-by: Amaury Decr=EAme <amaury.decreme-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>  drivers/i2c/busses/i2c-sis630.c |    4 +---
>  1 files changed, 1 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/i2c/busses/i2c-sis630.c b/drivers/i2c/busses/i2c=
-sis630.c
> index df8e20a..3124d80 100644
> --- a/drivers/i2c/busses/i2c-sis630.c
> +++ b/drivers/i2c/busses/i2c-sis630.c
> @@ -213,10 +213,8 @@ static int sis630_transaction_wait(struct i2c_ad=
apter *adap, int size)
> =20
>  static void sis630_transaction_end(struct i2c_adapter *adap, u8 oldc=
lock)
>  {
> -	int temp =3D 0;
> -
>  	/* clear all status "sticky" bits */
> -	sis630_write(SMB_STS, temp);
> +	sis630_write(SMB_STS, 0xFF);
> =20
>  	dev_dbg(&adap->dev, "SMB_CNT before clock restore 0x%02x\n", sis630=
_read(SMB_CNT));
> =20

Reviewed-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>

--=20
Jean Delvare
