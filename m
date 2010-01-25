From: David Daney <ddaney-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH 2/3] I2C: Add driver for Cavium OCTEON I2C ports.
Date: Mon, 25 Jan 2010 10:19:14 -0800
Message-ID: <4B5DE0A2.8070405@caviumnetworks.com>
References: <4B463B1F.6000404@caviumnetworks.com> <1262894061-32613-2-git-send-email-ddaney@caviumnetworks.com> <20100124160017.GF28675@fluff.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100124160017.GF28675-elnMNo+KYs3pIgCt6eIbzw@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Cc: linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org, ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, rade.bozic.ext-OYasijW0DpE@public.gmane.org, ml.lawnick-Mmb7MZpHnFY@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Ben Dooks wrote:
> On Thu, Jan 07, 2010 at 11:54:20AM -0800, David Daney wrote:
>> From: Rade Bozic <rade.bozic.ext-OYasijW0DpE@public.gmane.org>
>>
>> Signed-off-by: Rade Bozic <rade.bozic.ext-OYasijW0DpE@public.gmane.org>
>> Signed-off-by: David Daney <ddaney-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>
>> ---
>>  drivers/i2c/busses/Kconfig      |   10 +
>>  drivers/i2c/busses/Makefile     |    1 +
>>  drivers/i2c/busses/i2c-octeon.c |  579 +++++++++++++++++++++++++++++++++++++++
>>  3 files changed, 590 insertions(+), 0 deletions(-)
>>  create mode 100644 drivers/i2c/busses/i2c-octeon.c
[...]
>> +
>> +#ifndef NO_IRQ
>> +#define NO_IRQ (-1)
>> +#endif
> 
> this does not fill me with a warm joyous feeling... 
> 

Indeed.

[ many other helpful comments deleted for brevity.]

We will improve the driver and resubmit.

Thanks for looking at it.

David Daney
