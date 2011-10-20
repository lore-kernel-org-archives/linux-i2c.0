From: Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 2/2] i2c/nomadik: runtime PM support
Date: Fri, 21 Oct 2011 01:44:40 +0900
Message-ID: <CANqRtoSxHHKxLaKd-qPjCDomp5o-iiij8hqLCs7GNhs4xCV-jg@mail.gmail.com>
References: <1319127798-13395-1-git-send-email-linus.walleij@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1319127798-13395-1-git-send-email-linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
Cc: Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jonas Aaberg <jonas.aberg-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>, "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Fri, Oct 21, 2011 at 1:23 AM, Linus Walleij
<linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org> wrote:
> From: Jonas Aaberg <jonas.aberg-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
>
> Turn off the clock and regulator to the I2C block using runtime
> PM.
>
> Cc: Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Cc: Rafael J. Wysocki <rjw-KKrjLPT3xs0@public.gmane.org>
> Signed-off-by: Jonas Aaberg <jonas.aberg-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
> Signed-off-by: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> ---
> =A0drivers/i2c/busses/i2c-nomadik.c | =A0 53 ++++++++++++++++++++++++=
++++----------
> =A01 files changed, 39 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-nomadik.c b/drivers/i2c/busses/i2=
c-nomadik.c
> index ce4fd80..9ac9870 100644
> --- a/drivers/i2c/busses/i2c-nomadik.c
> +++ b/drivers/i2c/busses/i2c-nomadik.c

[snip]

> +static int nmk_i2c_runtime_suspend(struct device *dev)
> +{
> + =A0 =A0 =A0 struct platform_device *pdev =3D to_platform_device(dev=
);
> + =A0 =A0 =A0 struct nmk_i2c_dev *nmk_i2c =3D platform_get_drvdata(pd=
ev);
> +
> + =A0 =A0 =A0 clk_disable(nmk_i2c->clk);
> + =A0 =A0 =A0 if (nmk_i2c->regulator)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 regulator_disable(nmk_i2c->regulator);
> + =A0 =A0 =A0 return 0;
> +}
> +
> +static int nmk_i2c_runtime_resume(struct device *dev)
> +{
> + =A0 =A0 =A0 struct platform_device *pdev =3D to_platform_device(dev=
);
> + =A0 =A0 =A0 struct nmk_i2c_dev *nmk_i2c =3D platform_get_drvdata(pd=
ev);
> +
> + =A0 =A0 =A0 if (nmk_i2c->regulator)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 regulator_enable(nmk_i2c->regulator);
> + =A0 =A0 =A0 clk_enable(nmk_i2c->clk);
> + =A0 =A0 =A0 return 0;
> +}
> +

Hm, on SH-Mobile ARM we never control any clocks from the driver
runtime pm callbacks.

In our case the SoC code may associate various clocks with the struct
device and those clocks will be disabled and enabled automatically
when the driver does runtime pm put() and get() touch zero use count
for the device. The driver is happily unaware how many and which
clocks that are associated with the struct device.

So the clocks are started and stopped depending on the use count value
for a single device, but the actual driver callbacks are not however
invoked. In our case the runtime suspend callbacks are only invoked
when all the devices in the power domain happen to have a zero runtime
pm use count. So if you control your clocks from those callbacks then
they will be mostly left on which may not be what you want.

Perhaps your soc-specific code invokes the runtime pm suspend / resume
callbacks regardless of the state of all devices in a certain power
domain?

Cheers,

/ magnus
