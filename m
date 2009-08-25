From: Rodolfo Giometti <giometti-AVVDYK/kqiJWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH 5/6] of_i2c.c: add method for binding devices behind
	multiplexer
Date: Tue, 25 Aug 2009 12:11:18 +0200
Message-ID: <20090825101118.GJ2039@gundam.enneenne.com>
References: <1251193020-25839-1-git-send-email-christian.herzig@keymile.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1251193020-25839-1-git-send-email-christian.herzig-SkAbAL50j+5BDgjK7y7TUQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Christian Herzig <christian.herzig-SkAbAL50j+5BDgjK7y7TUQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, chris-jmrfutXsf6TiB9QmIjCX8w@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Tue, Aug 25, 2009 at 11:37:00AM +0200, Christian Herzig wrote:
> export similar code-fragments into a separate method.
> 
> Signed-off-by: Christian Herzig <christian.herzig-SkAbAL50j+5BDgjK7y7TUQ@public.gmane.org>
> ---
>  drivers/of/of_i2c.c |  113 +++++++++++++++++++++++++++++++++-----------------
>  1 files changed, 74 insertions(+), 39 deletions(-)
> 
> diff --git a/drivers/of/of_i2c.c b/drivers/of/of_i2c.c

I don't know very well this code. Did you forward this modification to
its maintainer for proper review?

Ciao,

Rodolfo

-- 

GNU/Linux Solutions                  e-mail: giometti-AVVDYK/kqiJWk0Htik3J/w@public.gmane.org
Linux Device Driver                          giometti-k2GhghHVRtY@public.gmane.org
Embedded Systems                     phone:  +39 349 2432127
UNIX programming                     skype:  rodolfo.giometti
Freelance ICT Italia - Consulente ICT Italia - www.consulenti-ict.it
