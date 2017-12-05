From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: [PATCH v3 1/1] at24: support eeproms that do not auto-rollover reads.
Date: Tue, 5 Dec 2017 09:14:22 +0100
Message-ID: <CAMRc=MdeEcJ=hH42725S3u3ncVeNdyk-VBs2TvV1D8_kTR3nOw@mail.gmail.com>
References: <1512401778-20366-1-git-send-email-svendev@arcx.com>
 <1512401778-20366-2-git-send-email-svendev@arcx.com> <20171204214023.ml2ujacezsop5ilb@kekkonen.localdomain>
 <CAGngYiXR83+0phkeAvJYYEm8HvmN-c9d0B9p1BRiPHyUz1ogAA@mail.gmail.com> <20171205074451.gpsidrxlwyfo2fu7@paasikivi.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-oi0-f42.google.com ([209.85.218.42]:33538 "EHLO
        mail-oi0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752531AbdLEIOX (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Tue, 5 Dec 2017 03:14:23 -0500
Received: by mail-oi0-f42.google.com with SMTP id w131so13664064oiw.0
        for <linux-i2c@vger.kernel.org>; Tue, 05 Dec 2017 00:14:23 -0800 (PST)
In-Reply-To: <20171205074451.gpsidrxlwyfo2fu7@paasikivi.fi.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: Sven Van Asbroeck <thesven73@gmail.com>, Sven Van Asbroeck <svendev@arcx.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Wolfram Sang <wsa@the-dreams.de>, nsekhar@ti.com, David Lechner <david@lechnology.com>, javier@dowhile0.org, divagar.mohandass@intel.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-i2c <linux-i2c@vger.kernel.org>, Sven Van Asbroeck <svenv@arcx.com>

2017-12-05 8:44 GMT+01:00 Sakari Ailus <sakari.ailus@linux.intel.com>:
> On Mon, Dec 04, 2017 at 05:24:33PM -0500, Sven Van Asbroeck wrote:
>> > If this is truly specific to at24, then vendor prefix would be appropriate,
>> > plus it'd go to an at24 specific binding file. However if it isn't I'd just
>> > remove the above sentence. I guess the latter?
>>
>> Yes, no-read-rollover is truly specific to at24.c, because it applies only
>> to i2c multi-address chips. The at25 is spi based so cannot have multiple
>> addresses.
>>
>> So yes, "at24,no-read-rollover" would perhaps be a better name.
>>
>> Regarding an at24 specific binding file. You're saying I should create
>> Documentation/devicetree/bindings/eeprom/at24.txt ? Should I indicate
>> that at24.txt "inherits from" eeprom.txt? Note that at25.txt does not
>> currently do this.
>
> Hmm. I actually missed we didn't have one to begin with. at25.txt exists
> and it documents a number of properties specific to at25, so if at24 will
> have an at24-specific property, then I think it should go to a separate
> file.

The eeprom.txt file in the bindings directory actually describes the
bindings for at24. There's a patch[1] from Wolfram waiting for Rob's
ack that renames it to at24.txt. I hope that clears any confusion.

@Sven: please split the patch into two: one for bindings and one for code.

As for the name: I would change it to at24,no-read-rollover and remove
the fragment saying it's only supported in at24 - as I said: this file
only concerns at24 and will be renamed.

>
> Aren't there really other chips which need this? It'd be (a little bit)
> easier to just remove the sentence. :-)
>
> --
> Regards,
>
> Sakari Ailus
> sakari.ailus@linux.intel.com

Thanks,
Bartosz

[1] http://patchwork.ozlabs.org/patch/842500/
