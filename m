From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: [RESEND PATCH v4 1/2] dt-bindings: at24: Add address-width property
Date: Wed, 25 Jul 2018 09:35:30 +0200
Message-ID: <CAMRc=MdHAU8Y==hhhV6L7o1-J9LfTUZrDMYCLm+rASpagFMNmQ@mail.gmail.com>
References: <1532488822-5622-1-git-send-email-alanx.chiang@intel.com> <1532488822-5622-2-git-send-email-alanx.chiang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1532488822-5622-2-git-send-email-alanx.chiang@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Chiang, AlanX" <alanx.chiang@intel.com>
Cc: linux-i2c <linux-i2c@vger.kernel.org>, "Yeh, Andy" <andy.yeh@intel.com>, Sakari Ailus <sakari.ailus@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, "Shevchenko, Andriy" <andriy.shevchenko@intel.com>, Rajmohan Mani <rajmohan.mani@intel.com>, Andy Shevchenko <andy.shevchenko@gmail.com>, tfiga@chromium.org, jcliang@chromium.org, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Arnd Bergmann <arnd@arndb.de>, "Robert P. J. Day" <rpjday@crashcourse.ca>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, devicetree <devicetree@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

2018-07-25 5:20 GMT+02:00  <alanx.chiang@intel.com>:
> From: Alan Chiang <alanx.chiang@intel.com>
>
> Currently the only way to use a variant of a supported model with
> a different address with a different address width is to define a

There's some copy-paste problem here. I fixed it.

> new compatible string and the corresponding chip data structure.
>
> Provide a flexible way to specify the size of the address pointer
> by defining a new property: address-width.
>
> Signed-off-by: Alan Chiang <alanx.chiang@intel.com>
> Signed-off-by: Andy Yeh <andy.yeh@intel.com>
> Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
>  Documentation/devicetree/bindings/eeprom/at24.txt | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/eeprom/at24.txt b/Documentation/devicetree/bindings/eeprom/at24.txt
> index 61d833a..aededdb 100644
> --- a/Documentation/devicetree/bindings/eeprom/at24.txt
> +++ b/Documentation/devicetree/bindings/eeprom/at24.txt
> @@ -72,6 +72,8 @@ Optional properties:
>
>    - wp-gpios: GPIO to which the write-protect pin of the chip is connected.
>
> +  - address-width: number of address bits (one of 8, 16).
> +
>  Example:
>
>  eeprom@52 {
> --
> 2.7.4
>

Applied both to for-next.

Bart
