From: =?UTF-8?B?QsO2c3rDtnJtw6lueWkgWm9sdMOhbg==?= <zboszor@pr.hu>
Subject: Re: [PATCH 1/2] i2c: piix4: Use request_muxed_region
Date: Tue, 13 Feb 2018 12:48:37 +0100
Message-ID: <ca8f74c0-c249-7698-21f7-e3ee49cd5516@pr.hu>
References: <1514652658-6228-1-git-send-email-linux@roeck-us.net>
 <20180212111041.027edd85@endymion> <20180212185152.GA20877@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180212185152.GA20877@roeck-us.net>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Guenter Roeck <linux@roeck-us.net>, Jean Delvare <jdelvare@suse.de>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

2018-02-12 19:51 keltezéssel, Guenter Roeck írta:
> On Mon, Feb 12, 2018 at 11:10:41AM +0100, Jean Delvare wrote:
>> Hi Guneter,
>>
>> Sorry for the delay :(
>>
>> On Sat, 30 Dec 2017 08:50:57 -0800, Guenter Roeck wrote:
>>> Accesses to SB800_PIIX4_SMB_IDX can occur from multiple drivers.
>>> Use request_muxed_region() to ensure synchronization.
>>
>> Which ones? Documenting it, at least in the commit message, would seem
>> useful. Out of curiosity, have these other drivers been converted to
>> use request_muxed_region already?
>>
> Primarily watchdog, but there is also unprotected initialization code
> in several locations.

There are three locations touching the same I/O ports:
the PCI-USB quirks code (still doesn't use locking AFAIK), i2c-piix4 and
the sp5100_tco watchdog drivers.

Best regards,
Zoltán Böszörményi
