From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH] eeprom: at24: Add support for large EEPROMs connected to
 SMBus adapters
Date: Wed, 4 Feb 2015 12:33:52 -0800
Message-ID: <20150204203352.GA18073@roeck-us.net>
References: <1423067017-27607-1-git-send-email-linux@roeck-us.net>
 <20150204174723.GB30930@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150204174723.GB30930@katana>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Wed, Feb 04, 2015 at 06:47:23PM +0100, Wolfram Sang wrote:
> 
> On Wed, Feb 04, 2015 at 08:23:37AM -0800, Guenter Roeck wrote:
> > Large EEPROMS (24c32 and larger) require a two-byte data address
> > instead of just a single byte. Implement support for such EEPROMs
> > with SMBus commands.
> > 
> > Support has limitations (reads are not multi-master safe) and is slow,
> > but it works. Practical use is for a system with 24c32 connected to
> > Intel 82801I (ICH9).
> 
> Can't you simply use i2c-dev to access the EEPROM? In multi-master
> environments, things can really go wrong, so I wouldn't like to add
> something dangerous by default. Maybe with a module parameter named
> "allow-multimaster-unsafe-access-to-large-eeproms-with-smbus" which is
> default off. But I'd really prefer the i2c-dev solution. Hooking a 16bit
> EEPROM to SMBus is daring, after all. SMBus is multi-master, too.
> 

Hi Wolfram,

thinking about it some more, the problem you are concerned about really is
that 24c32 and larger EEPROMs can not be reliably supported in multi-master
configurations with SMBus adapters.

My solution to that problem would be not to build such hardware. Your
solution appears to be not to support 24c32 and larger EEPROMs on SMBUs
adapters at all, which I consider highly restrictive.

Please reconsider.

Thanks,
Guenter
