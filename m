From: Guenter Roeck <guenter.roeck-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH 00/12] lis3 accelerator feature update
Date: Sun, 24 Oct 2010 08:35:48 -0700
Message-ID: <20101024153548.GA14303@ericsson.com>
References: <1287748654-2626-1-git-send-email-samu.p.onkalo@nokia.com>
 <4CC44B3D.5030404@tremplin-utc.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4CC44B3D.5030404-VkQ1JFuSMpfAbQlEx87xDw@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: =?iso-8859-1?Q?=C9ric?= Piel <eric.piel-VkQ1JFuSMpfAbQlEx87xDw@public.gmane.org>
Cc: Samu Onkalo <samu.p.onkalo-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, "khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org" <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, "jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org" <jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>, "lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org" <lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Sun, Oct 24, 2010 at 11:05:33AM -0400, =C9ric Piel wrote:
> Op 22-10-10 13:57, Samu Onkalo schreef:
> > Changes are tested only with I2C interface using 8bit sensor since =
I don't
> > have other possibilities. Some features are not enabled
> > by default since I can't test them with all possible configurations=
=2E
> > Platform data contains field which controls new features.
> Thanks Samu for persevering with the automatic power down feature.=20
> Hopefully I'll find also some time to activate it on the hp_accel sid=
e.
>=20
> For now, I've reviewed the changes and everything looked fine, as wel=
l=20
> as tested them on my HP laptop (with a 12 bits sensor). Although most=
 of=20
> the changes are not visible on this platform, at least there shouldn'=
t=20
> be any regression.
>=20
Great, thanks.

Unfortunately, the patches don't apply to my staging branch, probably
because of the other pending lis3 changes.

Samu, please rebase your patches to=20
	git://git.kernel.org/pub/scm/linux/kernel/git/groeck/staging.git hwmon=
-next
and resubmit.

Thanks,
Guenter
