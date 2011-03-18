From: <Waldemar.Rymarkiewicz-++hxYGjEMp0AvxtiuMwx3w@public.gmane.org>
Subject: RE: [PATCH] NFC: Driver for Inside Secure MicroRead NFC chip
Date: Fri, 18 Mar 2011 17:57:24 +0200
Message-ID: <99B09243E1A5DA4898CDD8B7001114481085881990@EXMB04.eu.tieto.com>
References: <1300444824-13713-1-git-send-email-waldemar.rymarkiewicz@tieto.com>
	<1300444824-13713-2-git-send-email-waldemar.rymarkiewicz@tieto.com>
 <20110318085033.9bea6dc9.rdunlap@xenotime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20110318085033.9bea6dc9.rdunlap-/UHa2rfvQTnk1uMJSBkQmQ@public.gmane.org>
Content-Language: en-US
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: rdunlap-/UHa2rfvQTnk1uMJSBkQmQ@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, hthebaud-Umy9UjvE/gtWk0Htik3J/w@public.gmane.org, matti.j.aaltonen-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Randy, 

>> +data to be read. Then, poll() will indicate that fact to 
>the userspace.
>> +
>> +The application can use ioctl(MICROREAD_IOC_RESET)to reset 
>the hardware.
>
>                                              _RESET) to reset
>

Thanks, all are now fixed. 

Waldek
