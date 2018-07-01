From: Peter Rosin <peda@axentia.se>
Subject: Re: [PATCH 1/5] i2c: smbus: add unlocked __i2c_smbus_xfer variant
Date: Sun, 01 Jul 2018 18:40:06 +0200
Message-ID: <4570C1C1-1494-41B8-846F-CB906949C46B@axentia.se>
References: <20180620085157.30121-1-peda@axentia.se> <20180620085157.30121-2-peda@axentia.se> <20180626023757.l54suaryim2fieq3@ninjato> <79E4A06C-26EF-4FF4-AFEA-7E7769FDF995@axentia.se> <20180626134606.h4ciolw23t6qnrjb@ninjato> <58972586-68FD-4FD6-8B38-E7CA93D2131E@axentia.se> <20180627070818.4zb3i557qjiicsv7@katana> <20180701121320.uwhnaggm2wmijkrw@ninjato>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180701121320.uwhnaggm2wmijkrw@ninjato>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-kernel@vger.kernel.org, Vadim Pasternak <vadimp@mellanox.com>, Michael Shych <michaelsh@mellanox.com>, Guenter Roeck <linux@roeck-us.net>, Akinobu Mita <akinobu.mita@gmail.com>, Jean Delvare <jdelvare@suse.com>, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On July 1, 2018 2:13:20 PM GMT+02:00, Wolfram Sang <wsa@the-dreams=2Ede> wr=
ote:
>On Wed, Jun 27, 2018 at 09:08:18AM +0200, Wolfram Sang wrote:
>>=20
>> > Because, thinking more about it, the problem with those allocs are
>not
>> > related to the locking details; adding another trylock to the mix
>just
>> > makes it so much more obvious=2E I mean, first we would specifically
>> > handle atomic/irq context with a trylock "documenting" that
>atomic/irq
>> > users are welcome to at least try xfers, and then we blattantly
>break
>> > the rulez with a GFP_KERNEL alloc=2E=2E=2E
>>=20
>> Yes, thinking more about it, I came to the conclusion that we should
>not
>> add trylock to SMBus and keep the requirement to allow sleeping=2E
>>=20
>> True, SMBus is not consistent with I2C then, but actually, I'd prefer
>> the consistency the other way around: I wish we had a clear statement
>> that i2c_transfer may sleep=2E And have a dedicated irqless,
>non-sleeping
>> callback for handling the atomic case instead=2E
>>=20
>> I really don't like the commit which introduced the trylock
>> into i2c_transfer[1]=2E Its commit message even says: "It is the
>> reponsability of the caller to ensure that the underlying i2c bus
>driver
>> will not sleep either=2E" Which seems broken to me because I can't see
>how
>> the caller should do that? And most bus drivers will sleep=2E But that
>> commit is upstream for 10 years now, so there are probably users=2E
>Which
>> also are very hard to spot, I am afraid=2E I wouldn't see a way to
>convert
>> them off the top of my head=2E
>>=20
>> [1] cea443a81c9c ("i2c: Support i2c_transfer in atomic contexts")
>>=20
>> > Currently, I assume they are only broken when the alloc happens to
>> > need to do more than is allowed from the given context=2E Something
>> > which might or might not be common?
>>=20
>> The only regression now would be using smbus_emulated from atomic
>> context=2E Which is a bug on the caller side because it cannot know if
>> smbus_emulated will be used or not=2E For the non-emulated case, it
>must
>> not be atomic anyhow=2E
>>=20
>> So, unless I overlooked something, if we decide to not add trylock to
>> smbus_xfer, we are all fine?
>>=20
>> And I think we should really keep this clean rule of smbus functions
>> being non-atomic=2E
>>=20
>> D'accord?
>
>So, if no other arguments drop in, I'll apply this series as is next
>week=2E

Right, I had the below response sitting in my drafts folder=2E  I thought =
I had sent it, but apparently I didn't=2E=2E=2E



Well, IF there are SMBus users that in fact do rely on the emulation allow=
ing calls from atomic/irq context then it will be a regression even if thos=
e users are "buggy"=2E But if someone complains, I think the correct respon=
se is to open-code the trylock dance and call the new unlocked __i2c_smbus_=
xfer at the affected location=2E So, I think we have a contingency plan=2E

Other than that, we are in violent agreement, and I think you also agree w=
ith the above=2E

I guess that also means the series is fine as-is (modulo the fixes recentl=
y made in the tail of the first hunk of patch 1/5 that causes a trivial but=
 annoying conflict when applying it, i=2Ee=2E below the i2c_transfer -> __i=
2c_transfer update in the emulation function)=2E

As far as I'm concerned, you can take this whole series directly even if m=
ost patches are i2c-mux patches=2E I don't have anything in my tree yet so =
I'll simply base any other stuff on this once I can fetch it from you=2E=2E=
=2E

Ok?

Cheers,
Peter
