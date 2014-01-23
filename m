From: Curt Brune <curt@cumulusnetworks.com>
Subject: Re: [PATCH 2/2] Add at24 based EEPROMs to the eeprom_dev hardware
 class
Date: Thu, 23 Jan 2014 07:05:24 -0800
Message-ID: <20140123150524.GH29955@cumulusnetworks.com>
References: <CAOMwXhMVgcVVWiUYbEgGcM+K5bZmKA3LO0=jZCEsyJak1TbTSA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAOMwXhMVgcVVWiUYbEgGcM+K5bZmKA3LO0=jZCEsyJak1TbTSA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Laszlo Papp <lpapp@kde.org>
Cc: Thomas De Schampheleire <patrickdepinguin@gmail.com>, gregkh@linuxfoundation.org, Shrijeet Mukherjee <shm@cumulusnetworks.com>, wolfram@the-dreams.de, linux-i2c@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

On Thu Jan 23 07:44, Laszlo Papp wrote:
> On Wed, Jan 22, 2014 at 5:23 PM, Curt Brune <curt@cumulusnetworks.com> wrote:
> > During device instantiation have the at24 driver add the new device to
> > the eeprom_dev hardware class.  The functionality is enabled by
> > CONFIG_EEPROM_CLASS.
[snip]
> >  static void __exit at24_exit(void)
> >  {
> >         i2c_del_driver(&at24_driver);
> >  }
> >  module_exit(at24_exit);
> 
> Couldn't you use module_i2c_driver() instead of this?

I'm not sure what you mean.

Do you mean should the class registration/unregistration be put in
module_i2c_driver()?  That would not work as not all i2c devices are
eeproms.

> 
> >  MODULE_DESCRIPTION("Driver for most I2C EEPROMs");
> >  MODULE_AUTHOR("David Brownell and Wolfram Sang");
> 
> I would personally put your name in here if I were you, otherwise
> David and Wolfram might get contacted by some people instead of you
> (at least based on this).

Hmmm.   I don't know.  I didn't change the driver very much, just
added about 10 lines to a perfectly fine driver.  git-blame would
point right at me for anything to do with this patch.

> 
> PS.: Fixing the broken i2c mailing list typo, and updating Wolfram's
> address from the broken (obsolete?) version.

Thanks for fixing that.

Cheers,
Curt
