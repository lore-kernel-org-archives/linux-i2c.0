From: Alan Cox <alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>
Subject: Re: [PATCH] i2c-intel-mid: I2C FIFO buffer size setting and
 fragmentation
Date: Thu, 27 Jan 2011 10:34:10 +0000
Message-ID: <20110127103410.4f615557@lxorguk.ukuu.org.uk>
References: <20110125142728.10001.85888.stgit@bob.linux.org.uk>
	<20110127004759.GJ15795@trinity.fluff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20110127004759.GJ15795-SMNkleLxa3Z6Wcw2j4pizdi2O/JbrIOy@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Thu, 27 Jan 2011 00:47:59 +0000
Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org> wrote:

> On Tue, Jan 25, 2011 at 02:28:07PM +0000, Alan Cox wrote:
> > From: Major Lee <major_lee-8+ZHUTgF1KZBDgjK7y7TUQ@public.gmane.org>
> >=20
> > The FIFO buffer size is different with different CPU stepping.
> > Define it as 32-byte; it is safe for all CPU stepping.
> >=20
> > There is a problem when xfer size is greater then FIFO buffer size.
> > Implement software fragmentation in host bus driver so that the
> > I=B2C slave device drivers need not to be modified or to know about=
 the
> > limits.
>=20
> This is quite a big change, does it need to go into a -rc, or can it
> wait for the next kernel merge window?

I was submitting it for next merge window.

Alan
