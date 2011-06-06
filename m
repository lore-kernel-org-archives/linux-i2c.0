From: Pavan Savoy <pavan_savoy@sify.com>
Subject: Re: [PATCH] NFC: Driver for Inside Secure MicroRead NFC chip
Date: Mon, 6 Jun 2011 15:22:01 -0500
Message-ID: <BANLkTimsZeqvSWj+kKWLSmFOQc70KWodcw@mail.gmail.com>
References: <1300444824-13713-1-git-send-email-waldemar.rymarkiewicz@tieto.com>
	<20110325142648.GC3879@sortiz-mobl>
	<99B09243E1A5DA4898CDD8B7001114481085E2375D@EXMB04.eu.tieto.com>
	<201103291305.02293.arnd@arndb.de>
	<20110331141650.GB2704@sortiz-mobl>
	<99B09243E1A5DA4898CDD8B7001114481085F0FE7C@EXMB04.eu.tieto.com>
	<20110331153010.GD2704@sortiz-mobl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20110331153010.GD2704@sortiz-mobl>
Sender: linux-kernel-owner@vger.kernel.org
To: Samuel Ortiz <sameo@linux.intel.com>
Cc: Waldemar.Rymarkiewicz@tieto.com, arnd@arndb.de, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, hthebaud@insidefr.com, matti.j.aaltonen@nokia.com, alan@lxorguk.ukuu.org.uk, Sebastian.Chlad@tieto.com
List-Id: linux-i2c@vger.kernel.org

On Thu, Mar 31, 2011 at 9:30 AM, Samuel Ortiz <sameo@linux.intel.com> w=
rote:
> On Thu, Mar 31, 2011 at 06:24:50PM +0300, Waldemar.Rymarkiewicz@tieto=
=2Ecom wrote:
>> Hi Samuel,
>>
>> >That's the Bluetooth approach, and it works just fine as well.
>> >However, the netlink option for sending commands and receiving
>> >answers to/from a subsystem sounds more appropriate, at least to me=
=2E
>>
>> I haven't used netlink in practice, so just wondering why netlink. I=
 assume, then, it's more suitable :)
>>
> Have a look at the wireless nl80211.c implementation. It's a good exa=
mple for
> that sort of usage.

So, why was the network interface 'ala eth0 or the netlink interface dr=
opped?
I saw these patches recently "NFC: add nfc subsystem core" - which
seem to add just the device /dev/nfc - am I correct ?
Or missing something ?

> Cheers,
> Samuel.
>
> --
> Intel Open Source Technology Centre
> http://oss.intel.com/
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kerne=
l" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
> Please read the FAQ at =C2=A0http://www.tux.org/lkml/
>
>
>
