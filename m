From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: Winbond W83L604G
Date: Wed, 6 Jul 2011 09:03:47 +0200
Message-ID: <20110706090347.44bd4bbe@endymion.delvare>
References: <6D7A567890E70E4BA49B8A9B365980FA12D99C14BE@shsmsx501.ccr.corp.intel.com>
	<8829587.204.1309885573653.JavaMail.root@zmail.rockbochs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <8829587.204.1309885573653.JavaMail.root-N94c1vXlnCs/q/FG96+aB0EOCMrvLtNR@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tim Nelson <tnelson-f4DZ+GDyDBaakBO8gow8eQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Tim,

On Tue, 5 Jul 2011 12:06:13 -0500 (CDT), Tim Nelson wrote:
> I've done that:
> 
> root@aaa:~# lsmod | grep i2c
> i2c_dev                 3382  0
> i2c_core               12703  1 i2c_dev
> 
> But, nothing of interest in dmesg other than:
> 
> [108414.944722] i2c /dev entries driver
> 
> and running i2cdetect still turns up nothing:
> 
> root@aaa:~# i2cdetect -l
> 
> Any thoughts? Does this specific Winbond chip require a device specific kernel module to operate such as those found in /lib/modules/2.6.32-5-486/kernel/drivers/i2c/busses  ?

As I understand it, the W83L604G is a GPIO expander on I2C/SMBus, so
what it needs is a driver in drivers/gpio. We don't seem to have support
for it yet, unless it is 100% compatible with another device we already
support.

On top of that, you need a driver for the I2C/SMBus controller on your
mainboard, to which the W83L604G is connected. Without it, you won't
even be able to talk to the W83L604G. You did not tell us anything
about your system so we can't tell you which driver that would be - if
we have a driver at all. Does lspci say anything about SMBus? If not,
what is your system based on?

-- 
Jean Delvare
