From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: RFC: proposal for new i2c.h macro to initialize i2c address lists
	on the fly
Date: Sat, 6 Jun 2009 18:20:26 -0400
Message-ID: <9e4733910906061520o7b0b2858wf4530cf672b1adc9@mail.gmail.com>
References: <200906061500.49338.hverkuil@xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-media-owner@vger.kernel.org>
In-Reply-To: <200906061500.49338.hverkuil@xs4all.nl>
Sender: linux-media-owner@vger.kernel.org
To: Hans Verkuil <hverkuil@xs4all.nl>
Cc: linux-i2c@vger.kernel.org, linux-media@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Sat, Jun 6, 2009 at 9:00 AM, Hans Verkuil<hverkuil@xs4all.nl> wrote:
> Hi all,
>
> For video4linux we sometimes need to probe for a single i2c address.
> Normally you would do it like this:

Why does video4linux need to probe to find i2c devices? Can't the
address be determined by knowing the PCI ID of the board?


>
> static const unsigned short addrs[] =3D {
> =A0 =A0 =A0 =A0addr, I2C_CLIENT_END
> };
>
> client =3D i2c_new_probed_device(adapter, &info, addrs);
>
> This is a bit awkward and I came up with this macro:
>
> #define V4L2_I2C_ADDRS(addr, addrs...) \
> =A0 =A0 =A0 =A0((const unsigned short []){ addr, ## addrs, I2C_CLIENT=
_END })
>
> This can construct a list of one or more i2c addresses on the fly. Bu=
t this
> is something that really belongs in i2c.h, renamed to I2C_ADDRS.
>
> With this macro we can just do:
>
> client =3D i2c_new_probed_device(adapter, &info, I2C_ADDRS(addr));
>
> Comments?
>
> Regards,
>
> =A0 =A0 =A0 =A0Hans
>
> --
> Hans Verkuil - video4linux developer - sponsored by TANDBERG Telecom
> --
> To unsubscribe from this list: send the line "unsubscribe linux-i2c" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>



--=20
Jon Smirl
jonsmirl@gmail.com
--
To unsubscribe from this list: send the line "unsubscribe linux-media" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
