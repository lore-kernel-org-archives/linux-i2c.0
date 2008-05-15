From: Ben Hutchings <bhutchings-s/n/eUQHGBpZroRs9YW3xA@public.gmane.org>
Subject: Re: SFC driver implements its own I2C support
Date: Thu, 15 May 2008 15:49:17 +0100
Message-ID: <20080515144916.GL28241@solarflare.com>
References: <20080513103325.1ab317cf@hyperion.delvare>
	<20080514215818.GH28241@solarflare.com>
	<20080515112416.55ffd328@hyperion.delvare>
	<Pine.LNX.4.62.0805151258150.13626@dolphin.home>
	<20080515143954.15bc4170@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20080515143954.15bc4170-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Linux I2C <i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>, Michael Brown <mbrown-OViyBiuKJBuK421+ScFKDQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Jean Delvare wrote:
> On Thu, 15 May 2008 13:04:50 +0100 (BST), Michael Brown wrote:
> > On Thu, 15 May 2008, Jean Delvare wrote:
> > > > Last time I checked (i.e. when I originally wrote this bit of the 
> > > > code), the kernel's own i2c layer didn't provide any clean way for 
> > > > kernel code (rather than user code) to access i2c devices.
> > > 
> > > I am not sure what Michael was referring to exactly, but access to i2c 
> > > devices from the kernel has been supported pretty much forever. Maybe he 
> > > really meant access to hardware monitoring devices? For these indeed 
> > > there is a standard user-space interface (through sysfs) but no standard 
> > > in-kernel access; mainly because there has never been a clear need for 
> > > one. Again, if you need something, please discuss it on the relevant 
> > > mailing lists and we'll find a way for you to use the standard 
> > > subsystems rather than reimplementing them for your own use.
> > 
> > From memory (and this may be inaccurate), it looked as though the i2c 
> > subsystem code for EEPROM access was contained within 
> > drivers/i2c/chips/eeprom.c, and that this code provided an interface for 
> > userspace to access the EEPROM contents, but no interface for kernel code 
> > to do so.
> 
> This is correct and is still the case. This eeprom driver is a simple
> way to export small EEPROM data to user-space in read-only mode.
<snip>

This doesn't matter to us now, as our current controller has the EEPROM
attached to an SPI bus.  Michael's original version of the driver had to
support our earlier controller which had EEPROM on I2C.

Ben.

-- 
Ben Hutchings, Senior Software Engineer, Solarflare Communications
Not speaking for my employer; that's the marketing department's job.

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
