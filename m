From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: [PATCH] treewide: remove redundent IS_ERR() before error code check
Date: Mon, 6 Jan 2020 10:38:05 +0100
Message-ID: <CAMRc=MeTC8X9wDV7bowEvjPxjUNH8hXSJC79iy9s9W9Yn6Fh8A@mail.gmail.com>
References: <20200106045833.1725-1-masahiroy@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200106045833.1725-1-masahiroy@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, devicetree <devicetree@vger.kernel.org>, alsa-devel@alsa-project.org, linux-acpi@vger.kernel.org, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, netdev <netdev@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Julia Lawall <julia.lawall@lip6.fr>, "open list:MEMORY TECHNOLOGY..." <linux-mtd@lists.infradead.org>, linux-crypto@vger.kernel.org, linux-clk <linux-clk@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, linux-i2c <linux-i2c@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

pon., 6 sty 2020 o 06:00 Masahiro Yamada <masahiroy@kernel.org> napisa=C5=
=82(a):
>
> 'PTR_ERR(p) =3D=3D -E*' is a stronger condition than IS_ERR(p).
> Hence, IS_ERR(p) is unneeded.
>
> The semantic patch that generates this commit is as follows:
>
> // <smpl>
> @@
> expression ptr;
> constant error_code;
> @@
> -IS_ERR(ptr) && (PTR_ERR(ptr) =3D=3D - error_code)
> +PTR_ERR(ptr) =3D=3D - error_code
> // </smpl>
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

For GPIO:

Acked-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
