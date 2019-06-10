From: Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v12 1/1] Add support for IPMB driver
Date: Mon, 10 Jun 2019 14:55:30 -0700
Message-ID: <54f3c0e0-7aaa-9078-5328-50e8f709ebae@infradead.org>
References: <cover.1560192707.git.Asmaa@mellanox.com>
 <319690553a0da2a1e80b400941341081b383e5f1.1560192707.git.Asmaa@mellanox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <319690553a0da2a1e80b400941341081b383e5f1.1560192707.git.Asmaa@mellanox.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Asmaa Mnebhi <Asmaa@mellanox.com>, minyard@acm.org, wsa@the-dreams.de, vadimp@mellanox.com, michaelsh@mellanox.com
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On 6/10/19 11:57 AM, Asmaa Mnebhi wrote:
> Support receiving IPMB requests on a Satellite MC from the BMC.
> Once a response is ready, this driver will send back a response
> to the BMC via the IPMB channel.
> 
> Signed-off-by: Asmaa Mnebhi <Asmaa@mellanox.com>
> Acked-by: vadimp@mellanox.com
> ---
>  Documentation/IPMB.txt           | 103 +++++++++++
>  drivers/char/ipmi/Kconfig        |   8 +
>  drivers/char/ipmi/Makefile       |   1 +
>  drivers/char/ipmi/ipmb_dev_int.c | 364 +++++++++++++++++++++++++++++++++++++++
>  4 files changed, 476 insertions(+)
>  create mode 100644 Documentation/IPMB.txt
>  create mode 100644 drivers/char/ipmi/ipmb_dev_int.c
> 
> diff --git a/Documentation/IPMB.txt b/Documentation/IPMB.txt
> new file mode 100644
> index 0000000..7160d53
> --- /dev/null
> +++ b/Documentation/IPMB.txt
> @@ -0,0 +1,103 @@

[...]

> +Instantiate the device
> +----------------------
> +
> +After loading the driver, you can instantiate the device as
> +described in 'Documentation/i2c/instantiating-devices'.
> +If you have multiple BMCs, each connected to your Satellite MC via
> +a different I2C bus, you can instantiate a device for each of
> +those BMCs.
> +The name of the instantiated device contains the I2C bus number
> +associated with it as follows:
> +
> +BMC1 ------ IPMB/I2C bus 1 ---------|   /dev/ipmb-1
> +				Satellite MC
> +BMC1 ------ IPMB/I2C bus 2 ---------|   /dev/ipmb-2
> +
> +For instance, you can instantiate the ipmb-dev-int device from
> +user space at the 7 bit address 0x10 on bus 2:
> +
> +  # echo ipmb-dev 0x1010 > /sys/bus/i2c/devices/i2c-2/new_device

This is confusing.

Can you clarify how the 7-bit address is extracted from that hex number?
Is the 7-bit address repeated (duplicated)?
Is the 7-bit address the low order (low bits) 0x10 or the 0x10 at bits
15-8 (or 14-8)?

> +This will create the device file /dev/ipmb-2, which can be accessed
> +by the user space program. The device needs to be instantiated
> +before running the user space program.

thanks.
-- 
~Randy
