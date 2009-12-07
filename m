From: Rodolfo Giometti <giometti-AVVDYK/kqiJWk0Htik3J/w@public.gmane.org>
Subject: Re: Q: I2C multiplexer support
Date: Mon, 7 Dec 2009 10:56:24 +0100
Message-ID: <20091207095624.GC3647@enneenne.com>
References: <4B1CC5EA.7040902@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4B1CC5EA.7040902-Mmb7MZpHnFY@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Michael Lawnick <ml.lawnick-Mmb7MZpHnFY@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Delvare, Jean " <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Mon, Dec 07, 2009 at 10:07:54AM +0100, Michael Lawnick wrote:
> Hi,
> 
> on my current project I'm now at the point to have to implement
> multiplexer support. The last patch set from Rodolfo was for 2.6.29,
> most parts seem to have been integrated already in 2.6.31
> If I got it correctly the patch based on creating a mux folder with
> i2c-mux.c as a core file and then additional mux layer files.
> So my questions:
> Rodolfo, do you have a more resent patch set?

No.

> Jean, what are your plans about multiplexer support, where do you see
> open issues? Do you agree with current centralized layout or would you
> prefer independent single files integrating all necessary parts and
> residing in bus folder?

If Jean agree on my last rework I'm willing to do all whatever is
needed in order to finish this job and integrate this support into the
main line. :)

Ciao,

Rodolfo

-- 

GNU/Linux Solutions                  e-mail: giometti-AVVDYK/kqiJWk0Htik3J/w@public.gmane.org
Linux Device Driver                          giometti-k2GhghHVRtY@public.gmane.org
Embedded Systems                     phone:  +39 349 2432127
UNIX programming                     skype:  rodolfo.giometti
Freelance ICT Italia - Consulente ICT Italia - www.consulenti-ict.it
