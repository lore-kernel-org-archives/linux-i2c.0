From: Peter Rosin <peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org>
Subject: Re: [PATCH v7 00/24] i2c mux cleanup and locking update
Date: Fri, 22 Apr 2016 07:54:12 +0000
Message-ID: <AM4PR02MB1299DD7DBCE30E8EFE9E1259BC6F0@AM4PR02MB1299.eurprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Language: sv-SE
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Peter Rosin <peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org>
Cc: "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Jonathan Corbet <corbet-T1hC0tSOHrs@public.gmane.org>, Peter Korsgaard <peter.korsgaard-ob4gmnvZ1/cAvxtiuMwx3w@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Hartmut Knaack <knaack.h-Mmb7MZpHnFY@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Peter Meerwald <pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org>, Antti Palosaari <crope-X3B1VOXEql0@public.gmane.org>, Mauro Carvalho Chehab <mchehab-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Frank Rowand <frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, "David S. Miller" <davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Kalle Valo <kvalo-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Jiri Slaby <jslaby-IBi9RG/b67k@public.gmane.org>, Daniel Baluta <daniel.baluta-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Lucas De Marchi <lucas.demarchi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Adriana Reus <adriana.reus-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Matt Ranostay <matt.ran>
List-Id: linux-i2c@vger.kernel.org

Hi Wolfram,

Wolfram Sang wrote:
> This was the diff of v6:
> 
> >  32 files changed, 1277 insertions(+), 915 deletions(-)
> 
> This is v7:
> 
> >  32 files changed, 1225 insertions(+), 916 deletions(-)
> 
> So, we gained a little overall. And while the individual drivers have a
> few lines more now, I still think it is more readable.
> 
> So, thanks for doing that!

Most, if not all, of these ~50 lines gained in v7 come from removing
i2c_mux_reserve_adapters and realloc. I.e., I think we might even have
lost a few lines with the i2c_mux_one_adapter removal, but not that many.
If the doc patch is taken out of the equation, we gain new functionality,
fix a bug and lose lines of code. Feels good!
However, this is not why I'm writing this message...

> I'll give people some time for testing. I'll have a further look, too.
> Hopefully, I can pick up patches 1-14 by the end of the week.

The reason for this message is that I just realized a couple of things.

First, you have suggested to merge patches 1-14 about now, and I assumed
that implied merging with Linus for 4.6, but on rereading I realize that
you have consistently targeted 4.7. I must be sloppy, and that had escaped
me. Is it really necessary to be that cautious? Maybe I'm overly confident,
but is 1-14 really such a big deal that it has to float in next for a whole
cycle?

The problem with waiting until 4.8 with the rest of the series is that it
will likely go stale, e.g. patch 22 ([media] rtl2832: change the i2c gate
to be mux-locked) touches a ton of register accesses in that driver since
it removes a regmap wrapper that is rendered obsolete. Expecting that
patch to work for 4.8 is overly optimistic, and while patching things up
is (probably) easy, it also renders any previous testing suspect.

That said, maybe I'm just impatient and reckless?

Second, should we not add 15-24 to the next branch now as well to get
testing going asap, even if we do not intend to merge it just yet or even
in that exact form? Or is that abusing the next branch?

Third, should we deprecate the old i2c_add_mux_adapter, so that new
users do not crop up behind our backs in the transition? Or not bother?

Fourth, I forgot to change patch 8 (iio: imu: inv_mpu6050: convert to
use an explicit i2c mux core) to not change i2c_get_clientdata() ->
dev_get_drvdata() as requested by Jonathan Cameron. How should I handle
that? There are also some new Tested-by tags that I have added to my
local branch but have not pushed anywhere. I'm ready to push all that
to a new branch once you are ready to take it.

Cheers,
Peter
