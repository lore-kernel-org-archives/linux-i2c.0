From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [RESEND PATCH 0/9] eeprom: at24: at24cs series serial number read
Date: Wed, 21 Oct 2015 16:15:49 +0200
Message-ID: <CAMpxmJWX_20=X_zDqwz0H=_4s+bPVTi0qf8CT6y-4ABeCGfVRQ@mail.gmail.com>
References: <1445330607-12470-1-git-send-email-bgolaszewski@baylibre.com>
	<87bnbsiiuv.fsf@dell.be.48ers.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-io0-f180.google.com ([209.85.223.180]:34294 "EHLO
	mail-io0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753639AbbJUOPu (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Wed, 21 Oct 2015 10:15:50 -0400
Received: by iow1 with SMTP id 1so58617082iow.1
        for <linux-i2c@vger.kernel.org>; Wed, 21 Oct 2015 07:15:49 -0700 (PDT)
In-Reply-To: <87bnbsiiuv.fsf@dell.be.48ers.dk>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Peter Korsgaard <peter@korsgaard.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-i2c <linux-i2c@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

2015-10-21 13:03 GMT+02:00 Peter Korsgaard <peter@korsgaard.com>:
>>>>>> "Bartosz" == Bartosz Golaszewski <bgolaszewski@baylibre.com> writes:
>
>  > Chips from the at24cs EEPROM series have an additional read-only memory area
>  > containing a factory pre-programmed serial number. In order to access it, a
>  > dummy write must be executed before reading the serial number bytes.
>
>  > This series adds support for reading the serial number through a sysfs
>  > attribute.
>
>  > While we're at it: some of the patches contain readability tweaks and code
>  > organization fixes.
>
>  > Tested with at24cs64 and at24cs02 chips (for both 16 and 8 bit address
>  > pointers).
>
> As the serial number is available on a separate i2c address, wouldn't
> it be simpler to handle these as special (read only) device variants and
> instantiate E.G. a 24c64 (for the normal data) and a 24cs64 (for the
> serial)?
>

Hi Peter,

I wanted to respond that this way we would not be protected from
concurrent accesses, but then I saw I didn't actually include any
locks in the serial read function - my bad. It needs to be fixed as
both memory blocks share the same address pointer.

I'll resend the series.

Best regards,
Bartosz Golaszewski
