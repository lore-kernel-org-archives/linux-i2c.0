From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH 5/5] i2c: i2c-piix4: coding style fix - quoted string
 split across lines
Date: Tue, 11 Oct 2016 19:03:56 -0700
Message-ID: <1476237836.2116.8.camel@perches.com>
References: <20161011172441.7422-1-palminha@synopsys.com>
         <20161011173455.7803-1-palminha@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from smtprelay0070.hostedemail.com ([216.40.44.70]:47494 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752957AbcJLCEC (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Tue, 11 Oct 2016 22:04:02 -0400
In-Reply-To: <20161011173455.7803-1-palminha@synopsys.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Carlos Palminha <CARLOS.PALMINHA@synopsys.com>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: jdelvare@suse.com, wsa@the-dreams.de

On Tue, 2016-10-11 at 18:34 +0100, Carlos Palminha wrote:
[]
> diff --git a/drivers/i2c/busses/i2c-piix4.c b/drivers/i2c/busses/i2c-piix4.c
[]
> @@ -260,7 +260,8 @@ static int piix4_setup(struct pci_dev *PIIX4_dev,
>  	else if ((temp & 0x0E) == 0)
>  		dev_dbg(&PIIX4_dev->dev, "Using SMI# for SMBus\n");
>  	else
> -		dev_err(&PIIX4_dev->dev, "Illegal Interrupt configuration "
> +		dev_err(&PIIX4_dev->dev,
> +			"Illegal Interrupt configuration "
>  			"(or code out of date)!\n");

typically, this format would be coalesced into a single line.
