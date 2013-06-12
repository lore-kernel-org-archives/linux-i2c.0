From: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Subject: Re: [PATCHv4 2/9] i2c: mv64xxx: make the registers offset
	configurable
Date: Wed, 12 Jun 2013 15:51:39 +0100
Message-ID: <20130612145139.GS18614@n2100.arm.linux.org.uk>
References: <1371024438-16631-1-git-send-email-maxime.ripard@free-electrons.com> <1371024438-16631-3-git-send-email-maxime.ripard@free-electrons.com> <20130612135735.GR18614@n2100.arm.linux.org.uk> <20130612144447.GI16699@lukather>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20130612144447.GI16699@lukather>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Emilio Lopez <emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org>, Tomasz Figa <tomasz.figa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sunny-0TFLnhJekD6UEPyfVivIlAC/G2K4zDHf@public.gmane.org, shuge-0TFLnhJekD6UEPyfVivIlAC/G2K4zDHf@public.gmane.org, kevin-0TFLnhJekD6UEPyfVivIlAC/G2K4zDHf@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Wed, Jun 12, 2013 at 04:44:47PM +0200, Maxime Ripard wrote:
> Hi Russel,
> 
> On Wed, Jun 12, 2013 at 02:57:35PM +0100, Russell King - ARM Linux wrote:
> > It'd be much better to copy the offsets themselves in drv_data.  You're
> > only talking about 7 bytes here, so there's no worry about bloating the
> > drv_data structure.
> 
> It was more about keeping things separated. Moreover, the probe
> function gets smaller, since you have only a pointer to pass on, instead
> of assigning those 7 bytes.

	struct driver_data {
		struct mv64xxx_i2c_regs reg_offsets;
	};

	struct driver_data *drv_data;

	memcpy(drv_data->reg_offsets, reg_offsets, sizeof(drv_data->reg_offsets));

No need to write it each member as a separate assignment.
