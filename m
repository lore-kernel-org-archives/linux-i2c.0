From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 4/5] i2c: stu300: Use proper printk format for iomem pointer
Date: Tue, 7 Jan 2020 11:36:04 +0100
Message-ID: <CACRpkdaKPWott93XQp1iWMO6m6TqqW+iuN33PnSDOnOMMdCEbg@mail.gmail.com>
References: <20191230172751.17985-1-krzk@kernel.org> <20191230172751.17985-4-krzk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191230172751.17985-4-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Vladimir Zapolskiy <vz@mleia.com>, Sylvain Lemieux <slemieux.tyco@gmail.com>, Wolfram Sang <wsa@the-dreams.de>, Jean Delvare <jdelvare@suse.de>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Max Staudt <max@enpas.org>, Juergen Fitschen <jfi@ssv-embedded.de>, Elie Morisse <syniurge@gmail.com>, linux-i2c <linux-i2c@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>
List-Id: linux-i2c@vger.kernel.org

On Mon, Dec 30, 2019 at 6:28 PM Krzysztof Kozlowski <krzk@kernel.org> wrote=
:

> iomem pointers should be printed with pointer format to hide the
> actual value and fix warnings when compiling on 64-bit platform (e.g. wit=
h
> COMPILE_TEST):
>
>     drivers/i2c/busses/i2c-stu300.c: In function =E2=80=98stu300_wait_whi=
le_busy=E2=80=99:
>     drivers/i2c/busses/i2c-stu300.c:446:76: warning:
>         cast from pointer to integer of different size [-Wpointer-to-int-=
cast]
>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
