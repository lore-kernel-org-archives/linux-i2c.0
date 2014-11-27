From: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: Freeze of mouse and keyboard after suspend due to i2c-designware
Date: Thu, 27 Nov 2014 18:40:46 +0200
Message-ID: <20141127164046.GL1304@lahna.fi.intel.com>
References: <54724D46.6040501@bluewin.ch>
 <54772BA0.200@bluewin.ch>
 <20141127142942.GD3230@katana>
 <20141127144913.GE1304@lahna.fi.intel.com>
 <547751E3.3060104@bluewin.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <547751E3.3060104-goEDY2E6dbVyDzI6CaY1VQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Prof. H.-M. Hoogewoud" <hhoogewoud-goEDY2E6dbVyDzI6CaY1VQ@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Romain Baeriswyl <Romain.Baeriswyl-ux6zf3SgZrrQT0dZR+AlfA@public.gmane.org>, "Du, Wenkai" <wenkai.du-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Tan, Raymond" <raymond.tan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Thu, Nov 27, 2014 at 05:31:31PM +0100, Prof. H.-M. Hoogewoud wrote:
> Hello,
> 
> The crash result during resume and happen while suspending to disk and mem.
> During resume I can see the screen and the login dialog, but keyboard, mous,
> touchscreen and touchpad are frozen. Caps lock does not work!

OK.

Can you run 'dmesg > /to/some/file && sync' from your resume script,
then reboot the machine and send me the resulting file?
