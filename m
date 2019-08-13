From: Max Staudt <max@enpas.org>
Subject: Re: [PATCH v2 1/4] i2c/busses: Add i2c-icy for I2C on m68k/Amiga
Date: Tue, 13 Aug 2019 11:50:02 +0200
Message-ID: <09642ea4-03b0-36be-1d52-6ef5e09f20d0@enpas.org>
References: <20190812235237.21797-1-max@enpas.org>
 <CAMuHMdWCm9peP9P5_6KBC63cMHXiC3p1oycb0DvKqEd8G4Nx6g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAMuHMdWCm9peP9P5_6KBC63cMHXiC3p1oycb0DvKqEd8G4Nx6g@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux I2C <linux-i2c@vger.kernel.org>, linux-hwmon@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>, Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, Linux/m68k <linux-m68k@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
List-Id: linux-i2c@vger.kernel.org

On 08/13/2019 09:08 AM, Geert Uytterhoeven wrote:
>> +       dev_info(&z->dev, "ICY I2C controller at %#x, IRQ not implemented\n",
>> +                z->resource.start);
> 
> z->resource.start has type phys_addr_t, so you should pas a reference, and
> use %pa to print it.
> Alternatively, you can print the full resource using %pR.
> See Documentation/core-api/printk-formats.rst

Ack, this snuck in from the early days. Thanks for pointing this out!


Max
