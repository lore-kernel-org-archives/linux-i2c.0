From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v15 00/13] mux controller abstraction and iio/i2c muxes
Date: Sat, 3 Jun 2017 21:34:45 +0200
Message-ID: <20170603193445.GA18851@kroah.com>
References: <1494791476-14599-1-git-send-email-peda@lysator.liu.se>
 <20170603102627.GA24274@kroah.com>
 <CAExDi1QZsccMm_0v90Wx5Bxi7XYT_eNBWRJ51Neb8nWa4GD-+A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:37888 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750991AbdFCTew (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Sat, 3 Jun 2017 15:34:52 -0400
Content-Disposition: inline
In-Reply-To: <CAExDi1QZsccMm_0v90Wx5Bxi7XYT_eNBWRJ51Neb8nWa4GD-+A@mail.gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Peter Rosin <peda@lysator.liu.se>, open list <linux-kernel@vger.kernel.org>, Peter Rosin <peda@axentia.se>, Wolfram Sang <wsa@the-dreams.de>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Jonathan Corbet <corbet@lwn.net>, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-iio@vger.kernel.org, linux-doc@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Colin Ian King <colin.king@canonical.com>, Paul Gortmaker <paul.gortmaker@windriver.com>, Philipp Zabel <p.zabel@pengutronix.de>, kernel@pengutronix.de

On Sat, Jun 03, 2017 at 08:37:21PM +0200, Luc Van Oostenryck wrote:
> On Sat, Jun 3, 2017 at 12:26 PM, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> > On Sun, May 14, 2017 at 09:51:03PM +0200, Peter Rosin wrote:
> >> From: Peter Rosin <peda@axentia.se>
> >>
> >> Hi Greg,
> >>
> >> Philipp found problems in v14 with using a mutex for locking that was
> >> the outcome of the review for v13, so I'm now using a semaphore instead
> >> of the rwsem that was in v13. That at least got rid of the scary call
> >> to downgrade_write. However, I'm still unsure about what you actually
> >> meant with your comment about lack of sparse markings [1]. I did add
> >> __must_check to the funcs that selects the mux, but I've got this
> >> feeling that this is not what you meant?
> >
> > I thought there was a way to mark a function as requiring a lock be held
> > when it is being called.  Does sparse not support that anymore?
> 
> sparse still support these annotations, of course.
> In this case, I suppose you're talking about '__must_hold()' which
> *must* be used instead of a pair of '__releases()' + '__acquires()'
> when the lock is help on function entry and exit.

Ah, yes, that's what I was thinking of.  I don't know if sparse can
track things like this across an exported symbol, so I doubt it really
will help here.  Sorry for the noise.

thanks,

greg k-h
