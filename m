From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] i2c-dev: relax ban on I2C_M_RECV_LEN
Date: Tue, 21 Feb 2012 08:31:26 +0100
Message-ID: <20120221083126.3bda01f3@endymion.delvare>
References: <4F2DA645.3080604@interlog.com>
	<20120220162939.5ce96d52@endymion.delvare>
	<4F43133F.5040906@interlog.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4F43133F.5040906-qazKcTl6WRFWk0Htik3J/w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: dgilbert-qazKcTl6WRFWk0Htik3J/w@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Doug,

On Mon, 20 Feb 2012 22:45:03 -0500, Douglas Gilbert wrote:
> In the embedded space I only see I2C (TWI) so I don't understand
> the fixation with SMBus (some subset I believe).

Yes, SMBus is essentially a subset of I2C with better defined semantics.

> My illegitimate use case is:
> Sonmicro 13.56 MHz RFID Mifare Module:
> http://www.sonmicro.com/en/downloads/Mifare/ds_SM130.pdf
> http://www.sonmicro.com/en/downloads/Mifare/AN601.pdf
> 
> I can make it work by requesting the maximum number of bytes it
> will ever respond with on all reads.

I have read these two documents quickly and I don't see any use case
for I2C_M_RECV_LEN. The two block reads I see (5.6 READ BLOCK and 5.7
READ VALUE BLOCK in ds_SM130.pdf) have predefined response lengths of
18 and 6 bytes respectively. Nowhere I see a read command that would
reply a block length as the first byte.

Please point me to the page and section of these documents where you
think I2C_M_RECV_LEN is needed.

> Some suggestions for when and if the I2C pass-through is rewritten:
>    - make it clean to the user space, don't use it for internal
>      plumbing within the kernel (to avoid horrors like those you
>      allude to above)

I'm not even sure what you call "I2C pass through", sorry. Most of the
I2C device drivers are in the kernel so it seems reasonable to offer a
convenient in-kernel interface for these. i2c-dev has been historically
used for debugging, development and investigation more than anything
else. I definitely agree that it isn't friendly for writing user-space
drivers, it wasn't designed for this in the first place.

>    - put some version number in it so when you want to put some
>      extra fields through it (e.g. extra i2c_msg.len field) you
>      can bump version number ***

That's obviously too late.

>    - the multiple I2C transfers in one structure is great, but
>      would be more useful if a delay could be placed between
>      each one.

You are not the first one to complain about the lack of flexibility of
i2c_transfer. But the fun thing is that everybody has been asking for
something different. You want delays, others asked for the possibility
to defined future writes based on the value of past reads, others
wanted to be able to skip repeated starts between messages, etc. It
might make more sense to add pre/post message hooks and let the drivers
do whatever they want there. That's something for in-kernel drivers
though, not user-space.

> *** Getting new ioctls into the kernel is really difficult since
>      the management seems to think pass-throughs subvert the OS
>      (they do indeed) and where absolutely necessary sysfs can be
>      used for the purpose.

These are technical details that can always be sorted out. What is
important is to figure out what is needed and how it would be best
implemented.

-- 
Jean Delvare
