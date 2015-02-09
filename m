From: Nicholas Mc Guire <der.herr-kA1LtwSENNE@public.gmane.org>
Subject: Re: [PATCH] i2c: img-scb: match return type of
	wait_for_completion_timeout
Date: Mon, 9 Feb 2015 15:57:17 +0100
Message-ID: <20150209145717.GA10012@opentech.at>
References: <1423401155-8955-1-git-send-email-hofrat@osadl.org> <20150209132204.GE2491@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150209132204.GE2491@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Nicholas Mc Guire <hofrat-Q945KHDl0DbYtjvyW6yDsg@public.gmane.org>, James Hogan <james.hogan-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>, Ezequiel Garcia <ezequiel.garcia-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>, Andrew Bresticker <abrestic-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Mon, 09 Feb 2015, Wolfram Sang wrote:

> On Sun, Feb 08, 2015 at 08:12:35AM -0500, Nicholas Mc Guire wrote:
> > Return type of wait_for_completion_timeout is unsigned long not int. ret in 
> > img_i2c_reset_bus() was exclusively used for wait_for_completion_timeout so 
> > its type is simply adjusted. In img_i2c_xfer an appropriately typed variable
> > is added and assignment fixed up.
> > 
> > Signed-off-by: Nicholas Mc Guire <hofrat-Q945KHDl0DbYtjvyW6yDsg@public.gmane.org>
> 
> Same as for the axxia driver: Please rename the variable because ret
> being an int is kind of an idiom.
>
added "don't break idioms" to my list of Checks - maybe something like this
even should be in SubmittingPatches ?

will fix up and resend.

thx!
hofrat
