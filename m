From: Octavian Purdila <octavian.purdila-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v3 2/3] i2c: add support for Diolan DLN-2 USB-I2C adapter
Date: Mon, 8 Sep 2014 20:15:07 +0300
Message-ID: <CAE1zotJomxwAJA3aXm9MHnHd5Pg9V=K7XaptOPWkArV0jio4DQ@mail.gmail.com>
References: <1409930279-1382-1-git-send-email-octavian.purdila@intel.com>
	<1409930279-1382-3-git-send-email-octavian.purdila@intel.com>
	<20140908144447.GD9560@localhost>
	<CAE1zot+R25OAu9d9WB2tOFqO9J9m-Vwo25msn6TD2HxseBTUzQ@mail.gmail.com>
	<20140908163058.GF9560@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140908163058.GF9560@localhost>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Daniel Baluta <daniel.baluta-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Laurentiu Palcu <laurentiu.palcu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lkml <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Mon, Sep 8, 2014 at 7:30 PM, Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> On Mon, Sep 08, 2014 at 06:57:29PM +0300, Octavian Purdila wrote:
>> On Mon, Sep 8, 2014 at 5:44 PM, Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
>>
>> <snip>
>>
>> Hi Johan,
>>
>> Again, thanks for the detailed review, I am addressing your review
>> comments as we speak. Some questions below.
>>
>> <snip>
>>
>> > > +     int ret, len;
>> > > +     struct tx_data {
>> > > +             u8 port;
>> > > +             u8 addr;
>> > > +             u8 mem_addr_len;
>> > > +             __le32 mem_addr;
>> > > +             __le16 buf_len;
>> > > +             u8 buf[DLN2_I2C_MAX_XFER_SIZE];
>> > > +     } __packed tx;
>> >
>> > Allocate these buffers dynamically (possibly at probe).
>> >
>>
>> I double checked this, and DLN2_I2C_MAX_XFER_SIZE should actually be <
>> 64 as the USB endpoint configuration max packet size is 64. In this
>> case, can we keep it on the stack?
>
> It's better to lift that restriction and allocate it dynamically. Using
> larger buffers (> EP size) is also more efficient.
>
>> <snip>
>>
>> > > +     int ret, buf_len, rx_len = sizeof(rx);
>> >
>> > Again, one declaration per line.
>>
>> AFAICS there are many places where declaration on the same line
>> (initialization included) are used. When did this became a coding
>> style issue?
>
> It's ugly, hurts readability, and can also obfuscate the fact that your
> function really needs to be refactored.
>
> And it's in the CodingStyle:
>
>         "To this end, use just one data declaration per line (no commas
>         for multiple data declarations)."
>

OK, I always thought that was for when declaring structures/unions.
Just one more question on this subject: is the following allowed:

int ret, len;

or should it be:

int ret;
int len;
