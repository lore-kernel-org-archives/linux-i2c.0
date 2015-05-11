From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v2 2/3] i2c / ACPI: Use 0 to indicate that device does not
 have interrupt assigned
Date: Mon, 11 May 2015 11:58:29 +0200
Message-ID: <CACRpkdYXGfhwo1awUThbc4F7muMny-ZZrzDrg4Vmf=iow4UocA@mail.gmail.com>
References: <1430908148-201129-1-git-send-email-mika.westerberg@linux.intel.com>
	<1430908148-201129-3-git-send-email-mika.westerberg@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <1430908148-201129-3-git-send-email-mika.westerberg@linux.intel.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Alexandre Courbot <gnurou@gmail.com>, Octavian Purdila <octavian.purdila@intel.com>, Robert Dolca <robert.dolca@intel.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

On Wed, May 6, 2015 at 12:29 PM, Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:

> This is the convention used in most parts of the kernel including DT
> counterpart of I2C slave enumeration. To make things consistent do the same
> for ACPI I2C slave enumeration path as well.
>
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>

This needs to go through the GPIO tree along with 3/3.
Wolfram, can I have your ACK on this patch?

Yours,
Linus Walleij
