From: Timur Tabi <timur-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: Re: [PATCH] powerpc: i2c-mpc: make speed registers
 configurable	via FDT
Date: Thu, 31 Jul 2008 13:13:10 -0500
Message-ID: <489200B6.9060906@freescale.com>
References: <fa686aa40807250612g34b5167dtbe70c810f30a5d32@mail.gmail.com>
	<ed82fe3e0807250721n115d28c7ha1f641c9175c473d@mail.gmail.com>
	<4889EFFE.2070201@grandegger.com> <4889FD1D.4010804@freescale.com>
	<20080727012722.GH12191@secretlab.ca>
	<4891A744.6060005@grandegger.com>
	<9e4733910807310849g7e5612dbk9536733e061af8ad@mail.gmail.com>
	<4891F4D8.9090905@grandegger.com>
	<fa686aa40807311031r66f6451aw206faf54509c14d9@mail.gmail.com>
	<4891FC3A.7040609@freescale.com>
	<20080731180959.GA29057@secretlab.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080731180959.GA29057-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Cc: Scott Wood <scottwood-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org, Wolfgang Grandegger <wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org>, Linux I2C <i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Grant Likely wrote:

> This is a solved problem.  The device tree simple claims compatibility
> with an older part that has the identical register-level interface.

That would assume that the clock frequency is the only thing that decides
compatibility, which may technically be true now, but I don't think it's a good
idea.

I don't understand what's wrong with simply specifying the actual clock
frequency that the device uses?  It varies from SOC to SOC, but U-Boot
calculates today already:

#if defined(CONFIG_MPC8540) || defined(CONFIG_MPC8541) || \
	defined(CONFIG_MPC8560) || defined(CONFIG_MPC8555)
	gd->i2c1_clk = sys_info.freqSystemBus;
#elif defined(CONFIG_MPC8544)
	/*
	 * On the 8544, the I2C clock is the same as the SEC clock.  This can be
	 * either CCB/2 or CCB/3, depending on the value of cfg_sec_freq. See
	 * 4.4.3.3 of the 8544 RM.  Note that this might actually work for all
	 * 85xx, but only the 8544 has cfg_sec_freq, so it's unknown if the
	 * PORDEVSR2_SEC_CFG bit is 0 on all 85xx boards that are not an 8544.
	 */
	if (gur->pordevsr2 & MPC85xx_PORDEVSR2_SEC_CFG)
		gd->i2c1_clk = sys_info.freqSystemBus / 3;
	else
		gd->i2c1_clk = sys_info.freqSystemBus / 2;
#else
	/* Most 85xx SOCs use CCB/2, so this is the default behavior. */
	gd->i2c1_clk = sys_info.freqSystemBus / 2;
#endif
	gd->i2c2_clk = gd->i2c1_clk;

We need this ugliness in U-Boot.  Let's take advantage of this and do something
clean and elegant in the device tree.

-- 
Timur Tabi
Linux kernel developer at Freescale

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
