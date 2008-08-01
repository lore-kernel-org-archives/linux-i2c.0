From: "Jon Smirl" <jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] powerpc: i2c-mpc: make speed registers
	configurable via FDT
Date: Thu, 31 Jul 2008 21:44:41 -0400
Message-ID: <9e4733910807311844p142b26ffyb4105df3e136f65@mail.gmail.com>
References: <4889EFFE.2070201@grandegger.com> <4891FC3A.7040609@freescale.com>
	<20080731180959.GA29057@secretlab.ca>
	<489200B6.9060906@freescale.com>
	<20080731182810.GB29097@secretlab.ca> <48920607.5040606@freescale.com>
	<9e4733910807311157q358640ddyef1f14865c069b8@mail.gmail.com>
	<Pine.LNX.4.58.0807311656250.10341@shell4.speakeasy.net>
	<9e4733910807311819i60872285ga4829c841185fdc0@mail.gmail.com>
	<Pine.LNX.4.58.0807311828580.10341@shell4.speakeasy.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <Pine.LNX.4.58.0807311828580.10341-13q4cmjDBaTP3RPoUHIrnuTW4wlIGRCZ@public.gmane.org>
Content-Disposition: inline
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
Cc: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org, Linux I2C <i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>, Scott Wood <scottwood-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Timur Tabi <timur-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Wolfgang Grandegger <wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On 7/31/08, Trent Piepho <xyzzy-zY4eFNvK5D+xbKUeIHjxjQ@public.gmane.org> wrote:
> On Thu, 31 Jul 2008, Jon Smirl wrote:
>
> > >  Here's my idea:
>  > >
>  > >         i2c@0 {
>  > >                 compatible = "fsl-i2c";
>  > >                 bus-frequency = <100000>;
>  > >
>  > >                 /* Either */
>  > >                 source-clock-frequency = <0>;
>  > >                 /* OR */
>  > >                 source-clock = <&ccb>;
>  > >         };
>  >
>  > Can't we hide a lot of this on platforms where the source clock is not
>  > messed up? For example the mpc5200 doesn't need any of this, the
>  > needed frequency is already available in mpc52xx_find_ipb_freq().
>  > mpc5200 doesn't need any uboot change.
>  >
>  > Next would be normal mpc8xxx platforms where i2c is driven by a single
>  > clock, add a uboot filled in parameter in the root node (or I think it
>  > can be computed off of the ones uboot is already filling in). make a
>  > mpc8xxx_find_i2c_freq() function. May not need to change device tree
>  > and uboot.
>  >
>  > Finally use this for those days when the tea leaves were especially
>  > bad. Both a device tree and uboot change.
>
>
> If you have to support clock speed in the i2c node anyway, what's the point
>  of the other options?

So that I don't have to change my existing mpc5200 systems. mpc5200
has no need for specifying the source clock in each i2c node, hardware
doesn't allow it.

>  > > Except the i2c clock isn't always a based on an integer divider of the CCB
>  > >  frequency.  What's more, it's not always the same for both i2c controllers.
>  > >  Suppose i2c #1 uses CCB times 2/3 and i2c #2 uses CCB/2, how would
>  > >  fsl_get_i2c_freq() figure that out from bus-frequency and
>  > >  i2c-clock-divider?
>  >
>  > If you get the CCB frequency from uboot and know the chip model, can't
>  > you compute these in the platform code? Then make a
>  > mpc8xxx_find_i2c_freq(cell_index).
>
>
> You need a bunch of random other device registers (SEC, ethernet, sdhc,
>  etc.) too.
>
>
>  > I don't see why we want to go through the trouble of having uboot tell
>  > us things about a chip that are fixed in stone. Obviously something
>  > like the frequency of the external crystal needs to be passed up, but
>  > why pass up stuff that can be computed (or recovered by reading a
>  > register)?
>
>
> One could also say that if U-boot has to have the code and already
>  calculated the value, why duplicate the code and the calculation in Linux?

What about the Efika which is mpc5200 based and doesn't use uboot?

-- 
Jon Smirl
jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
