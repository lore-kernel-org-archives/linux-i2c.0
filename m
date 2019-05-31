From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH] eeprom: at24: use struct_size() in devm_kzalloc()
Date: Fri, 31 May 2019 09:10:06 +0200
Message-ID: <CAMpxmJV_RQ-V8DMfsOSqRjY_HAys4cpmppUCffCwDWCrFchmLQ@mail.gmail.com>
References: <20190529163052.GA29158@embeddedor>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190529163052.GA29158@embeddedor>
Sender: linux-kernel-owner@vger.kernel.org
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-i2c <linux-i2c@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

=C5=9Br., 29 maj 2019 o 18:30 Gustavo A. R. Silva <gustavo@embeddedor.com>
napisa=C5=82(a):
>
> One of the more common cases of allocation size calculations is finding
> the size of a structure that has a zero-sized array at the end, along
> with memory for some number of elements for that array. For example:
>
> struct foo {
>     int stuff;
>     struct boo entry[];
> };
>
> size =3D sizeof(struct foo) + count * sizeof(struct boo);
> instance =3D devm_kzalloc(dev, size, GFP_KERNEL);
>
> Instead of leaving these open-coded and prone to type mistakes, we can
> now use the new struct_size() helper:
>
> instance =3D devm_kzalloc(dev, struct_size(instance, entry, count), GFP_K=
ERNEL);
>
> Notice that, in this case, variable at24_size is not necessary, hence it
> is removed.
>
> This code was detected with the help of Coccinelle.
>
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>  drivers/misc/eeprom/at24.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
> index ba8e73812644..78ba6b1917a8 100644
> --- a/drivers/misc/eeprom/at24.c
> +++ b/drivers/misc/eeprom/at24.c
> @@ -568,7 +568,6 @@ static int at24_probe(struct i2c_client *client)
>         unsigned int i, num_addresses;
>         struct at24_data *at24;
>         struct regmap *regmap;
> -       size_t at24_size;
>         bool writable;
>         u8 test_byte;
>         int err;
> @@ -652,8 +651,8 @@ static int at24_probe(struct i2c_client *client)
>         if (IS_ERR(regmap))
>                 return PTR_ERR(regmap);
>
> -       at24_size =3D sizeof(*at24) + num_addresses * sizeof(struct at24_=
client);
> -       at24 =3D devm_kzalloc(dev, at24_size, GFP_KERNEL);
> +       at24 =3D devm_kzalloc(dev, struct_size(at24, client, num_addresse=
s),
> +                           GFP_KERNEL);
>         if (!at24)
>                 return -ENOMEM;
>
> --
> 2.21.0
>

Applied, thanks!

Bart
