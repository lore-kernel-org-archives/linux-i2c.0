From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v9 6/9] i3c: master: Add driver for Cadence IP
Date: Fri, 26 Oct 2018 09:43:25 +0200
Message-ID: <CAK8P3a0WDRpukjDBm1rGPnZiH2FJRpquWhEknOBg=CphNOYOwg@mail.gmail.com>
References: <20181022133404.2061-1-boris.brezillon@bootlin.com>
 <20181022133404.2061-7-boris.brezillon@bootlin.com> <20181024202048.7e3534f7@bbrezillon>
 <CAK8P3a2DBgfvXs-9KzoDvbQpV+VN96xb7xHG-5=NDDgnt7ViVQ@mail.gmail.com>
 <20181025180720.1790f6a1@bbrezillon> <CAK8P3a02ELWiMB_pe0bzbsMfdqYOG1G0bFnSHzGu3ZbQHatH2w@mail.gmail.com>
 <20181025183005.3c0fa452@bbrezillon>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181025183005.3c0fa452@bbrezillon>
Sender: linux-kernel-owner@vger.kernel.org
To: Boris Brezillon <boris.brezillon@bootlin.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, Linux I2C <linux-i2c@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, gregkh <gregkh@linuxfoundation.org>, Przemyslaw Sroka <psroka@cadence.com>, Arkadiusz Golec <agolec@cadence.com>, Alan Douglas <adouglas@cadence.com>, Bartosz Folta <bfolta@cadence.com>, Damian Kos <dkos@cadence.com>, Alicja Jurasik-Urbaniak <alicja@cadence.com>, Cyprian Wronka <cwronka@cadence.com>, Suresh Punnoose <sureshp@cadence.com>, Rafal Ciepiela <rafalc@cadence.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@he>
List-Id: linux-i2c@vger.kernel.org

On Thu, Oct 25, 2018 at 6:30 PM Boris Brezillon
<boris.brezillon@bootlin.com> wrote:
> On Thu, 25 Oct 2018 18:13:51 +0200 Arnd Bergmann <arnd@arndb.de> wrote:
> On Thu, Oct 25, 2018 at 6:07 PM Boris Brezillon <boris.brezillon@bootlin.com> wrote:
> > > On Thu, 25 Oct 2018 17:30:26 +0200
> > > Arnd Bergmann <arnd@arndb.de> wrote:
> > > > On 10/24/18, Boris Brezillon <boris.brezillon@bootlin.com> wrote:
> > > > > On Mon, 22 Oct 2018 15:34:01 +0200
> > > I guess I could dynamically allocate the payload, but that requires
> > > going over all users of i3c_send_ccc_cmd() to patch them.
> >
> > This reminds me that Wolfram mentioned in his ELC talk that the
> > buffers on i3c should all be DMA capable to make life easier for
> > i3c master drivers that want to implement DMA transfers.
>
> And this is the case for all buffers passed to
> i3c_device_do_priv_xfers() (and soon i3c_device_send_hdr_cmd()),
> but I did not enforce that for the internal
> i3c_master_send_ccc_cmd_locked() helper, maybe I should...
> It was just convenient to place the object to be transmitted/received on
> the stack.

Ok. Is i3c_master_send_ccc_cmd_locked() what implements the public
interfaces then, or is this something else?

If you place a buffer on the stack, it is not DMA capable, but
it is guaranteed to be at least 32-bit word aligned, and should
not cause an exception in readsl(), unless it starts with a couple of
(not multiple of four)  extra bytes that are not sent to the devices.
Is that what happens here?

> > If we have buffers here that are not aligned to cache lines
> > (or even just 32 bit words), doesn't that also mean that the
> > same buffers are not DMA capable either?
>
> Yep, if it's not cache-line-aligned (and on the stack), it's not
> DMA-able.

This sounds like a more fundamental problem to solve first
then. Obviously it is incredibly /useful/ to be able to put short
i2c or i3c messages on the stack, but allowing that in general
also prevents the use of DMA without bounce buffers.

One way to address this might be to always bounce any
messages that are less than a cache line through a
(pre-)kmallocated buffer, and require any longer messages
to be cache capable. This could also solve the issue with
readsl(), but it would be a rather confusing user interface.

Another option might be to have separate interfaces for
"short" and "long" messages at the API level and have
distinct rules for those: short would always be bounced
by the i3c code, and long puts restrictions on the buffer
location.

       Arnd
