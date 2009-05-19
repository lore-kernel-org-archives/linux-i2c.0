From: Trilok Soni <soni.trilok-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/1] MFD: Add U300 AB3100 core support v2
Date: Tue, 19 May 2009 22:56:16 +0530
Message-ID: <5d5443650905191026w22b0ff95j992e09923f55dd0a@mail.gmail.com>
References: <63386a3d0905181340y42ad1868k6b2978e586abc18d@mail.gmail.com>
	 <4A12C3B5.2050100@compulab.co.il>
	 <63386a3d0905190923t36d301c5hf245c06db00b6127@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <63386a3d0905190923t36d301c5hf245c06db00b6127-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linus Walleij <linus.ml.walleij-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Mike Rapoport <mike-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Linus,

On Tue, May 19, 2009 at 9:53 PM, Linus Walleij
<linus.ml.walleij-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> Hm I shouldn't been so trigger-happy as to send v3 out so soon... :-/
>
> Thanks for you quick review Mike!
>
> 2009/5/19 Mike Rapoport <mike-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>:
>
>>> + =A0 =A0 /* Set a pointer back to the container in device data */
>>> + =A0 =A0 for (i =3D 0; i < ARRAY_SIZE(ab3100_platform_devs); i++)
>>> + =A0 =A0 =A0 =A0 =A0 =A0 platform_set_drvdata(ab3100_platform_devs=
[i], ab3100_local);
>>> +
>>> + =A0 =A0 /* Register the platform devices */
>>> + =A0 =A0 platform_add_devices(ab3100_platform_devs,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ARRAY_SIZE(ab3=
100_platform_devs));
>>
>> If you register sub-devices this way, they won't appear as ab3100 ch=
ildren.
>
> I'll set the parent in the first loop then (will test that this works=
) because I
> really like that device table. (Similar to how the board setup does t=
hings.)
>

I don't know but why people are not encouraging to use mfd_xxx apis
here? Lot's of drivers are available under drivers/mfd, but only
couple of them are using real mfd_xxx apis? Is there anything missing
in those apis?

--=20
---Trilok Soni
http://triloksoni.wordpress.com
http://www.linkedin.com/in/triloksoni
