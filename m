From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH -next] eeprom: at24: Remove set but not used variable 'addr'
Date: Fri, 31 May 2019 09:10:25 +0200
Message-ID: <CAMpxmJVDk1whp+YJXJO7QZKOR0e_EkU4TakJqRei0xF5Ay_Log@mail.gmail.com>
References: <20190529145954.14500-1-yuehaibing@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190529145954.14500-1-yuehaibing@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: YueHaibing <yuehaibing@huawei.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Greg KH <gregkh@linuxfoundation.org>, LKML <linux-kernel@vger.kernel.org>, linux-i2c <linux-i2c@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

=C5=9Br., 29 maj 2019 o 17:00 YueHaibing <yuehaibing@huawei.com> napisa=C5=
=82(a):
>
> Fixes gcc '-Wunused-but-set-variable' warning:
>
> drivers/misc/eeprom/at24.c: In function at24_make_dummy_client:
> drivers/misc/eeprom/at24.c:514:21: warning: variable addr set but not use=
d [-Wunused-but-set-variable]
>
> It's not used since commit e7308628d0ae ("eeprom:
> at24: use devm_i2c_new_dummy_device()")
>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/misc/eeprom/at24.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
> index ba8e73812644..fa730bb342e8 100644
> --- a/drivers/misc/eeprom/at24.c
> +++ b/drivers/misc/eeprom/at24.c
> @@ -511,13 +511,11 @@ static int at24_make_dummy_client(struct at24_data =
*at24, unsigned int index,
>                                   struct regmap_config *regmap_config)
>  {
>         struct i2c_client *base_client, *dummy_client;
> -       unsigned short int addr;
>         struct regmap *regmap;
>         struct device *dev;
>
>         base_client =3D at24->client[0].client;
>         dev =3D &base_client->dev;
> -       addr =3D base_client->addr + index;
>
>         dummy_client =3D devm_i2c_new_dummy_device(dev, base_client->adap=
ter,
>                                                  base_client->addr + inde=
x);
> --
> 2.17.1
>
>

Applied, thanks!

Bart
