From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: Re: [PATCH] NFC: Driver for Inside Secure MicroRead NFC chip
Date: Tue, 29 Mar 2011 14:04:38 +0200
Message-ID: <201103291404.39023.arnd@arndb.de>
References: <1300444824-13713-1-git-send-email-waldemar.rymarkiewicz@tieto.com> <201103291305.02293.arnd@arndb.de> <20110329125931.21a69776@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20110329125931.21a69776-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alan Cox <alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>
Cc: Waldemar.Rymarkiewicz-++hxYGjEMp0AvxtiuMwx3w@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, hthebaud-Umy9UjvE/gtWk0Htik3J/w@public.gmane.org, matti.j.aaltonen-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Tuesday 29 March 2011, Alan Cox wrote:
> > The difference between the two is where you keep the common
> > NFC logic:
> 
> I think I'd disagree on that
> > 
> > If you have a character device, it will be like a serial port
> > connecting to a modem. Any higher-level protocols live in the
> > user space and are limited to a single application then, which
> > is required to have appropriate priviledges to open the device.
> 
> A socket is just an API just as a file, you can put the stack in either
> place in either case.

Fair enough. Obviously the character device that we've been talking
about here does not include the stack, but that would be another option.

As you say, using a socket with a dumb interface is also possible,
but that sounds to me like a combination of all the disadvantages.

> > character device is its simplicity, so that would be preferred
> > if you only expect a very small set of possible applications
> > for this.
> 
> NFC is not particularly performance dependant so having a lot of the
> stack in a daemon isn't really going to hurt anything too much on a
> client embedded device/phone.
> 
> The bigger question is probably what it needs to look like the other end
> - ie the server side embedded devices doing transactions.

I was under the impression that NFC was peer-to-peer, so the driver
would already be handling both sides potentially.

	Arnd
