From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [tpmdd-devel] [PATCH] char/tpm: Convert struct i2c_msg
 initialization to C99 format
Date: Tue, 9 Oct 2012 18:32:08 +0200
Message-ID: <20121009183208.56716682@endymion.delvare>
References: <1349782951-9175-1-git-send-email-shubhrajyoti@ti.com>
	<74A44E99E3274B4CB570415926B37D440EC6CD@MUCSE501.eu.infineon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <74A44E99E3274B4CB570415926B37D440EC6CD-KSUqXBOclpKBCnxIfz/NYa7q7RIIQec8@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter.Huewe-d0qZbvYSIPpWk0Htik3J/w@public.gmane.org
Cc: shubhrajyoti-l0cyMroinI0@public.gmane.org, tpmdd-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, tpmdd-iBygD9l97zzQT0dZR+AlfA@public.gmane.org, mail-ZlhrYzitvtWsTnJN9+BGXg@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, key-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Tue, 9 Oct 2012 16:07:18 +0000, Peter.Huewe-d0qZbvYSIPpWk0Htik3J/w@public.gmane.org wrote:
> > Convert the struct i2c_msg initialization to C99 format. This makes
> > maintaining and editing the code simpler. Also helps once other fields
> > like transferred are added in future.
> 
> > Thanks to Julia Lawall <julia.lawall-L2FTfq7BK8M@public.gmane.org>  for automating the conversion
> 
> Looks good to me,
> Reviewed-by: Peter Huewe <peter.huewe-d0qZbvYSIPpWk0Htik3J/w@public.gmane.org>
> 
> BUT maybe we should probably wait for the outcome of the 
> "introduce macros for i2c_msg initialization" discussion also by Julia:
> https://lkml.org/lkml/2012/10/7/92
> which would wrap this initialization into a macro:
> 
> struct i2c_msg msg1 = I2C_MSG_WRITE(tpm_dev.client->addr, 1, &addr);
> struct i2c_msg msg2 I2C_MSG_READ(tpm_dev.client->addr, len, buffer);
> ...
> struct i2c_msg msg1 = I2C_MSG_WRITE(tpm_dev.client->addr, len + 1, tpm_dev.buf);
> 
> When the discussion is settled I'd probably go directly to I2C_MSG_ macros in order to avoid a double conversion.

I thought about it, but actually I'd rather pick Shubhrajyoti's patches
first. We don't know where Julia's patch will be going at this point,
and other patches depend on the patches Shubhrajyoti sent, which I do
not want to delay. Julia's changes, if applied, will touch over 200
drivers anyway, so 4 more or less don't make any difference. I also
suspect that Julia's scripts won't catch the non-C99 initializations,
so she probably won't see them Shubhrajyoti's patches are applied -
that's one more reason to apply them immediately.

-- 
Jean Delvare
