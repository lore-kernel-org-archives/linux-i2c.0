From: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [RFC] i2c_check_functionality and error code
Date: Sun, 21 Feb 2016 20:33:17 +0000
Message-ID: <56CA1F0D.2060707@kernel.org>
References: <CAKzfze-B4dx9aghERaRDu7xz0i6pMJcAUGMQX7OWJpWh7i=bxw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAKzfze-B4dx9aghERaRDu7xz0i6pMJcAUGMQX7OWJpWh7i=bxw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Matt Ranostay <mranostay-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On 14/02/16 23:09, Matt Ranostay wrote:
> Jonathan et all,
> 
> Has anyone noticed that there is no clear consensus on which error
> code to return when a i2c_check_functionality() check fails within the
> probe function. I've seen so far ENODEV, ENOTSUPP, EOPNOTSUPP, EIO,
> and ENOSYS in drivers/iio
> 
> Shouldn't these be made a standard value like -ENOTSUPP?
Would make sense - but is this the right choice.

Thought I'd grep HWMON as a possible source of a consensus on this and
got no clear answer.  The most common in there looks to be -ENODEV though
(From the first few pages of results anyway ;)

Hohum. Wolfram what do you think?

Worth cleaning this up?  Perhaps even kernel wise would lead to some
consistency. I've never been that sharp on this in IIO so I can't
really talk ;)

Jonathan


> 
> Thanks,
> 
> Matt
> 
