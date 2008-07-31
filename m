From: Timur Tabi <timur-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: Re: [PATCH] powerpc: i2c-mpc: make speed registers
 configurable via FDT
Date: Thu, 31 Jul 2008 15:35:36 -0500
Message-ID: <48922218.9020503@freescale.com>
References: <4889EFFE.2070201@grandegger.com>	
	<20080731180959.GA29057@secretlab.ca>
	<489200B6.9060906@freescale.com>	
	<20080731182810.GB29097@secretlab.ca>
	<48920607.5040606@freescale.com>	 <48921187.1090101@grandegger.com>
	<48921179.1080403@freescale.com>	 <48921888.3020900@grandegger.com>
	<48921954.4020103@freescale.com>	 <48921DED.6010403@grandegger.com>
	<9e4733910807311332q611b43b3y26f64b5269ccb657@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <9e4733910807311332q611b43b3y26f64b5269ccb657-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Jon Smirl <jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Scott Wood <scottwood-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Linux I2C <i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>, Wolfgang Grandegger <wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org>, Linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Jon Smirl wrote:

> For mpc5200 it is easy, mpc52xx_find_ipb_freq()  already exists to get
> the source clock for the i2c devices. Each i2c node in the device tree
> can then specify "clock-frequency = 400000;" or let it default. You

400KHz is the *speed* of the I2C bus, so let's be sure to use "speed" in the
property name.  Reserve the word "bus" for the input clock to the I2C device.

> #if defined(CONFIG_MPC8540) || defined(CONFIG_MPC8541) || \
>        defined(CONFIG_MPC8560) || defined(CONFIG_MPC8555)
>        gd->i2c1_clk = sys_info.freqSystemBus;
> #elif defined(CONFIG_MPC8544)
>        /*
>         * On the 8544, the I2C clock is the same as the SEC clock.  This can be
>         * either CCB/2 or CCB/3, depending on the value of cfg_sec_freq. See
>         * 4.4.3.3 of the 8544 RM.  Note that this might actually work for all
>         * 85xx, but only the 8544 has cfg_sec_freq, so it's unknown if the
>         * PORDEVSR2_SEC_CFG bit is 0 on all 85xx boards that are not an 8544.
>         */
>        if (gur->pordevsr2 & MPC85xx_PORDEVSR2_SEC_CFG)
>                gd->i2c1_clk = sys_info.freqSystemBus / 3;
>        else
>                gd->i2c1_clk = sys_info.freqSystemBus / 2;
> #else
>        /* Most 85xx SOCs use CCB/2, so this is the default behavior. */
>        gd->i2c1_clk = sys_info.freqSystemBus / 2;
> #endif
>        gd->i2c2_clk = gd->i2c1_clk;

I think the whole point is to eliminate duplicating this code in the Linux
driver.  It's hideously ugly, so it should be limited as much as possible.

-- 
Timur Tabi
Linux kernel developer at Freescale

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
