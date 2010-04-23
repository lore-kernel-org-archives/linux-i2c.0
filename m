From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] i2c-algo-pca: fix all coding style issues in
 i2c-algo-pca.c
Date: Fri, 23 Apr 2010 10:13:56 +0200
Message-ID: <20100423101356.454abdd6@hyperion.delvare>
References: <1271877097-10939-1-git-send-email-farid.hammane@gmail.com>
	<20100422092524.77b7aa84@hyperion.delvare>
	<20100422075937.GN24384@pengutronix.de>
	<201004222330.34660.farid.hammane@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <201004222330.34660.farid.hammane-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Farid Hammane <farid.hammane-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, Enrik.Berkhan-JJi787mZWgc@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Farid,

On Thu, 22 Apr 2010 23:30:34 +0200, Farid Hammane wrote:
> Hi Jean and Wolfram,
> 
> On Thursday 22 April 2010 09:59:37 you wrote:
> > On Thu, Apr 22, 2010 at 09:25:24AM +0200, Jean Delvare wrote:
> > > On Thu, 22 Apr 2010 01:57:38 +0200, Wolfram Sang wrote:
> > > > Hi Farid,
> > > >
> > > > thanks for this approach. Have you checked that the binary is the same
> > > > before/after your patch? If so, please mention in your patch
> > > > description.
> 
> Ok, I think that nothing can be broken with this kind of patch. I just built 
> i2c-algo-pca.c and everything was ok.
> 
> For further patchs I will mention that it has been tested. Thanks for the 
> advice !

It's not just a matter of building it. When you only fix coding style
issue, the binary object before and after your patch should be exactly
the same. It's a good idea to verify this, especially for drivers you
aren't using yourself.

-- 
Jean Delvare
