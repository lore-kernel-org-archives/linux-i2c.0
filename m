From: Alan Cox <alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>
Subject: Re: [PATCH] (RESEND #2)  i2c: prevent spurious interrupt
Date: Mon, 13 Feb 2012 23:45:32 +0000
Message-ID: <20120213234532.345d1ac5@pyramind.ukuu.org.uk>
References: <20120126161319.22798.6071.stgit@bob.linux.org.uk>
	<20120213232857.GI2999@freya.fluff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120213232857.GI2999-RazCHl0VsYgkUSuvROHNpA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Mon, 13 Feb 2012 23:28:57 +0000
Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org> wrote:

> On Thu, Jan 26, 2012 at 04:13:34PM +0000, Alan Cox wrote:
> > From: Kristen Carlson Accardi <kristen-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> > 
> > Don't call i2c_enable on resume because it causes a spurious
> > interrupt.
> > 
> > Signed-off-by:  Kristen Carlson Accardi <kristen-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> > Signed-off-by: Kirill A. Shutemov <kirill.shutemov-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> > Signed-off-by: Alan Cox <alan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> > ---
> 
> No-one seems to have decided to fix the title of this patch.

What wants fixing ?
