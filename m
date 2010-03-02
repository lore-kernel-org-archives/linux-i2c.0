From: Kevin Wells <kevin.wells-3arQi8VN3Tc@public.gmane.org>
Subject: RE: [PATCH] i2c-pnx: fix setting start/stop condition
Date: Tue, 2 Mar 2010 02:12:05 +0100
Message-ID: <083DF309106F364B939360100EC290F805CCF929E1@eu1rdcrdc1wx030.exi.nxp.com>
References: <1267446264-8446-1-git-send-email-l.fu@pengutronix.de>
 <083DF309106F364B939360100EC290F805CCF9294A@eu1rdcrdc1wx030.exi.nxp.com>
 <20100301191954.GA1811@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100301191954.GA1811-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Content-Language: en-US
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Luotao Fu <l.fu-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Vitaly Wool <vitalywool-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Julia Lawall <julia-dAYI7NvHqcQ@public.gmane.org>, Russell King <rmk+kernel-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


Hi Luotao,

> 
> I had a closer look into this and think that you are right. I was
> irritated by the unregular usage of start_bit and thought the stop bit is
> asserted with the i2c_pnx_stop call, which is apparently only used for
> zero sized transfers.
> 
> Fixed patch is attached with this mail.
> 

This latest patch seems to work fine and tests well with all our
I2C devices - including the pcf8563, which didn't work right before
this patch. I think it's good to go.

thanks!
Kevin

> cheers
> Luotao Fu
> --
> Pengutronix e.K.                           | Dipl.-Ing. Luotao Fu        |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  |
> Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
