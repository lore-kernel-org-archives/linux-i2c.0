From: Jean Delvare <jdelvare@suse.de>
Subject: Re: [PATCH 1/3] i2c-piix4: Support alternative port selection
 register
Date: Fri, 29 Jan 2016 13:04:03 +0100
Message-ID: <20160129130403.3633de2d@endymion.delvare>
References: <20160129104146.50f06562@endymion.delvare>
	<20160129104452.05e94c08@endymion.delvare>
	<20160129105923.GJ1778@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:49079 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755828AbcA2MEG (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Fri, 29 Jan 2016 07:04:06 -0500
In-Reply-To: <20160129105923.GJ1778@lahna.fi.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Linux I2C <linux-i2c@vger.kernel.org>, Christian Fetzer <fetzer.ch@gmail.com>, Wolfram Sang <wsa@the-dreams.de>

On Fri, 29 Jan 2016 12:59:23 +0200, Mika Westerberg wrote:
> > @@ -334,6 +344,18 @@ static int piix4_setup_sb800(struct pci_
> >  		 "SMBus Host Controller at 0x%x, revision %d\n",
> >  		 piix4_smba, i2ccfg >> 4);
> >  
> > +	/* Find which register is used for port selection */
> > +	mutex_lock(&piix4_mutex_sb800);
> > +	outb_p(SB800_PIIX4_PORT_IDX_SEL, SB800_PIIX4_SMB_IDX);
> > +	port_sel = inb_p(SB800_PIIX4_SMB_IDX + 1);
> > +	piix4_port_sel_sb800 = (port_sel & 0x01) ? SB800_PIIX4_PORT_IDX_ALT
> > +						 : SB800_PIIX4_PORT_IDX;
> > +	mutex_unlock(&piix4_mutex_sb800);
> > +
> > +	dev_info(&PIIX4_dev->dev,
> > +		 "Using register 0x%02x for SMBus port selection\n",
> > +		 (unsigned int)piix4_port_sel_sb800);
> 
> Would dev_dbg() be better here? Not sure how useful this information is
> for normal users.

Not sure. I agree that the register address isn't that helpful, but the
fact that port selection is needed is good to know. Sure I could use
dev_info() to mention that multiplexing is taking place, and then
dev_dbg() to give the port address, but that seems needlessly complex.
And it's not like the kernel log isn't full of I/O addresses already...

So I'd leave it as is, unless Wolfram objects.

-- 
Jean Delvare
SUSE L3 Support
