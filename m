From: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [RFC] i2c_check_functionality and error code
Date: Wed, 24 Feb 2016 20:42:37 +0000
Message-ID: <56CE15BD.3070800@kernel.org>
References: <CAKzfze-B4dx9aghERaRDu7xz0i6pMJcAUGMQX7OWJpWh7i=bxw@mail.gmail.com>
 <56CA1F0D.2060707@kernel.org> <20160221225606.GA1386@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160221225606.GA1386@katana>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Matt Ranostay <mranostay-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On 21/02/16 22:56, Wolfram Sang wrote:
>> Hohum. Wolfram what do you think?
> 
> I'd go for "EOPNOTSUPP" since it is most descriptive. I wouldn't say we
> really need to fix it up in the kernel tree. However, I neither would
> vote against it.
> 
I'm certainly keen on cleaning this up in IIO at the least.
A bit of consistency is always nice and once we have done it once
it should be reasonably pain free.

Anyhow, patches welcome ;)

Jonathan
