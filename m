From: Sudip Mukherjee <sudipm.mukherjee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 0/6] use devicemodel with parport
Date: Mon, 1 Jun 2015 14:04:27 +0530
Message-ID: <20150601083427.GA7642@sudip-PC>
References: <1432135622-8288-1-git-send-email-sudipm.mukherjee@gmail.com>
 <20150531220530.GF13872@kroah.com>
 <20150601054651.GA23300@sudip-PC>
 <20150601061811.GA5103@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150601061811.GA5103-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Cc: Tim Waugh <tim-xbtOLCSHb9Lk1uMJSBkQmQ@public.gmane.org>, Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Willy Tarreau <willy-859RlTSWH48dnm+yROfE0A@public.gmane.org>, Alan Cox <gnomes-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>, devel-gWbeCf7V1WCQmaza687I9mD2FQJk+8+b@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Mon, Jun 01, 2015 at 03:18:11PM +0900, Greg Kroah-Hartman wrote:
> On Mon, Jun 01, 2015 at 11:16:51AM +0530, Sudip Mukherjee wrote:
> > On Mon, Jun 01, 2015 at 07:05:30AM +0900, Greg Kroah-Hartman wrote:
> > > On Wed, May 20, 2015 at 08:56:56PM +0530, Sudip Mukherjee wrote:
<snip>
> 
> > And then there are some pending bugs in bugzilla. I am also planning to
> > add the code for epst in paride (i saw in many forums that people are
> > not able to use their scanner on latest kernels).
> 
> "epst"?  What's that?
it was part of ppscsi, mainly needed to use HP scanjet 5100C. I had a
short look and it seems like the other parts of ppscsi are already there
in paride, but somehow epst was leftout and Tim says he is not interested
with that code now. And besides paride might get orphaned now, so there is
noone else to re-add that support in the newer kernels. My only hesitation
is that I donot have the scanner to test the code. :(

regards
sudip

> 
