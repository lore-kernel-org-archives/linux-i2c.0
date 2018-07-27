From: "dbasehore ." <dbasehore@chromium.org>
Subject: Re: [PATCH] i2c: enable async suspend/resume on i2c devices
Date: Fri, 27 Jul 2018 09:17:12 -0700
Message-ID: <CAGAzgso2Lf6Yw+5xGLkaTdJ7TAZ8_43qEpOya+zUjWqy4ET7RQ@mail.gmail.com>
References: <20180726225508.74612-1-dbasehore@chromium.org>
 <CAHp75VfXXdzmp7M8rpcYTTKzwMT=QKt=_m7m7Bfp7uM4izMkrQ@mail.gmail.com> <1c3aba3d-0dfb-dc24-bd7a-5289a19a9065@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/alternative; boundary="0000000000006b4d7d0571fd72e3"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1c3aba3d-0dfb-dc24-bd7a-5289a19a9065@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: hdegoede@redhat.com
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, linux-kernel <linux-kernel@vger.kernel.org>, wsa@the-dreams.de, linux-i2c@vger.kernel.org, Doug Anderson <dianders@chromium.org>, dtor@chromium.org, venkateswarlu.v.vinjamuri@intel.corp-partner.google.com
List-Id: linux-i2c@vger.kernel.org

--0000000000006b4d7d0571fd72e3
Content-Type: text/plain; charset="UTF-8"

On Fri, Jul 27, 2018 at 5:07 AM Hans de Goede <hdegoede@redhat.com> wrote:

> Hi,
>
> On 07/27/2018 12:44 PM, Andy Shevchenko wrote:
> > On Fri, Jul 27, 2018 at 1:55 AM, Derek Basehore <dbasehore@chromium.org>
> wrote:
> >> This enables the async suspend property for i2c devices. This reduces
> >> the suspend/resume time considerably on platforms with multiple i2c
> >> devices (such as a trackpad or touchscreen).
> >
> > How did you test this?
>

It was tested on Apollolake Chromebook devices.


> >
> > Especially on Chromebooks based on Intel Cherrytrail / Braswell
> > platforms, they have a painful PMIC vs. OS design solution.
> >
> > +Cc: Hans, who did a lot in this area.
>
> We disable suspend of the i2c controller for the i2c-bus
> to which the PMIc is connected on these platforms, so I do not
> expect this to cause any new issues.
>
> But this is something to keep an eye on,
>
> Regards,
>
> Hans
>
>

--0000000000006b4d7d0571fd72e3
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><br><div class=3D"gmail_quote"><div dir=3D"ltr">On Fri=
, Jul 27, 2018 at 5:07 AM Hans de Goede &lt;<a href=3D"mailto:hdegoede@redh=
at.com">hdegoede@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gm=
ail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-le=
ft:1ex">Hi,<br>
<br>
On 07/27/2018 12:44 PM, Andy Shevchenko wrote:<br>
&gt; On Fri, Jul 27, 2018 at 1:55 AM, Derek Basehore &lt;<a href=3D"mailto:=
dbasehore@chromium.org" target=3D"_blank">dbasehore@chromium.org</a>&gt; wr=
ote:<br>
&gt;&gt; This enables the async suspend property for i2c devices. This redu=
ces<br>
&gt;&gt; the suspend/resume time considerably on platforms with multiple i2=
c<br>
&gt;&gt; devices (such as a trackpad or touchscreen).<br>
&gt; <br>
&gt; How did you test this?<br></blockquote><div><br></div><div>It was test=
ed on Apollolake Chromebook devices.</div><div>=C2=A0</div><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;pad=
ding-left:1ex">
&gt; <br>
&gt; Especially on Chromebooks based on Intel Cherrytrail / Braswell<br>
&gt; platforms, they have a painful PMIC vs. OS design solution.<br>
&gt; <br>
&gt; +Cc: Hans, who did a lot in this area.<br>
<br>
We disable suspend of the i2c controller for the i2c-bus<br>
to which the PMIc is connected on these platforms, so I do not<br>
expect this to cause any new issues.<br>
<br>
But this is something to keep an eye on,<br>
<br>
Regards,<br>
<br>
Hans<br>
<br>
</blockquote></div></div>

--0000000000006b4d7d0571fd72e3--
