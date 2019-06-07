From: Jean Delvare <jdelvare@suse.de>
Subject: Re: [PATCH v5] i2c: i801: Register optional lis3lv02d I2C device on
 Dell machines
Date: Fri, 7 Jun 2019 16:16:40 +0200
Message-ID: <20190607161640.0d90e1b9@endymion>
References: <20190606181845.14091-1-pali.rohar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190606181845.14091-1-pali.rohar@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pali =?UTF-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, =?UTF-8?B?TWljaGHFgiBLxJlwaWXFhA==?= <kernel@kempniu.pl>, Steven Honeyman <stevenhoneyman@gmail.com>, Valdis.Kletnieks@vt.edu, Jochen Eisinger <jochen@penguin-breeder.org>, Gabriele Mazzotta <gabriele.mzt@gmail.com>, Andy Lutomirski <luto@kernel.org>, Mario_Limonciello@dell.com, Alex Hung <alex.hung@canonical.com>, Takashi Iwai <tiwai@suse.de>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Thu,  6 Jun 2019 20:18:45 +0200, Pali Rohár wrote:
> Dell platform team told us that some (DMI whitelisted) Dell Latitude
> machines have ST microelectronics accelerometer at I2C address 0x29.
> 
> Presence of that ST microelectronics accelerometer is verified by existence
> of SMO88xx ACPI device which represent that accelerometer. Unfortunately
> ACPI device does not specify I2C address.
> 
> This patch registers lis3lv02d device for selected Dell Latitude machines
> at I2C address 0x29 after detection. And for Dell Vostro V131 machine at
> I2C address 0x1d which was manually detected.
> 
> Finally commit a7ae81952cda ("i2c: i801: Allow ACPI SystemIO OpRegion to
> conflict with PCI BAR") allowed to use i2c-i801 driver on Dell machines so
> lis3lv02d correctly initialize accelerometer.
> 
> Tested on Dell Latitude E6440.
> 
> Signed-off-by: Pali Rohár <pali.rohar@gmail.com>
> 
> ---
> Changes since v4:
>  * Remove usage of redundant acpi_bus_get_status_handle()
>  * Update comment about acpi_get_devices()
> (...)

Looks all good now.

Reviewed-by: Jean Delvare <jdelvare@suse.de>

Thanks!
-- 
Jean Delvare
SUSE L3 Support
