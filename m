From: Max Staudt <max@enpas.org>
Subject: Re: [PATCH] i2c/busses: Add i2c-icy for I2C on m68k/Amiga
Date: Mon, 12 Aug 2019 13:48:41 +0200
Message-ID: <befbe9c2-b975-757e-5ebc-caec1f8987d7@enpas.org>
References: <20190811043253.24938-1-max@enpas.org>
 <CAMuHMdVJJxjH-gPraW==smrkOOMcGYPKB8BPzrYPU4bstASX3A@mail.gmail.com>
 <fe5cf25f-1804-dc45-7010-01e602b3f3e5@enpas.org>
 <CAMuHMdUum4Dubx8EOsSakaNfLp4-Yyzsutfkvb_+i5mqtOtkKw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAMuHMdUum4Dubx8EOsSakaNfLp4-Yyzsutfkvb_+i5mqtOtkKw@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux I2C <linux-i2c@vger.kernel.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Linux/m68k <linux-m68k@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
List-Id: linux-i2c@vger.kernel.org

On 08/12/2019 01:07 PM, Geert Uytterhoeven wrote:
>> It sets the sensor modes in the LTC2990 and enables the three sensors listed below. I should have clarified this.
>>
>> I tried to integrate this in the driver, but ltc2990 only allows reading this configuration out of a device tree. Is there a good way to fake a DT entry in the init function?
> 
> You can add platform_data support to the ltc2990 driver, and pass it
> through i2c_board_info.platform_data.

Thanks, that sounds good and I'll look into it.

Max
