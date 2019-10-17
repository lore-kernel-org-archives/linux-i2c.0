From: Rob Herring <robh@kernel.org>
Subject: Re: [v3,1/2] dt-bindings: i2c: support property idle-state
Date: Thu, 17 Oct 2019 09:54:31 -0500
Message-ID: <20191017145431.GA30799@bogus>
References: <20191016040920.8511-1-biwen.li@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20191016040920.8511-1-biwen.li@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Biwen Li <biwen.li@nxp.com>
Cc: peda@axentia.se, leoyang.li@nxp.com, mark.rutland@arm.com, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Wed, Oct 16, 2019 at 12:09:19PM +0800, Biwen Li wrote:
> This supports property idle-state

The subject should indicate this is just for pca954x.

> 
> Signed-off-by: Biwen Li <biwen.li@nxp.com>
> ---
> Change in v3:
> 	- update subject and description
> 	- add some information for property idle-state
> 
> Change in v2:
> 	- update subject and description
> 	- add property idle-state
> 
>  Documentation/devicetree/bindings/i2c/i2c-mux-pca954x.txt | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/i2c/i2c-mux-pca954x.txt b/Documentation/devicetree/bindings/i2c/i2c-mux-pca954x.txt
> index 30ac6a60f041..7abda506b828 100644
> --- a/Documentation/devicetree/bindings/i2c/i2c-mux-pca954x.txt
> +++ b/Documentation/devicetree/bindings/i2c/i2c-mux-pca954x.txt
> @@ -25,6 +25,8 @@ Required Properties:
>  Optional Properties:
>  
>    - reset-gpios: Reference to the GPIO connected to the reset input.
> +  - idle-state: if present, overrides i2c-mux-idle-disconnect,
> +    Please refer to Documentation/devicetree/bindings/mux/mux-controller.txt
>    - i2c-mux-idle-disconnect: Boolean; if defined, forces mux to disconnect all
>      children in idle state. This is necessary for example, if there are several
>      multiplexers on the bus and the devices behind them use same I2C addresses.
> -- 
> 2.17.1
> 
