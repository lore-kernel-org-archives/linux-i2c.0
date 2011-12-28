From: Carsten Behling <carsten.behling-0M7HhAU3Y85FsXB23wyQUg@public.gmane.org>
Subject: AW: [PATCH v7 0/5] AT91: replace broken TWI driver i2c-at91.c
Date: Wed, 28 Dec 2011 14:36:44 +0100
Message-ID: <D99582E5322435468A77E74BB0039E7B1D18739F99@SRV02.hamburg.garz-fricke.de>
References: <cover.1322062555.git.n.voss@weinmann.de>
 <4ECFB755.6060509@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4ECFB755.6060509-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Content-Language: de-DE
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Hubert Feurstein <h.feurstein-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Nikolaus Voss <n.voss-+umVssTZoCsb1SvskN2V4Q@public.gmane.org>
Cc: "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi,

I've tested this driver with the pca953x GPIO expander driver with a PC=
A9554.

In the case of 8 GPIO pins (my case) "i2c_smbus_read_byte_data(...)"
is called to read the registers of the GPIO expander. This results in a=
 at91_twi_xfer with two messages. The first message is to put the regis=
ter address into the IADR and the second is to read the one byte conten=
t of the register.

At the end we have a one byte read with a repeated start condition.=20

I observed that reading out the GPIO status is one read delayed.
The first read to a register from the pca953x driver does not result in=
 a RXRDY interrupt and at91_twi_read_next_byte(...) is not called.
Only the completion routine is triggered with a TXCOMP interrupt.

Additionally, I took a look at the status flags just after the control =
flags are set (in at91_do_twi_transfer(...), AT91_TWI_START|AT91_TWI_ST=
OP for the one byte read). Surprisingly, the AT91_TWI_RXRDY flag is zer=
o before the first register read and one for the following reads. Accor=
ding to the manual this flag should be zero after a read on AT91_TWI_RH=
R.

Reading the AT91_TWI_RHR before the control flags are set to be sure th=
at the AT91_TWI_RXRDY is cleared leads to a never occurring RXRDY inter=
rupt.

This looks very strange to me. Can anyone help?

Mit freundlichen Gr=FC=DFen / Best regards
Carsten Behling

Development Engineer
Garz & Fricke GmbH
Tempowerkring 2, 21079 Hamburg - Germany
Amtsgericht Hamburg HRB 60514
Gesch=E4ftsf=FChrer: Manfred Garz, Matthias Fricke
Phone: +49 (0) 40 791 899 - 56
=46ax:    +49 40 / 791 899 - 39
www.garz-fricke.com=20

=20


-----Urspr=FCngliche Nachricht-----
Von: Hubert Feurstein [mailto:h.feurstein-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org]=20
Gesendet: Freitag, 25. November 2011 16:42
An: Nikolaus Voss
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org; li=
nux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org; Carsten Behling
Betreff: Re: [PATCH v7 0/5] AT91: replace broken TWI driver i2c-at91.c

Hi,

I've tested this driver on a 2.6.38 kernel with several i2c clients
(temp-sensor, audio-codec, touchscreen-controller, w1-bridge,
io-expanders) and works without problems. SoC: at91sam9g45

Because of the 2.6.38 kernel, I had to skip "[PATCH v7 2/5] Replace
clk_lookup.con_id with clk_lookup.dev_id entries for twi clk" and used
instead: at91_clock_associate("twi0_clk", &at91sam9g45_twi0_device.dev,
"twi_clk");

Best Regards
Hubert

On 2011-11-23 16:35, Nikolaus Voss wrote:
> The old driver has two main deficencies:
> i)  No repeated start (Sr) condiction is possible, this makes it unus=
able
>     e.g. for most SMBus transfers.
> ii) I/O was done with polling/busy waiting what caused over-/underrun=
s
>     even at light system loads and clock speeds.
>=20
> The new driver overcomes these deficencies and in addition allows for
> more than one TWI interface.
>=20

Tested-by: Hubert Feurstein <h.feurstein-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
