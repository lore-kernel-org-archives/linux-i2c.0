From: Alexander Sverdlin <alexander.sverdlin-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2] i2c: davinci: Refactor i2c_davinci_wait_bus_not_busy()
Date: Tue, 09 Jun 2015 12:54:25 +0200
Message-ID: <5576C5E1.1010302@nokia.com>
References: <55534BA0.3000506@nokia.com> <20150602155344.GE2661@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150602155344.GE2661@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: ext Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hello Wolfram,

On 02/06/15 17:53, ext Wolfram Sang wrote:
>> There are several problems in the function:
>> > - "to_cnt" variable does nothing
>> > - schedule_timeout() call without setting current state does nothing
>> > - "allow_sleep" parameter is not really used
>> > 
>> > Refactor the function so that it really tries to wait. In case of timeout try
>> > to recover the bus.
>> > 
>> > Signed-off-by: Alexander Sverdlin <alexander.sverdlin-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
> Don't you get a build warning?
> 
> drivers/i2c/busses/i2c-davinci.c: In function 'i2c_davinci_wait_bus_not_busy':
> drivers/i2c/busses/i2c-davinci.c:364:18: warning: passing argument 1 of 'i2c_recover_bus' from incompatible pointer type
>   i2c_recover_bus(dev);
>                   ^
> In file included from drivers/i2c/busses/i2c-davinci.c:26:0:
> include/linux/i2c.h:446:5: note: expected 'struct i2c_adapter *' but argument is of type 'struct davinci_i2c_dev *'
>  int i2c_recover_bus(struct i2c_adapter *adap);

oh, this is awful copy-paster error... I'll re-send!

-- 
Best regards,
Alexander Sverdlin.
