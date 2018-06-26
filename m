From: Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: at24: Add address-width property
Date: Tue, 26 Jun 2018 10:44:53 -0600
Message-ID: <CAL_JsqLEK5gevV6N6qiqX2xya+S+pWfwbWsmhD3rjKoJyy-shA@mail.gmail.com>
References: <1529994128-26770-1-git-send-email-alanx.chiang@intel.com> <1529994128-26770-2-git-send-email-alanx.chiang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1529994128-26770-2-git-send-email-alanx.chiang@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Chiang <alanx.chiang@intel.com>
Cc: Linux I2C <linux-i2c@vger.kernel.org>, Andy Yeh <andy.yeh@intel.com>, Sakari Ailus <sakari.ailus@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@intel.com>, Rajmohan Mani <rajmohan.mani@intel.com>, Andy Shevchenko <andy.shevchenko@gmail.com>, Bartosz Golaszewski <brgl@bgdev.pl>, Mark Rutland <mark.rutland@arm.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

On Tue, Jun 26, 2018 at 12:22 AM <alanx.chiang@intel.com> wrote:
>
> From: "alanx.chiang" <alanx.chiang@intel.com>

Please fix your author name and send bindings to the DT list if you
want them reviewed.

>
> The AT24 series chips use 8-bit address by default. If some
> chips would like to support more than 8 bits, should add the compatible
> field for specfic chips in the driver.
>
> Provide a flexible way to determine the addressing bits through
> address-width in this patch.
>
> Signed-off-by: Alan Chiang <alanx.chiang@intel.com>
> Signed-off-by: Andy Yeh <andy.yeh@intel.com>
>
> ---
> since v1:
> -- Remove the address-width field in the example.
>
> ---
>  Documentation/devicetree/bindings/eeprom/at24.txt | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/eeprom/at24.txt b/Documentation/devicetree/bindings/eeprom/at24.txt
> index 61d833a..9467482 100644
> --- a/Documentation/devicetree/bindings/eeprom/at24.txt
> +++ b/Documentation/devicetree/bindings/eeprom/at24.txt
> @@ -72,6 +72,8 @@ Optional properties:
>
>    - wp-gpios: GPIO to which the write-protect pin of the chip is connected.
>
> +  - address-width : number of address bits (one of 8, 16).
> +
>  Example:
>
>  eeprom@52 {
> --
> 2.7.4
>
