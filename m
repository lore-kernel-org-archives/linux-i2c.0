From: Sudip Mukherjee <sudipm.mukherjee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 4/6] i2c-parport: use new parport device model
Date: Wed, 20 May 2015 22:44:52 +0530
Message-ID: <20150520171452.GA9069@sudip-PC>
References: <1432135622-8288-1-git-send-email-sudipm.mukherjee@gmail.com>
 <1432135622-8288-5-git-send-email-sudipm.mukherjee@gmail.com>
 <20150520154907.GB2001@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150520154907.GB2001@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Tim Waugh <tim-xbtOLCSHb9Lk1uMJSBkQmQ@public.gmane.org>, Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>, Willy Tarreau <willy-859RlTSWH48dnm+yROfE0A@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Alan Cox <gnomes-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devel-gWbeCf7V1WCQmaza687I9mD2FQJk+8+b@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Wed, May 20, 2015 at 05:49:07PM +0200, Wolfram Sang wrote:
> On Wed, May 20, 2015 at 08:57:00PM +0530, Sudip Mukherjee wrote:
> > Modify i2c-parport driver to use the new parallel port device model.
> > 
> > Tested-by: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
> > Signed-off-by: Sudip Mukherjee <sudip-ofJRbWXBVFamYgehrs7/Lw@public.gmane.org>
> > ---
> 
> In general:
> 
> Acked-by: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
> 
> >  static struct parport_driver i2c_parport_driver = {
> > -	.name	= "i2c-parport",
> > -	.attach	= i2c_parport_attach,
> > -	.detach	= i2c_parport_detach,
> > +	.name		= "i2c-parport",
> > +	.match_port	= i2c_parport_attach,
> > +	.detach		= i2c_parport_detach,
> > +	.devmodel	= true,
> 
> Minor nit: I prefer to not use tabs but a single space after the struct
> member names. Less hazzle in the future and still readable IMO.
It was having space originally. I changed that into tab as it was
looking good with them as aligned.
I will wait today for some more review and send v2 tomorrow with this
chanage.

regards
sudip
> 
