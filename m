From: Max Staudt <max@enpas.org>
Subject: Re: [PATCH] i2c/busses: Add i2c-icy for I2C on m68k/Amiga
Date: Tue, 13 Aug 2019 00:21:03 +0200
Message-ID: <0d61e12f-5fc5-7cb6-755f-298ebf4c935f@enpas.org>
References: <20190811043253.24938-1-max@enpas.org>
 <CAMuHMdVJJxjH-gPraW==smrkOOMcGYPKB8BPzrYPU4bstASX3A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAMuHMdVJJxjH-gPraW==smrkOOMcGYPKB8BPzrYPU4bstASX3A@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux I2C <linux-i2c@vger.kernel.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Linux/m68k <linux-m68k@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
List-Id: linux-i2c@vger.kernel.org

On 08/12/2019 11:37 AM, Geert Uytterhoeven wrote:
>> +       iowrite8(val, address);
> 
> As this is on a Zorro bus, z_writeb()?

I forgot to ask about this.

What is the reasoning behind having a separate z_writeb() for Zorro?
As far as I can see in arch/m68k/include/asm this maps 1:1 to a direct memory access, and it prohibits cross-arch code as in i2c-elektor.


Thanks,
Max
