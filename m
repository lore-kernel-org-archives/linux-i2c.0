From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v2 3/3] i2c / ACPI: Assign IRQ for devices that have
 GpioInt automatically
Date: Mon, 11 May 2015 11:59:12 +0200
Message-ID: <CACRpkdZtANrJ+_1iWbr1aJVRNisky9P7jP2J_NGW2oaxX4oJZw@mail.gmail.com>
References: <1430908148-201129-1-git-send-email-mika.westerberg@linux.intel.com>
	<1430908148-201129-4-git-send-email-mika.westerberg@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1430908148-201129-4-git-send-email-mika.westerberg@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Alexandre Courbot <gnurou@gmail.com>, Octavian Purdila <octavian.purdila@intel.com>, Robert Dolca <robert.dolca@intel.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

On Wed, May 6, 2015 at 12:29 PM, Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:

> Following what DT already does. If the device does not have ACPI Interrupt
> resource but instead it has one or more GpioInt resources listed below it,
> we take the first GpioInt resource, convert it to suitable Linux IRQ number
> and pass it to the driver instead.
>
> This makes drivers simpler because the don't need to care about GPIOs at
> all if only thing they need is interrupt.
>
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Need Wolfram's ACK on this too, for funneling through the GPIO tree.

Yours,
Linus Walleij
