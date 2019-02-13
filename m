From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v4 3/8] dt-bindings: i2c: iproc: make 'interrupts'
 optional
Date: Wed, 13 Feb 2019 15:16:52 -0600
Message-ID: <20190213211651.GA10705@bogus>
References: <20190204231554.87666-1-ray.jui@broadcom.com>
 <20190204231554.87666-4-ray.jui@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190204231554.87666-4-ray.jui@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ray Jui <ray.jui@broadcom.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, Mark Rutland <mark.rutland@arm.com>, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com, Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
List-Id: linux-i2c@vger.kernel.org

On Mon, Feb 04, 2019 at 03:15:49PM -0800, Ray Jui wrote:
> In prep for the introduction of polling mode into the driver, update the
> binding document to make the 'interrupts' property optional
> 
> Signed-off-by: Ray Jui <ray.jui@broadcom.com>
> Signed-off-by: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
> ---
>  .../devicetree/bindings/i2c/brcm,iproc-i2c.txt         | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/i2c/brcm,iproc-i2c.txt b/Documentation/devicetree/bindings/i2c/brcm,iproc-i2c.txt
> index 81f982ccca31..d3a3620b1f06 100644
> --- a/Documentation/devicetree/bindings/i2c/brcm,iproc-i2c.txt
> +++ b/Documentation/devicetree/bindings/i2c/brcm,iproc-i2c.txt
> @@ -9,9 +9,6 @@ Required properties:
>      Define the base and range of the I/O address space that contain the iProc
>      I2C controller registers
>  
> -- interrupts:
> -    Should contain the I2C interrupt
> -
>  - clock-frequency:
>      This is the I2C bus clock. Need to be either 100000 or 400000
>  
> @@ -21,6 +18,13 @@ Required properties:
>  - #size-cells:
>      Always 0
>  
> +Optional properties:
> +
> +- interrupts:
> +    Should contain the I2C interrupt. If unspecified, driver will fall back to
> +    polling mode

What determines when you want to use polling mode? I'm not sure DT 
is the best way to control this unless it's really a property of 
the h/w. Driver behavior is really outside the scope of the DT. u-boot 
would use polling even if an interrupt is specified, for example.

Rob
