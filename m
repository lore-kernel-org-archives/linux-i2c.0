From: =?ISO-8859-1?Q?Richard_R=F6jfors?= <richard.rojfors-gfIc91nka+FZroRs9YW3xA@public.gmane.org>
Subject: Re: [PATCH 0/1] misc: Add Tunnel creek In-Vehicle I2C loader driver
Date: Wed, 29 Sep 2010 10:38:40 +0200
Message-ID: <4CA2FB10.2020605@pelagicore.com>
References: <1283956897.4593.12.camel@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1283956897.4593.12.camel@debian>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On 09/08/2010 04:41 PM, Richard R=F6jfors wrote:
> To follow is a patch adding a driver which adds devices to the I2C
> bus on tunnel creek in-vehicle development boards.

I never got any feedback on my patch.

It doesn't seem like misc has it own mailinglist so I suppose this is
where it should be posted(?)

The reason for the driver is the lack of board config in X86 so there i=
s
simply no way to define the devices on the I2C bus. It can not be done
from the user space, since GPIO pins need to be turned into interrupts
numbers and passed in the platform data to the I2C devices.

Any suggestions how to move forward to get such driver into the kernel?

Regards
Richard
