From: Philippe De Muyter <phdm@macqel.be>
Subject: Re: Re: [PATCH v2] m68knommu: driver for Freescale
	Coldfire I2C controller.
Date: Fri, 12 Mar 2010 12:04:53 +0100
Message-ID: <20100312110453.GA16156@frolo.macqel>
References: <201001101600.41932.sfking@fdwdc.com>
	<201001111024.05506.sfking@fdwdc.com>
	<20100124151519.GB28675@fluff.org.uk>
	<201001251156.31110.sfking@fdwdc.com>
Reply-To: uClinux development list <uclinux-dev@uclinux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <uclinux-dev-bounces@uclinux.org>
Content-Disposition: inline
In-Reply-To: <201001251156.31110.sfking@fdwdc.com>
List-Unsubscribe: <http://mailman.uclinux.org/mailman/listinfo/uclinux-dev>,
	<mailto:uclinux-dev-request@uclinux.org?subject=unsubscribe>
List-Archive: <http://mailman.uclinux.org/pipermail/uclinux-dev>
List-Post: <mailto:uclinux-dev@uclinux.org>
List-Help: <mailto:uclinux-dev-request@uclinux.org?subject=help>
List-Subscribe: <http://mailman.uclinux.org/mailman/listinfo/uclinux-dev>,
	<mailto:uclinux-dev-request@uclinux.org?subject=subscribe>
Sender: uclinux-dev-bounces@uclinux.org
Errors-To: uclinux-dev-bounces@uclinux.org
To: uClinux development list <uclinux-dev@uclinux.org>
Cc: Jean Delvare <khali@linux-fr.org>, linux-i2c@vger.kernel.org, Ben Dooks <ben-linux@fluff.org>, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Hello all,

On Mon, Jan 25, 2010 at 11:56:30AM -0800, Steven King wrote:
> > >
> > > Add support for the I2C controller used on Freescale/Motorola Coldfire
> > > MCUs.
> > >
> > > Signed-off-by: Steven King <sfking@fdwdc.com>

What's the status of this ?

I need to use i2c for a coldfire uclinux project (with a mcf5484) and I
now have 3 different coldfire i2c drivers, none of which is in mainline.

i2c-mcf.c (from uClinux-dist-20090618, but not in http://git.kernel.org/?p=linux/kernel/git/gerg/m68knommu.git;a=summary)
i2c-mcf548x.c (from ltib-m5475evb-20080808, found as "Linux BSP for MCF5484LITE, MCF5475/85EVB" at http://www.freescale.com/webapp/sps/site/prod_summary.jsp?code=MCF548X&fpsp=1&tab=Design_Tools_Tab)
i2c-coldfire.c (from http://lkml.org/lkml/2010/1/11/165)

I like to work with mainline sources to be be able to contribute to and benefit
from collective work.

Which one has the best chances to be put in mainline ?

Best regards

Philippe
_______________________________________________
uClinux-dev mailing list
uClinux-dev@uclinux.org
http://mailman.uclinux.org/mailman/listinfo/uclinux-dev
This message was resent by uclinux-dev@uclinux.org
To unsubscribe see:
http://mailman.uclinux.org/mailman/options/uclinux-dev
