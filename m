From: Jean Delvare <jdelvare@suse.de>
Subject: Re: [PATCH] i2c: i801: Drop needless bit-wise OR
Date: Thu, 2 Jun 2016 13:45:19 +0200
Message-ID: <20160602134519.002f4776@endymion>
References: <20160525093702.64d7309c@endymion>
	<CAGS+omBnhpUYTXzooaZZgMChyepiAkSzt0-MxRe530=-bTyCsw@mail.gmail.com>
	<20160601113703.382c2a5f@endymion>
	<CAGS+omBWXdY7n58i=kMggVwH-1OHScU+u7COCnpCcSmdvQu_7Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:40252 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752966AbcFBLpX (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Thu, 2 Jun 2016 07:45:23 -0400
In-Reply-To: <CAGS+omBWXdY7n58i=kMggVwH-1OHScU+u7COCnpCcSmdvQu_7Q@mail.gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Daniel Kurtz <djkurtz@chromium.org>
Cc: Linux I2C <linux-i2c@vger.kernel.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>

On Wed, 1 Jun 2016 17:38:27 +0800, Daniel Kurtz wrote:
> On Wed, Jun 1, 2016 at 5:37 PM, Jean Delvare <jdelvare@suse.de> wrote:
> >
> > Hi Daniel,
> >
> > On Mon, 30 May 2016 22:07:55 +0800, Daniel Kurtz wrote:
> > > On Wed, May 25, 2016 at 3:37 PM, Jean Delvare <jdelvare@suse.de> wrote:
> > > > The interrupt handling code makes it look like several status values
> > > > may be merged together before being processed, while this will never
> > > > happen. Change from bit-wise OR to simple assignment to make it more
> > > > obvious and avoid misunderstanding.
> > > >
> > > > Signed-off-by: Jean Delvare <jdelvare@suse.de>
> > > > Cc: Daniel Kurtz <djkurtz@chromium.org>
> > > > Cc: Jarkko Nikula <jarkko.nikula@linux.intel.com>
> > > > Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
> > > > Cc: Wolfram Sang <wsa@the-dreams.de>
> > > > ---
> > > > Daniel, was there any reason for this bit-wise OR, which I may be
> > > > missing?
> > >
> > > The only thing I can think of is that I didn't want to assume that we
> > > would always clear priv->status before another interrupt arrived.
> >
> > Well my question is quite clear: can this actually happen? I can't see
> > how.
> 
> I have no idea.  You'd have to ask Intel, I guess.

You wrote the code based on public documentation, I thought you would
know. But if you can't be bothered, never mind, I'll trust my
understanding of the code.

-- 
Jean Delvare
SUSE L3 Support
