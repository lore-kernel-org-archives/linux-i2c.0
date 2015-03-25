From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH] eeprom: at24: Add support for large EEPROMs connected
 to SMBus adapters
Date: Wed, 25 Mar 2015 07:11:31 -0700
Message-ID: <5512C213.7030705@roeck-us.net>
References: <20150205002630.GA396@roeck-us.net> <20150205144028.GA4865@katana> <20150205175326.GA26691@roeck-us.net> <20150212040126.GA1691@roeck-us.net> <20150216120951.GA2840@katana> <20150317042049.GA6765@roeck-us.net> <20150318132707.GD3580@katana> <550A4162.8000009@roeck-us.net> <20150319081612.GA900@katana> <20150319174314.GA17329@roeck-us.net> <20150319213937.GA899@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150319213937.GA899@katana>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On 03/19/2015 02:39 PM, Wolfram Sang wrote:
>
>> Turns out this is really easy to reproduce. One process reads
>> the eeprom over and over again, another runs i2cdump in a loop,
>> and voila ... lots of corruptions. Scary, especially considering
>> how wide-spread this kind of i2c access is in the kernel.
>
> A coccinelle script should at least be able to find vulnerable code
> paths, maybe even fix it. But not today for me... Thanks for testing and
> sharing the results!
>

Wolfram,

just to give you an update: I do have some code, but it is a bit messy,
and it doesn't work well for ds2482 (the chip behind it still hangs up
if I access it in parallel through i2c-dev). On top of that, it causes
pretty significant slow-downs when accessing other devices on the same
bus at the same time. Not surprising, I guess, since it expands the scope
of the bus lock significantly.

I thought about introducing a client lock, but that does not work because
of the way i2c-dev is written (creating its own 'shadow' client structure).
An address lock (ie a client lock based on <bus, address> instead of one
residing in the client structure) seems to be too expensive.

So right now I don't really know how to proceed, or if to proceed at all.
I'll think about it some more, but given how wide-spread the problem is
in the kernel, I might just leave it alone, and keep the at24 changes
out of tree.

Ultimately, the real problem is how i2c-dev accesses a client, not how
i2c client drivers (who assume they have exclusive access to a chip)
handle multi-command sequences. Forcing extensive locking on all drivers
because of i2c-dev just doesn't seem to be the right thing to do.

Guenter
