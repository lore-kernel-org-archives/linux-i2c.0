From: Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: State of arbitration and i2c_gpio?
Date: Mon, 16 Jul 2012 21:35:38 +0530
Message-ID: <50043BD2.9030505@nvidia.com>
References: <loom.20120710T223443-322@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <loom.20120710T223443-322-eS7Uydv5nfjZ+VzJOa5vwg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Matthias Urlichs <matthias-+qxcz+fHsVSELgA04lAiVw@public.gmane.org>
Cc: "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Viresh Kumar <viresh.kumar-qxv4g6HH51o@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Matthias,
I remember Viresh was working on this support sometimes ago where he=20
added gpio based arbitration recovery on i2c-core.

http://lwn.net/Articles/485046/

I am also looking to use the gpio based arb recovery mechanism for the=20
i2c-tegra.c.

As this recovery will be generic, better to have this in common place s=
o=20
that many driver can use this. Also the provision should be there to=20
configure pin as gpio and non-gpio mode.

Thanks,
Laxman


On Monday 16 July 2012 08:45 PM, Matthias Urlichs wrote:
> Hello people,
>
> I'd like to ask whether anybody is working on adding arbitration supp=
ort to
> i2c_algo_bit.c. The code still has the old "FIXME do arbitration here=
" comments,
> added five years ago when the I=C2=B2C was imported into Linux 2.3.34=
pre1. :-/
>
> If not, and I'm going to have to do that myself =E2=80=A6 my main que=
stion is, even
> before I get to that -- how do I even detect that the bus is idle? Tu=
rn
> interrupts off and busy-loop-check that both SCL and SDA stay high fo=
r at least
> one and a half clock periods?
>
> Ugh.
>

-----------------------------------------------------------------------=
------------
This email message is for the sole use of the intended recipient(s) and=
 may contain
confidential information.  Any unauthorized review, use, disclosure or =
distribution
is prohibited.  If you are not the intended recipient, please contact t=
he sender by
reply email and destroy all copies of the original message.
-----------------------------------------------------------------------=
------------
