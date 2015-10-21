From: Peter Korsgaard <peter@korsgaard.com>
Subject: Re: [RESEND PATCH 0/9] eeprom: at24: at24cs series serial number read
Date: Wed, 21 Oct 2015 17:08:10 +0200
Message-ID: <87k2qgtg2t.fsf@dell.be.48ers.dk>
References: <1445330607-12470-1-git-send-email-bgolaszewski@baylibre.com>
	<87bnbsiiuv.fsf@dell.be.48ers.dk>
	<CAMpxmJWX_20=X_zDqwz0H=_4s+bPVTi0qf8CT6y-4ABeCGfVRQ@mail.gmail.com>
	<87oafsti5k.fsf@dell.be.48ers.dk>
	<CAMpxmJWkioHCLZnJ7LfK3Y4K4jJ2iPMaZ4Kaj_BmAwXqYfW76A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wi0-f182.google.com ([209.85.212.182]:38888 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752215AbbJUPIP (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Wed, 21 Oct 2015 11:08:15 -0400
In-Reply-To: <CAMpxmJWkioHCLZnJ7LfK3Y4K4jJ2iPMaZ4Kaj_BmAwXqYfW76A@mail.gmail.com>
	(Bartosz Golaszewski's message of "Wed, 21 Oct 2015 16:42:04 +0200")
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-i2c <linux-i2c@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

>>>>> "Bartosz" == Bartosz Golaszewski <bgolaszewski@baylibre.com> writes:

Hi,

 >> > I wanted to respond that this way we would not be protected from
 >> > concurrent accesses, but then I saw I didn't actually include any
 >> > locks in the serial read function - my bad. It needs to be fixed as
 >> > both memory blocks share the same address pointer.
 >> 
 >> > I'll resend the series.
 >> 
 >> But we're protected by the i2c bus lock, right? You do a single
 >> i2c_transfer to read the serial number.

 > Why the at24->lock then?

I'm not sure. Wolfram?

-- 
Bye, Peter Korsgaard 
