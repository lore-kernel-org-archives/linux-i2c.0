From: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v4 5/8] i2c: Export i2c_match_id() for direct use by
 device drivers
Date: Fri, 11 Sep 2015 10:30:52 +0100
Message-ID: <20150911093052.GN3260@x1>
References: <1441823627-6227-1-git-send-email-kieranbingham@gmail.com>
 <1441823627-6227-6-git-send-email-kieranbingham@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1441823627-6227-6-git-send-email-kieranbingham-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kieran Bingham <kieranbingham-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Wed, 09 Sep 2015, Kieran Bingham wrote:

> From: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>=20
> When there was no other way to match a I2C device to driver i2c_match=
_id()
> was exclusively used.  However, now there are other types of tables w=
hich
> are commonly supplied, matching on an i2c_device_id table is used les=
s
> frequently.  Instead of _always_ calling i2c_match_id() from within t=
he
> framework, we only need to do so from drivers which have no other way=
 of
> matching.  This patch makes i2c_match_id() available to the aforement=
ioned
> device drivers.
>=20
> Acked-by: Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> Signed-off-by: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

SoB?

> ---
>  drivers/i2c/i2c-core.c | 3 ++-
>  include/linux/i2c.h    | 2 ++
>  2 files changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
> index 2ebc64d..0e40136 100644
> --- a/drivers/i2c/i2c-core.c
> +++ b/drivers/i2c/i2c-core.c
> @@ -447,7 +447,7 @@ static inline int acpi_i2c_install_space_handler(=
struct i2c_adapter *adapter)
> =20
>  /* -----------------------------------------------------------------=
-------- */
> =20
> -static const struct i2c_device_id *i2c_match_id(const struct i2c_dev=
ice_id *id,
> +const struct i2c_device_id *i2c_match_id(const struct i2c_device_id =
*id,
>  						const struct i2c_client *client)
>  {
>  	if (!(id && client))
> @@ -460,6 +460,7 @@ static const struct i2c_device_id *i2c_match_id(c=
onst struct i2c_device_id *id,
>  	}
>  	return NULL;
>  }
> +EXPORT_SYMBOL_GPL(i2c_match_id);
> =20
>  static int i2c_device_match(struct device *dev, struct device_driver=
 *drv)
>  {
> diff --git a/include/linux/i2c.h b/include/linux/i2c.h
> index 48bbbab..126585c 100644
> --- a/include/linux/i2c.h
> +++ b/include/linux/i2c.h
> @@ -232,6 +232,8 @@ struct i2c_client {
> =20
>  extern struct i2c_client *i2c_verify_client(struct device *dev);
>  extern struct i2c_adapter *i2c_verify_adapter(struct device *dev);
> +extern const struct i2c_device_id *i2c_match_id(const struct i2c_dev=
ice_id *id,
> +					const struct i2c_client *client);
> =20
>  static inline struct i2c_client *kobj_to_i2c_client(struct kobject *=
kobj)
>  {

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
