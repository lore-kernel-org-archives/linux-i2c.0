From: =?ISO-8859-1?Q?H=E5vard_Skinnemoen?= <hskinnemoen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] i2c-gpio: add devicetree support
Date: Sun, 30 Jan 2011 19:26:24 -0800
Message-ID: <AANLkTi=5Uik+EwBRfYs_Pa77+qHngY03ezC63RC0WLQ8@mail.gmail.com>
References: <1296403013-6058-1-git-send-email-thomas@wytron.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1296403013-6058-1-git-send-email-thomas-SDxUXYEhEBiCuPEqFHbRBg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Thomas Chou <thomas-SDxUXYEhEBiCuPEqFHbRBg@public.gmane.org>
Cc: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, nios2-dev-1eJk0qcHJCcaeqlQEoCUNoJY59XmG8rH@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Albert Herranz <albert_herranz-mRCrAkd8dF0@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi,

On Sun, Jan 30, 2011 at 7:56 AM, Thomas Chou <thomas-SDxUXYEhEBiCuPEqFHbRBg@public.gmane.org> wro=
te:
> From: Albert Herranz <albert_herranz-mRCrAkd8dF0@public.gmane.org>
>
> This patch is based on an earlier patch from Albert Herranz,
> http://git.infradead.org/users/herraa1/gc-linux-2.6.git/commit/
> 9854eb78607c641ab5ae85bcbe3c9d14ac113733

That commit has a single-line description of which I don't understand
a single word (unless "wii" is what I think it is, which seems
likely). Could you please explain how that commit relates to this
patch?

> The dts binding is modified as Grant suggested. The of probing
> is merged inline instead of a separate file. It uses the newer
> of gpio probe.

It seems like a terrible idea to merge firmware-specific code into the
driver. Is there are reason why of-based platforms can't just pass the
data they need in pdata like everyone else?

Not saying that it necessarily _is_ a terrible idea, but I think the
reasoning behind it needs to be included in the patch description.

> Signed-off-by: Albert Herranz <albert_herranz-mRCrAkd8dF0@public.gmane.org>
> Signed-off-by: Thomas Chou <thomas-SDxUXYEhEBiCuPEqFHbRBg@public.gmane.org>
> ---
> =A0Documentation/devicetree/bindings/gpio/i2c.txt | =A0 39 ++++++++++=
++++
> =A0drivers/i2c/busses/i2c-gpio.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0|=
 =A0 67 ++++++++++++++++++++++-
> =A02 files changed, 103 insertions(+), 3 deletions(-)
> =A0create mode 100644 Documentation/devicetree/bindings/gpio/i2c.txt
>
> diff --git a/Documentation/devicetree/bindings/gpio/i2c.txt b/Documen=
tation/devicetree/bindings/gpio/i2c.txt
> new file mode 100644
> index 0000000..402569e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/gpio/i2c.txt

This looks a bit backwards. i2c-gpio is a i2c driver which happens to
utilize the gpio framework, not the other way around.

> @@ -0,0 +1,39 @@
> +GPIO-based I2C
> +
> +Required properties:
> +- compatible : should be "i2c-gpio".
> +- gpios : should specify GPIOs used for SDA and SCL lines, in that o=
rder.
> +Optional properties:
> +- sda-is-open-drain : present if SDA gpio is open-drain.
> +- scl-is-open-drain : present if SCL gpio is open-drain.
> +- scl-is-output-only : present if SCL is an output gpio only.

I think "present if the output driver for SCL cannot be turned off" is
more accurate. Might also be worth mentioning that this will prevent
clock stretching from working.

> --- a/drivers/i2c/busses/i2c-gpio.c
> +++ b/drivers/i2c/busses/i2c-gpio.c
> @@ -14,6 +14,9 @@
> =A0#include <linux/module.h>
> =A0#include <linux/slab.h>
> =A0#include <linux/platform_device.h>
> +#include <linux/of_platform.h>
> +#include <linux/of_gpio.h>
> +#include <linux/of_i2c.h>

Do these headers provide stubs so non-of platforms won't break?

> @@ -83,11 +86,52 @@ static int __devinit i2c_gpio_probe(struct platfo=
rm_device *pdev)
> =A0 =A0 =A0 =A0struct i2c_gpio_platform_data *pdata;
> =A0 =A0 =A0 =A0struct i2c_algo_bit_data *bit_data;
> =A0 =A0 =A0 =A0struct i2c_adapter *adap;
> + =A0 =A0 =A0 struct device_node *np =3D pdev->dev.of_node;

Would be nice if this could be eliminated on non-of platforms.

> =A0 =A0 =A0 =A0int ret;
>
> =A0 =A0 =A0 =A0pdata =3D pdev->dev.platform_data;
> - =A0 =A0 =A0 if (!pdata)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENXIO;
> + =A0 =A0 =A0 if (!pdata) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (np && of_gpio_count(np) >=3D 2) {

If that expression somehow always evaluates to false on non-of
platforms, this might be ok. But please confirm if this is the case;
otherwise, it looks like a pretty large addition to an otherwise very
small driver.

How about a tiny bit of restructuring: Move the block below into a
separate function, which is only called if some constant expression
says that of is enabled. Then you can move the declaration above
either into the if block or into the function, depending on where you
want to do the conditional above.

> =A0static struct platform_driver i2c_gpio_driver =3D {
> =A0 =A0 =A0 =A0.driver =A0 =A0 =A0 =A0 =3D {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.name =A0 =3D "i2c-gpio",
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.owner =A0=3D THIS_MODULE,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .of_match_table =3D i2c_gpio_match,

Is this field always present even when of is disabled?

Havard
