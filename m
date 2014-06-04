From: Jean Delvare <jdelvare@suse.de>
Subject: Re: [PATCH] i2c: pca954x: Fix compilation without CONFIG_GPIOLIB
Date: Wed, 4 Jun 2014 23:02:09 +0200
Message-ID: <20140604230209.21182dd3@endymion.delvare>
References: <CA+r1Zhi9Qd4aZ2WJ02K4Gv=zg7QvG+r=t2VpiXRKXcYRc1vt=A@mail.gmail.com>
	<1401900992-16581-1-git-send-email-laurent.pinchart@ideasonboard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1401900992-16581-1-git-send-email-laurent.pinchart@ideasonboard.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, linux-next@vger.kernel.org, wsa@the-dreams.de, linus.walleij@linaro.org, paul.gortmaker@windriver.com, jg1.han@samsung.com, Stephen Rothwell <sfr@canb.auug.org.au>, Jim Davis <jim.epost@gmail.com>
List-Id: linux-i2c@vger.kernel.org

On Wed,  4 Jun 2014 18:56:32 +0200, Laurent Pinchart wrote:
> The pca954x driver recently switched to the GPIO descriptor API witho=
ut
> including the correct <linux/gpio/consumer.h> header. This breaks
> compilation without CONFIG_GPIOLIB.
>=20
> drivers/i2c/muxes/i2c-mux-pca954x.c: In function =E2=80=98pca954x_pro=
be=E2=80=99:
> drivers/i2c/muxes/i2c-mux-pca954x.c:204:2: error: implicit declaratio=
n
> of function =E2=80=98devm_gpiod_get=E2=80=99 [-Werror=3Dimplicit-func=
tion-declaration]
>   gpio =3D devm_gpiod_get(&client->dev, "reset");
>   ^
> drivers/i2c/muxes/i2c-mux-pca954x.c:204:7: warning: assignment makes
> pointer from integer without a cast [enabled by default]
>   gpio =3D devm_gpiod_get(&client->dev, "reset");
>        ^
> drivers/i2c/muxes/i2c-mux-pca954x.c:206:3: error: implicit declaratio=
n
> of function =E2=80=98gpiod_direction_output=E2=80=99
> [-Werror=3Dimplicit-function-declaration]
>    gpiod_direction_output(gpio, 0);
>    ^
> cc1: some warnings being treated as errors
> make[3]: *** [drivers/i2c/muxes/i2c-mux-pca954x.o] Error 1
>=20
> Fix it by including the right header.
>=20
> Reported-by: Jim Davis <jim.epost@gmail.com>
> Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> ---
>  drivers/i2c/muxes/i2c-mux-pca954x.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> (...)

Acked-by: Jean Delvare <jdelvare@suse.de>

--=20
Jean Delvare
SUSE L3 Support
