From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v2] i2c: i801: fix unused-function warning
Date: Mon, 14 May 2018 20:18:37 +0300
Message-ID: <CAHp75VdJEzDsvJmv812wvc5p=frqc3KU8HW=y4cGULYEp4=SKQ@mail.gmail.com>
References: <20180510152719.6e37b10e@endymion> <20180514093326.30314-1-anders.roxell@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180514093326.30314-1-anders.roxell@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Anders Roxell <anders.roxell@linaro.org>
Cc: Jean Delvare <jdelvare@suse.com>, linux-i2c <linux-i2c@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

On Mon, May 14, 2018 at 12:33 PM, Anders Roxell
<anders.roxell@linaro.org> wrote:
> With CONFIG_PM, we get a harmless build warning:
> drivers/i2c/busses/i2c-i801.c:1723:12: warning: =E2=80=98i801_resume=E2=
=80=99 defined but not used [-Wunused-function]
>  static int i801_resume(struct device *dev)
>             ^~~~~~~~~~~
> drivers/i2c/busses/i2c-i801.c:1714:12: warning: =E2=80=98i801_suspend=E2=
=80=99 defined but not used [-Wunused-function]
>  static int i801_suspend(struct device *dev)
>             ^~~~~~~~~~~~

> -#ifdef CONFIG_PM
> +#ifdef CONFIG_PM_SLEEP
>  static int i801_suspend(struct device *dev)

The better pattern is to get rid of ugly ifdef and supply
__maybe_unused annotation to each function in question.


--=20
With Best Regards,
Andy Shevchenko
