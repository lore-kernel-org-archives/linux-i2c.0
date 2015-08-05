From: Shubhrajyoti Datta <shubhrajyoti.datta-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH-v5 2/5] i2c: pxa: enable/disable i2c module across msg xfer
Date: Wed, 5 Aug 2015 16:16:44 +0530
Message-ID: <CAKfKVtGzDjgHzy70aa0d2W=ROMcxVzerg-qpuB9e4PaGKPpMTQ@mail.gmail.com>
References: <1437482466-16126-1-git-send-email-vaibhav.hiremath@linaro.org>
	<1437482466-16126-3-git-send-email-vaibhav.hiremath@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1437482466-16126-3-git-send-email-vaibhav.hiremath-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Vaibhav Hiremath <vaibhav.hiremath-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Yi Zhang <yizhang-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robert.jarzmik-GANU6spQydw@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

hi ,
On Tue, Jul 21, 2015 at 6:11 PM, Vaibhav Hiremath
<vaibhav.hiremath-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:
> From: Yi Zhang <yizhang-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
>
> Enable i2c module/unit before transmission and disable when it
> finishes.
>
> why?
> It's because the i2c bus may be disturbed if the slave device,
> typically a touch, powers on.

Why should that be an issue?
Is it an errata.

In which mode it is an issue slave / master or both?

>
> As we do not want to break slave mode support, this patch introduces
> DT property to control disable of the I2C module after xfer in master
> mode of operation.
>
> i2c-disable-after-xfer : If set, driver will disable I2C module after
> msg xfer
>
> Signed-off-by: Yi Zhang <yizhang-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
> Signed-off-by: Vaibhav Hiremath <vaibhav.hiremath-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> ---
