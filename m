From: Octavian Purdila <octavian.purdila-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2 1/3] mfd: add support for Diolan DLN-2 devices
Date: Wed, 3 Sep 2014 16:39:48 +0300
Message-ID: <CAE1zotLnBZ83O23kaDz_xVhhSpPW6YyOQmkaTfZaicmf6MfOdQ@mail.gmail.com>
References: <CAE1zotK0cddns4f4ay-GJie8O2pjb72+-yYndZvW0hbF0D83HA@mail.gmail.com>
	<20140901095127.GK7374@lee--X1>
	<CAE1zot+T6eq0jrL6_Qh=5nihNOgGEaWe5RCDk7_1XS8ZWaWKqA@mail.gmail.com>
	<20140901113949.GP7374@lee--X1>
	<CAE1zotKNBTEMX8DDYwdwOcq0qZgqxZWazE60TUQeiOmD0a4xbA@mail.gmail.com>
	<20140901154626.GH8796@lee--X1>
	<CAE1zotL-cjHqrdymzYhZq24zx+0qGY8-4JnrVZf-TGXDf5Sm3w@mail.gmail.com>
	<20140901175453.GR4894@localhost>
	<20140902080010.GD17117@lee--X1>
	<CAE1zotJzFL0bZvNo4mHK3+EhURarhTPDE5n+SdNzof8Nc-CFew@mail.gmail.com>
	<20140902152311.GY4894@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140902152311.GY4894@localhost>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lkml <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Daniel Baluta <daniel.baluta-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Laurentiu Palcu <laurentiu.palcu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Tue, Sep 2, 2014 at 6:23 PM, Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> On Tue, Sep 02, 2014 at 11:45:55AM +0300, Octavian Purdila wrote:
>> On Tue, Sep 2, 2014 at 11:00 AM, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:
>> > On Mon, 01 Sep 2014, Johan Hovold wrote:
>
>> >> I haven't looked at the details of the protocol for the device in
>> >> question, but it might even be possible to use regmap here (as I
>> >> mentioned in my comments on v1).
>> >
>> > Obviously that would be preferred.
>> >
>> > Octavian, did you look into that?
>> >
>> Yes, I did. Since this is the first time I am looking at regmap I may
>> be wrong but I don't see a way to use it. The dln2 i2c driver needs to
>> be able to send and receive arbitrary size buffers and this does not
>> seem possible to do with the regmap API.
>
> That should be possible using the regmap bus read and write operations.

I took a closer look on the regmap bus read/write operations and I
think they are not fit for what we need in the driver. The driver uses
a request/response model which, IMHO, does not fit well with a
register read/write API. Yes, maybe we can emulate it, but why do
that?

>> (Also creating a regmap class for a particular device seems over
>> engineering since nobody else is going to use it)
>
> Possibly, but it would allow subdrivers to be implemented using a
> standard interface and also provide register caching for free.
>

Using a standard interface is nice, but I think that using the right
interface type is more important. This hardware does not use registers
but a messages to communicate with the OS.

Also caching is not useful for i2c and only partially useful for GPIO
(to cache the pin direction, and pin status in output mode only) so
its not a big win.
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
