From: Cory Maccarrone <darkstar6262-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v3] [MFD] i2c-htcpld: Add the HTCPLD driver
Date: Wed, 6 Jan 2010 06:47:30 -0800
Message-ID: <6cb013311001060647s3bce5e63mbae1a10036a14ae1@mail.gmail.com>
References: <1260841135-6680-1-git-send-email-darkstar6262@gmail.com>
	<20100106123532.GB5500@sortiz.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100106123532.GB5500-jcdQHdrhKHMdnm+yROfE0A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Wed, Jan 6, 2010 at 4:35 AM, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org> wr=
ote:
> Hi Cory,
>
> late review, sorry about that...
>
> The driver looks fine to me, but I get 23 checkpatch warnings and 5 e=
rrors for
> it.
> Could you please fix them, keeping in mind that I'm fine with printk/=
dev_*
> strings being more than 80 chars.
>

Yup, no problem.

> A couple of additional comments:
>
> ?cpld? ??

That should probably be rephrased to say "unknown model CPLD".  I'll fi=
x that.

> Please use pr_* instead. It seems you're using it already, so let's b=
e
> consistent.

Right.

> This routine is fairly big, and could be more readable by calling som=
e
> subroutines. The chips initialisation part could be extracted out for=
 example.

OK.

> Shouldnt it be: htcpld->chip[i].cache_in =3D 0; instead ?

Yes, good catch.

> You could have a nicer indentation here:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0error =3D request_threaded_irq(htcpld->chained_irq,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 NULL, htcpld_handler,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 flags, pdev->name, htcpld);
>

OK.

I'll make those fixes and resubmit.  Thanks for reviewing it!

- Cory
