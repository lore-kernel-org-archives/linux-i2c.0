From: Sonic Zhang <sonic.adi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2] i2c: bfin: turn to Resource-managed API in probe function
Date: Fri, 23 May 2014 10:38:23 +0800
Message-ID: <CAJxxZ0Pa+t5afj3hS8RNo5ie=SPaAELHY37==v5FVARXLBYfTw@mail.gmail.com>
References: <1400751219-7943-1-git-send-email-sonic.adi@gmail.com>
	<20140522111300.GC2573@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140522111300.GC2573@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, adi-buildroot-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Sonic Zhang <sonic.zhang-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Wolfram,

On Thu, May 22, 2014 at 7:13 PM, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org> wrote:
> On Thu, May 22, 2014 at 05:33:39PM +0800, Sonic Zhang wrote:
>> From: Sonic Zhang <sonic.zhang-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
>>
>> No need to free managed resources any more.
>>
>> Signed-off-by: Sonic Zhang <sonic.zhang-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
>>
>> ---
>> v2-changes:
>> - Remove resource checking. devm_ioremap_resource will do it.
>> - Remove cast of the return value.
>> - Remove free_irq from the module remove function.
>
> How did you test it?
>

root:/> modprobe i2c-bfin-twi
i2c-bfin-twi i2c-bfin-twi.0: Blackfin on-chip I2C TWI Contoller,
regs_base@ffc01e00
i2c-bfin-twi i2c-bfin-twi.1: Blackfin on-chip I2C TWI Contoller,
regs_base@ffc01f00
root:/> random: nonblocking pool is initialized

root:/> lsmod
Module                  Size  Used by
i2c_bfin_twi            4322  0
root:/> rmmod i2c-bfin-twi
root:/> lsmod
Module                  Size  Used by
root:/>
root:/> modprobe i2c-bfin-twi
i2c-bfin-twi i2c-bfin-twi.0: Blackfin on-chip I2C TWI Contoller,
regs_base@ffc01e00
i2c-bfin-twi i2c-bfin-twi.1: Blackfin on-chip I2C TWI Contoller,
regs_base@ffc01f00
root:/> ls /dev/i2c-*
/dev/i2c-0  /dev/i2c-1
root:/> rmmod i2c-bfin-twi
root:/> ls /dev/i2c-*
ls: /dev/i2c-*: No such file or directory
root:/>


Regards,

Sonnic
