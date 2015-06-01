From: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Subject: Re: [PATCH 0/6] use devicemodel with parport
Date: Mon, 1 Jun 2015 15:18:11 +0900
Message-ID: <20150601061811.GA5103@kroah.com>
References: <1432135622-8288-1-git-send-email-sudipm.mukherjee@gmail.com>
 <20150531220530.GF13872@kroah.com>
 <20150601054651.GA23300@sudip-PC>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150601054651.GA23300@sudip-PC>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sudip Mukherjee <sudipm.mukherjee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Tim Waugh <tim-xbtOLCSHb9Lk1uMJSBkQmQ@public.gmane.org>, Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Willy Tarreau <willy-859RlTSWH48dnm+yROfE0A@public.gmane.org>, Alan Cox <gnomes-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>, devel-gWbeCf7V1WCQmaza687I9mD2FQJk+8+b@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Mon, Jun 01, 2015 at 11:16:51AM +0530, Sudip Mukherjee wrote:
> On Mon, Jun 01, 2015 at 07:05:30AM +0900, Greg Kroah-Hartman wrote:
> > On Wed, May 20, 2015 at 08:56:56PM +0530, Sudip Mukherjee wrote:
> > > After 5 versions of WIP, finally a patch submission.
> > > parport subsystem is now in the transition stage and supports the old
> > > model and the new device model. 3 of the drivers have been converted
> > > into new model and tested.
> > > After other drivers are converted we can remove the old code from
> > > parport.
> > 
> > This looks good, very nice job.
> Thanks, but its not me alone. Dan, Jean, Alan has helped me a lot in this.
> > 
> > Are you going to continue to fix up the other drivers?  I don't want us
> > to have a half-converted subsystem in the kernel.
> ofcourse yes. I also donot want to be a maintainer of half converted
> subsystem. :)
> i am thinking, after it is in the linux-next for a few days and seeing
> any effects of these changes I will start with the other drivers.
> and after all drivers are converted and that is also in next for sufficient
> days I will start with the cleanup of the old codes.

Sounds like a good plan.

> And then there are some pending bugs in bugzilla. I am also planning to
> add the code for epst in paride (i saw in many forums that people are
> not able to use their scanner on latest kernels).

"epst"?  What's that?
