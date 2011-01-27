From: Alan Cox <alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>
Subject: Re: [PATCH 1/3] i2c_intel_mid: Improve error reporting
Date: Thu, 27 Jan 2011 11:33:50 +0000
Message-ID: <20110127113350.6e6cfc18@lxorguk.ukuu.org.uk>
References: <20110125142040.9472.88734.stgit@bob.linux.org.uk>
	<20110127004422.GI15795@trinity.fluff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20110127004422.GI15795-SMNkleLxa3Z6Wcw2j4pizdi2O/JbrIOy@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Thu, 27 Jan 2011 00:44:23 +0000
Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org> wrote:

> On Tue, Jan 25, 2011 at 02:20:48PM +0000, Alan Cox wrote:
> > From: Catalin Popescu <catalinx.popescu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> > 
> > The error messages printed from mrst_i2c_abort() didn't give slave address info.
> > 
> > But I2C device driver developers always need this to check which slave device
> > has the problem.
> 
> Erm, surely the driver itself should know what i2c device it is communicating
> with? Secondly, does this swamp the kernel dmesg buffer when run with the

It lets you see what is going on if you need to and stuff is misbehaving
- its a debug aid.

> i2c-detect tool?

Only if you turn all the debug on and do that which presumably is when
you want it. Not that you would as on these platforms the i2c bus
configuration is enumerated in a firmware table.
