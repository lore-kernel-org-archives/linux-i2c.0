From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v2 1/4] i2c: sunxi: Add Reduced Serial Bus
 (RSB) support
Date: Thu, 5 Mar 2015 19:28:17 +0100
Message-ID: <20150305182817.GB4911@lukather>
References: <1425284686-5116-1-git-send-email-wens@csie.org>
 <1425284686-5116-2-git-send-email-wens@csie.org>
 <20150304172710.GA884@katana>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MHoG8na4IvP3G3ze"
Return-path: <linux-sunxi+bncBD2ZNBF5VYJRBK6B4KTQKGQEWED4WJI-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150304172710.GA884@katana>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <http://groups.google.com/group/linux-sunxi/subscribe>
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

--MHoG8na4IvP3G3ze
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline

Hi Wolfram,

On Wed, Mar 04, 2015 at 06:27:11PM +0100, Wolfram Sang wrote:
> On Mon, Mar 02, 2015 at 04:24:43PM +0800, Chen-Yu Tsai wrote:
> > The RSB controller looks like an SMBus controller which only supports byte
> > and word data transfers. It can also do double-word data transfers, but the
> > I2C subsystem does not support this, nor have we seen devices using this.
> > 
> > The RSB differs from standard SMBus protocol on several aspects:
> > - it uses addresses set at runtime to address slaves. Runtime addresses
> >   are sent to slaves using their 12bit hardware addresses. Up to 15
> >   runtime addresses are available.
> > - it adds a parity bit every 8bits of data and address for read and
> >   write accesses; this replaces the ack bit
> > - only one read access is required to read a byte (instead of a write
> >   followed by a read access in standard SMBus protocol)
> > - there's no Ack bit after each read access
> > 
> > This means this bus cannot be used to interface with standard SMBus
> > devices (known devices supporting this interface are the AXP223, AXP806,
> > AXP809 PMICs and the AC100 codec/RTC). However the RSB protocol is an
> > extension of P2WI, which was close enough to SMBus to be integrated into
> > the I2C subsystem in commit 3e833490fae5 ("i2c: sunxi: add P2WI (Push/Pull
> > 2 Wire Interface) controller support").
> > 
> > Signed-off-by: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
> 
> I don't have the bandwidth for a full review right now. However, I
> already wanted to tell you guys that my gut feeling is that this
> protocol is quite far away from I2C. P2WI was already at the edge.
> Maybe there is a better place for such custom stuff? I dunno yet.

That's unfortunate, especially since it looks closer to SPI than what
P2WI even was.

What would be your suggestion?

Thanks,
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
--MHoG8na4IvP3G3ze--
