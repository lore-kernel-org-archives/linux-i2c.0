From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: Moving to new driver model: probe never called
Date: Mon, 4 May 2009 18:10:20 +0200
Message-ID: <20090504181020.62d1d413@hyperion.delvare>
References: <1241193404.31476.6.camel@homestead>
	<20090501195146.4da8edf5@hyperion.delvare>
	<1241205250.31476.86.camel@homestead>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1241205250.31476.86.camel@homestead>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Shane Dixon <shane.dixon-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Shane,

On Fri, 01 May 2009 13:14:10 -0600, Shane Dixon wrote:
> Thank you for the help.  This is only my 2nd driver I've ever written
> (the first one being the i2c legacy version of the same driver!)  I
> think that did it.  The device is a tpm, but the I2C_CLASS_HWMON seems
> to help it get a little farther to the detect function.

Might be acceptable for your local testing, but obviously not for
upstream submission.

> I also had to
> make sure I had the normal_i2c[] struct present because I know the
> device listens on 0x29.  This isn't something I can modify the
> board_info for because it's just wires jumping the device over to a
> development board (for a demo), so it's not permanently soldered on.  I
> don't think it would be correct to use the board_info to treat it like a
> static device.

OK, that makes sense. I have just added a sysfs interface to handle
this situation more gracefully. I'll Cc you when I post it (in a
minute), please give it a try if you can.

-- 
Jean Delvare
http://khali.linux-fr.org/wishlist.html
