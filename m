From: Michael Brown <mbrown@fensystems.co.uk>
Subject: Re: SFC driver implements its own I2C support
Date: Thu, 15 May 2008 13:04:50 +0100 (BST)
Message-ID: <Pine.LNX.4.62.0805151258150.13626@dolphin.home>
References: <20080513103325.1ab317cf@hyperion.delvare> <20080514215818.GH28241@solarflare.com>
 <20080515112416.55ffd328@hyperion.delvare>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20080515112416.55ffd328@hyperion.delvare>
Sender: netdev-owner@vger.kernel.org
To: Jean Delvare <khali@linux-fr.org>
Cc: Ben Hutchings <bhutchings@solarflare.com>, Jeff Garzik <jgarzik@redhat.com>, netdev@vger.kernel.org, Linux I2C <i2c@lm-sensors.org>, linux-net-drivers@solarflare.com
List-Id: linux-i2c@vger.kernel.org

On Thu, 15 May 2008, Jean Delvare wrote:
> > Last time I checked (i.e. when I originally wrote this bit of the 
> > code), the kernel's own i2c layer didn't provide any clean way for 
> > kernel code (rather than user code) to access i2c devices.
> 
> I am not sure what Michael was referring to exactly, but access to i2c 
> devices from the kernel has been supported pretty much forever. Maybe he 
> really meant access to hardware monitoring devices? For these indeed 
> there is a standard user-space interface (through sysfs) but no standard 
> in-kernel access; mainly because there has never been a clear need for 
> one. Again, if you need something, please discuss it on the relevant 
> mailing lists and we'll find a way for you to use the standard 
> subsystems rather than reimplementing them for your own use.

>From memory (and this may be inaccurate), it looked as though the i2c 
subsystem code for EEPROM access was contained within 
drivers/i2c/chips/eeprom.c, and that this code provided an interface for 
userspace to access the EEPROM contents, but no interface for kernel code 
to do so.

I think there may also have been issues with the fact that the i2c system 
allows for failures on the shutdown path (e.g. i2c_detach_client() can 
return a failure), which becomes awkward to handle when you are in the 
middle of a shutdown path that is not allowed to fail (e.g. a
pci_driver->remove method).

Michael
