From: Octavian Purdila <octavian.purdila@intel.com>
Subject: Re: [PATCH v3 2/3] i2c: add support for Diolan DLN-2 USB-I2C adapter
Date: Mon, 8 Sep 2014 18:57:29 +0300
Message-ID: <CAE1zot+R25OAu9d9WB2tOFqO9J9m-Vwo25msn6TD2HxseBTUzQ@mail.gmail.com>
References: <1409930279-1382-1-git-send-email-octavian.purdila@intel.com>
	<1409930279-1382-3-git-send-email-octavian.purdila@intel.com>
	<20140908144447.GD9560@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <20140908144447.GD9560@localhost>
Sender: linux-gpio-owner@vger.kernel.org
To: Johan Hovold <johan@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, wsa@the-dreams.de, Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Daniel Baluta <daniel.baluta@intel.com>, Laurentiu Palcu <laurentiu.palcu@intel.com>, linux-usb@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>, linux-gpio@vger.kernel.org, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Mon, Sep 8, 2014 at 5:44 PM, Johan Hovold <johan@kernel.org> wrote:

<snip>

Hi Johan,

Again, thanks for the detailed review, I am addressing your review
comments as we speak. Some questions below.

<snip>

> > +     int ret, len;
> > +     struct tx_data {
> > +             u8 port;
> > +             u8 addr;
> > +             u8 mem_addr_len;
> > +             __le32 mem_addr;
> > +             __le16 buf_len;
> > +             u8 buf[DLN2_I2C_MAX_XFER_SIZE];
> > +     } __packed tx;
>
> Allocate these buffers dynamically (possibly at probe).
>

I double checked this, and DLN2_I2C_MAX_XFER_SIZE should actually be <
64 as the USB endpoint configuration max packet size is 64. In this
case, can we keep it on the stack?

<snip>

> > +     int ret, buf_len, rx_len = sizeof(rx);
>
> Again, one declaration per line.
>

AFAICS there are many places where declaration on the same line
(initialization included) are used. When did this became a coding
style issue?


Thanks,
Tavi
