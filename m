From: Peter Rosin <peda@axentia.se>
Subject: Re: [PATCH 1/5] i2c: smbus: add unlocked __i2c_smbus_xfer variant
Date: Wed, 27 Jun 2018 06:18:55 +0200
Message-ID: <58972586-68FD-4FD6-8B38-E7CA93D2131E@axentia.se>
References: <20180620085157.30121-1-peda@axentia.se> <20180620085157.30121-2-peda@axentia.se> <20180626023757.l54suaryim2fieq3@ninjato> <79E4A06C-26EF-4FF4-AFEA-7E7769FDF995@axentia.se> <20180626134606.h4ciolw23t6qnrjb@ninjato>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180626134606.h4ciolw23t6qnrjb@ninjato>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-kernel@vger.kernel.org, Vadim Pasternak <vadimp@mellanox.com>, Michael Shych <michaelsh@mellanox.com>, Guenter Roeck <linux@roeck-us.net>, Akinobu Mita <akinobu.mita@gmail.com>, Jean Delvare <jdelvare@suse.com>, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On June 26, 2018 3:46:07 PM GMT+02:00, Wolfram Sang <wsa@the-dreams=2Ede> w=
rote:
>> I don't think it's that easy as I just thought about another problem
>> with lifting the locking from the emulation function=2E It calls
>> kzalloc(=2E=2E=2E, GFP_KERNEL), at least in some cases, and that's not =
a
>> very good idea from atomic/irq context=2E=2E=2E
>
>Right=2E However, we could simply bail out early when we are in atomic
>context=2E Simply no DMA then=2E=2E=2E

Yeah, we could bail out early, and perhaps we should=2E But we risk regres=
sions, see below=2E=2E=2E

And that should probably be fixed before we add the unlocked __i2c_smbus_x=
fer function=2E

Because, thinking more about it, the problem with those allocs are not rel=
ated to the locking details; adding another trylock to the mix just makes i=
t so much more obvious=2E I mean, first we would specifically handle atomic=
/irq context with a trylock "documenting" that atomic/irq users are welcome=
 to at least try xfers, and then we blattantly break the rulez with a GFP_K=
ERNEL alloc=2E=2E=2E

Also, the fact that the buffer is DMA-friendly does not mean that DMA is a=
ctually going to be used, so the patch that introduced those allocs might h=
ave regressed for this case:
- SMBus user from atomic/irq context
- SMBus emulated
- emulation triggering a GFP_KERNEL alloc
- the existing trylock in i2c_transfer succeeding
- driver not ending up doing DMA

Bailing out would break these users, always=2E Currently, I assume they ar=
e only broken when the alloc happens to need to do more than is allowed fro=
m the given context=2E Something which might or might not be common?

But as usual, I might be missing something=2E=2E=2E

Cheers,
Peter
