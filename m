From: Pavel Pisa <ppisa4lists-hnFyeMMZ0rvQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH V3] I2C driver for IMX
Date: Mon, 14 Apr 2008 02:55:46 +0200
Message-ID: <200804140255.46603.ppisa4lists@pikron.com>
References: <ftf8ud$pl6$1@ger.gmane.org>
	<20080410122404.GE26575@flint.arm.linux.org.uk>
	<ftl1i0$e5n$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <ftl1i0$e5n$1@ger.gmane.org>
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
To: linux-arm-kernel-xIg/pKzrS19vn6HldHNs0ANdhmdF6hFW@public.gmane.org
Cc: Darius <augulis.darius-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Thursday 10 April 2008 14:31, Darius wrote:
> Russell King - ARM Linux wrote:
> > On Thu, Apr 10, 2008 at 01:33:51PM +0200, Juergen Beisert wrote:
> >> On Thursday 10 April 2008 12:33, Darius wrote:
> >>>> Then I guess that we want to add support to the i2c-mpc driver rather
> >>>> than adding another driver to the kernel tree?
> >>>
> >>> I prefer to use separate driver for imx i2c inteface.
> >>> if it's not needed for all, I'll leave it for my private needs.
> >>
> >>                                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> >> As I did with my imx i2c driver last year....Yes, this I2C controller is
> >> mostly the same than the one in the MPC family and mostly the same the
> >> ones we can find in the MCX family (i.MX21/27, i.MX31?). But it seems
> >> there is noone who is able to write such a generic driver.
> >
> > Which basically means everyone gets to write their own IMX I2C driver.
> > What a brilliant advert for open source software. ;(
>
> why not to submit this my driver into kernel? i2c driver is not so big
> fat thing, kernel size will not increase dramatically, even mpc has
> similar hardware and similar driver.

Hello All,

I agree, that it is better to include this driver than to wait for common
one. If there be even two fully working and tested variants, then it could
be simpler to prepare generic one in future.

I admit that I am the one who noticed similarity of the i.MX and MPC
I2C cores last year but the differences/lack of functionality
of i.MX version makes reuse of MPC one very problematic.
I have tried to contact MPC variant author, but nobody
replied => separate i.MX version is probably the best option
for now.

Best wishes

             Pavel

On Friday 10 August 2007 17:15, Pavel Pisa wrote:
....
> The curious information for you could be, that driver for
> I2C core same/similar to one found in i.MX families is
> already included in mainline kernel.
>
>   linux-2.6.23-git/drivers/i2c/busses/i2c-mpc.c
>
> It is I2C core for PowerPC MPC5200 chips.
> Unfortunately, the i.MX version lacks
> I2C Interrupt Control Register, which is later
> patch added to MPC5200. It is common to both MPC5200
> I2C interfaces. It provides very wanted feature.
> It allow s to ask for signaling interrupt when bus
> becomes free (BNBE1 and BNBE2 bits). It is paintfully
> missing on i.MX. This means, that probing for bus
> free condition has to be solved by polling timer on MX1.
>
> The other difference is missing bit AKF in Status Register,
> which complicates processing of lost arbitration and
> simultaneous addressed as slave condition.
>
> The less important is missing support for glitches
> filtering configuration register.
>
> I suggest to look at MPC5200 documentation, because
> it is little more comprehensive. The other source
> of documentation Tundra Universe II VME to PCI bridge
> manual, because this chip contains same I2C core too.
>
> I have even written fully interrupt driven driver
> for MX1 for RTEMS executive. It runs in its own thread.
> I have not finished functionality yet, but master works
> reliably. I can send it as other reference.
>
> Generally it would be nice if "i2c-mpc" driver could
> be reuse by i.MX familly. It is better to have not
> two drivers implementations for same IP core.
> But due to lack of BNBEx and other minor differences
> it would require some ifdefs in the source or processing
> altered by core variant flags. The free bus polling
> timer for BNBEx would be required too. So I am not
> sure if something like that is acceptable for PowerPC
> people or if the code should be duplicated.
> I am sending copy to Adrian Cox who seems
> to be author of MPC5200 driver.

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
