From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v3 0/6] Add Advantech iManager EC driver set
Date: Sun, 10 Jan 2016 16:54:40 -0800
Message-ID: <5692FD50.5010407@roeck-us.net>
References: <1452468675-5827-1-git-send-email-richard.dorsch@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1452468675-5827-1-git-send-email-richard.dorsch@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: richard.dorsch@gmail.com, linux-kernel@vger.kernel.org
Cc: lm-sensors@lm-sensors.org, linux-i2c@vger.kernel.org, linux-watchdog@vger.kernel.org, linux-gpio@vger.kernel.org, lee.jones@linaro.org, jdelvare@suse.com, wim@iguana.be, jo.sunga@advantech.com
List-Id: linux-i2c@vger.kernel.org

On 01/10/2016 03:31 PM, richard.dorsch@gmail.com wrote:
> From: Richard Vidal-Dorsch <richard.dorsch@gmail.com>
>
> The Advantech iManager is an embedded controller (depending on board type,
> ITE it8518/it8528) on which a custom firmware runs. All drivers (GPIO, I2C,
> HWmon, Watchdog, and backlight) are being managed by the imanager mfd driver.
> The imanager mfd driver acts as a 'gateway' and handles all communications
> between the EC and sub-drivers (GPIO, I2C, ...). The feature specific
> communication portions are split up into core files such as
> imanager-ec-[gpio, i2c, ...].
>
> Changes from v2:
> I forgot to remove .owner from other drivers too... silly me!
> - Remove .owner from platform_driver in:
>    drivers/gpio/imanager-bl
>    drivers/gpio/imanager-core.c
>    drivers/gpio/imanager-i2c.c
>    drivers/gpio/imanager-hwmon.c
>

Hi Richard,

in case there are more alerts from the 0day build system, or minor feedback
from others, please give us time to actually review the code before
resending the series. I have not even had time to look into v1 (and I bet
no one else had either), and you already sent v3, just to remove various
.owner fields.

Also, please be a bit patient. The commit window just opened, meaning
all maintainers will be busy preparing to send pull requests to Linus.

Thanks,
Guenter
