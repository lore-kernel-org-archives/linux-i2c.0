From: Rabin Vincent <rabin-66gdRtMMWGc@public.gmane.org>
Subject: Re: [PATCH] i2c: Factor out runtime suspend checks from PM operations
Date: Thu, 23 Dec 2010 00:49:39 +0530
Message-ID: <AANLkTin5eSg8vL4Q8yZ9tme38fbS2aAZ-xeLQSNu809B@mail.gmail.com>
References: <1293041268-7707-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1293041268-7707-1-git-send-email-broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Cc: rjw-KKrjLPT3xs0@public.gmane.org, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Wed, Dec 22, 2010 at 11:37 PM, Mark Brown
<broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org> wrote:
> =A0static int i2c_device_pm_restore(struct device *dev)
> @@ -266,15 +247,16 @@ static int i2c_device_pm_restore(struct device =
*dev)
> =A0 =A0 =A0 =A0const struct dev_pm_ops *pm =3D dev->driver ? dev->dri=
ver->pm : NULL;
> =A0 =A0 =A0 =A0int ret;
>
> - =A0 =A0 =A0 if (pm)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D pm->restore ? pm->restore(dev) =
: 0;
> - =A0 =A0 =A0 else
> + =A0 =A0 =A0 if (pm) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D pm_generic_restore(dev);
> + =A0 =A0 =A0 } else {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ret =3D i2c_legacy_resume(dev);
>
> - =A0 =A0 =A0 if (!ret) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 pm_runtime_disable(dev);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 pm_runtime_set_active(dev);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 pm_runtime_enable(dev);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!ret) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pm_runtime_disable(dev)=
;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pm_runtime_set_active(d=
ev);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pm_runtime_enable(dev);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> =A0 =A0 =A0 =A0}

I asked Rafael about the legacy operations earlier on the other thread:

On Fri, Dec 17, 2010 at 5:39 AM, Rafael J. Wysocki <rjw-KKrjLPT3xs0@public.gmane.org> wrote:
> On Thursday, December 16, 2010, Rabin Vincent wrote:
>> If so, before I send patches to fix them: can it be assumed that onl=
y
>> drivers using dev_pm_ops (and not the legacy ops of these busses) wi=
ll
>> need the interactions between runtime PM and system sleep as done in=
 the
>> generic ops?
>
> Yes, you can make this assumption safely. =A0The drivers that don't u=
se
> dev_pm_ops can't support runtime PM at all.

And even if we did want to support runtime PM interaction for legacy
ops, the code for restore() above suffers from the problem of setting
active even when no callback exists, like I mentioned in the same email
for resume():

On Thu, Dec 16, 2010 at 11:56 PM, Rabin Vincent <rabin-66gdRtMMWGc@public.gmane.org> wrote:
> =A0(2) Both I2C and platform do not set the device as active when a
> =A0 =A0 =A0pm->resume callback exists and it succeeds.
>
> =A0 =A0 =A0This seems to have been done in i2c until recently, but ha=
s been
> =A0 =A0 =A0removed by 753419f59e ("i2c: Fix for suspend/resume issue"=
). =A0It
> =A0 =A0 =A0seems to me that this removal is incorrect, and instead th=
e real
> =A0 =A0 =A0problem with the implementation was that it set the device=
 as
> =A0 =A0 =A0active even if no resume callback existed, whereas it shou=
ld only
> =A0 =A0 =A0do so when it exists and returns zero, like the generic op=
s.
