From: Jean Delvare <jdelvare@suse.de>
Subject: Re: [PATCH 5/5] i2c: i2c-piix4: coding style fix - quoted string
 split across lines
Date: Thu, 13 Oct 2016 13:34:40 +0200
Message-ID: <20161013133440.11b8a61a@endymion>
References: <20161011172441.7422-1-palminha@synopsys.com>
        <20161011173455.7803-1-palminha@synopsys.com>
        <1476237836.2116.8.camel@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:53757 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754070AbcJMLfb (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 13 Oct 2016 07:35:31 -0400
In-Reply-To: <1476237836.2116.8.camel@perches.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Joe Perches <joe@perches.com>
Cc: Carlos Palminha <CARLOS.PALMINHA@synopsys.com>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, wsa@the-dreams.de

On Tue, 11 Oct 2016 19:03:56 -0700, Joe Perches wrote:
> On Tue, 2016-10-11 at 18:34 +0100, Carlos Palminha wrote:
> []
> > diff --git a/drivers/i2c/busses/i2c-piix4.c b/drivers/i2c/busses/i2c-piix4.c
> []
> > @@ -260,7 +260,8 @@ static int piix4_setup(struct pci_dev *PIIX4_dev,
> >  	else if ((temp & 0x0E) == 0)
> >  		dev_dbg(&PIIX4_dev->dev, "Using SMI# for SMBus\n");
> >  	else
> > -		dev_err(&PIIX4_dev->dev, "Illegal Interrupt configuration "
> > +		dev_err(&PIIX4_dev->dev,
> > +			"Illegal Interrupt configuration "
> >  			"(or code out of date)!\n");
> 
> typically, this format would be coalesced into a single line.

Especially when the patch claims to "fix quoted string split across
lines" :-D

-- 
Jean Delvare
SUSE L3 Support
