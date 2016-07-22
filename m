From: Jan Kandziora <jjj@gmx.de>
Subject: Re: [PATCH 2/2] add w1_ds28e17 driver for the DS28E17 Onewire to I2C
 master bridge
Date: Fri, 22 Jul 2016 22:56:15 +0200
Message-ID: <5792886F.1010508@gmx.de>
References: <578A95E4.1080903@gmx.de> <20160721070220.GE1664@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.15.18]:54496 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750856AbcGVU4S (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Fri, 22 Jul 2016 16:56:18 -0400
In-Reply-To: <20160721070220.GE1664@katana>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
Cc: Wolfram Sang <wsa@the-dreams.de>, Evgeniy Polyakov <zbr@ioremap.net>

Am 21.07.2016 um 09:02 schrieb Wolfram Sang:
>> + +		/* Resume to same DS28E17. */ +		if 
>> (w1_reset_resume_command(sl->master)) +			return -ENXIO;
> 
> -ENXIO? Please check Documentation/i2c/fault-codes if that fits
> 
It's an error while addressing the DS28E17. I'm not sure about this,
what to return when the bus master has gone, which may be only a
temporary problem.


Kind regards

	Jan
