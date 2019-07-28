From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: [PATCH v2 1/2] eeprom: at24: make spd world-readable again
Date: Sun, 28 Jul 2019 18:50:24 +0200
Message-ID: <CAMRc=Mfu7=GQ_BiBANVf1AQnkvtwPOE88f=DX4o0hSwXfFFEtA@mail.gmail.com>
References: <20190728184138.78afc30f@endymion>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190728184138.78afc30f@endymion>
Sender: linux-kernel-owner@vger.kernel.org
To: Jean Delvare <jdelvare@suse.de>
Cc: Linux I2C <linux-i2c@vger.kernel.org>, Andrew Lunn <andrew@lunn.ch>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

niedz., 28 lip 2019 o 18:41 Jean Delvare <jdelvare@suse.de> napisa=C5=82(a)=
:
>
> The integration of the at24 driver into the nvmem framework broke the
> world-readability of spd EEPROMs. Fix it.
>
> Signed-off-by: Jean Delvare <jdelvare@suse.de>
> Fixes: 57d155506dd5 ("eeprom: at24: extend driver to plug into the NVMEM =
framework")
> Cc: Andrew Lunn <andrew@lunn.ch>
> Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Bartosz Golaszewski <brgl@bgdev.pl>
> Cc: Arnd Bergmann <arnd@arndb.de>
> ---
> Note: This is only the 1st half of the fix, the nvmem core driver
> also needs to be fixed.
>
> Changes since V1:
>  * Split into 2 patches, one to the at24 driver and one to the nvmem
>    core.
>
>  drivers/misc/eeprom/at24.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> --- linux-5.1.orig/drivers/misc/eeprom/at24.c   2019-07-28 16:52:06.55091=
8923 +0200
> +++ linux-5.1/drivers/misc/eeprom/at24.c        2019-07-28 16:53:28.10416=
7083 +0200
> @@ -719,7 +719,7 @@ static int at24_probe(struct i2c_client
>         nvmem_config.name =3D dev_name(dev);
>         nvmem_config.dev =3D dev;
>         nvmem_config.read_only =3D !writable;
> -       nvmem_config.root_only =3D true;
> +       nvmem_config.root_only =3D !(flags & AT24_FLAG_IRUGO);
>         nvmem_config.owner =3D THIS_MODULE;
>         nvmem_config.compat =3D true;
>         nvmem_config.base_dev =3D dev;
>
>
> --
> Jean Delvare
> SUSE L3 Support

Applied to fixes.

Bart
