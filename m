From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: Re: [PATCH] NFC: Driver for Inside Secure MicroRead NFC chip
Date: Tue, 29 Mar 2011 15:22:56 +0200
Message-ID: <201103291522.56667.arnd@arndb.de>
References: <1300444824-13713-1-git-send-email-waldemar.rymarkiewicz@tieto.com> <201103291404.39023.arnd@arndb.de> <20110329132305.7aa065a1@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20110329132305.7aa065a1-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alan Cox <alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>
Cc: Waldemar.Rymarkiewicz-++hxYGjEMp0AvxtiuMwx3w@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, hthebaud-Umy9UjvE/gtWk0Htik3J/w@public.gmane.org, matti.j.aaltonen-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Tuesday 29 March 2011, Alan Cox wrote:
> > I was under the impression that NFC was peer-to-peer, so the driver
> > would already be handling both sides potentially.
> 
> Your security requirements each side are going to be very different. A
> phone or handheld device is generally single user at a time, the other
> end may well be interacting with many devices at once each with their own
> security context and potentially handling sensitive data (payment
> authorisations for example).

Yes, good point.

	Arnd
