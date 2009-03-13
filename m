From: Mauro Carvalho Chehab <mchehab-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Subject: Re: [PATCH] i2c: Let checkpatch shout on users of the legacy model
Date: Thu, 12 Mar 2009 23:41:33 -0300
Message-ID: <20090312234133.2c84c56a@pedra.chehab.org>
References: <20090312161551.51ee067f@hyperion.delvare>
	<20090312123204.7d093fca@pedra.chehab.org>
	<20090312185110.41e25953@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090312185110.41e25953-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Hans Verkuil <hverkuil-qWit8jRvyhVmR6Xm/wNWPw@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Thu, 12 Mar 2009 18:51:10 +0100
Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org> wrote:

> Hi Mauro,
> 
> On Thu, 12 Mar 2009 12:32:04 -0300, Mauro Carvalho Chehab wrote:
> > Hi Jean,
> > 
> > On Thu, 12 Mar 2009 16:15:51 +0100
> > Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org> wrote:
> > 
> > > As suggested by Mauro Carvalho Chehab.
> > > 
> > > Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
> > > Cc: Mauro Carvalho Chehab <mchehab-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
> > > ---
> > >  Documentation/feature-removal-schedule.txt |    3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > 
> > > --- linux-2.6.29-rc7.orig/Documentation/feature-removal-schedule.txt	2009-03-12 08:48:06.000000000 +0100
> > > +++ linux-2.6.29-rc7/Documentation/feature-removal-schedule.txt	2009-03-12 16:07:35.000000000 +0100
> > > @@ -311,7 +311,8 @@ Who:  Krzysztof Piotr Oledzki <ole@ans.p
> > >  ---------------------------
> > >  
> > >  What:	i2c_attach_client(), i2c_detach_client(), i2c_driver->detach_client()
> > > -When:	2.6.29 (ideally) or 2.6.30 (more likely)
> > > +When:	2.6.30
> > 
> > There are still some legacy v4l drivers that uses those functions. I'm not sure
> > if there are enough time to convert all of them in time for 2.6.30 merge
> > window.
> 
> Well, the legacy API will go away in 2.6.30. Drivers using it will
> break, I'm sure this will motivate users to complain, and in turn
> developers to fix their drivers ;)
> 
> (I'm only half-kidding.)

:)

I agree on trying to do this for 2.6.30, but it will depend on when Linus will
release 2.6.29.
> 
> > Those directly references i2c_attach_client:
> > 	ir-kbd-i2c.c, ov7670.c, v4l2-common.c
> > 
> > And those are using the legacy I2C header, created by Hans:
> > 	cs53l32a.c, cx25840-core.c, msp3400-driver.c, saa6588.c, saa7115.c, tda7432.c
> > 	tda9875.c, tuner-core.c, tvaudio.c, tvp5150.c, wm8775.c
> 
> As I understand it, Hans is already working on converting these drivers
> to no longer use the legacy model. So there really only are 3 drivers
> which need more work. I am working on ir-kbd-i2c myself (well, I am
> supposed to... didn't progress too much lately).

> 
> > This plus the I2C buses that requires those drivers.
> > 
> > Depending on the time Linus releases 2.6.29, it would probably be more
> > realistic to schedule it to 2.6.31.
> 
> There's no point in rescheduling. If we patiently wait for an API to
> become unused before we remove it, there's no point to announce a
> version when the API will be removed in the first palce, and there's a
> risk that the removal will never happen. The whole point of announcing
> a version is that developers can prepare for it and we stick to what we
> announced (as much as possible).
> 
> Really, I don't think 2.6.30 is unrealistic. Hans has done a huge work
> already for the v4l side.

True. Thanks to Hans, most of drivers were converted.

> I have done my part on hwmon, and Alessandro
> Zummo on rtc. Getting the remainder done within a few weeks sounds
> totally possible _if_ we can drop support kernels < 2.6.22 from the
> v4l-dvb repository. This has already been discussed... There are i2c
> subsystem fixes and improvements which many people have asked for which
> depend on this.

The issue is not related to drop support for < 2.6.22, but to finish porting
the I2C adapters that use those I2C drivers, and test they with the several
different supported i2c combinations.

On a first glance, it seems that we still need to port bttv, cafe-ccic, cx23885,
em28xx, cx88 and pvrusb2.

Those drivers responds for the majority number of different TV capture boards
in the market.

I know that Hans is working with bttv driver, and asked other developers to
help on this task.

It is still a huge job, due to the number of different I2C variants that each
card have, the need for tests with several different I2C configurations and the
lack of information we have about a large number of the supported cards.

Doing this conversion without care and enough testing will for sure generate
regressions.

Cheers,
Mauro
