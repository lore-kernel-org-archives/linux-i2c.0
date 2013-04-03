From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH 3/3] watchdog: Add Congatec CGEB watchdog driver
Date: Wed, 3 Apr 2013 17:16:54 +0200
Message-ID: <20130403151654.GY1906@pengutronix.de>
References: <1360663374-30951-1-git-send-email-s.hauer@pengutronix.de>
 <1360663374-30951-4-git-send-email-s.hauer@pengutronix.de>
 <CAH9NwWd7YdtK0urutisVgKoE7NmPFLpG3wFG5W6P7o45vUqAng@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAH9NwWd7YdtK0urutisVgKoE7NmPFLpG3wFG5W6P7o45vUqAng@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Christian Gmeiner <christian.gmeiner@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, x86@kernel.org, linux-i2c@vger.kernel.org, linux-watchdog@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-i2c@vger.kernel.org

On Tue, Mar 26, 2013 at 11:16:35AM +0100, Christian Gmeiner wrote:
> 2013/2/12 Sascha Hauer <s.hauer@pengutronix.de>:
> > --
> 
> There seems to be a problem:
> 
> Mar 26 16:11:25 OT kernel: [   80.207514] cgeb-watchdog
> cgeb-watchdog.0: registered
> Mar 26 16:11:38 OT watchdog[2519]: stopping daemon (5.9)
> Mar 26 16:11:43 OT watchdog[2750]: starting daemon (5.9):
> Mar 26 16:11:43 OT watchdog[2750]: int=1s realtime=yes sync=no soft=no
> mla=0 mem=0
> Mar 26 16:11:43 OT watchdog[2750]: ping: no machine to check
> Mar 26 16:11:43 OT watchdog[2750]: file: no file to check
> Mar 26 16:11:43 OT watchdog[2750]: pidfile: no server process to check
> Mar 26 16:11:43 OT watchdog[2750]: interface: no interface to check
> Mar 26 16:11:43 OT watchdog[2750]: test=none(0) repair=none(0)
> alive=/dev/watchdog heartbeat=none temp=none to=root no_act=no
> Mar 26 16:11:43 OT watchdog[2750]: cannot set timeout 60 (errno = 95 =
> 'Operation not supported')

As mentioned in my other mail the watchdog core no longer sets
wdd->timeout which results in the above message. Should be fixed
with the next version.

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
