From: Yegor Yefremov <yegorslists-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Subject: Re: [PATCH] at24: add kernel side usage description
Date: Sun, 29 Jan 2012 01:16:36 +0100
Message-ID: <CAGm1_kuiucZjjX7oaF+A9PcQ534X-6XTk=KWP58zV0cSfx4OGw@mail.gmail.com>
References: <1327507871-15211-1-git-send-email-yegorslists@googlemail.com> <20120128225336.GC26708@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120128225336.GC26708-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Sat, Jan 28, 2012 at 11:53 PM, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org> =
wrote:
> On Wed, Jan 25, 2012 at 05:11:11PM +0100, yegorslists-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org =
wrote:
>> From: Yegor Yefremov <yegorslists-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
>>
>> Add EEPROM usage instructions and example for kernel side.
>> dm644x-evm was taken as example.
>>
>> Signed-off-by: Yegor Yefremov <yegorslists-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
>> ---
>> =C2=A0drivers/misc/eeprom/at24.c | =C2=A0 =C2=A09 +++++++++
>> =C2=A01 files changed, 9 insertions(+), 0 deletions(-)
>>
>> diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
>> index ab1ad41..49494ad 100644
>> --- a/drivers/misc/eeprom/at24.c
>> +++ b/drivers/misc/eeprom/at24.c
>> @@ -438,6 +438,15 @@ static ssize_t at24_bin_write(struct file *filp=
, struct kobject *kobj,
>> =C2=A0 * This lets other kernel code access the eeprom data. For exa=
mple, it
>> =C2=A0 * might hold a board's Ethernet address, or board-specific ca=
libration
>> =C2=A0 * data generated on the manufacturing floor.
>> + *
>> + * struct at24_platform_data provides special hook .setup, that can
>> + * invoke at24_macc_read()/at24_macc_write() through memory_accesso=
r:
>> + *
>> + * void =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(*setup)(st=
ruct memory_accessor *, void *context);
>> + *
>> + * setup hook (if provided) will be executed at the end of at24_pro=
be().
>> + *
>> + * See arch/arm/mach-davinci/board-dm644x-evm.c for details.
>
> I think a reference to some board code is not good, since the code mi=
ght change
> for whatever reason. I know that I suggested to place the comment the=
re, but
> meanwhile I think at24_platform_data really needs to get proper kerne=
l-doc
> annotations, also including your suggestion. I won't force that on yo=
u and will
> do it in the next days, unless you are eager to do it, of course :)

I think you're the best man to do the job :-) Since you have more
experience in this area.

Yegor
