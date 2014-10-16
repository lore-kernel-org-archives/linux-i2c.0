From: Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Subject: Re: [PATCH 1/2] drivers/misc/eeprom/men_eeprod: Introduce MEN Board
 Information EEPROM driver
Date: Thu, 16 Oct 2014 11:34:14 +0200
Message-ID: <20141016093414.GA25214@kroah.com>
References: <cover.1413416105.git.andreas.werner@men.de>
 <d169930cfe45d4c05c79f7dd00471d732441529d.1413416105.git.andreas.werner@men.de>
 <20141016085835.GA1273@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20141016085835.GA1273@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Andreas Werner <andreas.werner-csrFAY9JiS4@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, johannes.thumshirn-csrFAY9JiS4@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Thu, Oct 16, 2014 at 10:58:35AM +0200, Wolfram Sang wrote:
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

It's not allowed to reorder, but it can add padding wherever it wants
to, which if this is a on-device structure, can cause problems.  Use
__packed to prevent that.

thanks,

greg k-h
