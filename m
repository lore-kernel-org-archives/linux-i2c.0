From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: Re: [PATCH 1/4] parport: modify parport subsystem to use devicemodel
Date: Wed, 15 Apr 2015 15:58:04 +0530
Message-ID: <20150415102804.GA3803@sudip-PC>
References: <1429084124-2271-1-git-send-email-sudipm.mukherjee@gmail.com>
 <1429084124-2271-2-git-send-email-sudipm.mukherjee@gmail.com>
 <20150415082746.GI10964@mwanda>
 <20150415092055.GA3198@sudip-PC>
 <20150415094500.GZ16501@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150415094500.GZ16501@mwanda>
Sender: linux-doc-owner@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Jean Delvare <jdelvare@suse.de>, Wolfram Sang <wsa@the-dreams.de>, Willy Tarreau <willy@meta-x.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, linux-i2c@vger.kernel.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Wed, Apr 15, 2015 at 12:45:00PM +0300, Dan Carpenter wrote:
> On Wed, Apr 15, 2015 at 02:50:55PM +0530, Sudip Mukherjee wrote:
> > <snip>
> > > > +	tmp->name = name;
> > > 
> > > I wonder who frees this name variable.  My concern is that it gets
> > > freed before we are done using it or something.  (I have not looked at
> > > the details).
> > it will be done in free_port() the release callback of parport device.
> 
> That doesn't work.  Some of the callers pass a string literal.
oops, when i replied to your first mail about this I looked at
parport_register_port(), but the one that you have mentioned is the one
I gave in parport_register_dev() and it seems that the name is not freed
anywhere except the driver that has called parport_register_device() or
parport_register_dev(). I think I should better copy it and then give it
to tmp->name and free it also in the unregister function. And this should
be fixed in the original parport_register_device() also.
I will wait for some more reviews send the v2 series tomorrow.

regards
sudip

> 
> regards,
> dan carpenter
> 
