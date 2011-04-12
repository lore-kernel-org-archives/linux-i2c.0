From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: Decode dimms on dual socket machines
Date: Tue, 12 Apr 2011 13:26:11 +0200
Message-ID: <20110412132611.045ace21@endymion.delvare>
References: <4DA4250A.3060907@fuckner.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4DA4250A.3060907-iWcS09LKDTLR7s880joybQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Michael Fuckner <michael-iWcS09LKDTLR7s880joybQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hallo Michael,

On Tue, 12 Apr 2011 12:10:18 +0200, Michael Fuckner wrote:
> I have a Dual-Socket Machine with Supermicro Motherboard (X8DTH-iF) and 
> I'd like to use decode-dimms, but it just decodes the modules on one 
> socket (dmidecode -t 17 and ipmitool sdr show all 6 modules on both 
> sockets).
> 
> 
> Does anybody have a clue how to access those other 3 modules?

Odds are that your SMBus is multiplexed and the other memory sockets
are connected to a different bus segment. Unfortunately there are
various ways to achieve multiplexing, this can't be detected
automatically and it is rarely documented in the board manual. So you
will have to ask the vendor for technical details on this point.
Multiplexing can be done through GPIO pins (either on the south bridge
or the Super-I/O chip) or with a chip on the SMBus itself.

Note that you will need a recent enough kernel (>= 2.6.36) to have
support for SMBus multiplexing.

> this is what I can see right now:
> test24:/media/i2c-tools # ./tools/i2cdetect 0
> WARNING! This program can confuse your I2C bus, cause data loss and worse!
> I will probe file /dev/i2c-0.
> I will probe address range 0x03-0x77.
> Continue? [Y/n]
>       0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> 00:          -- -- -- -- -- 08 -- -- -- -- -- -- --
> 10: -- -- -- -- -- -- -- -- UU -- UU -- UU -- -- --
> 20: -- -- -- -- -- -- -- -- -- -- -- -- -- -- 2e 2f
> 30: 30 -- 32 -- 34 -- -- -- -- -- -- -- -- -- 3e --
> 40: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
> 50: UU -- UU -- UU -- -- -- -- -- -- -- -- -- -- --
> 60: -- 61 62 -- -- -- -- -- -- 69 -- -- -- -- -- --
> 70: 70 -- -- -- -- -- -- --

FWIW, address 0x70 is used by the PCA954x multiplexers, so maybe this
is what you have (and a driver is available).

At 0x2f is probably a W83793 or W83795 monitoring chip, supported by
the w83793 and w83795 drivers, respectively. Only use these dedicated
drivers if you do not intend to use the IPMI features of the board.

> 18,1a,1c: jc42 temperature sensors
> 50,52,54: eeproms

-- 
Jean Delvare
http://khali.linux-fr.org/wishlist.html
