From: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: Re: [patch 1/1] i2c_gpio: keep probe resident for
	hotplugged	devices.
Date: Thu, 10 Jul 2008 14:29:17 +0100
Message-ID: <20080710132917.GF30539@fluff.org.uk>
References: <20080702101611.757880819@fluff.org>
	<20080702101611.858837181@fluff.org>
	<20080702124406.2f3d1384@hskinnemo-gx745.norway.atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20080702124406.2f3d1384-+1Ci8juu1zowFJ3MlZkdtq14KzY7BuZjUIXZgC+OUhs@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Haavard Skinnemoen <haavard.skinnemoen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Cc: Haavard Skinnemoen <hskinnemoen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>, Ben-cy1Wll9GaHOsTnJN9+BGXg@public.gmane.org, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Wed, Jul 02, 2008 at 12:44:06PM +0200, Haavard Skinnemoen wrote:
> Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org> wrote:
> > Change the i2c_gpio driver to use platform_driver_register()
> > instead of platform_driver_probe() to ensure that is can
> > attach to any devices that may be loaded after it has initialised.
> 
> Does anyone actually do that?

At the moment our standard kernel configuration only
builds in the SM501 which will work without this patch
on.

However, we have clients that do build module kernels
and I would like to replace i2c-simtec.c with the gpio
driver and if the relevant module instantiating the gpio
support is loaded post kernel init, then we will need to
do this.

-- 
Ben (ben-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
