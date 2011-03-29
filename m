From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] NFC: Driver for Inside Secure MicroRead NFC chip
Date: Tue, 29 Mar 2011 12:59:31 +0100
Message-ID: <20110329125931.21a69776@lxorguk.ukuu.org.uk>
References: <1300444824-13713-1-git-send-email-waldemar.rymarkiewicz@tieto.com>
	<20110325142648.GC3879@sortiz-mobl>
	<99B09243E1A5DA4898CDD8B7001114481085E2375D@EXMB04.eu.tieto.com>
	<201103291305.02293.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <201103291305.02293.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Waldemar.Rymarkiewicz@tieto.com, sameo@linux.intel.com, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, hthebaud@insidefr.com, matti.j.aaltonen@nokia.com
List-Id: linux-i2c@vger.kernel.org

> The difference between the two is where you keep the common
> NFC logic:

I think I'd disagree on that
> 
> If you have a character device, it will be like a serial port
> connecting to a modem. Any higher-level protocols live in the
> user space and are limited to a single application then, which
> is required to have appropriate priviledges to open the device.

A socket is just an API just as a file, you can put the stack in either
place in either case.

> character device is its simplicity, so that would be preferred
> if you only expect a very small set of possible applications
> for this.

NFC is not particularly performance dependant so having a lot of the
stack in a daemon isn't really going to hurt anything too much on a
client embedded device/phone.

The bigger question is probably what it needs to look like the other end
- ie the server side embedded devices doing transactions.
