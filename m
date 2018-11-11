From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v10 0/9] Add the I3C subsystem
Date: Sun, 11 Nov 2018 09:39:32 -0800
Message-ID: <20181111173932.GA12254@kroah.com>
References: <20181026144333.12276-1-boris.brezillon@bootlin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181026144333.12276-1-boris.brezillon@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Boris Brezillon <boris.brezillon@bootlin.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Przemyslaw Sroka <psroka@cadence.com>, Arkadiusz Golec <agolec@cadence.com>, Alan Douglas <adouglas@cadence.com>, Bartosz Folta <bfolta@cadence.com>, Damian Kos <dkos@cadence.com>, Alicja Jurasik-Urbaniak <alicja@cadence.com>, Cyprian Wronka <cwronka@cadence.com>, Suresh Punnoose <sureshp@cadence.com>, Rafal Ciepiela <rafalc@cadence.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>devi
List-Id: linux-i2c@vger.kernel.org

On Fri, Oct 26, 2018 at 04:43:24PM +0200, Boris Brezillon wrote:
> Hi Greg,
> 
> I think we've reached a point where we can eventually consider the I3C
> framework for inclusion in 4.20 (5.0?). A few more issues were reported
> on v9 and fixed in v10. I can't guarantee that the implementation is
> free of bugs but I still think it's worth merging it in v4.20: it's a
> new subsystem, so we don't risk regressions, and the only way we can
> detect other issues is by having other people experiment with this
> implementation.
> 
> The only remaining concern raised by Arnd is the fact that both hosts
> and slaves share the same bus type and are differentiated thanks to
> their device_type, which IMHO is fine since this is what other
> subsystems do (plus I don't see other solutions to have both I3C
> devices and I3C buses represented under /sys/bus/i3c/).

Yeah, it's not the nicest, but it will work, we did it also for USB and
greybus and it solves the issue.

This all looks good to me, so I've queued it up.  Let's see if
linux-next has any problems with it.  Thanks for sticking with it, nice
work!

greg k-h
