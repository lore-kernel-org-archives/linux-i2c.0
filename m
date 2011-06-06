From: Pavan Savoy <pavan_savoy-OuV/mKzhOIQ@public.gmane.org>
Subject: Re: [PATCH] NFC: Driver for Inside Secure MicroRead NFC chip
Date: Mon, 6 Jun 2011 15:30:42 -0500
Message-ID: <BANLkTim9tyZXhLUxzHL2K-nWtujsJTB0fw@mail.gmail.com>
References: <1300444824-13713-1-git-send-email-waldemar.rymarkiewicz@tieto.com>
	<20110325142648.GC3879@sortiz-mobl>
	<99B09243E1A5DA4898CDD8B7001114481085E2375D@EXMB04.eu.tieto.com>
	<201103291305.02293.arnd@arndb.de>
	<20110331141650.GB2704@sortiz-mobl>
	<99B09243E1A5DA4898CDD8B7001114481085F0FE7C@EXMB04.eu.tieto.com>
	<20110331153010.GD2704@sortiz-mobl>
	<BANLkTimsZeqvSWj+kKWLSmFOQc70KWodcw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <BANLkTimsZeqvSWj+kKWLSmFOQc70KWodcw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: Waldemar.Rymarkiewicz-++hxYGjEMp0AvxtiuMwx3w@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, hthebaud-Umy9UjvE/gtWk0Htik3J/w@public.gmane.org, matti.j.aaltonen-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org, alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org, Sebastian.Chlad-++hxYGjEMp0AvxtiuMwx3w@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Mon, Jun 6, 2011 at 3:22 PM, Pavan Savoy <pavan_savoy-OuV/mKzhOIQ@public.gmane.org> wrot=
e:
> On Thu, Mar 31, 2011 at 9:30 AM, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>=
 wrote:
>> On Thu, Mar 31, 2011 at 06:24:50PM +0300, Waldemar.Rymarkiewicz@tiet=
o.com wrote:
>>> Hi Samuel,
>>>
>>> >That's the Bluetooth approach, and it works just fine as well.
>>> >However, the netlink option for sending commands and receiving
>>> >answers to/from a subsystem sounds more appropriate, at least to m=
e.
>>>
>>> I haven't used netlink in practice, so just wondering why netlink. =
I assume, then, it's more suitable :)
>>>
>> Have a look at the wireless nl80211.c implementation. It's a good ex=
ample for
>> that sort of usage.
>
> So, why was the network interface 'ala eth0 or the netlink interface =
dropped?
> I saw these patches recently "NFC: add nfc subsystem core" - which
> seem to add just the device /dev/nfc - am I correct ?
> Or missing something ?

Yes apparently I did miss a whole of patches in the series.
So, for anyone who is interested on the list - this is the proposed
architecture,

http://code.openbossa.org/?p=3Dnfc/linux-nfc.git;a=3Dblob;f=3DDocumenta=
tion/networking/nfc.txt;h=3De17ac191ca958235db99da23786c46c4c60082e9;hb=
=3Df8d3349352063626240ad1c1a15e2361dab81ef4

>> Cheers,
>> Samuel.
>>
>> --
>> Intel Open Source Technology Centre
>> http://oss.intel.com/
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-kern=
el" in
>> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.h=
tml
>> Please read the FAQ at =C2=A0http://www.tux.org/lkml/
>>
>>
>>
>
