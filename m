From: Wolfgang Grandegger <wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org>
Subject: Re: [PATCH v3 0/5] i2c: i2c-mpc: make I2C bus speed configurable
Date: Wed, 08 Apr 2009 09:25:19 +0200
Message-ID: <49DC515F.3040100@grandegger.com>
References: <20090407082052.477328750@denx.de> <53B42D49-C040-442E-8448-7BC3190220A5@kernel.crashing.org> <F4E3E1FF-C544-460A-AC27-DB9501C13ED3@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <F4E3E1FF-C544-460A-AC27-DB9501C13ED3-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kumar Gala <galak-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
Cc: Linux/PPC Development <linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org>, devicetree-discuss <devicetree-discuss-mnsaURCQ41sdnm+yROfE0A@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Kumar Gala wrote:
> 
> On Apr 8, 2009, at 12:11 AM, Kumar Gala wrote:
> 
>>
>> On Apr 7, 2009, at 3:20 AM, Wolfgang Grandegger wrote:
>>
>>> This patch series makes the I2C bus speed configurable by using the
>>> I2C node property "clock-frequency". If the property is not defined,
>>> the old fixed clock settings will be used for backward compatibility.
>>> The property "fsl,preserve-clocking" allows to inherit the settings
>>> from the bootloader. Furthermore, it does some cleanup and uses the
>>> new bindings for the Socrates board:
>>>
>>> i2c: i2c-mpc: various coding style fixes
>>> i2c: i2c-mpc: use dev based printout function
>>> i2c: i2c-mpc: make I2C bus speed configurable
>>
>> It looks like Ben picked up these patches.
>>
>>> powerpc: i2c-mpc: document new FSL I2C bindings and cleanup
>>> powerpc/85xx: i2c-mpc: use new I2C bindings for the Socates board
>>
>> I would have preferred these two go via me, but it looks like the
>> board one got picked up by Ben.  I'll deal with the doc/binding update.
>>>
>>> Ben, could you please consider this patch series for inclusion into
>>> 2.6.30
> 
> So I'm a bit concerned with the output we now get:
> 
> mpc-i2c fffe03000.i2c: clock 0 Hz (dfsrr=16 fdr=49)
> 
> why 0? is that right?

This is the backward compatibility mode using hard-coded FDR values. The
output is missleading, I agree.

Wolfgang.
