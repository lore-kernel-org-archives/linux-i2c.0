From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 1/2] i2c: piix4: Use request_muxed_region
Date: Tue, 13 Feb 2018 06:11:48 -0800
Message-ID: <d9ed7023-84b3-366c-ac6b-74194aeffc78@roeck-us.net>
References: <1514652658-6228-1-git-send-email-linux@roeck-us.net>
 <20180212111041.027edd85@endymion> <20180212185152.GA20877@roeck-us.net>
 <ca8f74c0-c249-7698-21f7-e3ee49cd5516@pr.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <ca8f74c0-c249-7698-21f7-e3ee49cd5516@pr.hu>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?B?QsO2c3rDtnJtw6lueWkgWm9sdMOhbg==?= <zboszor@pr.hu>, Jean Delvare <jdelvare@suse.de>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On 02/13/2018 03:48 AM, Böszörményi Zoltán wrote:
> 2018-02-12 19:51 keltezéssel, Guenter Roeck írta:
>> On Mon, Feb 12, 2018 at 11:10:41AM +0100, Jean Delvare wrote:
>>> Hi Guneter,
>>>
>>> Sorry for the delay :(
>>>
>>> On Sat, 30 Dec 2017 08:50:57 -0800, Guenter Roeck wrote:
>>>> Accesses to SB800_PIIX4_SMB_IDX can occur from multiple drivers.
>>>> Use request_muxed_region() to ensure synchronization.
>>>
>>> Which ones? Documenting it, at least in the commit message, would seem
>>> useful. Out of curiosity, have these other drivers been converted to
>>> use request_muxed_region already?
>>>
>> Primarily watchdog, but there is also unprotected initialization code
>> in several locations.
> 
> There are three locations touching the same I/O ports:
> the PCI-USB quirks code (still doesn't use locking AFAIK), i2c-piix4 and
> the sp5100_tco watchdog drivers.
> 

There are a few more in arch code, though probably not all of those (or maybe none ?)
are relevant.

arch/x86/kernel/quirks.c
arch/x86/kernel/early-quirks.c
arch/x86/pci/fixup.c
arch/mips/loongson64/loongson-3/acpi_init.c
drivers/usb/host/pci-quirks.c
drivers/watchdog/sp5100_tco.[ch]
drivers/i2c/busses/i2c-piix4.c

Guenter
