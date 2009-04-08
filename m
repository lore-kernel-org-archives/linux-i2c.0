From: Kumar Gala <galak-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
Subject: Re: [PATCH v3 0/5] i2c: i2c-mpc: make I2C bus speed configurable
Date: Wed, 8 Apr 2009 00:11:15 -0500
Message-ID: <53B42D49-C040-442E-8448-7BC3190220A5@kernel.crashing.org>
References: <20090407082052.477328750@denx.de>
Mime-Version: 1.0 (Apple Message framework v930.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090407082052.477328750-ynQEQJNshbs@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfgang Grandegger <wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org, devicetree-discuss-mnsaURCQ41sdnm+yROfE0A@public.gmane.org, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


On Apr 7, 2009, at 3:20 AM, Wolfgang Grandegger wrote:

> This patch series makes the I2C bus speed configurable by using the
> I2C node property "clock-frequency". If the property is not defined,
> the old fixed clock settings will be used for backward compatibility.
> The property "fsl,preserve-clocking" allows to inherit the settings
> from the bootloader. Furthermore, it does some cleanup and uses the
> new bindings for the Socrates board:
>
>  i2c: i2c-mpc: various coding style fixes
>  i2c: i2c-mpc: use dev based printout function
>  i2c: i2c-mpc: make I2C bus speed configurable

It looks like Ben picked up these patches.

>  powerpc: i2c-mpc: document new FSL I2C bindings and cleanup
>  powerpc/85xx: i2c-mpc: use new I2C bindings for the Socates board

I would have preferred these two go via me, but it looks like the  
board one got picked up by Ben.  I'll deal with the doc/binding update.
>
> Ben, could you please consider this patch series for inclusion into
> 2.6.30.

- k
