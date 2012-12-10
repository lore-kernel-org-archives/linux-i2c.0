From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [tpmdd-devel] [PATCH] char/tpm: Convert struct i2c_msg
 initialization to C99 format
Date: Mon, 10 Dec 2012 23:09:38 +0100
Message-ID: <20121210230938.4b505beb@endymion.delvare>
References: <1349782951-9175-1-git-send-email-shubhrajyoti@ti.com>
	<20121010110638.498f0a50@endymion.delvare>
	<CAM=Q2cv2-85S7NoVEpcuCohQs=CFxKcyVdm62g4d5q7pJzcpXg@mail.gmail.com>
	<74A44E99E3274B4CB570415926B37D44101A60@MUCSE501.eu.infineon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <74A44E99E3274B4CB570415926B37D44101A60-KSUqXBOclpKBCnxIfz/NYa7q7RIIQec8@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter.Huewe-d0qZbvYSIPpWk0Htik3J/w@public.gmane.org
Cc: omaplinuxkernel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, key-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org, tpmdd-iBygD9l97zzQT0dZR+AlfA@public.gmane.org, mail-ZlhrYzitvtWsTnJN9+BGXg@public.gmane.org, tpmdd-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, shubhrajyoti-l0cyMroinI0@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Mon, 10 Dec 2012 16:54:08 +0000, Peter.Huewe-d0qZbvYSIPpWk0Htik3J/w@public.gmane.org wrote:
> -----Original Message-----
> From: Huewe Peter (IFAG CCS TI SWT SW ESW) 
> Sent: Wednesday, October 10, 2012 4:15 PM
> To: 'Shubhrajyoti Datta'; Jean Delvare
> Cc: tpmdd-iBygD9l97zzQT0dZR+AlfA@public.gmane.org; mail-ZlhrYzitvtWsTnJN9+BGXg@public.gmane.org; tpmdd-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org; linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; key-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org; Shubhrajyoti D
> Subject: RE: [tpmdd-devel] [PATCH] char/tpm: Convert struct i2c_msg initialization to C99 format
> 
> > -----Original Message-----
> > From: Shubhrajyoti Datta [mailto:omaplinuxkernel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org]
> > Subject: [PATCHv2] char/tpm: Convert struct i2c_msg initialization to 
> > C99 format
> 
> > Convert the struct i2c_msg initialization to C99 format. This makes 
> > maintaining and editing the code simpler. Also helps once other fields 
> > like transferred are added in future.
> 
> > Thanks to Julia Lawall <julia.lawall-L2FTfq7BK8M@public.gmane.org>  for automating the 
> > conversion
> 
> > Acked-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
> > Signed-off-by: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
> 
> > Acked-by: Peter Huewe <peter.huewe-d0qZbvYSIPpWk0Htik3J/w@public.gmane.org>
> 
> 
> Hi,
> 
> was this applied somewhere? 

Not that I am aware of. Would be a good idea to resend it with Cc to
Andrew so that it doesn't get lost.

-- 
Jean Delvare
