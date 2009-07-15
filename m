From: alfred steele <alfred.jaquez-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [lm-sensors] Use the Linux I2C subsystem for a two wire interface
	protocol
Date: Wed, 15 Jul 2009 12:32:20 -0500
Message-ID: <528f13590907151032y30ae62beo486d4e1056219983@mail.gmail.com>
References: <528f13590907140925h7aa36452o60da32d3bf941241@mail.gmail.com>
	 <4A5CB908.4060404@cam.ac.uk>
	 <528f13590907141358w17869b6fq450bf223e4f54687@mail.gmail.com>
	 <4A5D6C0A.7030903@gmx.de>
	 <528f13590907150722q2a91139bve72d65cbd555b8e9@mail.gmail.com>
	 <4A5DEB12.3020602@cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4A5DEB12.3020602-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jonathan Cameron <jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>
Cc: Michael Lawnick <ml.lawnick-Mmb7MZpHnFY@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, LM Sensors <lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi

> On an embedded board this would typically be in the board config
> file. =A0For example, see arch/arm/mach-pxa/imote2.c which has an sht=
15
> attached. =A0The exact method of registration may be a bit architectu=
re
> specific but will look something like the relevant parts of that file=
=2E
Was trying to look through the imote2.c but i did not get any exact
match, i am not sure if you are talking about the traditional method
of declaring the platform data/device and use sort of
platform_register(). Are you talking about the following chunk?

[vcc_sensor_1_8] =3D {
248                 .constraints =3D { /* default 1.8V */
249                         .name =3D "vcc_sensor_1_8",
250                         .min_uV =3D 1800000,
251                         .max_uV =3D 1800000,
252                 },
253         },

How does the structure in  sht15_platform_data in the sht15 code
relate to this?  I am a bit confused.
-Alfred.
