From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 1/2] i2c: piix4: Use request_muxed_region
Date: Mon, 26 Feb 2018 12:37:29 -0800
Message-ID: <20180226203729.GA28554@roeck-us.net>
References: <1514652658-6228-1-git-send-email-linux@roeck-us.net>
 <20180212111041.027edd85@endymion>
 <20180212185152.GA20877@roeck-us.net>
 <20180214152305.57b76ea5@endymion>
 <20180226195521.vs32bemg7iopkjvd@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180226195521.vs32bemg7iopkjvd@ninjato>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Jean Delvare <jdelvare@suse.de>, =?iso-8859-1?B?Wm9sdOFuIEL2c3r2cm3pbnlp?= <zboszor@pr.hu>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Mon, Feb 26, 2018 at 08:55:21PM +0100, Wolfram Sang wrote:
> On Wed, Feb 14, 2018 at 03:23:05PM +0100, Jean Delvare wrote:
> > On Mon, 12 Feb 2018 10:51:52 -0800, Guenter Roeck wrote:
> > > On Mon, Feb 12, 2018 at 11:10:41AM +0100, Jean Delvare wrote:
> > > > On Sat, 30 Dec 2017 08:50:57 -0800, Guenter Roeck wrote:  
> > > > > @@ -298,12 +295,15 @@ static int piix4_setup_sb800(struct pci_dev *PIIX4_dev,
> > > > >  	else
> > > > >  		smb_en = (aux) ? 0x28 : 0x2c;
> > > > >  
> > > > > -	mutex_lock(&piix4_mutex_sb800);
> > > > > +	if (!request_muxed_region(SB800_PIIX4_SMB_IDX, 2, "sb800_piix4_smb"))
> > > > > +		return -EBUSY;  
> > > > 
> > > > This would happen if and only if another driver has requested the
> > > > region already but without IORESOURCE_MUXED, right? Don't you want to  
> > > 
> > > Or if its call to alloc_resource() fails.
> > 
> > OK, two things which are not supposed to happen, so failing is the
> > right thing to do.
> > 
> > > > write an error message then? I don't think request_muxed_region() will
> > > > do, and probe failing with -EBUSY but no error message logged would be
> > > > hard to diagnose.
> > >
> > > NP, though the analysis is quite simple - /proc/iomem will show the culprit.
> > 
> > I'm confused. How would the user know what to look for in /proc/iomem
> > (or, I believe, /proc/ioports actually) if the driver does not print
> > which resource allocation failed?
> > 
> > If the information is already printed somewhere, then I agree there's no
> > point adding a message. But from the code I could not find it.
> 
> I don't see any ack or rev from Jean, so I guess there are open issues?
> 
I was suppopsed to send v2, and I had prepared it, but it looks like I forgot
to actually send it out. I'll try to do that today.

Guenter
