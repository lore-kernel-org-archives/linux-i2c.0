From: Angelo Compagnucci <angelo@amarulasolutions.com>
Subject: Re: [PATCH i2c-tools] tools/Module.mk: Add missing dependencies
Date: Thu, 14 Dec 2017 09:12:58 +0100
Message-ID: <CA+_SqVbPD572i0Moyr9BtLFtSQLpqYwAdrQX2vn4TAvUivyP3A@mail.gmail.com>
References: <20171212213355.5f25754e@endymion> <CA+_SqVY_3mrB17KWFaJYJefb7wpeYi5MhRXpcMoyQfGi1eQ0fQ@mail.gmail.com>
 <20171214085328.4244e4d5@endymion>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-ot0-f179.google.com ([74.125.82.179]:40557 "EHLO
        mail-ot0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751127AbdLNINj (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Thu, 14 Dec 2017 03:13:39 -0500
Received: by mail-ot0-f179.google.com with SMTP id e74so4262258ote.7
        for <linux-i2c@vger.kernel.org>; Thu, 14 Dec 2017 00:13:39 -0800 (PST)
In-Reply-To: <20171214085328.4244e4d5@endymion>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jean Delvare <jdelvare@suse.de>
Cc: Linux I2C <linux-i2c@vger.kernel.org>

On Thu, Dec 14, 2017 at 8:53 AM, Jean Delvare <jdelvare@suse.de> wrote:
> On Wed, 13 Dec 2017 11:36:31 +0100, Angelo Compagnucci wrote:
>> On Tue, Dec 12, 2017 at 9:33 PM, Jean Delvare <jdelvare@suse.de> wrote:
>> > Better build the library before building the tools which link against
>> > it, otherwise parallel builds could run into a race and break.
>>
>> Tested-by: Angelo Compagnucci <angelo@amarulasolutions.com>
>> Acked-by: Angelo Compagnucci <angelo@amarulasolutions.com>
>
> Thank you Angelo, your review and testing is highly appreciated :-)

You're welcome! Could you please review this one:
https://patchwork.ozlabs.org/patch/847141/

Thanks!

>
> Fix committed.
>
> --
> Jean Delvare
> SUSE L3 Support
