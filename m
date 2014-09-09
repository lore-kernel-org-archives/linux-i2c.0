From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v3 2/3] i2c: add support for Diolan DLN-2 USB-I2C adapter
Date: Tue, 9 Sep 2014 09:20:29 +0100
Message-ID: <20140909082029.GJ30307@lee--X1>
References: <1409930279-1382-1-git-send-email-octavian.purdila@intel.com>
 <1409930279-1382-3-git-send-email-octavian.purdila@intel.com>
 <20140908144447.GD9560@localhost>
 <CAE1zot+R25OAu9d9WB2tOFqO9J9m-Vwo25msn6TD2HxseBTUzQ@mail.gmail.com>
 <20140908163058.GF9560@localhost>
 <CAE1zotJomxwAJA3aXm9MHnHd5Pg9V=K7XaptOPWkArV0jio4DQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAE1zotJomxwAJA3aXm9MHnHd5Pg9V=K7XaptOPWkArV0jio4DQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Octavian Purdila <octavian.purdila@intel.com>
Cc: Johan Hovold <johan@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, wsa@the-dreams.de, Samuel Ortiz <sameo@linux.intel.com>, Arnd Bergmann <arnd@arndb.de>, Daniel Baluta <daniel.baluta@intel.com>, Laurentiu Palcu <laurentiu.palcu@intel.com>, linux-usb@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>, linux-gpio@vger.kernel.org, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Mon, 08 Sep 2014, Octavian Purdila wrote:

> On Mon, Sep 8, 2014 at 7:30 PM, Johan Hovold <johan@kernel.org> wrote=
:
> > On Mon, Sep 08, 2014 at 06:57:29PM +0300, Octavian Purdila wrote:
> >> On Mon, Sep 8, 2014 at 5:44 PM, Johan Hovold <johan@kernel.org> wr=
ote:
> >>
> >> <snip>
> >>
> >> Hi Johan,
> >>
> >> Again, thanks for the detailed review, I am addressing your review
> >> comments as we speak. Some questions below.
> >>
> >> <snip>
> >>
> >> > > +     int ret, len;
> >> > > +     struct tx_data {
> >> > > +             u8 port;
> >> > > +             u8 addr;
> >> > > +             u8 mem_addr_len;
> >> > > +             __le32 mem_addr;
> >> > > +             __le16 buf_len;
> >> > > +             u8 buf[DLN2_I2C_MAX_XFER_SIZE];
> >> > > +     } __packed tx;
> >> >
> >> > Allocate these buffers dynamically (possibly at probe).
> >> >
> >>
> >> I double checked this, and DLN2_I2C_MAX_XFER_SIZE should actually =
be <
> >> 64 as the USB endpoint configuration max packet size is 64. In thi=
s
> >> case, can we keep it on the stack?
> >
> > It's better to lift that restriction and allocate it dynamically. U=
sing
> > larger buffers (> EP size) is also more efficient.
> >
> >> <snip>
> >>
> >> > > +     int ret, buf_len, rx_len =3D sizeof(rx);
> >> >
> >> > Again, one declaration per line.
> >>
> >> AFAICS there are many places where declaration on the same line
> >> (initialization included) are used. When did this became a coding
> >> style issue?
> >
> > It's ugly, hurts readability, and can also obfuscate the fact that =
your
> > function really needs to be refactored.
> >
> > And it's in the CodingStyle:
> >
> >         "To this end, use just one data declaration per line (no co=
mmas
> >         for multiple data declarations)."
> >
>=20
> OK, I always thought that was for when declaring structures/unions.
> Just one more question on this subject: is the following allowed:
>=20
> int ret, len;
>=20
> or should it be:
>=20
> int ret;
> int len;

Common sense usually prevails here.  I sometimes bunch up the really
simple/obvious/throw-away variables like; i, j, k, ret, val etc,
especially when there are a lot of variables in use, but it's nicer to
see the less used, more complex ones on separate lines.

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
