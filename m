From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: Implementing a new driver
Date: Sat, 24 Jan 2009 09:58:21 +0100
Message-ID: <20090124095821.316b05ff@hyperion.delvare>
References: <49798DAD.1070100@manoweb.com>
	<20090123103909.281770dd@hyperion.delvare>
	<4979FEF2.1090006@manoweb.com>
	<20090123212506.7997e4ee@hyperion.delvare>
	<497A3820.2060405@manoweb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <497A3820.2060405-+h0hele9I7BBDgjK7y7TUQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alessio Sangalli <alesan-+h0hele9I7BBDgjK7y7TUQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Alessio,

On Fri, 23 Jan 2009 13:35:28 -0800, Alessio Sangalli wrote:
> Jean Delvare wrote:
> 
> > Examples of I2C chip drivers can be found under drivers/rtc (for RTC
> 
> 
> Thanks. I guess there is already a driver for DDC/EDID monitor
> parameters right? Should be a fairly common feature for graphic cards

See drivers/video/fb_ddc.c and drivers/video/edid.h, presumably this is
what you want for a framebuffer driver. For an X driver, the code
handling DDC is in X itself.

Or, for testing purpose, you can use the legacy "eeprom" driver
together with the ddcmon and decode-edid scripts from i2c-tools [1].

[1] http://www.lm-sensors.org/wiki/I2CTools

-- 
Jean Delvare
