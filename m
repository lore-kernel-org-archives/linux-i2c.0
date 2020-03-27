From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH 6/6] drm/radeon: convert to use i2c_new_client_device()
Date: Fri, 27 Mar 2020 18:03:42 +0100
Message-ID: <20200327170342.GA5572@ravnborg.org>
References: <20200326211005.13301-1-wsa+renesas@sang-engineering.com>
 <20200326211005.13301-7-wsa+renesas@sang-engineering.com>
 <CADnq5_P07b-A-VawLTgiTMSdifxMbWS5kgQV_+0Bw2x_DQHATQ@mail.gmail.com>
 <20200327152535.GA2191@ravnborg.org>
 <CADnq5_O-pXK1FeT1NfGBdXYZbqF6jmyXJNPgJt5qLaYMLiZy_Q@mail.gmail.com>
 <20200327154509.GB3971@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from asavdk4.altibox.net ([109.247.116.15]:52188 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726515AbgC0RDr (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Fri, 27 Mar 2020 13:03:47 -0400
Content-Disposition: inline
In-Reply-To: <20200327154509.GB3971@ninjato>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Alex Deucher <alexdeucher@gmail.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, amd-gfx list <amd-gfx@lists.freedesktop.org>, David Airlie <airlied@linux.ie>, LKML <linux-kernel@vger.kernel.org>, Maling list - DRI developers <dri-devel@lists.freedesktop.org>, Linux I2C <linux-i2c@vger.kernel.org>, Alex Deucher <alexander.deucher@amd.com>, Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>

On Fri, Mar 27, 2020 at 04:45:09PM +0100, Wolfram Sang wrote:
> 
> > > > > Move away from the deprecated API.
> > > > >
> > > > > Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> > > >
> > > > patches 1,6, are:
> > > > Acked-by: Alex Deucher <alexander.deucher@amd.com>
> > > Should we commit all to drm-misc-next?
> > 
> > I'm fine to see it go through whatever tree makes sense.
> 
> I'd suggest drm-misc-next to minimize merge conflicts. But I can take it
> via I2C tree, too, if desired.

If no-one else speaks up until tomorrow I will land them in
drm-misc-next.
Just wanted to make sure it was OK.

	Sam
