From: Jan Glauber <jan.glauber@caviumnetworks.com>
Subject: Re: [PATCH 4/4] i2c: xlp9xx: Add MAINTAINERS entry
Date: Tue, 22 May 2018 13:57:50 +0200
Message-ID: <20180522115750.GA9310@hc>
References: <1526454019-32714-1-git-send-email-george.cherian@cavium.com>
 <1526454019-32714-5-git-send-email-george.cherian@cavium.com>
 <20180522115414.473odncwfdpgmcz7@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180522115414.473odncwfdpgmcz7@ninjato>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: George Cherian <george.cherian@cavium.com>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, kamlakant.patel@cavium.com, mchehab+samsung@kernel.org, davem@davemloft.net, gregkh@linuxfoundation.org, akpm@linux-foundation.org, linus.walleij@linaro.org, rdunlap@infradead.org
List-Id: linux-i2c@vger.kernel.org

On Tue, May 22, 2018 at 01:54:14PM +0200, Wolfram Sang wrote:
> On Wed, May 16, 2018 at 12:00:19AM -0700, George Cherian wrote:
> > The i2c XLP9xx driver is maintained by Cavium.
> > Add George Cherian and Jan Glauber as the Maintainers.
> > 
> > Signed-off-by: George Cherian <george.cherian@cavium.com>
> > ---
> >  MAINTAINERS | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index df6e9bb..68da265 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -15509,6 +15509,14 @@ L:	linux-kernel@vger.kernel.org
> >  S:	Supported
> >  F:	drivers/char/xillybus/
> >  
> > +XLP9XX I2C DRIVER
> > +M:	George Cherian <george.cherian@cavium.com>
> > +M:	Jan Glauber <jglauber@cavium.com>
> 
> Jan, I need an explicit ACK from you for this change.
> 

Sure:
Acked-by: Jan Glauber <jglauber@cavium.com>

Cheers,
Jan
