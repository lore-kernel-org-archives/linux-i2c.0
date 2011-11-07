From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: 10-bit address support in i2c-omap and i2c-davinci
Date: Mon, 7 Nov 2011 09:46:14 +0100
Message-ID: <20111107094614.0062a3f7@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Cc: Kevin Hilman <khilman-l0cyMroinI0@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Andy Green <andy.green-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Lucas De Marchi <lucas.demarchi-Y3ZbgMPKUGA34EUeqzHoZw@public.gmane.org>, Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Both bus drivers i2c-omap and i2c-davinci apparently handle 10-bit addresses:

(i2c-omap.c)
	if (msg->flags & I2C_M_TEN)
		w |= OMAP_I2C_CON_XA;

(i2c-davinci.c)
	/* if the slave address is ten bit address, enable XA bit */
	if (msg->flags & I2C_M_TEN)
		flag |= DAVINCI_I2C_MDR_XA;

However neither driver declares functionality flag I2C_FUNC_10BIT_ADDR,
so chip drivers would normally refuse to bind to these buses. If 10-bit
address support is incomplete or broken then it should be removed
completely. If it works then these drivers should declare so by adding
I2C_FUNC_10BIT_ADDR to the functionality flags they return.

-- 
Jean Delvare
