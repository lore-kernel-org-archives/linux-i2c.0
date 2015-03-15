From: Nicholas Mc Guire <der.herr-kA1LtwSENNE@public.gmane.org>
Subject: Re: [PATCH v2] i2c: img-scb: fixup of wait_for_completion_timeout
	return handling
Date: Sun, 15 Mar 2015 11:12:18 +0100
Message-ID: <20150315101218.GA26183@opentech.at>
References: <1423494921-2708-1-git-send-email-hofrat@osadl.org> <20150315100118.GA6770@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150315100118.GA6770@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Nicholas Mc Guire <hofrat-Q945KHDl0DbYtjvyW6yDsg@public.gmane.org>, James Hogan <james.hogan-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>, Ezequiel Garcia <ezequiel.garcia-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>, Andrew Bresticker <abrestic-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Sun, 15 Mar 2015, Wolfram Sang wrote:

> On Mon, Feb 09, 2015 at 10:15:21AM -0500, Nicholas Mc Guire wrote:
> > Return type of wait_for_completion_timeout is unsigned long not int. 
> > Appropriately typed/named variable are added and assignment fixed up.
> > 
> > Signed-off-by: Nicholas Mc Guire <hofrat-Q945KHDl0DbYtjvyW6yDsg@public.gmane.org>
> > ---
> 
> Fixed variable name to 'time_left' and applied to for-next, thanks!
> 
thanks - in all of the new cleanups (I hope) the naming
has been considered.

thx!
hofrat
