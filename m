From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH v4 07/14] ARM: dts: koelsch: use demuxer for I2C4
Date: Wed, 16 Nov 2016 14:47:37 +0100
Message-ID: <20161116134736.GA20704@verge.net.au>
References: <20161106202032.5227-1-wsa+renesas@sang-engineering.com>
 <20161106202032.5227-8-wsa+renesas@sang-engineering.com>
 <CAMuHMdXzqakz6RYXFMOe5ps0SPsxDWHbOV024ts_E_qufVOutQ@mail.gmail.com>
 <20161115174450.GA21715@verge.net.au>
 <CAMuHMdVVqhZgTjaFiGgviCRD0X0DkQPZjpnta2FOhFmV7M+CvQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:34959 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752203AbcKPNrp (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Wed, 16 Nov 2016 08:47:45 -0500
Content-Disposition: inline
In-Reply-To: <CAMuHMdVVqhZgTjaFiGgviCRD0X0DkQPZjpnta2FOhFmV7M+CvQ@mail.gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Linux I2C <linux-i2c@vger.kernel.org>, Ulrich Hecht <ulrich.hecht+renesas@gmail.com>

On Wed, Nov 16, 2016 at 11:35:22AM +0100, Geert Uytterhoeven wrote:
> Hi Simon,
> 
> On Tue, Nov 15, 2016 at 6:44 PM, Simon Horman <horms@verge.net.au> wrote:
> >> i2c4 shares pins with vin0. Hence enabling the former breaks the latter:
> >>
> >>     sh-pfc e6060000.pfc: pin GP_4_13 already requested by
> >> e6520000.i2c; cannot claim for e6ef0000.video
> >>     sh-pfc e6060000.pfc: pin-141 (e6ef0000.video) status -22
> >>     sh-pfc e6060000.pfc: could not request pin 141 (GP_4_13) from
> >> group vin0_data24  on device sh-pfc
> >>     rcar-vin e6ef0000.video: Error applying setting, reverse things back
> >>     rcar-vin: probe of e6ef0000.video failed with error -22
> >>
> >> There may be similar issues on other boards. Haven't checked yet.
> >
> > Thanks, I will drop this patch for now.
> >
> > I checked the boot logs of other boards with similar patches and didn't see
> > anything there.
> 
> Do you have CONFIG_VIDEO_ADV7604=y?

No, mainly because its not in shmobile_defconfig.

I tried again with that option enabled and still didn't see
anything of interest in kernel log.

> I expect the issue to be present on gose, too. So far I didn't see it
> there, yet.
> But the vin DTS of gose is different from koelsch, causing vin0 not to be
> initialized?

It seems so.
