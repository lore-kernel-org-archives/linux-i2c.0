From: Jean Delvare <jdelvare@suse.de>
Subject: Re: [PATCH] i2c: i801: Drop needless bit-wise OR
Date: Wed, 1 Jun 2016 11:37:03 +0200
Message-ID: <20160601113703.382c2a5f@endymion>
References: <20160525093702.64d7309c@endymion>
	<CAGS+omBnhpUYTXzooaZZgMChyepiAkSzt0-MxRe530=-bTyCsw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:60816 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757681AbcFAJhG (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Wed, 1 Jun 2016 05:37:06 -0400
In-Reply-To: <CAGS+omBnhpUYTXzooaZZgMChyepiAkSzt0-MxRe530=-bTyCsw@mail.gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Daniel Kurtz <djkurtz@chromium.org>
Cc: Linux I2C <linux-i2c@vger.kernel.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>

Hi Daniel,

On Mon, 30 May 2016 22:07:55 +0800, Daniel Kurtz wrote:
> On Wed, May 25, 2016 at 3:37 PM, Jean Delvare <jdelvare@suse.de> wrote:
> > The interrupt handling code makes it look like several status values
> > may be merged together before being processed, while this will never
> > happen. Change from bit-wise OR to simple assignment to make it more
> > obvious and avoid misunderstanding.
> >
> > Signed-off-by: Jean Delvare <jdelvare@suse.de>
> > Cc: Daniel Kurtz <djkurtz@chromium.org>
> > Cc: Jarkko Nikula <jarkko.nikula@linux.intel.com>
> > Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
> > Cc: Wolfram Sang <wsa@the-dreams.de>
> > ---
> > Daniel, was there any reason for this bit-wise OR, which I may be
> > missing?
> 
> The only thing I can think of is that I didn't want to assume that we
> would always clear priv->status before another interrupt arrived.

Well my question is quite clear: can this actually happen? I can't see
how.

> >  drivers/i2c/busses/i2c-i801.c |    2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > --- linux-4.5.orig/drivers/i2c/busses/i2c-i801.c        2016-05-24 11:04:33.169026906 +0200
> > +++ linux-4.5/drivers/i2c/busses/i2c-i801.c     2016-05-24 11:05:40.564642488 +0200
> > @@ -548,7 +548,7 @@ static irqreturn_t i801_isr(int irq, voi
> >         status &= SMBHSTSTS_INTR | STATUS_ERROR_FLAGS;
> >         if (status) {
> >                 outb_p(status, SMBHSTSTS(priv));
> > -               priv->status |= status;
> > +               priv->status = status;
> >                 wake_up(&priv->waitq);
> >         }

-- 
Jean Delvare
SUSE L3 Support
