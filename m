From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH] DT: i2c: Add Freescale MPL3115 to trivial devices list
Date: Tue, 29 Dec 2015 12:35:16 -0600
Message-ID: <20151229183516.GK12450@rob-hp-laptop>
References: <1450897147-22370-1-git-send-email-akshay.bhat@timesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1450897147-22370-1-git-send-email-akshay.bhat@timesys.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Akshay Bhat <akshay.bhat@timesys.com>
Cc: ktsai@capellamicro.com, wsa@the-dreams.de, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, trivial@kernel.org, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, justin.waters@timesys.com
List-Id: linux-i2c@vger.kernel.org

On Wed, Dec 23, 2015 at 01:59:07PM -0500, Akshay Bhat wrote:
> This adds devicetree documentation for the bindings of mpl3115 driver.
> 
> Signed-off-by: Akshay Bhat <akshay.bhat@timesys.com>
> ---
>  Documentation/devicetree/bindings/i2c/trivial-devices.txt | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Rob Herring <robh@kernel.org>

Who did you want to apply this? Send patches TO that person which I 
would expect to be Wolfram or me.

Rob

> 
> diff --git a/Documentation/devicetree/bindings/i2c/trivial-devices.txt b/Documentation/devicetree/bindings/i2c/trivial-devices.txt
> index c50cf13..f3f4bc2 100644
> --- a/Documentation/devicetree/bindings/i2c/trivial-devices.txt
> +++ b/Documentation/devicetree/bindings/i2c/trivial-devices.txt
> @@ -54,6 +54,7 @@ epson,rx8581		I2C-BUS INTERFACE REAL TIME CLOCK MODULE
>  fsl,mag3110		MAG3110: Xtrinsic High Accuracy, 3D Magnetometer
>  fsl,mc13892		MC13892: Power Management Integrated Circuit (PMIC) for i.MX35/51
>  fsl,mma8450		MMA8450Q: Xtrinsic Low-power, 3-axis Xtrinsic Accelerometer
> +fsl,mpl3115		MPL3115: Absolute Digital Pressure Sensor
>  fsl,mpr121		MPR121: Proximity Capacitive Touch Sensor Controller
>  fsl,sgtl5000		SGTL5000: Ultra Low-Power Audio Codec
>  gmt,g751		G751: Digital Temperature Sensor and Thermal Watchdog with Two-Wire Interface
> -- 
> 2.6.3
> 
