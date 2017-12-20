From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v6] i2c: Add support for NXP PCA984x family.
Date: Wed, 20 Dec 2017 12:27:45 -0600
Message-ID: <20171220182745.lo6i27ucfhjekmjp@rob-hp-laptop>
References: <07bf7aae-59ab-cb2b-dcb0-95ec2de66633@axentia.se>
 <20171218174506.20543-1-adrian.fiergolski@cern.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-pl0-f65.google.com ([209.85.160.65]:36955 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755816AbdLTS1s (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Wed, 20 Dec 2017 13:27:48 -0500
Content-Disposition: inline
In-Reply-To: <20171218174506.20543-1-adrian.fiergolski@cern.ch>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Adrian Fiergolski <adrian.fiergolski@cern.ch>
Cc: linux-i2c@vger.kernel.org, peda@axentia.se, devicetree@vger.kernel.org

On Mon, Dec 18, 2017 at 06:45:06PM +0100, Adrian Fiergolski wrote:
> This patch extends the current i2c-mux-pca954x driver and adds support for
> a newer PCA984x family of the I2C switches and multiplexers from NXP.
> 
> Signed-off-by: Adrian Fiergolski <adrian.fiergolski@cern.ch>
> ---
>  .../devicetree/bindings/i2c/i2c-mux-pca954x.txt    |  5 ++-
>  drivers/i2c/muxes/Kconfig                          |  6 ++--
>  drivers/i2c/muxes/i2c-mux-pca954x.c                | 38 +++++++++++++++++++---
>  3 files changed, 41 insertions(+), 8 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/i2c/i2c-mux-pca954x.txt b/Documentation/devicetree/bindings/i2c/i2c-mux-pca954x.txt
> index aa097045a10e..b428bc0d81b1 100644
> --- a/Documentation/devicetree/bindings/i2c/i2c-mux-pca954x.txt
> +++ b/Documentation/devicetree/bindings/i2c/i2c-mux-pca954x.txt
> @@ -1,10 +1,13 @@
>  * NXP PCA954x I2C bus switch
>  
> +The driver supports NXP PCA954x and PCA984x I2C mux/switch devices.
> +
>  Required Properties:
>  
>    - compatible: Must contain one of the following.
>      "nxp,pca9540", "nxp,pca9542", "nxp,pca9543", "nxp,pca9544",
> -    "nxp,pca9545", "nxp,pca9546", "nxp,pca9547", "nxp,pca9548"
> +    "nxp,pca9545", "nxp,pca9546", "nxp,pca9547", "nxp,pca9548",
> +    "nxp,pca9846", "nxp,pca9847", "nxp,pca9848", "nxp,pca9849"

The format here should be 1 valid combination of compatibles per line. 
So it should be clear what are valid fallbacks as Peter suggested.

>  
>    - reg: The I2C address of the device.
>  
