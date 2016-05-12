From: Thomas Zimmermann <tdz@users.sourceforge.net>
Subject: Re: [PATCH] i2c: Raise SDA for each received bit, if necessary
Date: Thu, 12 May 2016 18:19:12 +0200
Message-ID: <5734AD00.3050904@users.sourceforge.net>
References: <1461780714-20378-1-git-send-email-tdz@users.sourceforge.net>
 <20160512090544.GB1638@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wm0-f42.google.com ([74.125.82.42]:38026 "EHLO
	mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932086AbcELQTk (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Thu, 12 May 2016 12:19:40 -0400
In-Reply-To: <20160512090544.GB1638@katana>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org

Hi

Am 12.05.2016 um 11:05 schrieb Wolfram Sang:
> Hi Thomas,
> 
> On Wed, Apr 27, 2016 at 08:11:54PM +0200, Thomas Zimmermann wrote:
>> Some I2C adapters don't raise SDA by themselves when sending a bit. This
>> behavior can be seen with the DDC channel of SiS 300 graphics cards.
> 
> I think you mean 'clients' or 'devices' here, not adapters (masters),
> right?

Yes, sorry.

> So, it seems you have a bus without a pull-up resistor (or a
> broken one?) but use now a push-pull design. This is against the I2C
> standard and for most circiuts quite dangerous as it can lead to
> shortcuts.

I see.

> Do you have any hints that the bus is designed this way? In which driver
> do you want to use the new flag?

I was playing with the DRM framework and an old SiS graphics card. I
discovered this issue while trying to read the EDID from the monitor.

I have a few other SiS cards/models here and they all expose this
behavior. So I guess it's intentional(==cheaper?), although the HW docs
don't seem mention it explicitly.

Best regards
Thomas

> 
> Thanks,
> 
>    Wolfram
> 


-- 
GnuPG:          http://tdz.users.sourceforge.net/tdz.asc
Fingerprint:    16FF F599 82F8 E5AA 18C6 5220 D9DA D7D4 4EF1 DF08
