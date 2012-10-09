From: <Peter.Huewe-d0qZbvYSIPpWk0Htik3J/w@public.gmane.org>
Subject: RE: [tpmdd-devel] [PATCH] char/tpm: Convert struct i2c_msg
  initialization to C99 format
Date: Tue, 9 Oct 2012 16:59:56 +0000
Message-ID: <74A44E99E3274B4CB570415926B37D440EC6EC@MUCSE501.eu.infineon.com>
References: <1349782951-9175-1-git-send-email-shubhrajyoti@ti.com>
	<74A44E99E3274B4CB570415926B37D440EC6CD@MUCSE501.eu.infineon.com>
 <20121009183208.56716682@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20121009183208.56716682-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Content-Language: de-DE
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org
Cc: shubhrajyoti-l0cyMroinI0@public.gmane.org, tpmdd-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, tpmdd-iBygD9l97zzQT0dZR+AlfA@public.gmane.org, mail-ZlhrYzitvtWsTnJN9+BGXg@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, key-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Jean,

>> When the discussion is settled I'd probably go directly to I2C_MSG_ macros in order to avoid a double conversion.

> I thought about it, but actually I'd rather pick Shubhrajyoti's patches
> first. We don't know where Julia's patch will be going at this point,
> and other patches depend on the patches Shubhrajyoti sent, which I do
> not want to delay. Julia's changes, if applied, will touch over 200
> drivers anyway, so 4 more or less don't make any difference. I also
> suspect that Julia's scripts won't catch the non-C99 initializations,
> so she probably won't see them Shubhrajyoti's patches are applied -
> that's one more reason to apply them immediately.

Thanks for your input, I just read also your reply to Julia's patchset - so I'm fine with the patch.

> so she probably won't see them Shubhrajyoti's patches are applied...
Hehe, I tend to look at the i2c subsystem from time to time to catch-up with the new features (e.g. __i2c_transfer for this driver)
and apply them to stuff I'm aware of ;) - but of course you're right.


Reviewed-by: Peter Huewe <peter.huewe-d0qZbvYSIPpWk0Htik3J/w@public.gmane.org>
And as the driver's author:
Acked-by: Peter Huewe <peter.huewe-d0qZbvYSIPpWk0Htik3J/w@public.gmane.org>



Thanks,
Peter
