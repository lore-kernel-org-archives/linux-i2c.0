From: Guenter Roeck <guenter.roeck-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org>
Subject: Re: [lm-sensors] [PATCH 00/12] lis3 accelerator feature update
Date: Sun, 24 Oct 2010 10:01:20 -0700
Message-ID: <20101024170120.GA14747@ericsson.com>
References: <1287748654-2626-1-git-send-email-samu.p.onkalo@nokia.com>
 <4CC44B3D.5030404@tremplin-utc.net>
 <20101024153548.GA14303@ericsson.com>
 <20101024163529.GA14650@ericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20101024163529.GA14650-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: =?iso-8859-1?Q?=C9ric?= Piel <eric.piel-VkQ1JFuSMpfAbQlEx87xDw@public.gmane.org>
Cc: "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org" <lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Sun, Oct 24, 2010 at 12:35:29PM -0400, Guenter Roeck wrote:
> On Sun, Oct 24, 2010 at 11:35:48AM -0400, Guenter Roeck wrote:
> > On Sun, Oct 24, 2010 at 11:05:33AM -0400, =C9ric Piel wrote:
> > > Op 22-10-10 13:57, Samu Onkalo schreef:
> > > > Changes are tested only with I2C interface using 8bit sensor si=
nce I don't
> > > > have other possibilities. Some features are not enabled
> > > > by default since I can't test them with all possible configurat=
ions.
> > > > Platform data contains field which controls new features.
> > > Thanks Samu for persevering with the automatic power down feature=
=2E=20
> > > Hopefully I'll find also some time to activate it on the hp_accel=
 side.
> > >=20
> > > For now, I've reviewed the changes and everything looked fine, as=
 well=20
> > > as tested them on my HP laptop (with a 12 bits sensor). Although =
most of=20
> > > the changes are not visible on this platform, at least there shou=
ldn't=20
> > > be any regression.
> > >=20
> > Great, thanks.
> >=20
> > Unfortunately, the patches don't apply to my staging branch, probab=
ly
> > because of the other pending lis3 changes.
> >=20
> > Samu, please rebase your patches to=20
> > 	git://git.kernel.org/pub/scm/linux/kernel/git/groeck/staging.git h=
wmon-next
> > and resubmit.
> >=20
> Never mind. Played a bit with git, learned something new, and got it =
all merged.
> Now compiling.
>=20
> Eric, once I pushed the changes into above branch (hopefully by tonig=
ht),
> would be great if you could give it another test run.
>=20
Compiled and applied to hwmon-next. I'll let it rest there for a couple=
 of days
before sending it off to Linus. Eric, would be great if you can sanity =
test
the merged version.

Thanks,
Guenter
