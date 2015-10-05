From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v2 5/8] gpio: pca953x: store driver_data for future use
Date: Mon, 5 Oct 2015 10:56:47 +0200
Message-ID: <CACRpkdZouFU5Kfys4fuh5Gei=oVZC3AsobrzMCHFU5Pk-r-rPQ@mail.gmail.com>
References: <1443698430-74415-1-git-send-email-andriy.shevchenko@linux.intel.com>
	<1443698430-74415-6-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-ob0-f169.google.com ([209.85.214.169]:34649 "EHLO
	mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752140AbbJEI4s (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Mon, 5 Oct 2015 04:56:48 -0400
Received: by obbda8 with SMTP id da8so123599324obb.1
        for <linux-i2c@vger.kernel.org>; Mon, 05 Oct 2015 01:56:47 -0700 (PDT)
In-Reply-To: <1443698430-74415-6-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Lee Jones <lee.jones@linaro.org>, Wolfram Sang <wsa@the-dreams.de>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Mika Westerberg <mika.westerberg@intel.com>, "Puustinen, Ismo" <ismo.puustinen@intel.com>, "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Thu, Oct 1, 2015 at 1:20 PM, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> Instead of using id->driver_data directly we copied it to the internal
> structure. This will help to adapt driver for ACPI use.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Patch applied.

Yours,
Linus Walleij
