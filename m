From: Boris Brezillon <boris.brezillon@bootlin.com>
Subject: Re: [PATCH v4 00/10] Add the I3C subsystem
Date: Mon, 30 Apr 2018 11:37:50 +0200
Message-ID: <20180430113750.002d384f@bbrezillon>
References: <20180330074751.25987-1-boris.brezillon@bootlin.com>
        <20180423193814.5c8ca75a@bbrezillon>
        <20180423175646.GA23210@kroah.com>
        <20180429133642.GC28913@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180429133642.GC28913@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Wolfram Sang <wsa@the-dreams.de>, Arnd Bergmann <arnd@arndb.de>
Cc: linux-i2c@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, Przemyslaw Sroka <psroka@cadence.com>, Arkadiusz Golec <agolec@cadence.com>, Alan Douglas <adouglas@cadence.com>, Bartosz Folta <bfolta@cadence.com>, Damian Kos <dkos@cadence.com>, Alicja Jurasik-Urbaniak <alicja@cadence.com>, Cyprian Wronka <cwronka@cadence.com>, Suresh Punnoose <sureshp@cadence.com>, Rafal Ciepiela <rafalc@cadence.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Vitor
List-Id: linux-i2c@vger.kernel.org

Hi Greg,

On Sun, 29 Apr 2018 15:36:42 +0200
Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> On Mon, Apr 23, 2018 at 07:56:46PM +0200, Greg Kroah-Hartman wrote:
> > On Mon, Apr 23, 2018 at 07:38:14PM +0200, Boris Brezillon wrote:  
> > > Hi,
> > > 
> > > On Fri, 30 Mar 2018 09:47:41 +0200
> > > Boris Brezillon <boris.brezillon@bootlin.com> wrote:
> > >   
> > > > This patch series is a proposal for a new I3C subsystem.  
> > > 
> > > This v4 has been sent almost a month ago and I didn't get any feedback
> > > so far apart from Rob's R-b. Greg, is there any chance we can get these
> > > patches merged in 4.18? If not, could you tell me what should be
> > > addressed/improved/reworked?  
> > 
> > I'll look over it later this week, thanks.  
> 
> At first glance, it would be great to have at least one other
> reviewed-by or signed-off-by on the main code here.  I don't want to be
> the only one to have to review it :)

I understand. Arnd, Wolfram, any chance you could spend some time
reviewing this patch series? I know Arnd is in vacation for the next few
weeks, so I don't expect him to be able to do that immediately. Also,
Wolfram stated that he didn't have time to review the series in details
when I submitted the v1, I don't know if things have changed since then.

Anyway, I'll keep searching for people to review the code.

Regards,

Boris
