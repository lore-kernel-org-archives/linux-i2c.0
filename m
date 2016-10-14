From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v2] i2c: i2c-piix4: several coding style fixes
Date: Fri, 14 Oct 2016 09:08:25 +0200
Message-ID: <20161014070825.qlawh2ttlwj24jge@pengutronix.de>
References: <20161013223901.16460-1-palminha@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:35814 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1757378AbcJNHIu (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Fri, 14 Oct 2016 03:08:50 -0400
Content-Disposition: inline
In-Reply-To: <20161013223901.16460-1-palminha@synopsys.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Carlos Palminha <CARLOS.PALMINHA@synopsys.com>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org

Hello,

On Thu, Oct 13, 2016 at 11:39:01PM +0100, Carlos Palminha wrote:
> @@ -196,7 +204,7 @@ static int piix4_setup(struct pci_dev *PIIX4_dev,
>  	} else {
>  		pci_read_config_word(PIIX4_dev, SMBBA, &piix4_smba);
>  		piix4_smba &= 0xfff0;
> -		if(piix4_smba == 0) {
> +		if (piix4_smba == 0) {
>  			dev_err(&PIIX4_dev->dev, "SMBus base address "
>  				"uninitialized - upgrade BIOS or use "
>  				"force_addr=0xaddr\n");

did you left this message in three lines on purpose?

Best regards
Uwe


-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
