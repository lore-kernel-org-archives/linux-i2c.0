From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: Preliminary support for DDR3 in decode-dimms
Date: Tue, 9 Dec 2008 15:02:30 +0100
Message-ID: <20081209150230.76314c54@hyperion.delvare>
References: <Pine.NEB.4.64.0811230659540.29668@quicky.whooppee.com>
	<20081125103039.2f14bac7@hyperion.delvare>
	<Pine.NEB.4.64.0811250408050.29070@quicky.whooppee.com>
	<20081208145902.5962408c@hyperion.delvare>
	<Pine.NEB.4.64.0812080602060.14436@quicky.whooppee.com>
	<20081209101225.2ea39aae@hyperion.delvare>
	<Pine.NEB.4.64.0812090405080.8244@quicky.whooppee.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <Pine.NEB.4.64.0812090405080.8244-j58mV80z1I3O+KjX/08HYEEOCMrvLtNR@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Paul Goyette <paul-3orOWTcw9wBWk0Htik3J/w@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Tue, 9 Dec 2008 04:07:20 -0800 (PST), Paul Goyette wrote:
> On Tue, 9 Dec 2008, Jean Delvare wrote:
> 
> >
> > Thank you. I really don't mean to waste your time here, I just want to
> > make sure that the code quality is maintained at a proper level, that
> > we do not introduce any regression, and that maintaining the code in
> > the future won't be too difficult. Do what you can and I'll do the rest.
> >
> > In fact I had already started committing some clean-ups. I'll now adjust
> > your latest patch to apply on top of that. I'll let you know what I am
> > done and we can pursue with DDR3 support.
> 
> Kewl.  Let me know when you have a new baseline for me to work with.
> 
> I actually had done some of the clean-up stuff myself, but I'm more than 
> happy to have someone more familiar with perl to do that for me.  :)

Here we go. You can fetch an up-to-date version of decode-dimms with:

svn export http://lm-sensors.org/svn/i2c-tools/trunk/eeprom/decode-dimms

Main differences with your original patch:

* readspd() only reads data from the EEPROM, it doesn't attempt to
  compute the size. The reason is that you don't even know if what
  you're reading is an SPD EEPROM yet.

* All functions take a reference to the bytes array as a parameter,
  instead of the array itself.

* Handling of Rambus types is cleaner, in particular spd_sizes() isn't
  called for Rambus, as I don't think it would handle it properly. Not
  that I really care about Rambus though, given how unpopular it is. I'm
  curious if anyone actually ever ran decode-dimms on Rambus.

* Decoding of manufacturing information has moved to a separate
  function.

The rest is essentially the same as the code you had provided. I think
we ar ready to add support for DDR3 SDRAM now.

Thanks,
-- 
Jean Delvare
