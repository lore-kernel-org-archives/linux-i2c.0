From: Linus Walleij <linus.ml.walleij-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v3] Topcliff: Update PCH_I2C driver to 2.6.36
Date: Wed, 27 Oct 2010 09:15:53 -0400
Message-ID: <AANLkTimgCS=U3wzoOtZhtFe0skJtuOaKA+bp+gYc5+qS@mail.gmail.com>
References: <4CC645A1.5010509@dsn.okisemi.com>
	<20101026102048.316d0c04@endymion.delvare>
	<001a01cb74ec$e3eb3ea0$66f8800a@maildom.okisemi.com>
	<20101026111322.738b0b14@endymion.delvare>
	<001c01cb74f2$d3dd8990$66f8800a@maildom.okisemi.com>
	<20101026132649.623461f9@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20101026132649.623461f9-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Tomoya MORINAGA <tomoya-linux-ECg8zkTtlr0C6LszWs/t0g@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Ralf Baechle <ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, srinidhi kasagar <srinidhi.kasagar-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>, Tomoya MORINAGA <morinaga526-ECg8zkTtlr0C6LszWs/t0g@public.gmane.org>, Wang Qi <qi.wang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Wang Yong Y <yong.y.wang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, kok.howg.ewe-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, joel.clark-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, andrew.chih.howe.khor-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

2010/10/26 Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>:
> On Tue, 26 Oct 2010 18:47:37 +0900, Tomoya MORINAGA wrote:
>> Must we get Intel's signature ?
>> We have already got the following. Isn't =A0this enough ?
>> > Reviewed-by: Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
>>
>> Though I haven't heard like the requirement,
>> if Intel's signature is mandatory, I will request to Intel.
>
> It's not mandatory, but the time Ben and myself have to review new
> drivers is scarce, so it's in your own interest to have the code
> reviewed by people with more time and more interest in the specific
> hardware.

I agree. My Reviewed-by is mainly about the code structure,
a few antipatterns were removed and it looks nice to me now.
We indeed need someone who knows the hardware to look at this.

Yours,
Linus Walleij
