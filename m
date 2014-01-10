From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH 2/2] i2c-designware-pci: Index Haswell ULT bus names
 from 0
Date: Fri, 10 Jan 2014 08:59:39 +0100
Message-ID: <20140110085939.3d96c7e6@endymion.delvare>
References: <1382326010-4554-1-git-send-email-bleung@chromium.org>
	<1382326010-4554-3-git-send-email-bleung@chromium.org>
	<20131021065804.GX3521@intel.com>
	<CANLzEksGqD30Cefh3r2urH-ToxWzkxAnTJZiY07yX2Py58FQPw@mail.gmail.com>
	<20131114180538.GK11022@katana>
	<CANLzEksP1nRfBaQ3-sSouOYL4C+oLKiE75eHfFdEzLmrQKn3dQ@mail.gmail.com>
	<20131126130959.GI7427@katana>
	<20140103155217.GG7132@katana>
	<CANLzEkvgYQtkEyOMNpPcS9BeYzX3zJn7hvtsyhFzbDpViS8-2Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CANLzEkvgYQtkEyOMNpPcS9BeYzX3zJn7hvtsyhFzbDpViS8-2Q-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Benson Leung <bleung-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, jacmet-OfajU3CKLf1/SzgSGea1oA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Duncan Laurie <dlaurie-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Thu, 9 Jan 2014 16:12:14 -0800, Benson Leung wrote:
> Our devices and our platforms have some other requirements which
> turned me away from using i2c_register_board_info.
> 
> i2c_register_board_info looks to create predeclarations for a specific
> i2c bus... However, right now, the chromeos_laptop driver is
> structured to do explicit declaration (using i2c_new_probed_device)
> *after* the busses have come up.
> 
> Specifically, we have a class of atmel_mxt i2c touchpad/touchscreen
> devices that may appear at different addresses depending on whether
> the touch device is in bootloader mode or operational mode.
> 
> For that reason, the chromeos_laptop driver uses i2c_new_probed_device
> with a list of possible addresses when dealing with the atmel touch
> device.
> 
> You can see the driver here :
> drivers/platform/chrome/chromeos_laptop.c
> 
> Is there some way of getting the "probe" behavior while using
> i2c_register_board_info?

No, i2c_register_board_info works only for devices which are always
present at a known address.

-- 
Jean Delvare
