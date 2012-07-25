From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: i2c-mux-gpio platform device ID issue
Date: Wed, 25 Jul 2012 14:44:09 +0200
Message-ID: <20120725144409.1e47bd95@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter Korsgaard <peter.korsgaard-ob4gmnvZ1/cAvxtiuMwx3w@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Peter,

I am anticipating an issue with driver i2c-mux-gpio. Right now there
are no user in the kernel tree (surprisingly...), but I'm about to add
the first one (for SMBus multiplexing on an x86 motherboard) and I
expect more will follow.

Right now I am allocating the multiplexer device with:

	platform_device_alloc("i2c-mux-gpio", -1);

This is OK as long as I am the only user. But if the same system needs
another instance of "i2c-mux-gpio", the second attempt will fail,
because both devices will have the same name and this isn't allowed by
the driver core. I could pass an instance ID at allocation time,
however it would have to be different for my driver and the other
driver, and there's no way to guarantee this for two random drivers.

Do you have any idea how we can solve this problem?

My only idea so far is to change the semantics of pdev->id == -1 from
"there's only one device" to "I don't care about the device ID".
Platform devices created with pdev->id == -1 would get an arbitrary ID
value, using an IDA-style mechanism. The IDA would be stored at the
platform driver level. It has the drawback of adding some burden to all
platform drivers, but I'm not sure how much yet, it might be just
acceptable.

If a per-driver IDA isn't acceptable, then we can go for a global IDA,
but then we can't re-use pdev->id == -1 for it. We'd have to introduce
pdev->id == -2 for drivers which want a dynamically allocated unique
ID. Actually this might be a better approach, as it's less intrusive.

Opinions?

-- 
Jean Delvare
