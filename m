From: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Subject: Re: [PATCH] i2c: enable async suspend/resume on i2c devices
Date: Sun, 29 Mar 2020 09:49:10 -0300
Message-ID: <CAAEAJfCzquaiCkjxXYOJRH8tpGRkHJBSWnFD--S=C7uAvHwqUg@mail.gmail.com>
References: <20200327151951.18111-1-ricardo.canuelo@collabora.com>
 <20200327154345.GA3971@ninjato> <CAGAzgsqJznZi83ijxCgQg463Q4AnwiNX-a0Q9+Og9MW5OJ4Vew@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-ua1-f66.google.com ([209.85.222.66]:34228 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728087AbgC2Mt0 (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Sun, 29 Mar 2020 08:49:26 -0400
Received: by mail-ua1-f66.google.com with SMTP id d23so5018695uak.1
        for <linux-i2c@vger.kernel.org>; Sun, 29 Mar 2020 05:49:24 -0700 (PDT)
In-Reply-To: <CAGAzgsqJznZi83ijxCgQg463Q4AnwiNX-a0Q9+Og9MW5OJ4Vew@mail.gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: "dbasehore ." <dbasehore@chromium.org>
Cc: Wolfram Sang <wsa@the-dreams.de>, =?UTF-8?Q?Ricardo_Ca=C3=B1uelo?= <ricardo.canuelo@collabora.com>, linux-i2c@vger.kernel.org, Guenter Roeck <groeck@chromium.org>, Linux-pm mailing list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, kernel@collabora.com

Hi Derek,

On Fri, 27 Mar 2020 at 17:26, dbasehore . <dbasehore@chromium.org> wrote:
>
> On Fri, Mar 27, 2020 at 8:43 AM Wolfram Sang <wsa@the-dreams.de> wrote:
> >
> > On Fri, Mar 27, 2020 at 04:19:51PM +0100, Ricardo Ca=C3=B1uelo wrote:
> > > This enables the async suspend property for i2c devices. This reduces
> > > the suspend/resume time considerably on platforms with multiple i2c
> > > devices (such as a trackpad or touchscreen).
> > >
> > > (am from https://patchwork.ozlabs.org/patch/949922/)
> > >
> > > Signed-off-by: Derek Basehore <dbasehore@chromium.org>
> > > Reviewed-on: https://chromium-review.googlesource.com/1152411
> > > Tested-by: Venkateswarlu V Vinjamuri <venkateswarlu.v.vinjamuri@intel=
.com>
> > > Reviewed-by: Venkateswarlu V Vinjamuri <venkateswarlu.v.vinjamuri@int=
el.com>
> > > Reviewed-by: Justin TerAvest <teravest@chromium.org>
> > > Signed-off-by: Guenter Roeck <groeck@chromium.org>
> > > Signed-off-by: Ricardo Ca=C3=B1uelo <ricardo.canuelo@collabora.com>
> > > ---
> >
> > Adding linux-pm to CC. I don't know much about internals of async
> > suspend. Is there a guide like "what every maintainer needs to know
> > about"?
>
> For more details, you can look at the function dpm_resume in the
> drivers/base/power/main.c file and follow from there.
>
> I can't find anything in Documentation/, so here's a short overview:
> Async devices have suspend/resume callbacks scheduled via
> async_schedule at every step (normal, late, noirq, etc.) for
> suspending/resuming devices. We wait for all device callbacks to
> complete at the end of each of these steps before moving onto the next
> one. This means that you won't have a resume_early callback running
> when you start the normal device resume callbacks.
>
> The async callbacks still wait individually for children on suspend
> and parents on resume to complete their own callbacks before calling
> their own. Because some dependencies may not be tracked by the
> parent/child graph (or other unknown reasons), async is off by
> default.
>
> Enabling async is a confirmation that all dependencies to other
> devices are properly tracked, whether through the parent/child
> relationship or otherwise.
>

Have you noticed the async sysfs attribute [1]?

Given this allows userspace to enable the async suspend/resume,
wouldn't it be simpler to just do that in userspace, on the
platforms you want to target (e.g. Apollolake Chromebook devices, and so on=
) ?

Thanks,
Ezequiel

[1] Documentation/ABI/testing/sysfs-devices-power

> >
> > > This patch was originally created for chromeos some time ago and I'm
> > > evaluating if it's a good candidate for upstreaming.
> > >
> > > By the looks of it I think it was done with chromebooks in mind, but
> > > AFAICT this would impact every i2c client in every platform, so I'd l=
ike
> > > to know your opinion about it.
> > >
> > > As far as I know there was no further investigation or testing on it,=
 so
> > > I don't know if it was tested on any other hardware.
> > >
> > > Best,
> > > Ricardo
> > >
> > >  drivers/i2c/i2c-core-base.c | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.=
c
> > > index cefad0881942..643bc0fe0281 100644
> > > --- a/drivers/i2c/i2c-core-base.c
> > > +++ b/drivers/i2c/i2c-core-base.c
> > > @@ -769,6 +769,7 @@ i2c_new_client_device(struct i2c_adapter *adap, s=
truct i2c_board_info const *inf
> > >       client->dev.of_node =3D of_node_get(info->of_node);
> > >       client->dev.fwnode =3D info->fwnode;
> > >
> > > +     device_enable_async_suspend(&client->dev);
> > >       i2c_dev_set_name(adap, client, info);
> > >
> > >       if (info->properties) {
> > > --
> > > 2.18.0
> > >
