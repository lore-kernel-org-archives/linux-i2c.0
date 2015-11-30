From: Alexander Sverdlin <alexander.sverdlin@nokia.com>
Subject: Re: [PATCH] i2c: davinci: Increase module clock frequency
Date: Mon, 30 Nov 2015 15:00:12 +0100
Message-ID: <565C566C.7000809@nokia.com>
References: <564DBEE3.4030508@nokia.com> <20151130135504.GE1513@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from demumfd001.nsn-inter.net ([93.183.12.32]:49147 "EHLO
	demumfd001.nsn-inter.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753881AbbK3OAQ (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Mon, 30 Nov 2015 09:00:16 -0500
In-Reply-To: <20151130135504.GE1513@katana>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: EXT Wolfram Sang <wsa@the-dreams.de>
Cc: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, linux-i2c@vger.kernel.org, Murali Karicheri <m-karicheri2@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>

Hi!

On 30.11.2015 14:55, EXT Wolfram Sang wrote:
>>  	/* get minimum of 7 MHz clock, but max of 12 MHz */
>> > -	psc = (input_clock / 7000000) - 1;
>> > +	psc = (input_clock / 12000000) - 1;
> Doesn't make this the above comment invalid?

The comment refers to datasheet, not really to the code. And eventual changes to the datasheet
that's what can make it invalid (though I don't know TI's plans on it). Nevertheless, yes, I
think, it's better to drop the comment. Should I re-spin the patch with comment removal in it? 

-- 
Best regards,
Alexander Sverdlin.
Sent from my pdp-11
