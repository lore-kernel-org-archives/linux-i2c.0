From: "Herzig, Christian" <Christian.Herzig-SkAbAL50j+5BDgjK7y7TUQ@public.gmane.org>
Subject: RE: [PATCH] i2c pca954x: support channel selection in sysfs.
Date: Mon, 17 Aug 2009 10:10:08 +0200
Message-ID: <D839955AA28B9A42A61B9181506E27C401B336A7@SRVCHBER1212.ch.keymile.net>
References: <1250291420-15175-1-git-send-email-christian.herzig@keymile.com> <20090815073703.GA24114@gundam.enneenne.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-class: urn:content-classes:message
In-Reply-To: <20090815073703.GA24114-h5F9bMWSfx92wUeKyQHPq0EOCMrvLtNR@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: giometti-AVVDYK/kqiJWk0Htik3J/w@public.gmane.org, chris-jmrfutXsf6TiB9QmIjCX8w@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Rodolfo,

Do I have problems with subscribing linux-i2c mailing list if my
messages are not published?

The need of setting and getting the channel out of the shell is for
debugging use only. Ok, if everything works properly, this is an
unessential attribute. I thought, maybe someone else is also interested,
so I _tried_ to publish this patch to Linux-i2c. Another reason, why
I've published this patch is, getting feedback from Linux community -
what is good, what is amiss, how implementation is better...

My plan is, loading adapters and devices on the basis of a flattened
device tree (Documentation/powerpc/booting-without-of.txt). At the time,
I don't know where to tackle this problem. Any hints for me?

Christian

-----Original Message-----
From: giometti-AVVDYK/kqiJWk0Htik3J/w@public.gmane.org [mailto:giometti-AVVDYK/kqiJWk0Htik3J/w@public.gmane.org] 
Sent: Saturday, August 15, 2009 9:37 AM
To: Herzig, Christian
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; chris-jmrfutXsf6TiB9QmIjCX8w@public.gmane.org
Subject: Re: [PATCH] i2c pca954x: support channel selection in sysfs.

On Sat, Aug 15, 2009 at 01:10:19AM +0200, Christian Herzig wrote:
> I'm a newbie in kernel hacking, and also in programming. All
beginnings are difficult, so let's go ;-)
> 
> As groundwork i'll take the patches from Rodolfo Giometti
(git://git.enneenne.com/linux-i2c-mux).
> 
> My patch doesn't contains the last one from Rodolfo
(http://gitweb.enneenne.com/?p=linux-i2c-mux;a=commit;h=c597d7a621f705e6
d2a3db7a551655346872e46c). With Rodolfos patch, my kernel doesn't
compile anymore. In all probability, it's a mistake by my side.


I have to update my patches to the latest kernel as weel. :)

> I've added a channel attribute to pca954x driver, because i'd like
getting and setting the channel from userspace by the use of sysfs.

Why do you need it?

Ciao,

Rodolfo

-- 

GNU/Linux Solutions                  e-mail: giometti-AVVDYK/kqiJWk0Htik3J/w@public.gmane.org
Linux Device Driver                          giometti-k2GhghHVRtY@public.gmane.org
Embedded Systems                     phone:  +39 349 2432127
UNIX programming                     skype:  rodolfo.giometti
Freelance ICT Italia - Consulente ICT Italia - www.consulenti-ict.it
