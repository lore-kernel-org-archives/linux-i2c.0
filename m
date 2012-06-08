From: "Jayachandran C." <jayachandranc-oSioyQM9ZPnuBjGU1YDckgC/G2K4zDHf@public.gmane.org>
Subject: Re: [PATCH 2/4] i2c: i2c-ocores: Use reg-shift property
Date: Fri, 8 Jun 2012 17:56:52 +0530
Message-ID: <20120608122651.GD26948@jayachandranc.netlogicmicro.com>
References: <1338910868-12318-1-git-send-email-jayachandranc@netlogicmicro.com>
 <1338910868-12318-3-git-send-email-jayachandranc@netlogicmicro.com>
 <87aa0ejaj3.fsf@macbook.be.48ers.dk>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <87aa0ejaj3.fsf-uXGAPMMVk8amE9MCos8gUmSdvHPH+/yF@public.gmane.org>
Content-Disposition: inline
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter Korsgaard <jacmet-OfajU3CKLf1/SzgSGea1oA@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, devicetree-discuss-mnsaURCQ41sdnm+yROfE0A@public.gmane.org, richard.rojfors-gfIc91nka+FZroRs9YW3xA@public.gmane.org, Ganesan Ramalingam <ganesanr-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Fri, Jun 08, 2012 at 01:41:36PM +0200, Peter Korsgaard wrote:
> >>>>> "J" == Jayachandran C <jayachandranc-oSioyQM9ZPnuBjGU1YDckgC/G2K4zDHf@public.gmane.org> writes:
> 
>  J> From: Ganesan Ramalingam <ganesanr-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
>  J> Deprecate 'regstep' property and use the standard 'reg-shift' property
>  J> for register offset shifts. 'regstep' will still be supported as an
>  J> optional property, but will give a warning when used.
> 
> ..
>  
>  J>  struct ocores_i2c_platform_data {
>  J> -	u32 regstep;   /* distance between registers */
>  J> -	u32 clock_khz; /* input clock in kHz */
>  J> -	u8 num_devices; /* number of devices in the devices list */
>  J> +	u32 reg_shift;		/* register offset shift value */
>  J> +	u32 clock_khz;		/* input clock in kHz */
>  J> +	u8 num_devices;		/* number of devices in the devices list */
>  J>  	struct i2c_board_info const *devices; /* devices connected to the bus */
>  J>  };
> 
> Why not just keep this change to the dt bindings, instead of risking
> breaking stuff for platform drivers as well? There's no conceptual
> reason why reg_shift is any better than regstep.

This is to keep the names and meanings of platform property and DT
property same. Having two ways (setting regstep in platform code or
setting 'reg-shift' in DT) of specifying the same parameter is not
a nice.

There is only one user of this API in the whole kernel tree, which
is fixed as part of the patchset.

Also we make sure that we do not break existing DTBs by still accepting
'regstep' property.

Regards,
JC.
