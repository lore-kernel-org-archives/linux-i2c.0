From: Yermandu Patapitafious <yermandu.dev-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: i195 and boot freeze
Date: Mon, 23 May 2011 19:33:15 -0300
Message-ID: <BANLkTimZC9vOUu8On5DHkz5qxo8EfLKYYQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, i2c <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

since kernel .39 i can not boot, when kernel go to gmbus start the issue.
I try capture a dump with kexec, but no success, so i have the idea to
make video booting,
kernel version 2.6.39-02745-g0b26d47 and 2.6.39 vanilla same problem.

http://www.vimeo.com/24138372

lspci -v
00:02.0 VGA compatible controller: Intel Corporation Mobile 4 Series
Chipset Integrated Graphics Controller (rev 09) (prog-if 00 [VGA
controller])
	Subsystem: Elitegroup Computer Systems Device 995b
	Flags: bus master, fast devsel, latency 0, IRQ 44
	Memory at f8000000 (64-bit, non-prefetchable) [size=4M]
	Memory at d0000000 (64-bit, prefetchable) [size=256M]
	I/O ports at 1800 [size=8]
	Expansion ROM at <unassigned> [disabled]
	Capabilities: [90] MSI: Enable+ Count=1/1 Maskable- 64bit-
	Capabilities: [d0] Power Management version 3
	Kernel driver in use: i915

att
-- 
yermandu
