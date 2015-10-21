From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [RESEND PATCH 0/9] eeprom: at24: at24cs series serial number read
Date: Wed, 21 Oct 2015 16:42:04 +0200
Message-ID: <CAMpxmJWkioHCLZnJ7LfK3Y4K4jJ2iPMaZ4Kaj_BmAwXqYfW76A@mail.gmail.com>
References: <1445330607-12470-1-git-send-email-bgolaszewski@baylibre.com>
	<87bnbsiiuv.fsf@dell.be.48ers.dk>
	<CAMpxmJWX_20=X_zDqwz0H=_4s+bPVTi0qf8CT6y-4ABeCGfVRQ@mail.gmail.com>
	<87oafsti5k.fsf@dell.be.48ers.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-io0-f171.google.com ([209.85.223.171]:35067 "EHLO
	mail-io0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753767AbbJUOmF (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Wed, 21 Oct 2015 10:42:05 -0400
Received: by iofz202 with SMTP id z202so59421688iof.2
        for <linux-i2c@vger.kernel.org>; Wed, 21 Oct 2015 07:42:04 -0700 (PDT)
In-Reply-To: <87oafsti5k.fsf@dell.be.48ers.dk>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Peter Korsgaard <peter@korsgaard.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-i2c <linux-i2c@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

2015-10-21 16:23 GMT+02:00 Peter Korsgaard <peter@korsgaard.com>:
>>>>>> "Bartosz" == Bartosz Golaszewski <bgolaszewski@baylibre.com> writes:
>
>  >> As the serial number is available on a separate i2c address, wouldn't
>  >> it be simpler to handle these as special (read only) device variants and
>  >> instantiate E.G. a 24c64 (for the normal data) and a 24cs64 (for the
>  >> serial)?
>  >>
>
>  > Hi Peter,
>
>  > I wanted to respond that this way we would not be protected from
>  > concurrent accesses, but then I saw I didn't actually include any
>  > locks in the serial read function - my bad. It needs to be fixed as
>  > both memory blocks share the same address pointer.
>
>  > I'll resend the series.
>
> But we're protected by the i2c bus lock, right? You do a single
> i2c_transfer to read the serial number.

Why the at24->lock then?

Best regards,
Bartosz Golaszewski
