From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH 3/3] i2c-ocores: add some device tree documentation
Date: Thu, 23 Dec 2010 21:00:17 -0700
Message-ID: <20101224040017.GE2491@angua.secretlab.ca>
References: <1290615982-1028-1-git-send-email-jonas@southpole.se>
 <1290615982-1028-4-git-send-email-jonas@southpole.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1290615982-1028-4-git-send-email-jonas-A9uVI2HLR7kOP4wsBPIw7w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jonas Bonn <jonas-A9uVI2HLR7kOP4wsBPIw7w@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Wed, Nov 24, 2010 at 05:26:22PM +0100, Jonas Bonn wrote:
> This puts some documentation for the device tree configuration at the head
> of the driver file.  Hopefully this can get moved to a common area for this
> type of documentation at a later date; unfortunately, there isn't really
> such a place in the kernel tree at this time.
> 
> Furthermore, the regstep and clock-frequency parameters are really bus
> parameters and should probably be passed to the driver in a better way.
> Consider that a TODO.
> 
> Signed-off-by: Jonas Bonn <jonas-A9uVI2HLR7kOP4wsBPIw7w@public.gmane.org>
> ---
>  drivers/i2c/busses/i2c-ocores.c |   35 +++++++++++++++++++++++++++++++++++
>  1 files changed, 35 insertions(+), 0 deletions(-)

Binding looks good, except for a comment on the compatible value
below, but it should be kept with the other bindings.  Please move
into a file in Documentation/powerpc/dts-bindings (and, yes, this
directory does need to be moved out of Documentation/powerpc), or
document it on the devicetree.org wiki.

g.

> 
> diff --git a/drivers/i2c/busses/i2c-ocores.c b/drivers/i2c/busses/i2c-ocores.c
> index dee0352..ef3bcb1 100644
> --- a/drivers/i2c/busses/i2c-ocores.c
> +++ b/drivers/i2c/busses/i2c-ocores.c
> @@ -9,6 +9,41 @@
>   * kind, whether express or implied.
>   */
>  
> +/*
> + * Device tree configuration:
> + *
> + * Required properties:
> + * - compatible      : "opencores,i2c-ocores"

I assume the i2c-ocore interface could end up changing in the future.
This compatible value should have some form of version embedded into
it.

> + * - reg             : bus address start and address range size of device
> + * - interrupts      : interrupt number
> + * - regstep         : size of device registers in bytes
> + * - clock-frequency : frequency of bus clock in Hz
> + * 
> + * Example:
> + *
> + *  i2c0: ocores@a0000000 {
> + *              compatible = "opencores,i2c-ocores";
> + *              reg = <0xa0000000 0x8>;
> + *              interrupts = <10>;
> + *
> + *              regstep = <1>;
> + *              clock-frequency = <20000000>;
> + *
> + * -- Devices connected on this I2C bus get
> + * -- defined here; address- and size-cells
> + * -- apply to these child devices
> + *
> + *              #address-cells = <1>;
> + *              #size-cells = <0>;
> + *
> + *              dummy@60 {
> + *                     compatible = "dummy";
> + *                     reg = <60>;
> + *              };
> + *  };
> + *
> + */
> +
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/init.h>
> -- 
> 1.7.1
> 
> _______________________________________________
> devicetree-discuss mailing list
> devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
> https://lists.ozlabs.org/listinfo/devicetree-discuss
