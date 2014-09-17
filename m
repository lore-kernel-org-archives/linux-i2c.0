From: Octavian Purdila <octavian.purdila-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v4 2/3] i2c: add support for Diolan DLN-2 USB-I2C adapter
Date: Wed, 17 Sep 2014 13:07:51 +0300
Message-ID: <CAE1zotJt+Eq7dCaWgFUV_=tXvHL=nExW-KeL3gzTUEgqu8AX9Q@mail.gmail.com>
References: <1410290686-6680-1-git-send-email-octavian.purdila@intel.com>
	<1410290686-6680-3-git-send-email-octavian.purdila@intel.com>
	<20140917094445.GG20727@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140917094445.GG20727@localhost>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Daniel Baluta <daniel.baluta-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Laurentiu Palcu <laurentiu.palcu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lkml <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Wed, Sep 17, 2014 at 12:44 PM, Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:

<snip>

>> +     /*
>> +      * Buffer to hold the packet for read or write transfers. One
>> +      * is enough since we can't have multiple transfers in
>> +      * parallel on the i2c adapter.
>> +      */
>> +     union {
>> +             struct {
>> +                     u8 port;
>> +                     u8 addr;
>> +                     u8 mem_addr_len;
>> +                     __le32 mem_addr;
>> +                     __le16 buf_len;
>> +                     u8 buf[DLN2_I2C_MAX_XFER_SIZE];
>> +             } __packed tx;
>> +             struct {
>> +                     __le16 buf_len;
>> +                     u8 buf[DLN2_I2C_MAX_XFER_SIZE];
>> +             } __packed rx;
>> +     } buf;
>
> While this works in this case due to the extra copy you do in
> dln2_transfer, allocating buffers that would (generally) be used for DMA
> transfers as part of a larger structure is a recipe for trouble.
>
> It's probably better to allocate separately, if only to prevent people
> from thinking there might be a bug here.
>

Just to make sure I understand this, what could the issues be? The
buffers not being aligned or not allocated in continuous physical
memory?

<snip>

>> +
>> +     rx_buf_len = le16_to_cpu(dln2->buf.rx.buf_len);
>> +     if (rx_len < rx_buf_len + sizeof(dln2->buf.rx.buf_len))
>> +             return -EPROTO;
>> +
>> +     if (data_len > rx_buf_len)
>> +             data_len = rx_buf_len;
>
> You're still not checking that the received data does not overflow the
> supplied buffer as I already commented on v3.
>
>> +
>> +     memcpy(data, dln2->buf.rx.buf, data_len);
>> +
>> +     return data_len;
>> +}

Hmm, perhaps I am missing something, but we never transfer more then
data_len, where data_len is the size of the buffer supplied by the
user.

<snip>

>> +
>> +     platform_set_drvdata(pdev, dln2);
>> +
>> +     ret = device_create_file(dev, &dev_attr_freq);
>> +     if (ret < 0) {
>> +             dev_err(dev, "failed to add freq attribute\n");
>> +             return ret;
>> +     }
>
> There are a couple of problems here. First, you should not make this an
> attribute of the platform device, which is created before any driver is
> bound (might not ever happen).
>
> Instead add the attribute to the i2c adapter below. However, you need to
> do this using device attribute groups to avoid racing with userspace (as
> you are when using device_create_file after the device itself has been
> created).
>
> You should probably also make your attribute name less generic by adding
> a "dln2_"-prefix.

Thanks for the detailed review and explanations, as always :)
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
