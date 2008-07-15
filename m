From: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: Re: [patch 1/1] i2c_gpio: keep probe resident for
	hotplugged	devices.
Date: Tue, 15 Jul 2008 10:41:47 +0100
Message-ID: <20080715094147.GI30539@fluff.org.uk>
References: <20080702101611.757880819@fluff.org>
	<20080702101611.858837181@fluff.org>
	<20080702124406.2f3d1384@hskinnemo-gx745.norway.atmel.com>
	<20080710132917.GF30539@fluff.org.uk>
	<20080712090600.680f3c2e@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20080712090600.680f3c2e-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Haavard Skinnemoen <haavard.skinnemoen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>, i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Sat, Jul 12, 2008 at 09:06:00AM +0200, Jean Delvare wrote:
> Ben,
> 
> On Thu, 10 Jul 2008 14:29:17 +0100, Ben Dooks wrote:
> > On Wed, Jul 02, 2008 at 12:44:06PM +0200, Haavard Skinnemoen wrote:
> > > Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org> wrote:
> > > > Change the i2c_gpio driver to use platform_driver_register()
> > > > instead of platform_driver_probe() to ensure that is can
> > > > attach to any devices that may be loaded after it has initialised.
> > > 
> > > Does anyone actually do that?
> > 
> > At the moment our standard kernel configuration only
> > builds in the SM501 which will work without this patch
> > on.
> > 
> > However, we have clients that do build module kernels
> > and I would like to replace i2c-simtec.c with the gpio
> > driver and if the relevant module instantiating the gpio
> > support is loaded post kernel init, then we will need to
> > do this.
> 
> Should I take this patch in my i2c tree, or will you take it in yours?

I'll take it, I was just waiting to see if there
where any more objections from Haavard before applying
this.

If i've not received an objection by 0900GMT 2008-07-16
then I will add it to my rather small git tree and ask
linus to pull.

-- 
Ben (ben-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
