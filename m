From: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
Subject: Re: i2c-i801: Enable interrupts on ICH5/7/8/9/10
Date: Mon, 4 Aug 2014 20:36:04 +0200
Message-ID: <20140804203604.02c74b22@endymion.delvare>
References: <20140804175632.GA5288@fifo99.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140804175632.GA5288-zu3NM2574RrQT0dZR+AlfA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: dwalker-zu3NM2574RrQT0dZR+AlfA@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Daniel,

Please note my new e-mail address.

On Mon, 4 Aug 2014 17:56:32 +0000, dwalker-zu3NM2574RrQT0dZR+AlfA@public.gmane.org wrote:
> I had an issue with the i2c dev-interface. The executable runs i2c_smbus_write_word_data() and it hangs at
> that point. The issues wasn't present in earlier kernels , so I was able to bisect this to ,
> 
> commit 29b608540b030d38a978c972cbe99d40efdb7267
> Author: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
> Date:   Tue Jul 24 14:13:59 2012 +0200
>  
>     i2c-i801: Enable interrupts on ICH5/7/8/9/10
> 
> 
> The system I'm testing on is an ICH9 from and Intel BearLake.

I have had a few reports of problems with interrupts so far but could
never find the time to track it down. Maybe now is the time.

Please provide the output of:
# lspci -s 00:1f.3 -vvv
# grep i801_smbus /proc/interrupts

Does the problem only happen when writing words, or does it also happen
for other transfer types? Does it happen with the first transfer or
randomly after some time?

Please enable CONFIG_I2C_DEBUG_BUS and check if the driver complains
about anything suspicious before the hang occurs.

It would also be great if you could figure out where the driver code
hangs. It might be in wait_event(), I suppose it would be safer to use
wait_event_timeout() as other I2C bus drivers do. I'll prepare a patch.

-- 
Jean Delvare
SUSE L3 Support
