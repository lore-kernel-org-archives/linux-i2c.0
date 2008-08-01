From: Timur Tabi <timur-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: Re: [PATCH] powerpc: i2c-mpc: make speed registers
 configurable via FDT
Date: Fri, 01 Aug 2008 14:50:15 -0500
Message-ID: <489368F7.1040503@freescale.com>
References: <488982B5.4070102@grandegger.com>
	<fa686aa40807250612g34b5167dtbe70c810f30a5d32@mail.gmail.com>
	<ed82fe3e0807250721n115d28c7ha1f641c9175c473d@mail.gmail.com>
	<4889EFFE.2070201@grandegger.com> <4889FD1D.4010804@freescale.com>
	<20080727012722.GH12191@secretlab.ca>
	<4891A744.6060005@grandegger.com>
	<9e4733910807310849g7e5612dbk9536733e061af8ad@mail.gmail.com>
	<4891E06A.4070608@freescale.com>
	<Pine.LNX.4.58.0807311610170.10341@shell4.speakeasy.net>
	<ed82fe3e0808010617u101855f7x70d3cbd2bed31f8c@mail.gmail.com>
	<Pine.LNX.4.58.0808011246290.10341@shell4.speakeasy.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <Pine.LNX.4.58.0808011246290.10341-13q4cmjDBaTP3RPoUHIrnuTW4wlIGRCZ@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Trent Piepho <xyzzy-zY4eFNvK5D+xbKUeIHjxjQ@public.gmane.org>
Cc: Scott Wood <scottwood-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org, Linux I2C <i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Trent Piepho wrote:

> All 83xx other than 832x.

Never mind, I forgot that 83xx support for i2c1_clk was already in U-Boot:

#if defined(CONFIG_MPC834X)
	i2c1_clk = tsec2_clk;
#elif defined(CONFIG_MPC8360)
	i2c1_clk = csb_clk;
#elif defined(CONFIG_MPC832X)
	i2c1_clk = enc_clk;
#elif defined(CONFIG_MPC831X)
	i2c1_clk = enc_clk;
#elif defined(CONFIG_MPC837X)
	i2c1_clk = sdhc_clk;
#endif
#if !defined(CONFIG_MPC832X)
	i2c2_clk = csb_clk; /* i2c-2 clk is equal to csb clk */
#endif

-- 
Timur Tabi
Linux kernel developer at Freescale

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
