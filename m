From: Aloisio Almeida <aloisio.almeida-430g2QfJUUCGglJvpFV4uA@public.gmane.org>
Subject: Re: [PATCH] NFC: Driver for Inside Secure MicroRead NFC chip
Date: Fri, 1 Apr 2011 15:19:30 -0300
Message-ID: <AANLkTikjTAFrhS7_P+KJ-r-33K6fW2+63OnLhjXE-u0k@mail.gmail.com>
References: <1300444824-13713-1-git-send-email-waldemar.rymarkiewicz@tieto.com>
 <20110325142648.GC3879@sortiz-mobl> <99B09243E1A5DA4898CDD8B7001114481085E2375D@EXMB04.eu.tieto.com>
 <201103291305.02293.arnd@arndb.de> <20110331141650.GB2704@sortiz-mobl>
 <99B09243E1A5DA4898CDD8B7001114481085F0FE5A@EXMB04.eu.tieto.com>
 <20110331150939.GC2704@sortiz-mobl> <99B09243E1A5DA4898CDD8B7001114481085F0FE7C@EXMB04.eu.tieto.com>
 <20110331153010.GD2704@sortiz-mobl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20110331153010.GD2704@sortiz-mobl>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: Waldemar.Rymarkiewicz-++hxYGjEMp0AvxtiuMwx3w@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, hthebaud-Umy9UjvE/gtWk0Htik3J/w@public.gmane.org, matti.j.aaltonen-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org, alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org, Sebastian.Chlad-++hxYGjEMp0AvxtiuMwx3w@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi all,

On Thu, Mar 31, 2011 at 12:30 PM, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org> =
wrote:
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

We are finalizing a NFC stack prototype and we decided to use generic
netlink. But during the implementation we found a disadvantage of this
approach.

While implementing data_exchange through netlink, it was not possible
to avoid memcpy as the skbuff coming from netlink can contain more
than one message.

We didn't find any implementation that uses netlink to exchage data.
As in the nl80211, the netlink is used only for control commands.

We plan to publish for comments this prototype early next week. Then
we plan to implement a version using AF_NFC.

Regards,

Aloisio Almeida Jr
INdT - Instituto Nokia de Tecnologia

> Cheers,
> Samuel.
>
> --
> Intel Open Source Technology Centre
> http://oss.intel.com/
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kerne=
l" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at =A0http://www.tux.org/lkml/
>
