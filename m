From: "Byron Bradley" <byron.bbradley-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [patch 2.6.24-rc5-git] add i2c_new_dummy() utility
Date: Thu, 27 Dec 2007 20:58:17 +0000
Message-ID: <57e2b00712271258l6ea661ai2bfd6b9e099c71be@mail.gmail.com>
References: <20071216052308.A0FB11668D7@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20071216052308.A0FB11668D7-ZcXrCSuhvln6VZ3dlLfH/g4gEjPzgfUyLrfjE7I9kuVHxeISYlDBzl6hYfS7NtTn@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Cc: timtimred-f/KTTADhmRsdnm+yROfE0A@public.gmane.org, i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Dec 16, 2007 5:23 AM, David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org> wrote:
> This adds a i2c_new_dummy() primitive to help work with devices
> that consume multiple addresses, which include many I2C eeproms
> and at least one RTC.
>
> Signed-off-by: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>

For the S35390A RTC driver I called i2c_new_dummy() in the probe
function in a similar style to the at24 eeprom driver. This failed
because the probe function is called inside an i2c_attach_device()
which has already locked &adap->clist_lock. When you call the
i2c_new_dummy() function it will itself call i2c_attach_device() but
it will never be able to acquire &adap->clist_lock.

Below is the lock detection and backtrace.

=============================================
[ INFO: possible recursive locking detected ]
2.6.24-rc5-g7fffe9cc-dirty #38
---------------------------------------------
swapper/1 is trying to acquire lock:
 (&adap->clist_lock){--..}, at: [<c02b1ba4>] i2c_attach_client+0x28/0x1e8

but task is already holding lock:
 (&adap->clist_lock){--..}, at: [<c02b1ba4>] i2c_attach_client+0x28/0x1e8

other info that might help us debug this:
3 locks held by swapper/1:
 #0:  (core_lists){--..}, at: [<c02b2294>] i2c_register_adapter+0x50/0x26c
 #1:  (__i2c_board_lock){--..}, at: [<c02b23c4>]
i2c_register_adapter+0x180/0x26c
 #2:  (&adap->clist_lock){--..}, at: [<c02b1ba4>] i2c_attach_client+0x28/0x1e8

