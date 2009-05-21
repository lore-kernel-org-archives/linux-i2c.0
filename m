From: Linus Walleij <linus.ml.walleij-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/1] MFD: Add U300 AB3100 core support v4
Date: Thu, 21 May 2009 21:29:46 +0200
Message-ID: <63386a3d0905211229t2c02109cp6213b201e451cd74@mail.gmail.com>
References: <63386a3d0905200217i56accf6fw4ef2f8ed1793e44@mail.gmail.com>
	 <20090520222012.GB4541@sortiz.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090520222012.GB4541-jcdQHdrhKHMdnm+yROfE0A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

2009/5/21 Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>:

>> +static irqreturn_t ab3100_irq_handler(int irq, void *data)
>> +{
> struct ab3100 *ab3100 = (struct ab3100 *)data;
>
> you're even passing the ab3100 pointer to request_irq, so it's all set
> already.

Yeah and all the code was actually the way you wanted it before I started
to try to separate local accesses to the struct from accesses coming
in from the outside using a singleton pattern.

But no problem, I'll fix it back in the way you want it, just a minute!

Linus Walleij
