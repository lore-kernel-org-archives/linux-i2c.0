From: Max <max@enpas.org>
Subject: Re: [PATCH v5 1/3] i2c/busses: Add i2c-icy for I2C on m68k/Amiga
Date: Tue, 20 Aug 2019 11:23:45 +0200
Message-ID: <3F017C0B-44D6-4E63-A908-DDAA5586D67C@enpas.org>
References: <20190819121618.16557-1-max@enpas.org> <CAMuHMdU=18qtZi7N8+i9cJbKVL+pOB-wttnRRu_mOcMNymF_3w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAMuHMdU=18qtZi7N8+i9cJbKVL+pOB-wttnRRu_mOcMNymF_3w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux I2C <linux-i2c@vger.kernel.org>, linux-hwmon@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>, Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, Linux/m68k <linux-m68k@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
List-Id: linux-i2c@vger.kernel.org



On August 20, 2019 11:08:00 AM GMT+02:00, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>> +       int val = z_readb(address);
>> +
>> +       return val;
>
>return z_readb(address);

Argh, that slipped through the cracks. I'll mend it later. Thank you.

Max