stack backtrace:
[<c002df24>] (dump_stack+0x0/0x14) from [<c0067330>]
(__lock_acquire+0x92c/0x10cc)
[<c0066a04>] (__lock_acquire+0x0/0x10cc) from [<c0067b38>]
(lock_acquire+0x68/0x80)
[<c0067ad0>] (lock_acquire+0x0/0x80) from [<c035b880>]
(mutex_lock_nested+0x9c/0x2cc) r7:c7c16000 r6:c7c18000 r5:60000013
r4:c7e0e4e8
[<c035b7e4>] (mutex_lock_nested+0x0/0x2cc) from [<c02b1ba4>]
(i2c_attach_client+0x28/0x1e8)
[<c02b1b7c>] (i2c_attach_client+0x0/0x1e8) from [<c02b2204>]
(i2c_new_device+0xa8/0xe8)
[<c02b215c>] (i2c_new_device+0x0/0xe8) from [<c02b26cc>]
(i2c_new_dummy+0xb0/0xdc) r6:c7e0e488 r5:c036f848 r4:00000000
[<c02b261c>] (i2c_new_dummy+0x0/0xdc) from [<c02b0558>]
(s35390a_probe+0x9c/0x330) r6:c7e0e800 r5:c7cbab00 r4:00000001
[<c02b04bc>] (s35390a_probe+0x0/0x330) from [<c02b0b08>]
(i2c_device_probe+0x54/0x5c) r7:c0232b64 r6:c044721c r5:c7e0e828
r4:c7e0e800
[<c02b0ab4>] (i2c_device_probe+0x0/0x5c) from [<c0232a50>]
(driver_probe_device+0xac/0x1c0) r6:c0447248 r5:c7c19d0c r4:c7e0e828
[<c02329a4>] (driver_probe_device+0x0/0x1c0) from [<c0232b74>]
(__device_attach+0x10/0x14) r8:c7e0e628 r7:c0232b64 r6:c7e0e828
r5:c7c19d0c r4:00000000
[<c0232b64>] (__device_attach+0x0/0x14) from [<c0231b94>]
(bus_for_each_drv+0x5c/0x88)
[<c0231b38>] (bus_for_each_drv+0x0/0x88) from [<c0232c48>]
(device_attach+0xa4/0xb0) r7:c7e0e530 r6:00000000 r5:c7e0e93c
r4:c7e0e828
[<c0232ba4>] (device_attach+0x0/0xb0) from [<c0231af8>]
(bus_attach_device+0x48/0x88) r5:c7e0e828 r4:c04473b0
[<c0231ab0>] (bus_attach_device+0x0/0x88) from [<c0230710>]
(device_add+0x470/0x5e8) r5:c7e0e828 r4:c7e0e828
[<c02302a0>] (device_add+0x0/0x5e8) from [<c02308a8>]
(device_register+0x20/0x24)
[<c0230888>] (device_register+0x0/0x24) from [<c02b1c6c>]
(i2c_attach_client+0xf0/0x1e8) r4:c7e0e920
[<c02b1b7c>] (i2c_attach_client+0x0/0x1e8) from [<c02b2204>]
(i2c_new_device+0xa8/0xe8)
[<c02b215c>] (i2c_new_device+0x0/0xe8) from [<c02b240c>]
(i2c_register_adapter+0x1c8/0x26c) r6:c044733c r5:c7e0e488 r4:c7c0a240
[<c02b2244>] (i2c_register_adapter+0x0/0x26c) from [<c02b256c>]
(i2c_add_numbered_adapter+0xbc/0x) r8:c042df28 r7:c042df34 r6:00000020
r5:c7e0e488 r4:00000000
[<c02b24b0>] (i2c_add_numbered_adapter+0x0/0xcc) from [<c02b467c>]
(mv64xxx_i2c_probe+0x174/0x228) r5:c042dc28 r4:c7e0e400
[<c02b4508>] (mv64xxx_i2c_probe+0x0/0x228) from [<c02344dc>]
(platform_drv_probe+0x20/0x24)
[<c02344bc>] (platform_drv_probe+0x0/0x24) from [<c0232a50>]
(driver_probe_device+0xac/0x1c0)
[<c02329a4>] (driver_probe_device+0x0/0x1c0) from [<c0232d58>]
(__driver_attach+0x104/0x10c) r8:c04421a8 r7:c0232c54 r6:c04478f4
r5:c042dc30 r4:c042dd44
[<c0232c54>] (__driver_attach+0x0/0x10c) from [<c0231d00>]
(bus_for_each_dev+0x54/0x80) r6:c04478f4 r5:c7c19ef4 r4:00000000
[<c0231cac>] (bus_for_each_dev+0x0/0x80) from [<c02328b8>]
(driver_attach+0x20/0x28) r7:c0023eb4 r6:00000000 r5:c04478f4
r4:c04478fc
[<c0232898>] (driver_attach+0x0/0x28) from [<c0232104>]
(bus_add_driver+0x84/0x1e0)
[<c0232080>] (bus_add_driver+0x0/0x1e0) from [<c0232fac>]
(driver_register+0x54/0x90) r8:c7c18000 r7:c0023eb4 r6:00000000
r5:00000000 r4:c04478f4
[<c0232f58>] (driver_register+0x0/0x90) from [<c0234768>]
(platform_driver_register+0x6c/0x88) r4:00000000
[<c02346fc>] (platform_driver_register+0x0/0x88) from [<c001e454>]
(mv64xxx_i2c_init+0x14/0x1c)
[<c001e440>] (mv64xxx_i2c_init+0x0/0x1c) from [<c0008958>]
(kernel_init+0x98/0x2ac)
[<c00088c0>] (kernel_init+0x0/0x2ac) from [<c00459b8>] (do_exit+0x0/0x810)

-- 
Byron Bradley
