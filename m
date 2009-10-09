From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: Looking for ICH SMBUS "Process call" support in i2c-i801 bus
 driver
Date: Fri, 9 Oct 2009 08:35:19 +0200
Message-ID: <20091009083519.2659a79a@hyperion.delvare>
References: <COL117-W70326CE4BD5366E7F94C688CC0@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <COL117-W70326CE4BD5366E7F94C688CC0-MsuGFMq8XAE@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Krishna Kothapalli <krishna_sunitha-PkbjNfxxIARBDgjK7y7TUQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Krishna,

On Thu, 8 Oct 2009 19:09:27 -0400, Krishna Kothapalli wrote:
> I have a couple of devices EEDPROM and Power Sequencer(ADM1066) that need "Sequential Random Read" which has 2 byte address requirements.
> Currently Process call is not implemented in code drivers/i2c/busses/i2c-i801.c.

This is correct. Adding process call support to the i2c-i801 driver
would be easy, I even think some developers have done it already but
omitted to send the changes upstream.

However, beware that SMBus process call is _not_ 2-byte addressing. It
is single-byte addressing, followed by two bytes from master to slave,
followed by two bytes from slave to master. Are you certain you need
SMBus process call for the ADM1066? The datasheet doesn't mention it.
All the SMBus transactions mentioned in the ADM1066 datasheet are
already supported by the i2c-i801 driver.

> Appreciate any suggestions for alternative implementations.

Please make sure you know what your needs are, first.

-- 
Jean Delvare
http://khali.linux-fr.org/wishlist.html
