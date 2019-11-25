From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: Re: [PATCH 2/4] i2c: i2c-cros-ec-tunnel: Fix ACPI identifier
Date: Mon, 25 Nov 2019 17:23:17 +0100
Message-ID: <d82806a6-101e-181b-60de-0b32ff153ec6@collabora.com>
References: <20191121211053.48861-1-rrangel@chromium.org>
 <20191121140830.2.I68b9a92ed4def031c3f247d3b49996a2512d762d@changeid>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191121140830.2.I68b9a92ed4def031c3f247d3b49996a2512d762d@changeid>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Raul E Rangel <rrangel@chromium.org>, Wolfram Sang <wsa@the-dreams.de>
Cc: Akshu.Agrawal@amd.com, linux-kernel@vger.kernel.org, Guenter Roeck <groeck@chromium.org>, Benson Leung <bleung@chromium.org>, Neil Armstrong <narmstrong@baylibre.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-i2c@vger.kernel.org, dlaurie@chromium.org
List-Id: linux-i2c@vger.kernel.org

Hi Raul,

On 21/11/19 22:10, Raul E Rangel wrote:
> The initial patch was using the incorrect identifier.
> 
> Signed-off-by: Raul E Rangel <rrangel@chromium.org>
> ---
> There are currently no boards using the identifier so it's fine to
> change it.
> 

Right, I don't see GOOG001A being used but also I don't see GOOG0012. Anyway,
for the CrOS EC side, the change looks good to me. I think this will go through
the I2C tree?

Acked-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

Thanks,
 Enric

>  drivers/i2c/busses/i2c-cros-ec-tunnel.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/i2c/busses/i2c-cros-ec-tunnel.c b/drivers/i2c/busses/i2c-cros-ec-tunnel.c
> index ac2412755f0a..5d91e33eb600 100644
> --- a/drivers/i2c/busses/i2c-cros-ec-tunnel.c
> +++ b/drivers/i2c/busses/i2c-cros-ec-tunnel.c
> @@ -299,7 +299,7 @@ static const struct of_device_id cros_ec_i2c_of_match[] = {
>  MODULE_DEVICE_TABLE(of, cros_ec_i2c_of_match);
>  
>  static const struct acpi_device_id cros_ec_i2c_tunnel_acpi_id[] = {
> -	{ "GOOG001A", 0 },
> +	{ "GOOG0012", 0 },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(acpi, cros_ec_i2c_tunnel_acpi_id);
> 
