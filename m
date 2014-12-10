From: Varka Bhadram <varkabhadram@gmail.com>
Subject: Re: [PATCH 1/4] i2c: iProc: define Broadcom iProc I2C binding
Date: Wed, 10 Dec 2014 06:57:08 +0530
Message-ID: <5487A16C.5000707@gmail.com>
References: <Ray Jui <rjui@broadcom.com> <1418172891-19441-1-git-send-email-rjui@broadcom.com> <1418172891-19441-2-git-send-email-rjui@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1418172891-19441-2-git-send-email-rjui@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ray Jui <rjui@broadcom.com>, Wolfram Sang <wsa@the-dreams.de>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Grant Likely <grant.likely@linaro.org>, Christian Daudt <bcm@fixthebug.org>, Matt Porter <mporter@linaro.org>, Florian Fainelli <f.fainelli@gmail.com>, Russell King <linux@arm.linux.org.uk>
Cc: Scott Branden <sbranden@broadcom.com>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Hi,

On Wednesday 10 December 2014 06:24 AM, Ray Jui wrote:
> Document the I2C device tree binding for Broadcom iProc family of
> SoCs
>
> Signed-off-by: Ray Jui <rjui@broadcom.com>
> Reviewed-by: Scott Branden <sbranden@broadcom.com>
> ---
>   .../devicetree/bindings/i2c/brcm,iproc-i2c.txt     |   37 ++++++++++++++++++++
>   1 file changed, 37 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/i2c/brcm,iproc-i2c.txt
>
> diff --git a/Documentation/devicetree/bindings/i2c/brcm,iproc-i2c.txt b/Documentation/devicetree/bindings/i2c/brcm,iproc-i2c.txt
> new file mode 100644
> index 0000000..81f982c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/i2c/brcm,iproc-i2c.txt
> @@ -0,0 +1,37 @@
> +Broadcom iProc I2C controller
> +
> +Required properties:
> +
> +- compatible:
> +    Must be "brcm,iproc-i2c"
> +
> +- reg:
> +    Define the base and range of the I/O address space that contain the iProc
> +    I2C controller registers
> +
> +- interrupts:
> +    Should contain the I2C interrupt
> +
> +- clock-frequency:
> +    This is the I2C bus clock. Need to be either 100000 or 400000
> +
> +- #address-cells:
> +    Always 1 (for I2C addresses)
> +
> +- #size-cells:
> +    Always 0
> +

All the properties defined with two lines of statements.

Why cant they be with single line statement, like:

compatible:	Must be "brcm,iproc-i2c"
reg:		Define the base and range of the I/O address space that
		contain the iProc I2C controller registers

....


-- 
Thanks and Regards,
Varka Bhadram.
