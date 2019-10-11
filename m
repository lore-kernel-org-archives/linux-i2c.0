From: Rob Herring <robh@kernel.org>
Subject: Re: [v2,2/2] dt-bindings: i2c-mux-pca954x: Add optional property
 i2c-mux-never-disable
Date: Fri, 11 Oct 2019 09:44:45 -0500
Message-ID: <20191011144445.GA2340@bogus>
References: <20190930032503.44425-1-biwen.li@nxp.com>
 <20190930032503.44425-2-biwen.li@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190930032503.44425-2-biwen.li@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Biwen Li <biwen.li@nxp.com>
Cc: peda@axentia.se, leoyang.li@nxp.com, mark.rutland@arm.com, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Mon, Sep 30, 2019 at 11:25:03AM +0800, Biwen Li wrote:
> The patch adds an optional property i2c-mux-never-disable
> 
> Signed-off-by: Biwen Li <biwen.li@nxp.com>
> ---
> Change in v2:
> 	- update documentation
> 
>  Documentation/devicetree/bindings/i2c/i2c-mux-pca954x.txt | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/i2c/i2c-mux-pca954x.txt b/Documentation/devicetree/bindings/i2c/i2c-mux-pca954x.txt
> index 30ac6a60f041..71b73d0fdb62 100644
> --- a/Documentation/devicetree/bindings/i2c/i2c-mux-pca954x.txt
> +++ b/Documentation/devicetree/bindings/i2c/i2c-mux-pca954x.txt
> @@ -34,6 +34,7 @@ Optional Properties:
>      - first cell is the pin number
>      - second cell is used to specify flags.
>      See also Documentation/devicetree/bindings/interrupt-controller/interrupts.txt
> +  - i2c-mux-never-disable: always forces mux to be enabled.

Either needs to have a vendor prefix or be documented as a common 
property.

IIRC, we already have a property for mux default state which seems like 
that would cover this unless you need to leave it in different states.

Rob
