From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: Implementing a new driver
Date: Fri, 23 Jan 2009 10:39:09 +0100
Message-ID: <20090123103909.281770dd@hyperion.delvare>
References: <49798DAD.1070100@manoweb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <49798DAD.1070100-+h0hele9I7BBDgjK7y7TUQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alessio Sangalli <alesan-+h0hele9I7BBDgjK7y7TUQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Alessio,

On Fri, 23 Jan 2009 01:28:13 -0800, Alessio Sangalli wrote:
> Hi, I would like to implement a driver for an I2C interface we are
> implementing in a chip.
> 
> This interface will be used to read DDC/EDID data from monitors.
> 
> I have never worked with the I2C subsystem (only lm-sensors as a user,
> without deepening my knowledge on the actual drivers).
> 
> Can you give me a checklist of things to do for this task so that I can
> get started for implementation?

As a quick starting point I recommend this FAQ item:
http://i2c.wiki.kernel.org/index.php/Linux_2.6_I2C_development_FAQ#New_I2C_bus_drivers

If you have more detailed questions while writing the code, post them
on the list and we'll try to help.

-- 
Jean Delvare
