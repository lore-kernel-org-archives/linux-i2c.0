From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH 1/1] at24: add i2c_driver struct member for at24_driver,
  and reduce the priority of at24_init
Date: Tue, 21 Sep 2010 09:35:52 +0200
Message-ID: <20100921093552.18cfdf26@endymion.delvare>
References: <1285049243-17058-1-git-send-email-jgq516@gmail.com>
	<20100921090102.4afd1d07@endymion.delvare>
	<AANLkTikY8Q2PzdufNVjY3VohQMThtzwtXSGWJhfcbedh@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <AANLkTikY8Q2PzdufNVjY3VohQMThtzwtXSGWJhfcbedh-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: xiaojiang <jgq516-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Xiao,

Please always reply to the list, so that your reply gets archived, and
also so that others can participate in the discussion.

On Tue, 21 Sep 2010 15:29:29 +0800, xiaojiang wrote:
> 2010/9/21 Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
> > On Tue, 21 Sep 2010 14:07:23 +0800, jgq516-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org wrote:
> > > From: Xiao Jiang <jgq516-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> > >
> > > The following changes are ensure at24 driver can be probed successfully,
> > > which are based on Linux 2.6.36-rc5.
> > > 1. Add class, detect and address_list member in at24_driver because they
> > >    will be check in i2c_detect().
> > (...)
> > Nack. We don't want a driver to unconditionally attach to I2C
> > addresses. It will inevitably grab devices which it doesn't actually
> > support. There's also the problem that larger EEPROMs reply to more
> > than one address, and there's no way to differentiate between one large
> > and many smaller EEPROMs (for example one AT24C04 at 0x50 vs. two
> > AT24C02 at 0x50 and 0x51.)
>
> Sorry, I don't  consider this sceneo.
> 
> > Worse, the above gives _write_ access to the EEPROM from user-space.
> > This means users are free to make their expensive memory modules
> > unusable by accidentally writing to the SPD EEPROM.
>
> Why user-space can't do write operation to eeprom? if so, people can't
> update the eeprom's data, but update eeprom is necessay for my board.

Whether or not this is desirable, depends on what each EEPROM is being
used for on a given system. Of course we want write support in some
cases, but making it the default for autodetected devices seems way too
dangerous. If people really need write access to their EEPROMs, they
have to properly declare them and not rely on autodetection.

> > The bottom line is that EEPROM devices must be declared properly, they
> > can't be autodetected.
> >
> > The only case where autodetection makes sense is for read-only EEPROMs
> > with well-specified contents, so we can check the contents for
> > autodetection. SPD EEPROMs fall into this category, as well as the Sony
> > proprietary EEPROMs in Vaio laptops. EDID EEPROMs could qualify as
> > well, however I think I'd rather leave graphics adapter drivers deal
> > with them and not interfere.
> >
> > Don't get me wrong, I'd be happy to get rid of the legacy "eeprom"
> > driver, and in order to do this, extending the "at24" driver to
> > autodetect SPD EEPROMs is needed. But it needs to be done with great
> > care and thoughts.
>
>  I will consider more about it, thanks:)

-- 
Jean Delvare
