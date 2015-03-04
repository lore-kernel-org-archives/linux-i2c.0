From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v2 2/4] i2c: sunxi: Add Reduced Serial Bus
 (RSB) DT bindings documentation
Date: Wed, 4 Mar 2015 17:39:35 +0100
Message-ID: <20150304163935.GO4911@lukather>
References: <1425284686-5116-1-git-send-email-wens@csie.org>
 <1425284686-5116-3-git-send-email-wens@csie.org>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="KM+e2hnYAO+MCJ5e"
Return-path: <linux-sunxi+bncBD2ZNBF5VYJRBY7K3STQKGQEFJ7F6PA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1425284686-5116-3-git-send-email-wens-jdAy2FN1RRM@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <http://groups.google.com/group/linux-sunxi/subscribe>
To: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

--KM+e2hnYAO+MCJ5e
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline

On Mon, Mar 02, 2015 at 04:24:44PM +0800, Chen-Yu Tsai wrote:
> Reduced Serial Bus (RSB) is an SMBus like bus used to communicate
> with some PMICs (like the AXP223) or other peripherals.
> 
> The RSB DT bindings are pretty much the same as the one defined for
> the marvell's mv64xxx controller, with the additional RSB specific
> "allwinner,rsb-hw-addr" property for slave device nodes.
> 
> There are 2 types of addresses for RSB devices, a hardware address
> and a runtime (software) configurable address. The former is only
> used when configuring the latter. All read/write accesses use the
> runtime address.
> 
> It would seem straightforward to use the hardware address in the
> DT bindings as the slave's address. However this will not work as
> the hardware address is 12 bits wide, and at least 1 device, the
> AC100 audio codec, has the highest bit set. This address would be
> incompatible with I2C (7 or 10 bit addresses) and likely rejected.
> 
> Hence this binding uses statically allocated (by the author of the
> DT) runtime addresses for the slave's "reg" property. The hardware
> address is put in a separete named property. When writing a new DT,
                      ^ separate
> the author must take care to not have multiple slave devices use
> the same address. It is recommended to follow whatever conventions
> the hardware vendor uses.

While very complete, the three last paragraphs should rather be, or at
least duplicated, in the file itself.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
--KM+e2hnYAO+MCJ5e--
