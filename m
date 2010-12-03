From: Rodolfo Giometti <giometti-AVVDYK/kqiJWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH 1/3] i2c i2c-mv64xxx: send repeated START between
 messages in xfer
Date: Fri, 3 Dec 2010 09:28:13 +0100
Message-ID: <20101203082813.GB3370@enneenne.com>
References: <1290787616-27106-1-git-send-email-giometti@linux.it>
 <20101203023020.GE20097@trinity.fluff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20101203023020.GE20097-SMNkleLxa3Z6Wcw2j4pizdi2O/JbrIOy@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Mark A. Greer" <mgreer-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Fri, Dec 03, 2010 at 02:30:20AM +0000, Ben Dooks wrote:
> On Fri, Nov 26, 2010 at 05:06:56PM +0100, Rodolfo Giometti wrote:
> > As stated into file include/linux/i2c.h we must send a repeated START
> > between messages in the same xfer groupset:
> 
> patch says 1/3, but only one turned up?

Yes, sorry. It was my mistake in numbering the patch. :'( This is the
only patch regarding this topic.

Ciao,

Rodolfo

-- 

GNU/Linux Solutions                  e-mail: giometti-AVVDYK/kqiJWk0Htik3J/w@public.gmane.org
Linux Device Driver                          giometti-k2GhghHVRtY@public.gmane.org
Embedded Systems                     phone:  +39 349 2432127
UNIX programming                     skype:  rodolfo.giometti
Freelance ICT Italia - Consulente ICT Italia - www.consulenti-ict.it
