From: Linus Walleij <linus.ml.walleij-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/1] MFD: Add U300 AB3100 core support v2
Date: Tue, 19 May 2009 18:23:49 +0200
Message-ID: <63386a3d0905190923t36d301c5hf245c06db00b6127@mail.gmail.com>
References: <63386a3d0905181340y42ad1868k6b2978e586abc18d@mail.gmail.com>
	 <4A12C3B5.2050100@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4A12C3B5.2050100-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mike Rapoport <mike-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hm I shouldn't been so trigger-happy as to send v3 out so soon... :-/

Thanks for you quick review Mike!

2009/5/19 Mike Rapoport <mike-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>:

>> + =A0 =A0 /* Set a pointer back to the container in device data */
>> + =A0 =A0 for (i =3D 0; i < ARRAY_SIZE(ab3100_platform_devs); i++)
>> + =A0 =A0 =A0 =A0 =A0 =A0 platform_set_drvdata(ab3100_platform_devs[=
i], ab3100_local);
>> +
>> + =A0 =A0 /* Register the platform devices */
>> + =A0 =A0 platform_add_devices(ab3100_platform_devs,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ARRAY_SIZE(ab31=
00_platform_devs));
>
> If you register sub-devices this way, they won't appear as ab3100 chi=
ldren.

I'll set the parent in the first loop then (will test that this works) =
because I
really like that device table. (Similar to how the board setup does thi=
ngs.)

> Besides, setting the sub-devices drvdata to point to the master devic=
e makes it
> impossible for sub-device drivers to use this field for their needs.

Not really... It's just a pointer back to the AB3100 parent that can
be discarded
after copying it to a local driver struct. So the driver can actually:

foo_probe(platform_device *pdev) {
  foo =3D kmalloc(...);
  foo->ab_pointer =3D platform_get_drvdata(pdev);
  ...
  platform_set_drvdata(pdev, foo);
}

I could use platform_device_add_data() instead but that will start
kmalloc():ing and such...

>> +/*
>> + * This struct is PRIVATE and devices using it should NOT
>> + * access ANY fields. It is used as a token for calling the
>> + * AB3100 functions.
>> + */
>
> If the struct is private, probably it should be placed rather in the =
".c" file?

=46rom one point of view, yes, but from another point of view it feels =
bad to
pass around a (void *) as token for ab3100 operations. This is loosely
modeled on how wm8350 does it, so shouldn't be too controversial I thin=
k.

Yours,
Linus Walleij
