From: Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: Re: [PATCH v3 1/1] at24: support eeproms that do not auto-rollover
 reads.
Date: Tue, 5 Dec 2017 09:44:51 +0200
Message-ID: <20171205074451.gpsidrxlwyfo2fu7@paasikivi.fi.intel.com>
References: <1512401778-20366-1-git-send-email-svendev@arcx.com>
 <1512401778-20366-2-git-send-email-svendev@arcx.com>
 <20171204214023.ml2ujacezsop5ilb@kekkonen.localdomain>
 <CAGngYiXR83+0phkeAvJYYEm8HvmN-c9d0B9p1BRiPHyUz1ogAA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:42398 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752210AbdLEHo5 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Tue, 5 Dec 2017 02:44:57 -0500
Content-Disposition: inline
In-Reply-To: <CAGngYiXR83+0phkeAvJYYEm8HvmN-c9d0B9p1BRiPHyUz1ogAA@mail.gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Sven Van Asbroeck <thesven73@gmail.com>
Cc: Sven Van Asbroeck <svendev@arcx.com>, robh+dt@kernel.org, mark.rutland@arm.com, wsa@the-dreams.de, Bartosz Golaszewski <brgl@bgdev.pl>, nsekhar@ti.com, david@lechnology.com, javier@dowhile0.org, divagar.mohandass@intel.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-i2c <linux-i2c@vger.kernel.org>, Sven Van Asbroeck <svenv@arcx.com>

On Mon, Dec 04, 2017 at 05:24:33PM -0500, Sven Van Asbroeck wrote:
> > If this is truly specific to at24, then vendor prefix would be appropriate,
> > plus it'd go to an at24 specific binding file. However if it isn't I'd just
> > remove the above sentence. I guess the latter?
> 
> Yes, no-read-rollover is truly specific to at24.c, because it applies only
> to i2c multi-address chips. The at25 is spi based so cannot have multiple
> addresses.
> 
> So yes, "at24,no-read-rollover" would perhaps be a better name.
> 
> Regarding an at24 specific binding file. You're saying I should create
> Documentation/devicetree/bindings/eeprom/at24.txt ? Should I indicate
> that at24.txt "inherits from" eeprom.txt? Note that at25.txt does not
> currently do this.

Hmm. I actually missed we didn't have one to begin with. at25.txt exists
and it documents a number of properties specific to at25, so if at24 will
have an at24-specific property, then I think it should go to a separate
file.

Aren't there really other chips which need this? It'd be (a little bit)
easier to just remove the sentence. :-)

-- 
Regards,

Sakari Ailus
sakari.ailus@linux.intel.com
