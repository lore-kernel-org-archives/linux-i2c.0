From: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Subject: Re: [PATCH 3/4] devicetree: bindings: Add defeature-repeated-start
 property for Cadence I2C
Date: Tue, 02 Dec 2014 16:12:48 +0100
Message-ID: <547DD6F0.6060006@metafoo.de>
References: <1417514749-24319-1-git-send-email-harinik@xilinx.com> <1417514749-24319-4-git-send-email-harinik@xilinx.com> <20141202111907.GC23671@leverpostej> <CAFcVECLtPx6shBXJbg9Uf_8fnhkMoO1zpoxGcdda7PSA7z_2rA@mail.gmail.com> <20141202125203.GA4072@katana> <CAFcVECJwFoFd6GrmF282CG+fELnYb=FNCTDq=RYKky_dHha=Jg@mail.gmail.com> <20141202131611.GC4072@katana> <CAFcVECKMqACtumHZGHbToUUSjd_dWCcLbu=_ZjNnnGdAZQ_3fg@mail.gmail.com> <20141202141548.GA5883@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20141202141548.GA5883@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Harini Katakam <harinikatakamlinux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <Pawel.Moll-5wv7dgnIgG8@public.gmane.org>, "ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org" <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, "galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org" <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org" <michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>, "soren.brinkmann-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org" <soren.brinkmann-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "vishnum-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org" <vishnum-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On 12/02/2014 03:15 PM, Wolfram Sang wrote:
>>> What do you do when disable repeated start? Sending STOP and START? If
>>> so, this is really something different than repeated start. By using
>>> I2C_FUNC_I2C a user expects repeated start, so if the HW does not
>>> support it, we should say so and don't try to emulate it with something
>>> different.
>>
>> Yes, we send stop.
>
> As said before, this is wrong. Another master could interfere between
> the messages when using stop+start. This is no replacement for repeated
> start.

More importantly a lot of I2C slaves also reset their internal state machine 
on a stop. So e.g. if reading a register is implemented by doing 
start,write,repeated start,read,stop and you replace that with 
start,write,stop,start,read,stop you'll always read register zero instead of 
the register you wanted to read.

- Lars
