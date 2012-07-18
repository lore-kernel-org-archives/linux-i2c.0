From: bhanuprakash bodireddy <bhanuprakashbodireddy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Transaction timeout issue with Temperature sensor driver on
 2.6.32 kernel.
Date: Wed, 18 Jul 2012 18:46:53 +0530
Message-ID: <CALPjBuVY0wtL8qy=wRxEe5Sia24u7ugWKwvLVT_OC67LsnOoYQ@mail.gmail.com>
References: <CALPjBuW+B2=Y3g9n_Sqe2QOT18XHyJc4t77WGjvsm-0ik+NmAg@mail.gmail.com>
	<20120717131738.7f7aaf80@endymion.delvare>
	<CALPjBuUYJPOwTqZ+9gr2AVYigTD6N4B_2K6Erns+0vSX9biR+A@mail.gmail.com>
	<20120718092449.305baddb@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120718092449.305baddb-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

> If the code is from MontaVista, ask them for help, not us. Maybe they
> know of the issue and/or have an updated driver to offer.

Extremely sorry jean, I believed that the bug could be in bus driver and hence
posted here thinking it could be an known issue and may be a patch is available
for 2.6.32.

> the real thing, unmodified. One important point though is that a large
> part of the code appears to depend on the kernel version being < or >=
> to 2.6.30. As you switched from kernel version 2.6.21 to kernel version
> 2.6.32, you are actually no longer using the same code as before. Maybe
> there's a bug in the part of the code which runs on kernels >= 2.6.30.

Finally my driver is working and user space program could read the temperature
correctly. The i2c-i801.c file you gave me yesterday worked like a
charm. The issue
is with the bus driver in MVL code.

Below is the result from my user space program.

> peci_test
CPU_0 CORE_0(0x18) => Temp : 48
CPU_0 CORE_1(0x1A) => Temp : 48
CPU_1 CORE_0(0x1B) => Temp : 45
CPU_1 CORE_1(0x1C) => Temp : 45

Regards,
Bhanu Prakash.
