From: Boris Brezillon <boris.brezillon@bootlin.com>
Subject: Re: [PATCH v4 03/10] i3c: Add sysfs ABI spec
Date: Mon, 30 Apr 2018 11:10:14 +0200
Message-ID: <20180430111014.49083a77@bbrezillon>
References: <20180330074751.25987-1-boris.brezillon@bootlin.com>
        <20180330074751.25987-4-boris.brezillon@bootlin.com>
        <20180429133700.GD28913@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180429133700.GD28913@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Przemyslaw Sroka <psroka@cadence.com>, Arkadiusz Golec <agolec@cadence.com>, Alan Douglas <adouglas@cadence.com>, Bartosz Folta <bfolta@cadence.com>, Damian Kos <dkos@cadence.com>, Alicja Jurasik-Urbaniak <alicja@cadence.com>, Cyprian Wronka <cwronka@cadence.com>, Suresh Punnoose <sureshp@cadence.com>, Rafal Ciepiela <rafalc@cadence.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>devi
List-Id: linux-i2c@vger.kernel.org

Hi Greg,

On Sun, 29 Apr 2018 15:37:00 +0200
Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> On Fri, Mar 30, 2018 at 09:47:44AM +0200, Boris Brezillon wrote:
> > Document sysfs files/directories/symlinks exposed by the I3C subsystem.
> > 
> > Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
> > ---
> > Changes in v2:
> > - new patch
> > ---
> >  Documentation/ABI/testing/sysfs-bus-i3c | 95 +++++++++++++++++++++++++++++++++
> >  1 file changed, 95 insertions(+)
> >  create mode 100644 Documentation/ABI/testing/sysfs-bus-i3c
> > 
> > diff --git a/Documentation/ABI/testing/sysfs-bus-i3c b/Documentation/ABI/testing/sysfs-bus-i3c
> > new file mode 100644
> > index 000000000000..5e88cc093e0e
> > --- /dev/null
> > +++ b/Documentation/ABI/testing/sysfs-bus-i3c
> > @@ -0,0 +1,95 @@
> > +What:		/sys/bus/i3c/devices/i3c-<bus-id>
> > +KernelVersion:  4.16  
> 
> Wrong kernel versions :)

I'll fix that.

Thanks,

Boris
