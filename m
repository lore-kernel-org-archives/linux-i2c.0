From: Andreas Werner <andreas.werner@men.de>
Subject: Re: [PATCH 1/2] drivers/misc/eeprom/men_eeprod: Introduce MEN Board
 Information EEPROM driver
Date: Thu, 16 Oct 2014 12:11:03 +0200
Message-ID: <20141016101102.GA23256@awelinux>
References: <cover.1413416105.git.andreas.werner@men.de>
 <d169930cfe45d4c05c79f7dd00471d732441529d.1413416105.git.andreas.werner@men.de>
 <20141016084412.GB22265@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20141016084412.GB22265@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Andreas Werner <andreas.werner@men.de>, linux-kernel@vger.kernel.org, wsa@the-dreams.de, linux-i2c@vger.kernel.org, johannes.thumshirn@men.de
List-Id: linux-i2c@vger.kernel.org

On Thu, Oct 16, 2014 at 10:44:12AM +0200, Greg KH wrote:
> On Thu, Oct 16, 2014 at 10:15:08AM +0200, Andreas Werner wrote:
> > +struct eeprom_data {
> > +	uint8_t eeprod_id;
> 
> Please use the "real" kernel types, "u8" here, and "u32" in other places
> you use uint32_t (those are userspace types, not kernel types, sorry.)
> 

You are right i will change it.

> > +static DEVICE_ATTR(eeprod_id, S_IRUGO, show_eeprod_id, NULL);
> > +static DEVICE_ATTR(revision, S_IRUGO, show_revision, NULL);
> > +static DEVICE_ATTR(serial, S_IRUGO, show_serialnr, NULL);
> > +static DEVICE_ATTR(hw_name, S_IRUGO, show_hw_name, NULL);
> > +static DEVICE_ATTR(prod_date, S_IRUGO, show_prod_date, NULL);
> > +static DEVICE_ATTR(rep_date, S_IRUGO, show_rep_date, NULL);
> 
> DEVICE_ATTR_RO() please.

OK no problem, will change it.

Thanks.

Regards
Andy
