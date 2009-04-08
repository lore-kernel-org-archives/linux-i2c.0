From: Wolfgang Grandegger <wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org>
Subject: Re: [PATCH v3 5/5] powerpc/85xx: i2c-mpc: use new I2C bindings for
 the Socates board
Date: Wed, 08 Apr 2009 20:53:46 +0200
Message-ID: <49DCF2BA.3070203@grandegger.com>
References: <20090407082052.477328750@denx.de> <20090407082231.803193635@denx.de> 	<fa686aa40904070843q248f3ae1l9c8ca0d5a65c8cc3@mail.gmail.com> 	<49DC4F4D.10803@grandegger.com> <fa686aa40904080753p2b282338r9ba463c47f897fb@mail.gmail.com> <49DCEC80.2050507@grandegger.com> <C3323B74-40FE-41BC-A49C-C94D7DB3FF5A@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <C3323B74-40FE-41BC-A49C-C94D7DB3FF5A-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kumar Gala <galak-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
Cc: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org, devicetree-discuss-mnsaURCQ41sdnm+yROfE0A@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Kumar Gala wrote:
> 
> On Apr 8, 2009, at 1:27 PM, Wolfgang Grandegger wrote:
> 
>> Grant Likely wrote:
>>> On Wed, Apr 8, 2009 at 12:16 AM, Wolfgang Grandegger
>>> <wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org> wrote:
>>>> Grant Likely wrote:
>>>>> On Tue, Apr 7, 2009 at 1:20 AM, Wolfgang Grandegger
>>>>> <wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org> wrote:
>>>>>> Preserve I2C clock settings for the Socrates MPC8544 board.
>>>>> I had thought that the preserve-clocking property was intended for
>>>>> older boards that don't currently have any method of getting the clock
>>>>> setting out of u-boot.  Since Socrates is a new board, U-Boot should
>>>>> probably be made to fill in the real clock rate setting.
>>>> I'm not sure if I understand what you mean. If an old version of U-Boot
>>>> on an old board sets the I2C clock, it can be used (inherited) by Linux
>>>> using the property "preserve-clocking".
>>>>
>>>> It is actually the customers choice to set the I2C clock in U-Boot and
>>>> re-use it by Linux.
>>>
>>> Setting it in the register != recording the value in the device tree.
>>> I'm saying that since Socrates is a new board it should not use the
>>> preserve-clocking dirty trick (and it is a dirty trick) because the
>>> correct clocking data can be passed via the device tree.
>>
>> Why should an old board then use it. "fsl, preserve-clocking" is a new
>> feature, like using "clock-frequency" and you have the choice to
>> explicitly set the clocking via device tree or inherit it from the boot
>> loader. So far, a fixed FDR/DFRSS value (0x1031) was written to the
>> registers by Linux.
> 
> I think Grant's point is socrates is a new board with a new u-boot. 
> That u-boot should be able to set the clock-frequency property in i2c. 
> One assumes if you a clock-frequency property you wouldn't use
> "fsl,preserve-clocking".  (However -- its feasible they are mutually
> exclusive).

OK, now it makes more sense to me even if I never thought that way. My
intention was to allow Linux to use a *different* frequency as the
bootloader by specifying the "clock-frequency" property. This would not
be possible with a fixup by the bootloader.

Wolfgang.
