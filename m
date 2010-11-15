From: Rodolfo Giometti <giometti-AVVDYK/kqiJWk0Htik3J/w@public.gmane.org>
Subject: I2C controller i2c-mv64xxx.c not compliant
Date: Mon, 15 Nov 2010 15:54:07 +0100
Message-ID: <20101115145406.GE3372@enneenne.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: mgreer-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mauro Barella <mbarella-RSoB1PSltFvQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hello,

I'm using a ltc4266 (PoE chip) with the Marvell i2c controller (CPU
Feroceon 88FR131).

The ltc4266 wants a repeated START during a write/read sequence,
i.e. in order to read a register with the following messages:

        u8 reg = <address>;
	u8 val;
        struct i2c_msg msg[] = {
                { client->addr, 0, 1, &reg },
                { client->addr, I2C_M_RD, 1, &val },
        };

the master _must_ send a repeated START at beginning of the read
message otherwise the ltc4266 will reset its internal address register
and the master will read the register 0x00 each time!

Looking at the code the i2c-mv64xxx.c driver sends a STOP at each
message's end, but into the file include/linux/i2c.h is stated:

 * Except when I2C "protocol mangling" is used, all I2C adapters implement
 * the standard rules for I2C transactions.  Each transaction begins with a
 * START.  That is followed by the slave address, and a bit encoding read
 * versus write.  Then follow all the data bytes, possibly including a byte
 * with SMBus PEC.  The transfer terminates with a NAK, or when all those
 * bytes have been transferred and ACKed.  If this is the last message in a
 * group, it is followed by a STOP.  Otherwise it is followed by the next
 * @i2c_msg transaction segment, beginning with a (repeated) START.

Any suggestions in order to fix it?

Ciao,

Rodolfo

-- 

GNU/Linux Solutions                  e-mail: giometti-AVVDYK/kqiJWk0Htik3J/w@public.gmane.org
Linux Device Driver                          giometti-k2GhghHVRtY@public.gmane.org
Embedded Systems                     phone:  +39 349 2432127
UNIX programming                     skype:  rodolfo.giometti
Freelance ICT Italia - Consulente ICT Italia - www.consulenti-ict.it
