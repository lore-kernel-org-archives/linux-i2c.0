From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v1 5/8] gpio: pca953x: store driver_data for future use
Date: Fri, 2 Oct 2015 03:53:23 -0700
Message-ID: <CACRpkdb88A4wP2_z_SsxOU_NoyGVVsA7TomgcKO6Qn+fguoJFA@mail.gmail.com>
References: <1442916619-140607-1-git-send-email-andriy.shevchenko@linux.intel.com>
	<1442916619-140607-6-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <1442916619-140607-6-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Gregory CLEMENT <gregory.clement@free-electrons.com>, Grygorii Strashko <grygorii.strashko@ti.com>, Graeme Smecher <gsmecher@threespeedlogic.com>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Lee Jones <lee.jones@linaro.org>, Wolfram Sang <wsa@the-dreams.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Mika Westerberg <mika.westerberg@intel.com>, "Puustinen, Ismo" <ismo.puustinen@intel.com>, "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

On Tue, Sep 22, 2015 at 3:10 AM, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> Instead of using id->driver_data directly we copied it to the internal
> structure. This will help to adapt driver for ACPI use.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Gregory, Grygorii, Graeme: can I get some help in reviewing these
PCA patches for ACPI support?

Yours,
Linus Walleij
