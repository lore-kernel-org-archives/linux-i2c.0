From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: Looking for ICH SMBUS "Process call" support in i2c-i801 bus  
 driver
Date: Fri, 16 Oct 2009 09:02:25 +0200
Message-ID: <20091016090225.53438bdd@hyperion.delvare>
References: <COL117-W70326CE4BD5366E7F94C688CC0@phx.gbl>
	<COL117-W52FEEADBC012C39EE0485188CB0@phx.gbl>
	<COL117-W4849AF5757A0D75EED6B5E88C50@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <COL117-W4849AF5757A0D75EED6B5E88C50-MsuGFMq8XAE@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Krishna Kothapalli <krishna_sunitha-PkbjNfxxIARBDgjK7y7TUQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Krishna,

On Thu, 15 Oct 2009 16:42:07 -0400, Krishna Kothapalli wrote:
> > For 24C32 and larger=2C it requires full I2C support.
> 
> Wondering if USB-I2C module
> (http://www.robot-electronics.co.uk/htm/usb_i2c_tech.htm) is a better
> compared to ICH9 SMBUS controller from full I2C cycle support and
> software driver point of view?

I have no idea. Never heard of this USB device before. Apparently it
requires two drivers, one for USB to serial emulation and one for the
device itself, none of which is in the upstream kernel tree. The former
is binary-only and is in user-space. This means you will never be able
to use kernel I2C chip drivers on top of it. And anyway I would run
away from binary solutions.

The device in question supports the I2C transactions you need (if I
trust their website) but I wouldn't recommend it for technical
(software) reasons.

-- 
Jean Delvare
http://khali.linux-fr.org/wishlist.html
