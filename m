From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/3] dt-bindings: add "size" property.
Date: Thu, 3 Aug 2017 15:27:34 -0500
Message-ID: <20170803202734.rqyoiqhqvonvvtca@rob-hp-laptop>
References: <1501173789-25959-1-git-send-email-divagar.mohandass@intel.com>
 <1501173789-25959-2-git-send-email-divagar.mohandass@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1501173789-25959-2-git-send-email-divagar.mohandass-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: divagar.mohandass-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
Cc: mark.rutland-5wv7dgnIgG8@public.gmane.org, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rajmohan.mani-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Thu, Jul 27, 2017 at 10:13:07PM +0530, divagar.mohandass-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org wrote:
> From: Divagar Mohandass <divagar.mohandass-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

Please improve the subject. Add size to what?

> 
> This adds "size" as optional property for i2c eeproms.
> 
> "size" should be mentioned in byte and it should refer
> to the eeprom size. This will be read by the driver and
> used to calculating the number of bytes in read/write calls.
> 
> Signed-off-by: Divagar Mohandass <divagar.mohandass-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> ---
>  Documentation/devicetree/bindings/eeprom/eeprom.txt | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/eeprom/eeprom.txt b/Documentation/devicetree/bindings/eeprom/eeprom.txt
> index 5696eb5..1436569 100644
> --- a/Documentation/devicetree/bindings/eeprom/eeprom.txt
> +++ b/Documentation/devicetree/bindings/eeprom/eeprom.txt
> @@ -32,6 +32,8 @@ Optional properties:
>  
>    - read-only: this parameterless property disables writes to the eeprom
>  
> +  - size: total eeprom size in bytes
> +

This should be implied by the compatible string of the eeprom. Why do 
you need this?

Rob
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
