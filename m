From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v2 0/8] enable I2C devices behind I2C bus on Gen2
Date: Mon, 5 Oct 2015 09:20:45 +0200
Message-ID: <CACRpkdZEv8V1+qv4zzKkzicZhXsziWbePJbgO8ziCWRhh_tR9Q@mail.gmail.com>
References: <1443698430-74415-1-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-ob0-f172.google.com ([209.85.214.172]:36048 "EHLO
	mail-ob0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751104AbbJEHUp (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Mon, 5 Oct 2015 03:20:45 -0400
Received: by obcgx8 with SMTP id gx8so121873746obc.3
        for <linux-i2c@vger.kernel.org>; Mon, 05 Oct 2015 00:20:45 -0700 (PDT)
In-Reply-To: <1443698430-74415-1-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Lee Jones <lee.jones@linaro.org>, Wolfram Sang <wsa@the-dreams.de>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Mika Westerberg <mika.westerberg@intel.com>, "Puustinen, Ismo" <ismo.puustinen@intel.com>, "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Thu, Oct 1, 2015 at 1:20 PM, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> The patches 7 and 8 are pretty independent, though they don't make much sense
> without previous ones applied.

To me it seems patches 5 & 6 (GPIO patches) can be applied as-is
to my GPIO tree without any bad side effects. Is this correct?

In that case I will apply them.

Yours,
Linus Walleij
