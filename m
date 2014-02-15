From: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Subject: Re: [PATCH] Documentation: i2c: mention ACPI method for
 instantiating devices
Date: Sat, 15 Feb 2014 09:42:03 -0800
Message-ID: <20140215174203.GA19001@roeck-us.net>
References: <1392476315-13396-1-git-send-email-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1392476315-13396-1-git-send-email-wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Sat, Feb 15, 2014 at 03:58:35PM +0100, Wolfram Sang wrote:
> Signed-off-by: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
> Cc: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
> ---
> 
> Very basic, but probably should do for now?
> 

Good enough for me.

Acked-by: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>

>  Documentation/i2c/instantiating-devices | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/Documentation/i2c/instantiating-devices b/Documentation/i2c/instantiating-devices
> index 6df095a..0d85ac19 100644
> --- a/Documentation/i2c/instantiating-devices
> +++ b/Documentation/i2c/instantiating-devices
> @@ -81,6 +81,13 @@ additional properties which might be needed to set up the device, please refer
>  to its devicetree documentation in Documentation/devicetree/bindings/.
>  
>  
> +Method 1c: Declare the I2C devices via ACPI
> +-------------------------------------------
> +
> +ACPI can also describe I2C devices. There is special documentation for this
> +which is currently located at Documentation/acpi/enumeration.txt.
> +
> +
>  Method 2: Instantiate the devices explicitly
>  --------------------------------------------
>  
> -- 
> 1.8.5.1
> 
> 
