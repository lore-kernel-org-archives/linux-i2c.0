From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v4 3/5] i2c: designware: Add slave definitions
Date: Mon, 12 Dec 2016 11:02:14 -0600
Message-ID: <20161212170214.4cydp256jsp7srar@rob-hp-laptop>
References: <cover.1481131072.git.lolivei@synopsys.com>
 <5173a9456c423025d8f15baafa2499440cbe1b51.1481131072.git.lolivei@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <5173a9456c423025d8f15baafa2499440cbe1b51.1481131072.git.lolivei-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Luis Oliveira <Luis.Oliveira-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>
Cc: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ramiro.Oliveira-HKixBCOQz3hWk0Htik3J/w@public.gmane.org, Joao.Pinto-HKixBCOQz3hWk0Htik3J/w@public.gmane.org, CARLOS.PALMINHA-HKixBCOQz3hWk0Htik3J/w@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Wed, Dec 07, 2016 at 05:55:50PM +0000, Luis Oliveira wrote:
> - Add slave definitions to i2c-designware-core
> - Changes in Kconfig to auto-enable I2C_SLAVE when compiling the modules
> - Add mode property to designware-core.txt that enable the "slave" selection:
>   - "mode" is an optional property that could be "slave" or "master"
>   - if "mode" is not set the block is considered master by default
> 
> Signed-off-by: Luis Oliveira <lolivei-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>
> ---
> Changes V3->V4: (Andy Shevchenko)
> - created a common property for modes 
> - placed the generic dependency first
> 
>  .../devicetree/bindings/i2c/i2c-designware.txt     |  4 ++++
>  drivers/i2c/busses/Kconfig                         |  1 +
>  drivers/i2c/busses/i2c-designware-common.c         |  6 +++++
>  drivers/i2c/busses/i2c-designware-core.h           | 26 ++++++++++++++++++++++
>  4 files changed, 37 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/i2c/i2c-designware.txt b/Documentation/devicetree/bindings/i2c/i2c-designware.txt
> index fee26dc3e858..8ed2b532cd54 100644
> --- a/Documentation/devicetree/bindings/i2c/i2c-designware.txt
> +++ b/Documentation/devicetree/bindings/i2c/i2c-designware.txt
> @@ -20,6 +20,9 @@ Optional properties :
>   - i2c-sda-falling-time-ns : should contain the SDA falling time in nanoseconds.
>     This value which is by default 300ns is used to compute the tHIGH period.
>  
> + - mode : should be either:
> +           - "master" to setup the hardware block as a I2C master
> +           - "slave" to setup the hardware block as a I2C slave

This should be documented in a common location. Can't it be a boolean to 
enable slave mode? Or don't you need to set the slave address? That 
could be enough to enable slave mode and there's already one example 
doing that.

Rob
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
