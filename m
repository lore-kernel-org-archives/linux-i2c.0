From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCHv2] i2c: adds support for i2c bus on Freescale
 CPM1/CPM2 controllers
Date: Thu, 29 May 2008 20:41:42 +0200
Message-ID: <20080529204142.02190e21@hyperion.delvare>
References: <4834504E.6060205@scram.de>
	<20080529175226.273f9d49@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080529175226.273f9d49-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Jochen Friedrich <jochen-NIgtFMG+Po8@public.gmane.org>
Cc: linuxppc-dev list <linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org>, Linux I2C <i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Thu, 29 May 2008 17:52:26 +0200, Jean Delvare wrote:
> On Wed, 21 May 2008 18:39:42 +0200, Jochen Friedrich wrote:
> > This driver uses the port of 2.4 code from Vitaly Bordug
> > <vitb-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org> and the actual algorithm used by the i2c
> > driver of the DBox code on cvs.tuxboc.org from Felix Domke
> > (tmbinc-hi6Y0CQ0nG0@public.gmane.org) and Gillem (htoa-hi6Y0CQ0nG0@public.gmane.org) converted to an
> > of_platform_driver. Tested on CPM1 (MPC823 on dbox2 hardware) and
> > CPM2 (MPC8272).
> > 
> > Signed-off-by: Jochen Friedrich <jochen-NIgtFMG+Po8@public.gmane.org>
> > ---
> >  drivers/i2c/busses/Kconfig   |   10 +
> >  drivers/i2c/busses/Makefile  |    1 +
> >  drivers/i2c/busses/i2c-cpm.c |  745 ++++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 756 insertions(+), 0 deletions(-)
> >  create mode 100644 drivers/i2c/busses/i2c-cpm.c
> > 
> > Changes since last version:
> > - change bus-frequency -> clock-frequency to comply to OF standard.
> > 
> 
> Applied, thanks. And thanks a lot to Wolfram for the review :)

Oh, I almost forgot: Jochen, would you like to be the maintainer for
this new driver? If you do, please send a patch adding yourself to
MAINTAINERS. Having dedicated driver maintainers makes my subsystem
maintainer's job easier.

Thanks,
-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
