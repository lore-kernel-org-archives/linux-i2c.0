From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: I2C_RDRW_IOCTL_MAX_MSGS
Date: Tue, 17 Jan 2012 16:06:55 +0100
Message-ID: <20120117160655.0586cd2c@endymion.delvare>
References: <464859D4BE03A84686BA47749242C1D0317B66EC@DBDE01.ent.ti.com>
	<20120117140954.05dd30ef@endymion.delvare>
	<464859D4BE03A84686BA47749242C1D0317B6E7A@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <464859D4BE03A84686BA47749242C1D0317B6E7A-Er742YJ7I/eIQmiDNMet8wC/G2K4zDHf@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Srinivasan, Nageswari" <nageswari-l0cyMroinI0@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Tue, 17 Jan 2012 14:49:01 +0000, Srinivasan, Nageswari wrote:
> We have a slave device which requires more than 500 registers
> to be configured. (kind of bulk write) So, looking for an option
> of configuring all of them in single command.

How long will it take? You should ask yourself if it really OK to block
the bus for so long.

What happens if you configure the chip in several goes? The time
penalty shouldn't be that big and I can't believe a chip can't be
configured one register after the other (or at least group by group.)

If you really have to do it all in one go (and even if not) you should
check if the chip supports register address pointer autoincrement
(or block writes.) This would let you write several register values in
one message, so you no longer have to send 500 messages, plus this
would be faster than your current strategy.

-- 
Jean Delvare
