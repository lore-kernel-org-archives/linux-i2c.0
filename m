From: Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>
Subject: Re: [PATCH 2/2] i2c: Add bus driver for for OSIF USB i2c device.
Date: Fri, 10 Jan 2014 20:21:48 +0100
Message-ID: <20140110192148.GN9681@lunn.ch>
References: <20140104222842.GF3150@katana>
 <1388980536-7588-1-git-send-email-andrew@lunn.ch>
 <1388980536-7588-2-git-send-email-andrew@lunn.ch>
 <20140109214930.GC3866@katana>
 <20140110180154.GK9681@lunn.ch>
 <20140110181647.GA3186@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140110181647.GA3186@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Emmanuel Deloget <logout-GANU6spQydw@public.gmane.org>, Barry Carter <barry.carter-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Wolfram

> > Hi Wolfgang
> 
> Wolfram

Upps, Sorry.

> > So is this a zero byte transfer? Is that not what i2cdetect does?
> 
> Yes, you can enforce it with -q. It will do it for some addresses
> automatically and complain if it is not available. So, seems to work,
> great!

O.K, i will double check and then add this to functions.

     Andrew 
