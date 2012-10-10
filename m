From: <Peter.Huewe-d0qZbvYSIPpWk0Htik3J/w@public.gmane.org>
Subject: RE: [tpmdd-devel] [PATCH] char/tpm: Convert struct i2c_msg
	initialization to C99 format
Date: Wed, 10 Oct 2012 14:15:21 +0000
Message-ID: <74A44E99E3274B4CB570415926B37D440ECC0B@MUCSE501.eu.infineon.com>
References: <1349782951-9175-1-git-send-email-shubhrajyoti@ti.com>
	<20121010110638.498f0a50@endymion.delvare>
 <CAM=Q2cv2-85S7NoVEpcuCohQs=CFxKcyVdm62g4d5q7pJzcpXg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAM=Q2cv2-85S7NoVEpcuCohQs=CFxKcyVdm62g4d5q7pJzcpXg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Content-Language: de-DE
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: omaplinuxkernel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org
Cc: tpmdd-iBygD9l97zzQT0dZR+AlfA@public.gmane.org, mail-ZlhrYzitvtWsTnJN9+BGXg@public.gmane.org, tpmdd-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, key-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org, shubhrajyoti-l0cyMroinI0@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

> -----Original Message-----
> From: Shubhrajyoti Datta [mailto:omaplinuxkernel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org] 
> Subject: [PATCHv2] char/tpm: Convert struct i2c_msg initialization to C99 format

> Convert the struct i2c_msg initialization to C99 format. This makes
> maintaining and editing the code simpler. Also helps once other fields
> like transferred are added in future.

> Thanks to Julia Lawall <julia.lawall-L2FTfq7BK8M@public.gmane.org>  for automating the conversion

> Acked-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
> Signed-off-by: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>

Acked-by: Peter Huewe <peter.huewe-d0qZbvYSIPpWk0Htik3J/w@public.gmane.org>
