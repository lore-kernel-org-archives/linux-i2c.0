From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCHv2 1/6] i2c: sunxi: Add Allwinner A1X i2c driver
Date: Mon, 27 May 2013 12:04:53 +0200
Message-ID: <20130527100453.GM17847@lukather>
References: <1369563642-4390-1-git-send-email-maxime.ripard@free-electrons.com>
 <1369563642-4390-2-git-send-email-maxime.ripard@free-electrons.com>
 <51A1E9AA.4000008@schinagl.nl>
 <20130526132120.GJ17847@lukather>
 <51A25C21.2060700@schinagl.nl>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sunxi+bncBD2ZNBF5VYJRBR67RSGQKGQE7LLNP3Y-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <51A25C21.2060700-dxLnbx3+1qmEVqv0pETR8A@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post?hl=en-GB>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/?hl=en-GB>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi?hl=en-GB>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe?hl=en-GB>,
 <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe?hl=en-GB>,
 <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Content-Disposition: inline
To: Oliver Schinagl <oliver+list-dxLnbx3+1qmEVqv0pETR8A@public.gmane.org>
Cc: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Emilio Lopez <emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org>, kevin-0TFLnhJekD6UEPyfVivIlAC/G2K4zDHf@public.gmane.org, sunny-0TFLnhJekD6UEPyfVivIlAC/G2K4zDHf@public.gmane.org, shuge-0TFLnhJekD6UEPyfVivIlAC/G2K4zDHf@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Oliver,

On Sun, May 26, 2013 at 09:01:53PM +0200, Oliver Schinagl wrote:
> On 05/26/13 15:21, Maxime Ripard wrote:
> >For the iowrite* vs write*, there's no consensus, and as such no
> >preferred way. write* functions are doing an MMIO only access,
> >while iowrite functions can do MMIO and port I/O accesses.
> >
> >Note that it doesn't change anything on ARM, since there's no port IO on
> >ARM.
> Ah I see, missinformation on my end. Sorry.
> 
> But why write 32 bits? The register is only 8 wide, with the rest
> being 'reserved'. Then again, the register IS 32 bits wide and
> probably will haev 32 bits written to it? Correct?

Yes, the register is 32 bits wide. However, and I didn't noticed it at
first, that all the registers have the 3 upper bytes reserved.

But you'll end up writing a 32 bits value to a 32 bit register register
anyway, even if the relevant information is contained in the 8 first
bits.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
