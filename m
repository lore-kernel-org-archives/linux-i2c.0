From: Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH v14 00/11] mux controller abstraction and iio/i2c muxes
Date: Tue, 25 Apr 2017 18:32:57 +0200
Message-ID: <1493137977.2394.42.camel@pengutronix.de>
References: <1493022995-16917-1-git-send-email-peda@axentia.se>
         <1493031179.2446.9.camel@pengutronix.de>
         <2d978956-d247-917d-4150-a6723917a733@axentia.se>
         <1493043046.2446.37.camel@pengutronix.de>
         <6fb34ea5-edc8-c7aa-1d49-f6ce1d33a2d4@axentia.se>
         <1493045969.2446.47.camel@pengutronix.de>
         <f74d5619-8614-d003-3c70-710aee0b550b@axentia.se>
         <e53bbf82-793f-b22f-2e9b-4bd377446351@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <e53bbf82-793f-b22f-2e9b-4bd377446351-koto5C5qi+TLoDKTGw+V6w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter Rosin <peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org>
Cc: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Hartmut Knaack <knaack.h-Mmb7MZpHnFY@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Peter Meerwald-Stadler <pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org>, Jonathan Corbet <corbet-T1hC0tSOHrs@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Colin Ian King <colin.king-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>, Paul Gortmaker <paul.gortmaker-CWA4WttNNZF54TAoqtyWWQ@public.gmane.org>, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Tue, 2017-04-25 at 16:55 +0200, Peter Rosin wrote:
> On 2017-04-25 16:16, Peter Rosin wrote:
> > On 2017-04-24 16:59, Philipp Zabel wrote:
> >> On Mon, 2017-04-24 at 16:36 +0200, Peter Rosin wrote:
> >> [...]
> >>>> How about an atomic use_count on the mux_control, a bool shared that is
> >>>> only set by the first consumer, and controls whether selecting locks?
> >>>
> >>> That has the drawback that it is hard to restore the mux-control in a safe
> >>> way so that exclusive consumers are allowed after the last shared consumer
> >>> puts the mux away.
> >>
> >> True.
> >>
> >>> Agreed, it's a corner case, but I had this very similar
> >>> patch going through the compiler when I got this mail. Does it work as well
> >>> as what you suggested?
> >>
> >> Yes, this patch works just as well.
> > 
> > Right, as expected :-) However, I don't like it much. It divides the mux
> > consumers into two camps in a way that makes it difficult to select which
> > camp a consumer should be in.
> > 
> > E.g. consider the iio-mux. The current implementation only supports quick
> > accesses that fit the mux_control_get_shared case. But if that mux in the
> > future needs to grow continuous buffered accesses, I think there will be
> > pressure to switch it over to the exclusive mode. Because that is a lot
> > closer to what you are doing with the video-mux. And then what? It will be
> > impossible to predict if the end user is going to use buffered accesses or
> > not...
> > 
> > So, I think the best approach is to skip the distinction between shared
> > and exclusive consumers and instead implement the locking with an ordinary
> > semaphore (instead of the old rwsem or the current mutex). Semaphores don't
> > have the property that the same task should down/up them (mutexes require
> > that for lock/unlock, and is also the reason for the lockdep complaint) and
> > thus fits better for long-time use such as yours or the above iio-mux with
> > buffered accesses. It should also hopefully be cheaper that an rwsem, and
> > not have any downgrade_write calls thus possibly keeping Greg sufficiently
> > happy...

No idea whether this will placate Greg, but it does work for the
video-mux case.
The documentation for mux_control_(try_)select should mention that these
calls will hold the mux lock until deselect is called, and the
documentation for mux_control_select should probably mention that it
will block until the lock is released.

> > Sure, consumers can still dig themselves into a hole by not calling deselect
> > as they should, but at least I think it can be made to work w/o dividing the
> > consumers...
> 
> Like this (only compile-tested). Philipp, it should work the same as with
> the rwsem in v13 and earlier. At least for your case...

regards
Philipp

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
