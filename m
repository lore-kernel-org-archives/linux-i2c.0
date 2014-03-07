From: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Subject: Re: [PATCH v3 1/5] i2c: mv64xxx: Add reset deassert call
Date: Fri, 7 Mar 2014 10:34:33 +0000
Message-ID: <20140307103433.GH21483@n2100.arm.linux.org.uk>
References: <1393950521-4173-1-git-send-email-maxime.ripard@free-electrons.com> <1393950521-4173-2-git-send-email-maxime.ripard@free-electrons.com> <20140307095222.GG21483@n2100.arm.linux.org.uk> <20140307100751.GN607@lukather>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sunxi+bncBCUYRNXYZECRBQWB42MAKGQETHTGQ3I-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <20140307100751.GN607@lukather>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Content-Disposition: inline
To: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, zhuzhenhua-0TFLnhJekD6UEPyfVivIlAC/G2K4zDHf@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, kevin.z.m.zh-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, sunny-0TFLnhJekD6UEPyfVivIlAC/G2K4zDHf@public.gmane.org, shuge-0TFLnhJekD6UEPyfVivIlAC/G2K4zDHf@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Fri, Mar 07, 2014 at 11:07:51AM +0100, Maxime Ripard wrote:
> Hi Russell,
> 
> On Fri, Mar 07, 2014 at 09:52:23AM +0000, Russell King - ARM Linux wrote:
> > On Tue, Mar 04, 2014 at 05:28:37PM +0100, Maxime Ripard wrote:
> > > The Allwinner A31 SoC using that IP has a reset controller maintaining
> > > it reset unless told otherwise.
> > > 
> > > Add some optional reset support to the driver.
> > > 
> > > Signed-off-by: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
> > > Reviewed-by: Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
> > > Tested-by: Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
> > 
> > This appears to be causing some build errors in Olof's next builder
> > for many of the ARM platforms which make use of this:
> > 
> > drivers/i2c/busses/i2c-mv64xxx.c:924: undefined reference to `reset_control_assert'
> > drivers/i2c/busses/i2c-mv64xxx.c:904: undefined reference to `reset_control_assert'
> > drivers/i2c/busses/i2c-mv64xxx.c:771: undefined reference to `devm_reset_control_get'
> > drivers/i2c/busses/i2c-mv64xxx.c:778: undefined reference to `reset_control_deassert'
> 
> The reset framework doesn't define its functions when its not
> selected, and somehow I think it was not here. What's odd is that
> there is an explicit select on RESET_CONTROLLER in the Kconfig. Maybe
> it's the circular dependency issue that has been reported that cause
> this and Wolfram sent a patch for: http://patchwork.ozlabs.org/patch/327573/

If that patch has been taken, then yes, it will have caused the above -
because now we have Dove and Kirkwood platforms trying to build this
driver without RESET_CONTROLLER being set.

The problem with depending on RESET_CONTROLLER is that then these
platforms end up without their I2C controller - because there's nothing
which enables RESET_CONTROLLER in their configuration.

Since RESET_CONTROLLER is not required for those platforms, it really
should be optional - and I think the real fix is for the reset controller
support to provide stub functions.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
