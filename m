From: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Subject: Re: [PATCH] eeprom: at24: Add support for large EEPROMs connected to
 SMBus adapters
Date: Wed, 4 Feb 2015 16:26:30 -0800
Message-ID: <20150205002630.GA396@roeck-us.net>
References: <1423067017-27607-1-git-send-email-linux@roeck-us.net>
 <20150204174723.GB30930@katana>
 <20150204190819.GA15467@roeck-us.net>
 <20150204233516.GA1677@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150204233516.GA1677@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Thu, Feb 05, 2015 at 12:35:16AM +0100, Wolfram Sang wrote:
> On Wed, Feb 04, 2015 at 11:08:19AM -0800, Guenter Roeck wrote:
> > On Wed, Feb 04, 2015 at 06:47:23PM +0100, Wolfram Sang wrote:
> > > 
> > > On Wed, Feb 04, 2015 at 08:23:37AM -0800, Guenter Roeck wrote:
> > > > Large EEPROMS (24c32 and larger) require a two-byte data address
> > > > instead of just a single byte. Implement support for such EEPROMs
> > > > with SMBus commands.
> > > > 
> > > > Support has limitations (reads are not multi-master safe) and is slow,
> > > > but it works. Practical use is for a system with 24c32 connected to
> > > > Intel 82801I (ICH9).
> > > 
> > > Can't you simply use i2c-dev to access the EEPROM? In multi-master
> > > environments, things can really go wrong, so I wouldn't like to add
> > > something dangerous by default. Maybe with a module parameter named
> > > "allow-multimaster-unsafe-access-to-large-eeproms-with-smbus" which is
> > > default off. But I'd really prefer the i2c-dev solution. Hooking a 16bit
> > > EEPROM to SMBus is daring, after all. SMBus is multi-master, too.
> > > 
> > Hi Wolfram,
> > 
> > At the same time multi-master access is quite rare.
> 
> It should still work in those rare cases. A setup of an SoC, an EC
> (those like to be masters, as well), and an EEPROM is not very far off.
> 
It won't work if the 24c32 is connected to a controller which only supports
SMBus transactions. Also, there is no problem if it is connected to a
controller supporting direct i2c accesses.

The only real solution is to not use an SMBus-only controller together
with 24c32 or any similar chip in such situations.

> > Also, many of the kernel's i2c drivers are not multi-master-access
> > clean. In many cases that isn't even possible due to the chip
> > architecture (a good example are chips with multiple 'pages', where
> > the page address is set with one i2c command and the actual access
> > occurs with subsequent commands).
> 
> Huh, using i2c_transfer to ensure 'repeated start' between messages
> should do the trick, no? Drivers doing this via SMBus calls are broken
> and should be fixed.
> 

That would require all those drivers to have two separate implementations,
or to declare that any such chips must only be connected to controllers
supporting direct i2c accesses. Both isn't really practical and defies
the real world, where any kind of chip will be connected to SMBus-only
controllers. A worse situation would occur if the chip specifically
(only) supports SMBus transactions and thus doesn't explicitly support
repeated start after completion of one transaction. This may or may not
work depending on the chip or even chip revision, and it usually would
not be specified as a valid transaction in the chip datasheet.

Guenter
