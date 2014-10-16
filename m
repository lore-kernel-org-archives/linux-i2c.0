From: Andreas Werner <andreas.werner@men.de>
Subject: Re: [PATCH 1/2] drivers/misc/eeprom/men_eeprod: Introduce MEN Board
 Information EEPROM driver
Date: Thu, 16 Oct 2014 12:21:27 +0200
Message-ID: <20141016102126.GB23256@awelinux>
References: <cover.1413416105.git.andreas.werner@men.de>
 <d169930cfe45d4c05c79f7dd00471d732441529d.1413416105.git.andreas.werner@men.de>
 <20141016085835.GA1273@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20141016085835.GA1273@katana>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Andreas Werner <andreas.werner@men.de>, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, johannes.thumshirn@men.de
List-Id: linux-i2c@vger.kernel.org

On Thu, Oct 16, 2014 at 10:58:35AM +0200, Wolfram Sang wrote:
> * PGP Signed by an unknown key
> 
> On Thu, Oct 16, 2014 at 10:15:08AM +0200, Andreas Werner wrote:
> > Added driver to support the MEN Board Information EEPROM.
> > The driver exports the production information as read only sysfs
> > entries, as well as a user section which is read/write accessible.
> > 
> > Tested on PPC QorIQ and Intel Atom E680.
> > 
> > Tested-by: Johannes Thumshirn <johannes.thumshirn@men.de>
> > Signed-off-by: Andreas Werner <andreas.werner@men.de>
> 
> I guess this is just a standard EEPROM with a well defined layout?
> Why don't you want to use the standard driver then and parse the thing
> in userspace?
>

Yes it is a standard 256byte eeprom.
I do not want to parse the things in userspace because this EEPROM data
are related to the hardware and i want to give our customer the easiest way
to access the data without installing any tool.

The current state to read the eeprom data is, that customer needs to install a big
environment where the tool is integrated to have access to those kind of simple
data or they have to write their own code.

If our support department get some questions from the customer they always want
to have exact information about the board. Therefore I want to use this driver
and sysfs to get the informations as fast as possible without installing anything.
 
> Consider how bloated the sysfs-ABI might get if every vendor who uses an
> eeprom wants to expose the data this way?
> 

Yes and no. The possible sysfs entries gets bloated if every vendor will do it
like this way, but normally there is just one Board EEPROM on the board, therefore
only one driver gets loaded.

I mean its the same for every i2c device like a temperature sensor, I can also
read it from userspace without any special hwmon driver.

> > +struct eeprom_data {
> > +	uint8_t eeprod_id;
> > +
> > +	uint8_t revision[3];
> > +	uint32_t serialnr;
> > +	uint8_t board_model;
> > +	char hw_name[6];
> > +
> > +	uint8_t reserved;
> > +
> > +	__be16 prod_date;
> > +	__be16 rep_date;
> > +
> > +	uint8_t reserved2[4];
> > +};
> 
> And what if the compiler reorders?

Shit you are right, I will pack it.#

> 
> 
> * Unknown Key
> * 0x14A029B6

Regards
Andy
