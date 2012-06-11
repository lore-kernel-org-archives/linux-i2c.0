From: Steven King <sfking@fdwdc.com>
Subject: Re: [PATCH V3] m68knommu: driver for Freescale
	Coldfire I2C controller.
Date: Mon, 11 Jun 2012 12:29:51 -0700
Message-ID: <201206111229.51887.sfking@fdwdc.com>
References: <201205161910.36693.sfking@fdwdc.com>
 <20120611174634.GI3887@pengutronix.de>
Reply-To: uClinux development list <uclinux-dev@uclinux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <uclinux-dev-bounces@uclinux.org>
In-Reply-To: <20120611174634.GI3887@pengutronix.de>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.uclinux.org/mailman/options/uclinux-dev>,
 <mailto:uclinux-dev-request@uclinux.org?subject=unsubscribe>
List-Archive: <http://mailman.uclinux.org/pipermail/uclinux-dev>
List-Post: <mailto:uclinux-dev@uclinux.org>
List-Help: <mailto:uclinux-dev-request@uclinux.org?subject=help>
List-Subscribe: <http://mailman.uclinux.org/mailman/listinfo/uclinux-dev>,
 <mailto:uclinux-dev-request@uclinux.org?subject=subscribe>
Errors-To: uclinux-dev-bounces@uclinux.org
Sender: uclinux-dev-bounces@uclinux.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: gerg@uclinux.org, linux-i2c@vger.kernel.org, Ben Dooks <ben-linux@fluff.org>, uClinux development list <uclinux-dev@uclinux.org>
List-Id: linux-i2c@vger.kernel.org

On Monday 11 June 2012 10:46:34 am Wolfram Sang wrote:
> On Wed, May 16, 2012 at 07:10:35PM -0700, Steven King wrote:
> > D'oh!  I really dropped the ball on this, but I figure better late than
> > never ;-).
>
> Thank you for this! Yet, I just noticed that the register layout is the
> same as in i2c-imx.c. Not surprisingly, since both platforms share the
> roots. Have you checked if you can use the imx-driver as well?

While they are physically similar, just as the mpc and the imx are physically 
similar, the imx driver has a lot of imx'isms, device tree and OF 
dependencies that aren't supported by the m68k/nommu.  I would expect the 
changes needed tantamount to having separate drivers.  Plus I have no way of 
testing what impact any changes I made had on the imx functionality, so I 
expect I would end up mostly just annoying the imx developers.
_______________________________________________
uClinux-dev mailing list
uClinux-dev@uclinux.org
http://mailman.uclinux.org/mailman/listinfo/uclinux-dev
This message was resent by uclinux-dev@uclinux.org
To unsubscribe see:
http://mailman.uclinux.org/mailman/options/uclinux-dev
