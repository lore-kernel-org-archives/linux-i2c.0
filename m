From: Daniel Kurtz <djkurtz@chromium.org>
Subject: Re: [PATCH] i2c: i801: Drop needless bit-wise OR
Date: Fri, 3 Jun 2016 19:21:51 +0800
Message-ID: <CAGS+omAcKcJsW7dAMMa4mbw-S7jS632CniWCpRRNNB1ie-ew3Q@mail.gmail.com>
References: <20160525093702.64d7309c@endymion> <CAGS+omBnhpUYTXzooaZZgMChyepiAkSzt0-MxRe530=-bTyCsw@mail.gmail.com>
 <20160601113703.382c2a5f@endymion> <CAGS+omBWXdY7n58i=kMggVwH-1OHScU+u7COCnpCcSmdvQu_7Q@mail.gmail.com>
 <20160602134519.002f4776@endymion>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-it0-f53.google.com ([209.85.214.53]:35876 "EHLO
	mail-it0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752133AbcFCLWN (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Fri, 3 Jun 2016 07:22:13 -0400
Received: by mail-it0-f53.google.com with SMTP id f67so6372538ith.1
        for <linux-i2c@vger.kernel.org>; Fri, 03 Jun 2016 04:22:12 -0700 (PDT)
In-Reply-To: <20160602134519.002f4776@endymion>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jean Delvare <jdelvare@suse.de>
Cc: Linux I2C <linux-i2c@vger.kernel.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>

On Thu, Jun 2, 2016 at 7:45 PM, Jean Delvare <jdelvare@suse.de> wrote:
>
> On Wed, 1 Jun 2016 17:38:27 +0800, Daniel Kurtz wrote:
> > On Wed, Jun 1, 2016 at 5:37 PM, Jean Delvare <jdelvare@suse.de> wrote:
> > >
> > > Hi Daniel,
> > >
> > > On Mon, 30 May 2016 22:07:55 +0800, Daniel Kurtz wrote:
> > > > On Wed, May 25, 2016 at 3:37 PM, Jean Delvare <jdelvare@suse.de> wrote:
> > > > > The interrupt handling code makes it look like several status values
> > > > > may be merged together before being processed, while this will never
> > > > > happen. Change from bit-wise OR to simple assignment to make it more
> > > > > obvious and avoid misunderstanding.
> > > > >
> > > > > Signed-off-by: Jean Delvare <jdelvare@suse.de>
> > > > > Cc: Daniel Kurtz <djkurtz@chromium.org>
> > > > > Cc: Jarkko Nikula <jarkko.nikula@linux.intel.com>
> > > > > Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
> > > > > Cc: Wolfram Sang <wsa@the-dreams.de>
> > > > > ---
> > > > > Daniel, was there any reason for this bit-wise OR, which I may be
> > > > > missing?
> > > >
> > > > The only thing I can think of is that I didn't want to assume that we
> > > > would always clear priv->status before another interrupt arrived.
> > >
> > > Well my question is quite clear: can this actually happen? I can't see
> > > how.
> >
> > I have no idea.  You'd have to ask Intel, I guess.
>
> You wrote the code based on public documentation, I thought you would
> know. But if you can't be bothered, never mind, I'll trust my
> understanding of the code.

Here is the documentation:
http://www.intel.com/content/dam/doc/datasheet/io-controller-hub-6-datasheet.pdf
Page 570

I thought maybe there were situations where you could get INTR and an
error condition, but I don't see anything like that in the
documentation, so I think you are right and only one bit will be set
at a time.

Reviewed-by: Daniel Kurtz <djkurtz@chromium.org>


> --
> Jean Delvare
> SUSE L3 Support
