From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 6/6] Documentation/devicetree: Add FSI-attached I2C
 master dt bindings
Date: Wed, 28 Jun 2017 18:21:28 -0500
Message-ID: <20170628232128.ldglm4fjqivspxn3@rob-hp-laptop>
References: <1498505375-1454-1-git-send-email-eajames@linux.vnet.ibm.com>
 <1498505375-1454-7-git-send-email-eajames@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1498505375-1454-7-git-send-email-eajames-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Eddie James <eajames-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, jk-mnsaURCQ41sdnm+yROfE0A@public.gmane.org, joel-U3u1mxZcP9KHXe+LvDLADg@public.gmane.org, andrew-zrmu5oMJ5Fs@public.gmane.org, "Edward A. James" <eajames-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Mon, Jun 26, 2017 at 02:29:35PM -0500, Eddie James wrote:
> From: "Edward A. James" <eajames-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org>

"dt-bindings: i2c: ..." for the subject.

> 
> Document the bindings.
> 
> Signed-off-by: Edward A. James <eajames-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org>
> ---
>  Documentation/devicetree/bindings/i2c/i2c-fsi.txt | 31 +++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/i2c/i2c-fsi.txt
> 
> diff --git a/Documentation/devicetree/bindings/i2c/i2c-fsi.txt b/Documentation/devicetree/bindings/i2c/i2c-fsi.txt
> new file mode 100644
> index 0000000..fffc067
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/i2c/i2c-fsi.txt
> @@ -0,0 +1,31 @@
> +Device-tree bindings for FSI-attached I2C master driver
> +-------------------------------------------------------
> +
> +Required properties:
> + - compatible = "ibm,i2cm-fsi";

Only one version?

> + - reg = < address size >;		: The FSI CFAM address and address space
> +					  size.
> + - #address-cells = <1>;		: Number of address cells in child nodes
> + - #size-cells = <0>;			: Number of size cells in child nodes.
> + - child nodes				: Nodes to describe ports off the I2C
> +					  master.
> +
> +Child node required properties:
> + - reg = < port number >		: The port number on the I2C master.
> +
> +Examples:
> +
> +    i2cm@1800 {

i2c@1800

> +        compatible = "ibm,i2cm-fsi";
> +        reg = < 0x1800 0x400 >;
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        port@0 {

The ports are separate i2c buses? Use i2c-bus@... instead. "ports" is 
already used by OF graph binding.

> +            reg = <0>;
> +        };
> +
> +        port@1 {
> +            reg = <1>;
> +        };
> +    };
> -- 
> 1.8.3.1
> 
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
