From: Rodolfo Giometti <giometti-AVVDYK/kqiJWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH] i2c: support for hmc6343 3-Axis digital compass module.
Date: Thu, 9 Apr 2009 19:59:08 +0200
Message-ID: <20090409175908.GD7924@enneenne.com>
References: <1239290169-20393-1-git-send-email-giometti@enneenne.com> <20090409181435.7b55a861@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20090409181435.7b55a861-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Thu, Apr 09, 2009 at 06:14:35PM +0200, Jean Delvare wrote:
> On Thu,  9 Apr 2009 17:16:09 +0200, Rodolfo Giometti wrote:
> > From: Rodolfo Giometti <giometti-k2GhghHVRtY@public.gmane.org>
> > 
> > Signed-off-by: Rodolfo Giometti <giometti-k2GhghHVRtY@public.gmane.org>
> > ---
> >  drivers/i2c/chips/Kconfig   |   10 +
> >  drivers/i2c/chips/Makefile  |    1 +
> 
> Nack. Go read these files, thanks.

I see that note but this chip (IMHO) doesn't fit any already existing
categories... it's a compass module where should I add it? Maybe in
hwmon? But a compass or accelerometer doesn't monitor the
hardware at all... =:-o

Ciao,

Rodolfo

-- 

GNU/Linux Solutions                  e-mail: giometti-AVVDYK/kqiJWk0Htik3J/w@public.gmane.org
Linux Device Driver                          giometti-k2GhghHVRtY@public.gmane.org
Embedded Systems                     phone:  +39 349 2432127
UNIX programming                     skype:  rodolfo.giometti
