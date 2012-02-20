From: Daniel Kurtz <djkurtz-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH 0/3 v2] i2c: i801: enable irq
Date: Mon, 20 Feb 2012 19:23:10 +0800
Message-ID: <CAGS+omBvULkWsowprvVWkodBxT=diui7g5GtKZ0mb=Uy7DZKtg@mail.gmail.com>
References: <1325847502-17841-1-git-send-email-djkurtz@chromium.org> <20120106123531.3b5ca7db@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120106123531.3b5ca7db-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, seth.heasley-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, ben-/+tVBieCtBitmTQ+vhA3Yw@public.gmane.org, David.Woodhouse-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, olofj-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, bleung-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Fri, Jan 6, 2012 at 7:35 PM, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org> wrote=
:
> Hi Daniel,
>
> On Fri, =A06 Jan 2012 18:58:19 +0800, Daniel Kurtz wrote:
>> This is a second version of a set of patches enables the Intel PCH S=
MBus
>> controller interrupt. =A0It refactors the second two patches a littl=
e bit by
>> relying on DEV_ERR interrupt for timeouts, instead of using an expli=
cit
>> wait_event_timeout.
>>
>> The first attempt received absolutely no response. Maybe this time s=
omeone
>> will be interested.
>
> I was on vacation. But I am very interested and will review and test
> your patches. There have been several attempts to add IRQ support to
> i2c-i801 in the past but each time there was a blocker issue which
> prevented it from making it into mainline. Hopefully this time we'll
> get it there!
>
>>
>> The SMBus Host Controller Interrupt can signify:
>> =A0INTR - the end of a complete transaction
>> =A0DEV_ERR - that a device did not ACK a transaction
>> =A0BYTE_DONE - the completion of a single byte during a byte-by-byte=
 transaction
>>
>> This patchset arrives with the following caveats:
>>
>> =A01) =A0It has only been tested with a Cougar Point (Intel 6 Series=
 PCH) SMBus
>> controller, so the irq is only enabled for that chip type.
>
> I can test on ICH10 easily, and also on ICH7 and ICH3-M if needed.
>
>> =A02) It has not been tested with any devices that do transactions t=
hat use the
>> =A0 =A0 PEC. =A0In fact, I believe that an additional small patch wo=
uld be required
>> =A0 =A0 to the driver working correctly in interrupt mode with PEC.
>>
>> =A03) It has not been tested in SMBus Slave mode.
>>
>> =A04) It has not been tested with SMI#-type interrupts.
>>
>> =A05) The BIOS has to configure the PCH SMBus IRQ properly.
>>
>> =A06) It has not been tested with a device that does byte-by-byte sm=
bus (non-i2c)
>> =A0 =A0 reads.
>
> I think I can test this.
>
>> =A07) It has not been tested with smbus 'process call' transactions.
>
> But not this.
>
>> If would be very helpful if somebody could help test on other chipse=
ts, with
>> a PEC device, or on additional BIOS that woudl be very helpful.
>
> I will do what I can with the hardware I have here.

Jean,
Ping?


>
>> In the meantime, the interrupt behavior is only enabled on the Couga=
r Point,
>> and even here, it can be completely disabled with the "Interrupt" fe=
ature like
>> other advanced features of the driver.
>>
>> Daniel Kurtz (3):
>> =A0 i2c: i801: refactor i801_block_transaction_byte_by_byte
>> =A0 i2c: i801: enable irq for i801 smbus transactions
>> =A0 i2c: i801: enable irq for byte_by_byte transactions
>>
>> =A0drivers/i2c/busses/i2c-i801.c | =A0199 ++++++++++++++++++++++++++=
++++++++++-----
>> =A01 files changed, 175 insertions(+), 24 deletions(-)
>
> --
> Jean Delvare
