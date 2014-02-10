From: linux@roeck-us.net
Subject: Re: [PATCH 01/17] Documentation: i2c: describe devicetree method
 for instantiating devices
Date: Mon, 10 Feb 2014 12:21:19 -0600
Message-ID: <20140210122119.115858a7ntu4lr40@67.228.131.205>
References: <1392026654-5343-1-git-send-email-wsa@the-dreams.de>
 <1392026654-5343-2-git-send-email-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=ISO-8859-1;
 DelSp="Yes";
 format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1392026654-5343-2-git-send-email-wsa@the-dreams.de>
Content-Disposition: inline
Sender: linux-doc-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Rob Landley <rob@landley.net>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Quoting Wolfram Sang <wsa@the-dreams.de>:

> Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
> Cc: devicetree@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> ---
>
>  Documentation/i2c/instantiating-devices | 34  
> +++++++++++++++++++++++++++++++--
>  1 file changed, 32 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/i2c/instantiating-devices  
> b/Documentation/i2c/instantiating-devices
> index c70e7a7..6df095a 100644
> --- a/Documentation/i2c/instantiating-devices
> +++ b/Documentation/i2c/instantiating-devices
> @@ -8,8 +8,8 @@ reason, the kernel code must instantiate I2C devices  
> explicitly. There are
>  several ways to achieve this, depending on the context and requirements.
>
>
> -Method 1: Declare the I2C devices by bus number
> ------------------------------------------------
> +Method 1a: Declare the I2C devices by bus number
> +------------------------------------------------
>
>  This method is appropriate when the I2C bus is a system bus as is the case
>  for many embedded systems. On such systems, each I2C bus has a number
> @@ -51,6 +51,36 @@ The devices will be automatically unbound and  
> destroyed when the I2C bus
>  they sit on goes away (if ever.)
>
>
> +Method 1b: Declare the I2C devices via devicetree
> +-------------------------------------------------
> +

Hi Wolfram,

There is now also a means to instantiate I2C devices through
ACPI. This is documented in Documentation/acpi/enumeration.txt.

Might be worthwhile to reference it from instantiating-devices.
I guess that would be a separate patch though.

Thanks,
Guenter

