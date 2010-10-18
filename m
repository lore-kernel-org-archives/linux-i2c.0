From: <samu.p.onkalo-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Subject: RE: [PATCH 0/2] Short timeout for I2C transfers
Date: Mon, 18 Oct 2010 11:38:44 +0200
Message-ID: <62697B07E9803846BC582181BD6FB6B835EFD27D1C@NOK-EUMSG-02.mgdnok.nokia.com>
References: <1286977510-16702-1-git-send-email-samu.p.onkalo@nokia.com>
 <20101015145149.2f688c9d@endymion.delvare>
 <62697B07E9803846BC582181BD6FB6B835EFD27C35@NOK-EUMSG-02.mgdnok.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <62697B07E9803846BC582181BD6FB6B835EFD27C35-xJW1crHCIS+8kqYwC468Frtp2NbXvJi8gfoxzgwHRXE@public.gmane.org>
Content-Language: en-US
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: samu.p.onkalo-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org
Cc: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org



>-----Original Message-----
>From: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org [mailto:linux-i2c-
>owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org] On Behalf Of ext samu.p.onkalo-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org


>>The timeout is a symptom as the controller level. What is the root
>>cause at the LP5523 device level? What exactly happens on the wire?
>>
>
>Chip seems to release ACK signal too soon causing rising edge while
>SCL is high. This violates bus protocol and causes timeout at the
>controller. It is no recognized as ACK nor NACK.
>
>>I am asking because maybe some of the already available protocol
>>mangling flags would work for you, in particular I2C_M_IGNORE_NAK. See
>>Documentation/i2c/i2c-protocol.
>>
>>
>>You should also check why you hit the timeout condition. Ideally the
>>hardware would report problems as they happen, quickly, rather than
>>having to rely on the driver's timeout mechanism. The timeout should
>>really only be a safety mechanism, for when the bus controller itself
>>misbehaves at the hardware level.
>>

It seems that controller detects bus free condition when this happens.
So, instead of the timeout, bus free condition should be detected.
There is no such interrupt so this must be done by polling
the status register. In general this is not a good idea.

Would it make sense somehow tell that use polling and not
the interrupt / timeout control? I.e. by setting a flag that
this transfer doesn't end properly.

I2C_M_IGNORE_TIMEOUT?
In such case just either wait for bus free if supported by HW or
wait for some short time after start of the transmission

-Samu
