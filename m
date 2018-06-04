From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v9 0/7] i2c: Add FSI-attached I2C master algorithm
Date: Mon, 4 Jun 2018 22:22:33 +0300
Message-ID: <CAHp75VeZGSUmrfL_Kf2XmUDpftA==AUPBw-m6sQBJqm0bHD+iw@mail.gmail.com>
References: <1528138850-18259-1-git-send-email-eajames@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1528138850-18259-1-git-send-email-eajames@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Eddie James <eajames@linux.vnet.ibm.com>
Cc: linux-i2c <linux-i2c@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, devicetree <devicetree@vger.kernel.org>, Wolfram Sang <wsa@the-dreams.de>, Rob Herring <robh+dt@kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Joel Stanley <joel@jms.id.au>, Mark Rutland <mark.rutland@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>
List-Id: linux-i2c@vger.kernel.org

On Mon, Jun 4, 2018 at 10:00 PM, Eddie James <eajames@linux.vnet.ibm.com> wrote:
> This series adds an algorithm for an I2C master physically located on an FSI
> slave device. The I2C master has multiple ports, each of which may be connected
> to an I2C slave. Access to the I2C master registers is achieved over FSI bus.
>
> Due to the multi-port nature of the I2C master, the driver instantiates a new
> I2C adapter for each port connected to a slave. The connected ports should be
> defined in the device tree under the I2C master device.
>

Thanks for an update.
With some minor comments this looks indeed excellent work!

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Changes since v8
>  - Drop unecessary else statements
>  - Use i++ instead of ++i
>  - Use kzalloc/kfree instead of devm_kzalloc/devm_kfree for port structure
>  - Drop the list_empty check in remove
>
> Changes since v7
>  - Fix grammer in Kconfig (a -> an)
>  - Change I2C registers to use BIT and GENMASK
>  - Remove custom macros and use FIELD_PREP and FIELD_GET
>  - Fix a few unecessary initializations and "return rc" that are always zero
>  - Clean up the read/write fifo functions a bit
>  - Few other clean-up items
>
> Changes since v6
>  - Remove spinlock for reset functionality; it's unecessary and doesn't work
>    with the latest FSI core.
>  - Use a mutex instead of a semaphore, and don't wait for timeout to get the
>    lock.
>  - Use usleeps instead of schedule_timeout; it's not worth the overhead when
>    the wait should be very short in between sending the command and receiving
>    the response.
>
> Changes since v5
>  - Fix reset functionality and do a reset after every transfer failure
>
> Eddie James (7):
>   dt-bindings: i2c: Add FSI-attached I2C master dt binding documentation
>   i2c: Add FSI-attached I2C master algorithm
>   i2c: fsi: Add port structures
>   i2c: fsi: Add abort and hardware reset procedures
>   i2c: fsi: Add transfer implementation
>   i2c: fsi: Add I2C master locking
>   i2c: fsi: Add bus recovery
>
>  Documentation/devicetree/bindings/i2c/i2c-fsi.txt |  40 ++
>  drivers/i2c/busses/Kconfig                        |  11 +
>  drivers/i2c/busses/Makefile                       |   1 +
>  drivers/i2c/busses/i2c-fsi.c                      | 721 ++++++++++++++++++++++
>  4 files changed, 773 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/i2c/i2c-fsi.txt
>  create mode 100644 drivers/i2c/busses/i2c-fsi.c
>
> --
> 1.8.3.1
>



-- 
With Best Regards,
Andy Shevchenko
