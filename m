From: "Zhang, Sonic" <Sonic.Zhang-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 1/2] i2c-bfin-twi: integrate
	timeout timer withcompletion interface
Date: Sat, 10 Oct 2009 12:04:28 +0800
Message-ID: <0F1B54C89D5F954D8535DB252AF412FA04D703EB@chinexm1.ad.analog.com>
References: <1254973096-4391-1-git-send-email-vapier@gentoo.org>
	<20091008093817.GB6112@pengutronix.de>
	<0F1B54C89D5F954D8535DB252AF412FA04D6FC09@chinexm1.ad.analog.com>
	<8bd0f97a0910082210x7d89ac85wf9e9d144b59bdb85@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org>
Content-Class: urn:content-classes:message
In-Reply-To: <8bd0f97a0910082210x7d89ac85wf9e9d144b59bdb85-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://blackfin.uclinux.org/mailman/options/uclinux-dist-devel>,
	<mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=unsubscribe>
List-Archive: <http://blackfin.uclinux.org/pipermail/uclinux-dist-devel>
List-Post: <mailto:uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org>
List-Help: <mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=help>
List-Subscribe: <https://blackfin.uclinux.org/mailman/listinfo/uclinux-dist-devel>,
	<mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=subscribe>
Sender: uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
Errors-To: uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
To: Mike Frysinger <vapier.adi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

OK. The definition of adapter->timeout changed in new kernel from 10 millis=
econd to jiffies. So, change accordingly.

Sonic =


-----Original Message-----
From: Mike Frysinger [mailto:vapier.adi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org] =

Sent: Friday, October 09, 2009 1:10 PM
To: Zhang, Sonic
Cc: Wolfram Sang; uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org; linux-i2c@vger.k=
ernel.org; Ben Dooks
Subject: Re: [Uclinux-dist-devel] [PATCH 1/2] i2c-bfin-twi: integrate timeo=
ut timer withcompletion interface

On Fri, Oct 9, 2009 at 00:49, Zhang, Sonic wrote:
> From: Wolfram Sang [mailto:w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org]
>> On Wed, Oct 07, 2009 at 11:38:15PM -0400, Mike Frysinger wrote:
>>> From: Sonic Zhang <sonic.zhang-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
>>>
>>> There isn't much point in managing our own custom timeout timer when =

>>> the completion interface already includes support for it. =A0This =

>>> makes the resulting code much simpler and robust.
>>
>> This sounds like a good thing to do, but keep in mind that
>> adapter->timeout values should be in jiffies (see
>> 8a52c6b4d55b2960d93a90a7cf6afd252357fa54).
>
> Yes, jiffies is used in this patch for timeout value.

no it isnt.  the commit he refers to does things like:
-   adap->timeout =3D 1;
+   adap->timeout =3D HZ;
        ret =3D wait_event_interruptible_timeout(dev->wq,
-           !(in_8(&iic->sts) & STS_PT), dev->adap.timeout * HZ);
+           !(in_8(&iic->sts) & STS_PT), dev->adap.timeout);

we need to make the same change as our code is currently wrong:
+               if (!wait_for_completion_timeout(&iface->complete,
+                       adap->timeout * HZ)) {
+       p_adap->timeout =3D 5;
-mike
