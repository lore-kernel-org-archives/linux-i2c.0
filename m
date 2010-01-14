From: Jean-Hugues Deschenes <jean-hugues.deschenes-YGVykHU+fedBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 0/3] i2c-designware: Allow mixed endianness
Date: Thu, 14 Jan 2010 07:34:27 -0500
Message-ID: <4B4F0F53.9020103@octasic.com>
References: <20100113193224.753273000@octasic.com> <4B4E6815.9050908@necel.com> <20100114010905.GJ3738@trinity.fluff.org> <390831ED3DF58E41A3D2FB82591E2C36047AF627@MAILEXCH.octasic.com> <20100114064501.GR3738@trinity.fluff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100114064501.GR3738-SMNkleLxa3Z6Wcw2j4pizdi2O/JbrIOy@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Cc: Shinya Kuribayashi <shinya.kuribayashi-jaWZhaxaiAMAvxtiuMwx3w@public.gmane.org>, Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


>> Actually, the specific case I'm interested in is one where I have an
>> SOC built around an ARM core running in little-endian mode, in which
>> the Designware IP has been instantiated and hooked up (to the internal
>> data bus) in big endian format.
>>
>> This patch could also come in handy, for example, if someone were to
>> run an armeb kernel on an SOC where the DW IP has been instantiated
>> and hooked up in little endian format (as is probably the case for
>> most ARM-based SOCs out there).
>>     
>
> I think this is currently an oditity, most ARM systems are still armel,
> especiailly since very few distributions do armeb
>   
For the latter case, I definitely agree with you. Still, this patchset 
solves a problem which is very real (for me!) where I'm running an armel 
build and interfacing to a big endian DW I2C device.

jh
