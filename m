From: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Subject: Re: [PATCH] i2c: mux: create proper topology in sysfs
Date: Wed, 5 Nov 2014 06:26:31 -0800
Message-ID: <20141105142631.GB23392@roeck-us.net>
References: <1414960809-16860-1-git-send-email-wsa@the-dreams.de>
 <20141103205534.GA18937@roeck-us.net>
 <20141103210200.GA6242@katana>
 <20141103224908.GA18594@roeck-us.net>
 <20141104143309.GA12933@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20141104143309.GA12933@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Gerlando Falauto <gerlando.falauto-SkAbAL50j+5BDgjK7y7TUQ@public.gmane.org>, Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>, Martin Belanger <martin.belanger-Ir6+u9MVKBtBDgjK7y7TUQ@public.gmane.org>, Rodolfo Giometti <giometti-AVVDYK/kqiJWk0Htik3J/w@public.gmane.org>, Michael Lawnick <ml.lawnick-Mmb7MZpHnFY@public.gmane.org>, Jeroen De Wachter <jeroen.de.wachter-CNXmb7IdZIWZIoH1IeqzKA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Tue, Nov 04, 2014 at 03:33:09PM +0100, Wolfram Sang wrote:
> 
> > Ok, I think I know the problem. In my case, the parent adapter
> > and the mux device are the same (since both are on the same chip
> > and the mux is really merged into the i2c controller).
> > 
> > I'll have to figure out how to fix that.
> 
> Maybe something like this on top helps already? It skips link creation
> if the parent device is the parent i2c adapter. We should have this
> anyway...
> 
It fixes the tracebacks, but application code still fails. I'll have to track
that down; most likely it uses a means to find the i2c root adapter which no
longer works. I'll also try your other patch.

Guenter
