From: Agustin <gatoguan-os@yahoo.com>
Subject: Re: [PATCH] v4l2-subdev: add a v4l2_i2c_new_dev_subdev() function
Date: Tue, 21 Apr 2009 05:46:06 -0700 (PDT)
Message-ID: <86952.30815.qm@web32103.mail.mud.yahoo.com>
Reply-To: gatoguan-os@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-media-owner@vger.kernel.org>
Sender: linux-media-owner@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: Hans Verkuil <hverkuil@xs4all.nl>, Linux Media Mailing List <linux-media@vger.kernel.org>, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


On 21/4/09, Guennadi Liakhovetski <g.liakhovetski@gmx.de> wrote:
> On Tue, 21 Apr 2009, Agustin wrote:
> >=20
> > Hi,
> >=20
> > On 21/4/09, Guennadi Liakhovetski <g.liakhovetski@gmx.de> wrote:
> > > Video (sub)devices, connecting to SoCs over generic i2c busses ca=
nnot=20
> > > provide a pointer to struct v4l2_device in i2c-adapter driver_dat=
a, and=20
> > > provide their own i2c_board_info data, including a platform_data =
field.=20
> > > Add a v4l2_i2c_new_dev_subdev() API function that does exactly th=
e same
> > > as v4l2_i2c_new_subdev() but uses different parameters, and make=20
> > > v4l2_i2c_new_subdev() a wrapper around it.
> >=20
> > [snip]
> >=20
> > I am wondering about this ongoing effort and its pursued goal: is i=
t
> > to hierarchize the v4l architecture, adding new abstraction levels?
> > If so, what for?

> Driver-reuse. soc-camera framework will be able to use all available =
and=20
> new v4l2-subdev drivers, and vice versa.

Well, "Driver reuse." sounds more as a mantra than a reason for me. The=
n I can't find any "available" v4l2-subdev driver in 2.6.29.

I assume this subdev stuff plays a mayor role in current V4L2 architect=
ure refactorization. Then we probably should take this opportunity to r=
elieve V4L APIs from all its explicit I2C mangling, because...

> > To me, as an eventual driver developer, this makes it harder to=20
> > integrate my own drivers, as I use I2C and V4L in my system but I
> > don't want them to be tightly coupled.

> This conversion shouldn't make the coupling any tighter.

But still I think V4L system should not be aware of I2C at all.

To me, V4L is a kernel subsystem in charge of moving multimedia data fr=
om/to userspace/hardware, and the APIs should reflect just that.

If one V4L driver uses I2C for device control, what does V4L have to sa=
y about that, really? Or why V4L would never care about usb or SPI link=
s?

I2C and V4L should stay cleanly and clearly apart.

> > Of course I can ignore this "subdev" stuff and just link against=20
> > soc-camera which is what I need, and manage I2C without V4L knowing=
=20
> > about it. Which is what I do.

> You won't be able to. The only link to woc-camera will be the
> v4l2-subdev link. Already now with this patch many essential
> soc-camera API operations are gone.

I guess you mean that I will have to use v4l2-subdev interface to conne=
ct to soc-camera, and not to surrender my I2C management to an I2C-extr=
aneous subsystem. Is that right?

(Sorry for arriving this late to the discussion just to critizise your =
good efforts.)

Regards,
--Agust=EDn.
--
To unsubscribe from this list: send the line "unsubscribe linux-media" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
