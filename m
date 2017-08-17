From: Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: Re: [RFC 2/5] i3c: Add core I3C infrastructure
Date: Thu, 17 Aug 2017 09:48:26 +0200
Message-ID: <20170817094826.2b9efcb8@bbrezillon>
References: <1501518290-5723-1-git-send-email-boris.brezillon@free-electrons.com>
        <1501518290-5723-3-git-send-email-boris.brezillon@free-electrons.com>
        <CAK8P3a06GoMdKdn=3Cq0FUwYnjGX0oG+FQLjxfiasVDpbonWRw@mail.gmail.com>
        <20170731231509.77d1fba4@bbrezillon>
        <CAK8P3a0p=m-8U7TN8usG8HO-QNu_S7rSfykNzu4gm+MOaM2Kzg@mail.gmail.com>
        <20170801142936.5df48702@bbrezillon>
        <CAK8P3a0SH4kWcvXK+_iPt9LWuNnpjr+omp+ZpyTLjT=H602n+w@mail.gmail.com>
        <20170801153414.6ce34ee8@bbrezillon>
        <20170801141218.GA1450@katana>
        <20170801164826.423183ff@bbrezillon>
        <20170801150108.GC1450@katana>
        <CAMuHMdXB0aU6mdaTw02Fz-9Mr+Ums4_SLmtDgi8b2gE75SsMVg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <CAMuHMdXB0aU6mdaTw02Fz-9Mr+Ums4_SLmtDgi8b2gE75SsMVg@mail.gmail.com>
Sender: linux-doc-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Wolfram Sang <wsa@the-dreams.de>, Arnd Bergmann <arnd@arndb.de>, Linux I2C <linux-i2c@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Przemyslaw Sroka <psroka@cadence.com>, Arkadiusz Golec <agolec@cadence.com>, Alan Douglas <adouglas@cadence.com>, Bartosz Folta <bfolta@cadence.com>, Damian Kos <dkos@cadence.com>, Alicja Jurasik-Urbaniak <alicja@cadence.com>, Jan Kotas <jank@cadence.com>, Cyprian Wronka <cwronka@cadence.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark
List-Id: linux-i2c@vger.kernel.org

Le Wed, 16 Aug 2017 23:03:55 +0200,
Geert Uytterhoeven <geert@linux-m68k.org> a écrit :

> On Tue, Aug 1, 2017 at 5:01 PM, Wolfram Sang <wsa@the-dreams.de> wrote:
> >> I'm perfectly fine with the I3C / I2C framework separation. The only
> >> minor problem I had with that was the inaccuracy of the
> >> sysfs/device-model representation: we don't have one i2c and one i3c
> >> bus, we just have one i3c bus with a mix of i2c and i3c devices.  
> >
> > I understand that. What if I2C had the same seperation between the "bus"
> > and the "master"?  
> 
> There can be multiple masters on an i2c bus.  But not on an i3c bus, due
> to SCL being push/pull.

I guess you mean there can't be a mix of I2C and I3C masters on the same
bus. Then yes, you're right, you can only connect I2C slaves on an I3C
bus, but I don't think Wolfram suggested this approach to support this
case.

Note that there can be multiple I3C masters on an I3C bus. When a
'secondary master' wants to become the current master it must ask the
permission to the 'current master' which can decide to ack or nack the
request.
As soon as the previous 'current master' accepted to release the bus it
should act as a slave and if it needs to reclaim the bus, it should ask
the new 'current master'.
