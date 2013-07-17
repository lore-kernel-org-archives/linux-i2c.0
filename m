From: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Subject: Re: [PATCH v3 1/4] i2c: Add DIMM bus code
Date: Wed, 17 Jul 2013 15:23:49 -0700
Message-ID: <20130717222349.GD990@roeck-us.net>
References: <cover.1374093761.git.luto@amacapital.net>
 <b8e50b55358b4f0cd1db96174a9e6a2e69780359.1374093761.git.luto@amacapital.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <b8e50b55358b4f0cd1db96174a9e6a2e69780359.1374093761.git.luto-kltTT9wpgjJwATOyAt5JVQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andy Lutomirski <luto-kltTT9wpgjJwATOyAt5JVQ@public.gmane.org>
Cc: lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, James Ralston <james.d.ralston-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Wed, Jul 17, 2013 at 01:53:05PM -0700, Andy Lutomirski wrote:
> Add i2c_scan_dimm_bus to declare that a particular i2c_adapter
> contains DIMMs.  This will probe (and autoload modules!) for useful
> SMBUS devices that live on DIMMs.
> 
> As more SMBUS-addressable DIMM components become supported, this
> code can be extended to probe for them.
> 
I don't think this code is necessary. The temperature sensor would be
auto-detected if you mark the bus driver as I2C_CLASS_HWMON, and DIM eeprom
auto-detection should not be needed.

Guenter
