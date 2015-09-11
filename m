From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v4 3/8] i2c: Match using traditional OF methods, then by
 vendor-less compatible strings
Date: Fri, 11 Sep 2015 10:31:35 +0100
Message-ID: <20150911093135.GP3260@x1>
References: <1441823627-6227-1-git-send-email-kieranbingham@gmail.com>
 <1441823627-6227-4-git-send-email-kieranbingham@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1441823627-6227-4-git-send-email-kieranbingham@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kieran Bingham <kieranbingham@gmail.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, Samuel Ortiz <sameo@linux.intel.com>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, linus.walleij@linaro.org, grant.likely@linaro.org
List-Id: linux-i2c@vger.kernel.org

On Wed, 09 Sep 2015, Kieran Bingham wrote:

> From: Lee Jones <lee.jones@linaro.org>
>=20
> This function provides a single call for all I2C devices which need t=
o
> match firstly using traditional OF means i.e by of_node, then if that
> fails we attempt to match using the supplied I2C client name with a
> list of supplied compatible strings with the '<vendor>,' string
> removed.  The latter is required due to the unruly naming conventions
> used currently by I2C devices.
>=20
> Acked-by: Grant Likely <grant.likely@linaro.org>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

SoB?

> ---
>  drivers/i2c/i2c-core.c | 16 ++++++++++++++++
>  include/linux/i2c.h    | 12 ++++++++++++
>  2 files changed, 28 insertions(+)
>=20
> diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
> index 0788c1f..94ca76e 100644
> --- a/drivers/i2c/i2c-core.c
> +++ b/drivers/i2c/i2c-core.c
> @@ -1394,6 +1394,22 @@ i2c_of_match_device_strip_vendor(const struct =
of_device_id *matches,
>  	return NULL;
>  }
> =20
> +const struct of_device_id
> +*i2c_of_match_device(const struct of_device_id *matches,
> +		     struct i2c_client *client)
> +{
> +	const struct of_device_id *match;
> +
> +	if (!(client && matches))
> +		return NULL;
> +
> +	match =3D of_match_device(matches, &client->dev);
> +	if (match)
> +		return match;
> +
> +	return i2c_of_match_device_strip_vendor(matches, client);
> +}
> +EXPORT_SYMBOL_GPL(i2c_of_match_device);
>  #else
>  static void of_i2c_register_devices(struct i2c_adapter *adap) { }
>  #endif /* CONFIG_OF */
> diff --git a/include/linux/i2c.h b/include/linux/i2c.h
> index e83a738..48bbbab 100644
> --- a/include/linux/i2c.h
> +++ b/include/linux/i2c.h
> @@ -638,6 +638,10 @@ extern struct i2c_client *of_find_i2c_device_by_=
node(struct device_node *node);
>  /* must call put_device() when done with returned i2c_adapter device=
 */
>  extern struct i2c_adapter *of_find_i2c_adapter_by_node(struct device=
_node *node);
> =20
> +extern const struct of_device_id
> +*i2c_of_match_device(const struct of_device_id *matches,
> +		     struct i2c_client *client);
> +
>  #else
> =20
>  static inline struct i2c_client *of_find_i2c_device_by_node(struct d=
evice_node *node)
> @@ -649,6 +653,14 @@ static inline struct i2c_adapter *of_find_i2c_ad=
apter_by_node(struct device_node
>  {
>  	return NULL;
>  }
> +
> +const struct of_device_id
> +*i2c_of_match_device(const struct of_device_id *matches,
> +		     struct i2c_client *client)
> +{
> +	return NULL;
> +}
> +
>  #endif /* CONFIG_OF */
> =20
>  #endif /* _LINUX_I2C_H */

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
