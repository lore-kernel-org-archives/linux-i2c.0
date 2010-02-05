From: Philby John <pjohn-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v3 1/2] i2c: Add SDA and SCL pin numbers to i2c platform
	data
Date: Fri, 5 Feb 2010 19:28:22 +0530
Message-ID: <225d086e1002050558n3968f53k83c4267416028be1@mail.gmail.com>
References: <1263295031.3437.16.camel@localhost.localdomain>
	 <B85A65D85D7EB246BE421B3FB0FBB59301E235A3DA@dbde02.ent.ti.com>
Reply-To: pjohn-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB59301E235A3DA-/tLxBxkBPtCIQmiDNMet8wC/G2K4zDHf@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Nori, Sekhar" <nsekhar-l0cyMroinI0@public.gmane.org>
Cc: Philby John <pjohn-k0rHJ+Hhz/SB+jHODAdFcQ@public.gmane.org>, "davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org" <davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hello Sekhar,

On Mon, Feb 1, 2010 at 11:35 AM, Nori, Sekhar <nsekhar-l0cyMroinI0@public.gmane.org> wrote:
> Hi Philby,
>
> On Tue, Jan 12, 2010 at 16:47:11, Philby John wrote:
>> >From cb3347e45449ff16a332aa164eae24ef6a2432e6 Mon Sep 17 00:00:00 2=
001
>> From: Philby John <pjohn-k0rHJ+Hhz/SB+jHODAdFcQ@public.gmane.org>
>> Date: Mon, 11 Jan 2010 15:53:31 +0530
>> Subject: [PATCH 1/2] Add SDA and SCL pin numbers to i2c platform dat=
a
>>
>> Patch adds SDA and SCL pin numbers to the i2c platform data
>> structure for Davinci DM355 and DM6446. This at present is
>> used for i2c bus recovery.
>> TODO: Add SDA and SCL pin number information to include all
>> Davinci platforms such as dm355-leopard, dm365, dm646x, da8xx etc.
>>
>> Signed-off-by: Philby John <pjohn-k0rHJ+Hhz/SB+jHODAdFcQ@public.gmane.org>
>> ---
>> =A0arch/arm/mach-davinci/board-dm355-evm.c =A0| =A0 =A02 ++
>> =A0arch/arm/mach-davinci/board-dm644x-evm.c | =A0 =A02 ++
>> =A0arch/arm/mach-davinci/include/mach/i2c.h | =A0 =A02 ++
>> =A03 files changed, 6 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/arm/mach-davinci/board-dm355-evm.c b/arch/arm/mach=
-davinci/board-dm355-evm.c
>> index 077ecf4..aa48e3f 100644
>> --- a/arch/arm/mach-davinci/board-dm355-evm.c
>> +++ b/arch/arm/mach-davinci/board-dm355-evm.c
>> @@ -111,6 +111,8 @@ static struct platform_device davinci_nand_devic=
e =3D {
>> =A0static struct davinci_i2c_platform_data i2c_pdata =3D {
>> =A0 =A0 =A0 .bus_freq =A0 =A0 =A0 =3D 400 =A0 /* kHz */,
>> =A0 =A0 =A0 .bus_delay =A0 =A0 =A0=3D 0 =A0 =A0 /* usec */,
>> + =A0 =A0 .sda_pin =A0 =A0 =A0 =A0=3D 15,
>> + =A0 =A0 .scl_pin =A0 =A0 =A0 =A0=3D 14,
>> =A0};
>>
>> =A0static struct snd_platform_data dm355_evm_snd_data;
>> diff --git a/arch/arm/mach-davinci/board-dm644x-evm.c b/arch/arm/mac=
h-davinci/board-dm644x-evm.c
>> index e9612cf..976e11b 100644
>> --- a/arch/arm/mach-davinci/board-dm644x-evm.c
>> +++ b/arch/arm/mach-davinci/board-dm644x-evm.c
>> @@ -629,6 +629,8 @@ static struct i2c_board_info __initdata i2c_info=
[] =3D =A0{
>> =A0static struct davinci_i2c_platform_data i2c_pdata =3D {
>> =A0 =A0 =A0 .bus_freq =A0 =A0 =A0 =3D 20 /* kHz */,
>> =A0 =A0 =A0 .bus_delay =A0 =A0 =A0=3D 100 /* usec */,
>> + =A0 =A0 .sda_pin =A0 =A0 =A0 =A0=3D 44,
>> + =A0 =A0 .scl_pin =A0 =A0 =A0 =A0=3D 43,
>> =A0};
>>
>> =A0static void __init evm_init_i2c(void)
>> diff --git a/arch/arm/mach-davinci/include/mach/i2c.h b/arch/arm/mac=
h-davinci/include/mach/i2c.h
>> index c248e9b..39fdcea 100644
>> --- a/arch/arm/mach-davinci/include/mach/i2c.h
>> +++ b/arch/arm/mach-davinci/include/mach/i2c.h
>> @@ -16,6 +16,8 @@
>> =A0struct davinci_i2c_platform_data {
>> =A0 =A0 =A0 unsigned int =A0 =A0bus_freq; =A0 =A0 =A0 /* standard bu=
s frequency (kHz) */
>> =A0 =A0 =A0 unsigned int =A0 =A0bus_delay; =A0 =A0 =A0/* post-transa=
ction delay (usec) */
>> + =A0 =A0 unsigned int =A0 =A0sda_pin; =A0 =A0 =A0 =A0/* GPIO pin ID=
 to use for SDA */
>
> It doesn't look like you need the SDA pin to be
> a GPIO in patch 2/2 - can you drop it from platform
> data in that case?

Yes, SDA pin can be dropped. I merely added it for the sake of complete=
ness.

Regards,
Philby
