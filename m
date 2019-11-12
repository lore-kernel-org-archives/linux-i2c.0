From: "Agrawal, Akshu" <aagrawal2@amd.com>
Subject: Re: [PATCH] i2c: i2c-cros-ec-tunnel: Make the device acpi compatible
Date: Tue, 12 Nov 2019 12:21:42 +0530
Message-ID: <f4a5228d-0fcb-c64d-ecde-8dd20c39899f@amd.com>
References: <20191111161431.26293-1-akshu.agrawal@amd.com>
 <a5f6a3a9-8eb7-58fd-a624-718374c2437f@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <a5f6a3a9-8eb7-58fd-a624-718374c2437f@collabora.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>, Akshu Agrawal <akshu.agrawal@amd.com>
Cc: cychiang@chromium.org, rrangel@chromium.org, Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>, Wolfram Sang <wsa@the-dreams.de>, Mark Brown <broonie@kernel.org>, Neil Armstrong <narmstrong@baylibre.com>, "open list:I2C SUBSYSTEM HOST DRIVERS" <linux-i2c@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org


> Reviewed-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
>
> Question: Is this supported on older firmwares or is only expected to work on
> newer ACPI-based devices?

This is for new devices and we are yet to push Coreboot patch populating the entry.

Thanks,

Akshu
