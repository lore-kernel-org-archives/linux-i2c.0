From: Raul Rangel <rrangel@chromium.org>
Subject: Re: [PATCH] i2c: i2c-cros-ec-tunnel: Make the device acpi compatible
Date: Mon, 11 Nov 2019 09:19:50 -0700
Message-ID: <CAHQZ30DKWqGj+iC+vebgrZTU31icBMAzN2jW+fdKpwL9eeg4oQ@mail.gmail.com>
References: <20191111161431.26293-1-akshu.agrawal@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191111161431.26293-1-akshu.agrawal@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Akshu Agrawal <akshu.agrawal@amd.com>
Cc: cychiang@chromium.org, Benson Leung <bleung@chromium.org>, Enric Balletbo i Serra <enric.balletbo@collabora.com>, Guenter Roeck <groeck@chromium.org>, Wolfram Sang <wsa@the-dreams.de>, Mark Brown <broonie@kernel.org>, Neil Armstrong <narmstrong@baylibre.com>, "open list:I2C SUBSYSTEM HOST DRIVERS" <linux-i2c@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

On Mon, Nov 11, 2019 at 9:15 AM Akshu Agrawal <akshu.agrawal@amd.com> wrote:
>
> Add ACPI entry and use device_property_read to get fw value
> which is common to both dtsi and acpi.
>
> Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>
> ---
>  drivers/i2c/busses/i2c-cros-ec-tunnel.c | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-cros-ec-tunnel.c b/drivers/i2c/busses/i2c-cros-ec-tunnel.c
> index c551aa96a2e3..958161c71985 100644
> --- a/drivers/i2c/busses/i2c-cros-ec-tunnel.c
> +++ b/drivers/i2c/busses/i2c-cros-ec-tunnel.c
> @@ -3,6 +3,7 @@
>  //
>  // Copyright (C) 2013 Google, Inc.
>
> +#include <linux/acpi.h>
>  #include <linux/module.h>
>  #include <linux/i2c.h>
>  #include <linux/platform_data/cros_ec_commands.h>
> @@ -240,7 +241,6 @@ static const struct i2c_algorithm ec_i2c_algorithm = {
>
>  static int ec_i2c_probe(struct platform_device *pdev)
>  {
> -       struct device_node *np = pdev->dev.of_node;
>         struct cros_ec_device *ec = dev_get_drvdata(pdev->dev.parent);
>         struct device *dev = &pdev->dev;
>         struct ec_i2c_device *bus = NULL;
> @@ -256,7 +256,7 @@ static int ec_i2c_probe(struct platform_device *pdev)
>         if (bus == NULL)
>                 return -ENOMEM;
>
> -       err = of_property_read_u32(np, "google,remote-bus", &remote_bus);
> +       err = device_property_read_u32(dev, "google,remote-bus", &remote_bus);
>         if (err) {
>                 dev_err(dev, "Couldn't read remote-bus property\n");
>                 return err;
> @@ -271,7 +271,7 @@ static int ec_i2c_probe(struct platform_device *pdev)
>         bus->adap.algo = &ec_i2c_algorithm;
>         bus->adap.algo_data = bus;
>         bus->adap.dev.parent = &pdev->dev;
> -       bus->adap.dev.of_node = np;
> +       bus->adap.dev.of_node = pdev->dev.of_node;
>         bus->adap.retries = I2C_MAX_RETRIES;
>
>         err = i2c_add_adapter(&bus->adap);
> @@ -291,19 +291,24 @@ static int ec_i2c_remove(struct platform_device *dev)
>         return 0;
>  }
>
> -#ifdef CONFIG_OF
>  static const struct of_device_id cros_ec_i2c_of_match[] = {
>         { .compatible = "google,cros-ec-i2c-tunnel" },
>         {},
>  };
>  MODULE_DEVICE_TABLE(of, cros_ec_i2c_of_match);
> -#endif
> +
> +static const struct acpi_device_id cros_ec_i2c_tunnel_acpi_id[] = {
> +       { "GOOG001A", 0 },
> +       { }
> +};
> +MODULE_DEVICE_TABLE(acpi, cros_ec_i2c_tunnel_acpi_id);
>
>  static struct platform_driver ec_i2c_tunnel_driver = {
>         .probe = ec_i2c_probe,
>         .remove = ec_i2c_remove,
>         .driver = {
>                 .name = "cros-ec-i2c-tunnel",
> +               .acpi_match_table = ACPI_PTR(cros_ec_i2c_tunnel_acpi_id),
>                 .of_match_table = of_match_ptr(cros_ec_i2c_of_match),
>         },
>  };
> --
> 2.17.1
>

Acked-by: Raul E Rangel <rrangel@chromium.org>
