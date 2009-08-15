From: Rodolfo Giometti <giometti-AVVDYK/kqiJWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH] i2c pca954x: support channel selection in sysfs.
Date: Sat, 15 Aug 2009 09:37:03 +0200
Message-ID: <20090815073703.GA24114@gundam.enneenne.com>
References: <1250291420-15175-1-git-send-email-christian.herzig@keymile.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1250291420-15175-1-git-send-email-christian.herzig-SkAbAL50j+5BDgjK7y7TUQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Christian Herzig <christian.herzig-SkAbAL50j+5BDgjK7y7TUQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, chris-jmrfutXsf6TiB9QmIjCX8w@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Sat, Aug 15, 2009 at 01:10:19AM +0200, Christian Herzig wrote:
> I'm a newbie in kernel hacking, and also in programming. All beginnings are difficult, so let's go ;-)
> 
> As groundwork i'll take the patches from Rodolfo Giometti (git://git.enneenne.com/linux-i2c-mux).
> 
> My patch doesn't contains the last one from Rodolfo (http://gitweb.enneenne.com/?p=linux-i2c-mux;a=commit;h=c597d7a621f705e6d2a3db7a551655346872e46c). With Rodolfos patch, my kernel doesn't compile anymore. In all probability, it's a mistake by my side.

I have to update my patches to the latest kernel as weel. :)

> I've added a channel attribute to pca954x driver, because i'd like getting and setting the channel from userspace by the use of sysfs.

Why do you need it?

Ciao,

Rodolfo

-- 

GNU/Linux Solutions                  e-mail: giometti-AVVDYK/kqiJWk0Htik3J/w@public.gmane.org
Linux Device Driver                          giometti-k2GhghHVRtY@public.gmane.org
Embedded Systems                     phone:  +39 349 2432127
UNIX programming                     skype:  rodolfo.giometti
Freelance ICT Italia - Consulente ICT Italia - www.consulenti-ict.it
