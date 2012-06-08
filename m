From: Peter Korsgaard <jacmet-OfajU3CKLf1/SzgSGea1oA@public.gmane.org>
Subject: Re: [PATCH 2/4] i2c: i2c-ocores: Use reg-shift property
Date: Fri, 08 Jun 2012 13:41:36 +0200
Message-ID: <87aa0ejaj3.fsf@macbook.be.48ers.dk>
References: <1338910868-12318-1-git-send-email-jayachandranc@netlogicmicro.com>
	<1338910868-12318-3-git-send-email-jayachandranc@netlogicmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1338910868-12318-3-git-send-email-jayachandranc-oSioyQM9ZPnuBjGU1YDckgC/G2K4zDHf@public.gmane.org>
	(Jayachandran C.'s message of "Tue, 5 Jun 2012 21:11:06 +0530")
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jayachandran C <jayachandranc-oSioyQM9ZPnuBjGU1YDckgC/G2K4zDHf@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, devicetree-discuss-mnsaURCQ41sdnm+yROfE0A@public.gmane.org, richard.rojfors-gfIc91nka+FZroRs9YW3xA@public.gmane.org, Ganesan Ramalingam <ganesanr-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

>>>>> "J" == Jayachandran C <jayachandranc-oSioyQM9ZPnuBjGU1YDckgC/G2K4zDHf@public.gmane.org> writes:

 J> From: Ganesan Ramalingam <ganesanr-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
 J> Deprecate 'regstep' property and use the standard 'reg-shift' property
 J> for register offset shifts. 'regstep' will still be supported as an
 J> optional property, but will give a warning when used.

..
 
 J>  struct ocores_i2c_platform_data {
 J> -	u32 regstep;   /* distance between registers */
 J> -	u32 clock_khz; /* input clock in kHz */
 J> -	u8 num_devices; /* number of devices in the devices list */
 J> +	u32 reg_shift;		/* register offset shift value */
 J> +	u32 clock_khz;		/* input clock in kHz */
 J> +	u8 num_devices;		/* number of devices in the devices list */
 J>  	struct i2c_board_info const *devices; /* devices connected to the bus */
 J>  };

Why not just keep this change to the dt bindings, instead of risking
breaking stuff for platform drivers as well? There's no conceptual
reason why reg_shift is any better than regstep.

-- 
Bye, Peter Korsgaard
