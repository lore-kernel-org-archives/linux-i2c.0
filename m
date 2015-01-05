From: Daniel Baluta <daniel.baluta-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH V1 1/1] iio: Added Capella cm3232 ambient light sensor driver.
Date: Mon, 5 Jan 2015 19:50:32 +0200
Message-ID: <CAEnQRZA6=FK8CaJvh7kxOEAyDLQQE77xZ02UofLUUT67yZG8bg@mail.gmail.com>
References: <1420071030-888-1-git-send-email-ktsai@capellamicro.com>
	<CAEnQRZBD2NMYRp1cW0J2ssT4CT=0jSM=X6ByHQiUrA0ueV8fRA@mail.gmail.com>
	<1420463396.2652.8.camel@perches.com>
	<CAEnQRZBmwurFCJU4E4ArO8waU+YcGWrRYr3DRVxq9haduX2t=w@mail.gmail.com>
	<1420476166.2652.14.camel@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1420476166.2652.14.camel-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Joe Perches <joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org>
Cc: Daniel Baluta <daniel.baluta-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Kevin Tsai <ktsai-GubuWUlQtMwciDkP5Hr2oA@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Hartmut Knaack <knaack.h-Mmb7MZpHnFY@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Peter Meerwald <pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, "David S. Miller" <davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Mauro Carvalho Chehab <mchehab-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>, Antti Palosaari <crope-X3B1VOXEql0@public.gmane.org>, Archana Patni <archana.patni-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux
List-Id: linux-i2c@vger.kernel.org

On Mon, Jan 5, 2015 at 6:42 PM, Joe Perches <joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org> wrote:
> On Mon, 2015-01-05 at 16:20 +0200, Daniel Baluta wrote:
>> On Mon, Jan 5, 2015 at 3:09 PM, Joe Perches <joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org> wrote:
>> > On Mon, 2015-01-05 at 12:51 +0200, Daniel Baluta wrote:
>> >> On Thu, Jan 1, 2015 at 2:10 AM, Kevin Tsai <ktsai-GubuWUlQtMwciDkP5Hr2oA@public.gmane.org> wrote:
>> >> > CM3232 is an advanced ambient light sensor with I2C protocol interface.
>> >> > The I2C slave address is internally hardwired as 0x10 (7-bit).  Writing
>> >> > to configure register is byte mode, but reading ALS register requests to
>> >> > use word mode for 16-bit resolution.
> []
>> >> You could directly return i2c_smbus_write_byte_data(..).
>> >
>> > Sometimes it's better to return a specific value
>> > for the error instead of depending on correctness
>> > of all the indirect functions in the call chain.
>> >
>> > In this case, all the smbus_xfer functions must
>> > return 0 on success.  Do they?
>>
>> Yes.
>>
>> http://lxr.free-electrons.com/source/drivers/i2c/i2c-core.c#L2845
>
> This doesn't show that adapter->algo->smbus_xfer()
> returns 0, you have to look at the code for that
> indirectly called function.

I based my answer on the comment at the top of the function:

2845  * This executes an SMBus protocol operation, and returns a negative
2846  * errno code else zero on success.

>
>> Also, I guess kbuild test robot will complain about it, like here:
>>
>> http://marc.info/?l=linux-kernel&m=141963536230419&w=2
>
> Is the kbuild test robot now submitting patches for all
> possible coccinelle simplifications?  I don't think so.
