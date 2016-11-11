From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH v4 00/14] ARM: dts: r8a779x: use demuxer for I2C
Date: Fri, 11 Nov 2016 09:20:21 +0100
Message-ID: <20161111082020.GA7252@verge.net.au>
References: <20161106202032.5227-1-wsa+renesas@sang-engineering.com>
 <20161109084406.GA22213@verge.net.au>
 <20161109085954.GA1807@katana>
 <20161109143508.GA19184@verge.net.au>
 <CAMuHMdU_eLmb2ET0KvUyQEfeeUK7Vy3mk6+=FSvczBhy8snvNA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAMuHMdU_eLmb2ET0KvUyQEfeeUK7Vy3mk6+=FSvczBhy8snvNA@mail.gmail.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Wolfram Sang <wsa@the-dreams.de>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Linux I2C <linux-i2c@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

On Wed, Nov 09, 2016 at 08:00:01PM +0100, Geert Uytterhoeven wrote:
> On Wed, Nov 9, 2016 at 3:35 PM, Simon Horman <horms@verge.net.au> wrote:
> >> Will you get access to these boards in the foreseeable future?
> >
> > As mentioned by Geert, there is a porter in Magnus's board farm.
> > Unforunately I have never had much luck in getting it to boot.
> 
> >From the point of view of the kernel, there's not much difference between
> Koelsch/Lager and Porter. The U-Boot is newer than the one on Lager,
> though, so no need for the "dtb" keyword in the bootz command.
> 
> I use:
> 
>     setenv ethaddr 2e:01:02:03:04:05
>     tftp 41000000 porter/zImage
>     tftp 40f00000 porter/r8a7791-porter.dtb
>     bootz 41000000 - 40f00000
> 
> Perhaps you didn't have the MAC address set?

I think the load addresses I was using may have been the problem.
In any case I seem to have things working now.
