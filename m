From: Kumar Gala <galak-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
Subject: Re: [PATCHv3 2.6.25] i2c: adds support for i2c bus on
	Freescale CPM1/CPM2 controllers
Date: Mon, 28 Jan 2008 11:01:46 -0600
Message-ID: <24C74143-9A67-4B14-AE70-C02B7C892E47@kernel.crashing.org>
References: <479A185D.6010406@scram.de>
Mime-Version: 1.0 (Apple Message framework v915)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <479A185D.6010406-NIgtFMG+Po8@public.gmane.org>
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
Cc: linuxppc-dev list <linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org>, Vitaly Bordug <vitb-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, "Kernel,
	Linux" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux I2C <i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>, Scott Wood <scottwood-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


On Jan 25, 2008, at 11:11 AM, Jochen Friedrich wrote:

> Using the port of 2.4 code from Vitaly Bordug <vitb-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org 
> >
> and the actual algorithm used by the i2c driver of the DBox code on
> cvs.tuxboc.org from Tmbinc, Gillem (htoa-hi6Y0CQ0nG0@public.gmane.org). Renamed i2c-rpx.c  
> and
> i2c-algo-8xx.c to i2c-cpm.c and converted the driver to an
> of_platform_driver.
>
> Signed-off-by: Jochen Friedrich <jochen-NIgtFMG+Po8@public.gmane.org>
> ---
> arch/powerpc/boot/dts/mpc8272ads.dts         |   10 +
> arch/powerpc/boot/dts/mpc866ads.dts          |   10 +
> arch/powerpc/boot/dts/mpc885ads.dts          |   10 +
> arch/powerpc/platforms/8xx/mpc885ads_setup.c |    5 +
> drivers/i2c/busses/Kconfig                   |   10 +
> drivers/i2c/busses/Makefile                  |    1 +
> drivers/i2c/busses/i2c-cpm.c                 |  759 +++++++++++++++++ 
> +++++++++
> 7 files changed, 805 insertions(+), 0 deletions(-)

really should be split in two patches.  The drivers/i2c/* should go  
via the i2c maintainers.  the arch/powerpc via me or vitaly.

- k


_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
