From: Kumar Gala <galak-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
Subject: Re: [PATCH v3 0/5] i2c: i2c-mpc: make I2C bus speed configurable
Date: Wed, 8 Apr 2009 10:21:12 -0500
Message-ID: <E9E24C93-F147-49F0-9FBE-FCE4883D11BF@kernel.crashing.org>
References: <20090407082052.477328750@denx.de> <53B42D49-C040-442E-8448-7BC3190220A5@kernel.crashing.org> <F4E3E1FF-C544-460A-AC27-DB9501C13ED3@kernel.crashing.org> <49DC515F.3040100@grandegger.com>
Mime-Version: 1.0 (Apple Message framework v930.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <49DC515F.3040100-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfgang Grandegger <wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org>
Cc: Linux/PPC Development <linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org>, devicetree-discuss <devicetree-discuss-mnsaURCQ41sdnm+yROfE0A@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


On Apr 8, 2009, at 2:25 AM, Wolfgang Grandegger wrote:

>> So I'm a bit concerned with the output we now get:
>>
>> mpc-i2c fffe03000.i2c: clock 0 Hz (dfsrr=16 fdr=49)
>>
>> why 0? is that right?
>
> This is the backward compatibility mode using hard-coded FDR values.  
> The
> output is missleading, I agree.
>
> Wolfgang.

Can the output be fixed.  0 Hz seemed bad to me.

- k
