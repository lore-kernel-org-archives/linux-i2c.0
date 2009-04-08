From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] Fix sparse warnings for I2C_BOARD_INFO()
Date: Wed, 8 Apr 2009 20:12:12 +0200
Message-ID: <20090408201212.084db80a@hyperion.delvare>
References: <1239209853.3202.15.camel@achroite>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1239209853.3202.15.camel@achroite>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ben Hutchings <bhutchings-s/n/eUQHGBpZroRs9YW3xA@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Ben,

On Wed, 08 Apr 2009 17:57:33 +0100, Ben Hutchings wrote:
> =EF=BB=BFSince the first argument to I2C_BOARD_INFO() must be a strin=
g constant,
> there is no need to parenthesise it, and adding parentheses results i=
n
> an invalid initialiser for char[].  gcc obviously accepts this syntax=
 as
> an extension, but sparse complains, e.g.:
>=20
> drivers/net/sfc/boards.c:173:2: warning: array initialized from paren=
thesized string constant
>=20
> Therefore, remove the parentheses.
>=20
> Signed-off-by: Ben Hutchings <bhutchings-s/n/eUQHGBpZroRs9YW3xA@public.gmane.org>
> ---
>  i2c.h |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> ---
> diff --git a/include/linux/i2c.h b/include/linux/i2c.h
> index c86c3b0..f352a0a 100644
> --- a/include/linux/i2c.h
> +++ b/include/linux/i2c.h
> @@ -274,7 +274,7 @@ struct i2c_board_info {
>   * are provided using conventional syntax.
>   */
>  #define I2C_BOARD_INFO(dev_type, dev_addr) \
> -	.type =3D (dev_type), .addr =3D (dev_addr)
> +	.type =3D dev_type, .addr =3D (dev_addr)
> =20
> =20
>  /* Add-on boards should register/unregister their devices; e.g. a bo=
ard
>=20

Good catch! Applied, thanks.

--=20
Jean Delvare
