From: Wolfgang Grandegger <wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org>
Subject: Re: [PATCH 2/3] i2c-mpc: add support for the MPC512x processors	from
 Freescale
Date: Mon, 25 Jan 2010 19:33:31 +0100
Message-ID: <4B5DE3FB.10505@grandegger.com>
References: <1264408029-5290-1-git-send-email-wg@grandegger.com> <1264408029-5290-2-git-send-email-wg@grandegger.com> <1264408029-5290-3-git-send-email-wg@grandegger.com> <20100125115211.GA5257@pengutronix.de> <4B5D894C.4090001@grandegger.com> <20100125151509.GD5257@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100125151509.GD5257-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Wolfgang Grandegger <wg-ynQEQJNshbs@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Wolfram Sang wrote:
>>>>  
>>>> -static void __devinit mpc_i2c_setclock_52xx(struct device_node *node,
>>>> -					    struct mpc_i2c *i2c,
>>>> -					    u32 clock, u32 prescaler)
>>>> +static void __devinit mpc_i2c_setup_52xx(struct device_node *node,
>>>> +					 struct mpc_i2c *i2c,
>>>> +					 u32 clock, u32 prescaler)
>>>>  {
>>>>  	int ret, fdr;
>>>>  
>>>> +	if (clock == -1) {
>>> Could we use 0 for 'no_clock'? This would make the above statement simply
>> "0" is already used to maintain backward compatibility setting a safe
>> divider.
> 
> Ah, now I see:
> 
> 'clock == -1' means 'preserve clocks' (and is checked here in mpc_i2c_setup_52xx())

Yes, this is now necessary because "setup" does not just do clock settings.

> 'clock ==  0' means 'safe divider' (and is checked in mpc_i2c_get_fdr_52xx())

This is for compatibility with old DTS files and last time it was tricky
 to get that right and therefore...

> This is not a beauty ;)
> 
> What about adding a flags variable to the setup-functions?

.. I hesitate to make bigger changes to the code flow, which the
introduction of a flags variable would required. Also it seems to be
overkill to me. I will have a closer look, though. At a minimum I will
replace "-1" with "MPC_I2C_PRESERVE_CLOCK".

Wolfgang.
