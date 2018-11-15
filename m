From: Boris Brezillon <boris.brezillon@bootlin.com>
Subject: Re: [PATCH v10 0/9] Add the I3C subsystem
Date: Thu, 15 Nov 2018 20:07:39 +0100
Message-ID: <20181115200739.20b22d52@bbrezillon>
References: <20181026144333.12276-1-boris.brezillon@bootlin.com>
        <76b1d15d-232c-d8ba-5eba-8394e71be725@synopsys.com>
        <20181115135731.25f60990@bbrezillon>
        <CAK8P3a0gmCtMac7ctKZ3r=2Dxo03pYvuXkQ7c4Vnt9yMoLDMSQ@mail.gmail.com>
        <08a591ae-c75b-80b4-b608-ca92f6d932f9@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <08a591ae-c75b-80b4-b608-ca92f6d932f9@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
To: vitor <vitor.soares@synopsys.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Wolfram Sang <wsa@the-dreams.de>, Linux I2C <linux-i2c@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, gregkh <gregkh@linuxfoundation.org>, Przemyslaw Sroka <psroka@cadence.com>, Arkadiusz Golec <agolec@cadence.com>, Alan Douglas <adouglas@cadence.com>, Bartosz Folta <bfolta@cadence.com>, Damian Kos <dkos@cadence.com>, Alicja Jurasik-Urbaniak <alicja@cadence.com>, Cyprian Wronka <cwronka@cadence.com>, Suresh Punnoose <sureshp@cadence.com>, Rafal Ciepiela <rafalc@cadence.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>
List-Id: linux-i2c@vger.kernel.org

On Thu, 15 Nov 2018 15:25:11 +0000
vitor <vitor.soares@synopsys.com> wrote:

> Hi Arnd,
> 
> On 15/11/18 14:25, Arnd Bergmann wrote:
> > I agree about better not exposing the bus as a /dev/i3c* node, and that we
> > probably do need to expose individual devices in some form to allow
> > writing complete user space drivers that can do everything a kernel driver
> > can do.
> >
> > Can you describe what a low-level interface to the device looks like
> > in the kernel? Can this be abstracted as simply pread()/pwrite() plus
> > an interrupt mechanism, or do we need a set of ioctl() operations as
> > well?  
> 
> Like in i2c is likely to need the ioctl() too.

Yep, I think we'll need an ioctl given the various type of transfers
one case use to interact with a device.
