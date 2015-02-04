From: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Subject: Re: [PATCH] eeprom: at24: Add support for large EEPROMs connected to
 SMBus adapters
Date: Wed, 4 Feb 2015 11:08:19 -0800
Message-ID: <20150204190819.GA15467@roeck-us.net>
References: <1423067017-27607-1-git-send-email-linux@roeck-us.net>
 <20150204174723.GB30930@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150204174723.GB30930@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
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

At the same time multi-master access is quite rare. Also, many of the
kernel's i2c drivers are not multi-master-access clean. In many cases
that isn't even possible due to the chip architecture (a good example
are chips with multiple 'pages', where the page address is set with
one i2c command and the actual access occurs with subsequent commands).
Mandating that the at24 driver shall be multi-master clean doesn't help
all those other drivers or chips and only creates a false sense of security.
The only (somewhat) clean means to support multi-master i2c access is
to use bus master selector chips such as the pca9541 in a design.

No, we are not going to use i2c-dev, as it would require breaking our
user space / kernel ABI just because this one eeprom is not supported
by the kernel driver. It would also be even more risky as the i2c-dev access
would have to be limited to a single application (ie it would not even be
single-master clean). I don't like the idea, and I don't understand the
rationale, but if the patch is not acceptable upstream we'll just carry
it locally.

Thanks,
Guenter
