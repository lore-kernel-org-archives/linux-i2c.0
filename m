From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: randconfig build error with next-20140604, in drivers/i2c/muxes/i2c-mux-pca954x.c
Date: Mon, 9 Jun 2014 15:12:01 +0200
Message-ID: <CACRpkdZO_vE1VnJ6=gEdX8P-qNADsskJkMOdaRDg-TabTSySCQ@mail.gmail.com>
References: <CA+r1Zhi9Qd4aZ2WJ02K4Gv=zg7QvG+r=t2VpiXRKXcYRc1vt=A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CA+r1Zhi9Qd4aZ2WJ02K4Gv=zg7QvG+r=t2VpiXRKXcYRc1vt=A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jim Davis <jim.epost@gmail.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linux-next <linux-next@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, Wolfram Sang <wsa@the-dreams.de>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, "Jean Delvare (PC drivers, core)" <khali@linux-fr.org>, Paul Gortmaker <paul.gortmaker@windriver.com>, Jingoo Han <jg1.han@samsung.com>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

On Wed, Jun 4, 2014 at 6:44 PM, Jim Davis <jim.epost@gmail.com> wrote:

> Building with the attached random configuration file,
>
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

I've sent a patch for this to Wolfram and the i2c discuss list.

Yours,
Linus Walleij
