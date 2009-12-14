From: Cory Maccarrone <darkstar6262-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2] [MFD] i2c-htcpld: Add the HTCPLD driver
Date: Mon, 14 Dec 2009 07:30:11 -0800
Message-ID: <6cb013310912140730x3ff1d1c1vf0cd851e6f7e9f7f@mail.gmail.com>
References: <1260653372-29299-1-git-send-email-darkstar6262@gmail.com>
	<20091214134137.GC1250@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20091214134137.GC1250-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Mon, Dec 14, 2009 at 5:41 AM, Mark Brown
<broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org> wrote:
>
> request_threaded_irq() probably does what you want here and is more
> friendly to things like lockdep. =C2=A0There's an example of handling=
 this
> sort of chip with the genirq infrastructure in the WM831x driver.
>

Ah, cool, I didn't know about that.  That looks to be exactly what I wa=
nt.

>
> You don't need to cast awat from void.
>

Easy enough.

I'll make the changes and resubmit.  Thanks for the feedback!

- Cory
