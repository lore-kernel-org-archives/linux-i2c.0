From: "Gustavo F. Padovan" <gustavo-THi1TnShQwVAfugRpC6u6w@public.gmane.org>
Subject: Re: [PATCH 2/8]bluetooth/hci_ldisc.c Fix warning: variable 'tty'
 set but not used
Date: Mon, 14 Jun 2010 21:24:49 -0300
Message-ID: <20100615001444.GC9203@vigoh>
References: <1276547208-26569-1-git-send-email-justinmattock@gmail.com>
 <1276547208-26569-3-git-send-email-justinmattock@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1276547208-26569-3-git-send-email-justinmattock-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Justin P. Mattock" <justinmattock-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, reiserfs-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, clemens-P6GI/4k7KOmELgA04lAiVw@public.gmane.org, debora-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux1394-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Justin,

* Justin P. Mattock <justinmattock-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> [2010-06-14 13:26:42 -0700]:

> Im getting this while building:
>   CC [M]  drivers/bluetooth/hci_ldisc.o
> drivers/bluetooth/hci_ldisc.c: In function 'hci_uart_send_frame':
> drivers/bluetooth/hci_ldisc.c:213:21: warning: variable 'tty' set but not used
> 
> the below fixed it for me, but am not sure if
> it's correct.


The fix is correct, you just need to fix the trailing whitespace
problem and resend it.
Also we use "Bluetooth:" as part of the commit message on the bluetooth
subsystem. For example:

"Bluetooth: Remove set but not used varible 'tty' 

Or something like that.

-- 
Gustavo F. Padovan
http://padovan.org
