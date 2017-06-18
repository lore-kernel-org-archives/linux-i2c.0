From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 1/4] i2c: pca-platform: add devicetree awareness
Date: Sun, 18 Jun 2017 09:04:53 -0500
Message-ID: <20170618140453.3qrud7fuqe36uvud@rob-hp-laptop>
References: <20170613015641.29373-1-chris.packham@alliedtelesis.co.nz>
 <20170613015641.29373-2-chris.packham@alliedtelesis.co.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-yw0-f194.google.com ([209.85.161.194]:33006 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753110AbdFROE4 (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Sun, 18 Jun 2017 10:04:56 -0400
Content-Disposition: inline
In-Reply-To: <20170613015641.29373-2-chris.packham@alliedtelesis.co.nz>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc: wsa@the-dreams.de, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org

On Tue, Jun 13, 2017 at 01:56:38PM +1200, Chris Packham wrote:
> Allow devices that use this driver to be registered via a
> devicetree.
> 
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> ---
>  .../devicetree/bindings/i2c/i2c-pca-platform.txt    | 18 ++++++++++++++++++

It's preferred to split bindings to separate patch.

>  drivers/i2c/busses/i2c-pca-platform.c               | 21 +++++++++++++++++++++
>  2 files changed, 39 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/i2c/i2c-pca-platform.txt
> 
> diff --git a/Documentation/devicetree/bindings/i2c/i2c-pca-platform.txt b/Documentation/devicetree/bindings/i2c/i2c-pca-platform.txt
> new file mode 100644
> index 000000000000..47410bda3f37
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/i2c/i2c-pca-platform.txt
> @@ -0,0 +1,18 @@
> +* NXP PCA PCA9564/PCA9665 I2C controller
> +
> +The PCA9564/PCA9665 serves as an interface between most standard
> +parallel-bus microcontrollers/microprocessors and the serial I2C-bus
> +and allows the parallel bus system to communicate bi-directionally
> +with the I2C-bus.
> +
> +Required properties :
> +
> + - reg : Offset and length of the register set for the device
> + - compatible : one of "nxp,pca9564" or "nxp,pca9665"
> +
> +Optional properties
> + - interrupts : the interrupt number
> + - interrupt-parent : the phandle for the interrupt controller.
> +   If an interrupt is not specified polling will be used.
> + - gpios : gpio phandle to control device reset.

reset-gpios and state the active state.

> + - clock-frequency : I2C bus frequency.
> \ No newline at end of file

^^^
