From: Federico Vaga <federico.vaga@cern.ch>
Subject: Re: [PATCH v4 3/5] i2c:ocores: add polling interface
Date: Mon, 11 Feb 2019 14:46:28 +0100
Message-ID: <14487566.fPVnE3aI26@pcbe13614>
References: <20190211083122.32485-1-federico.vaga@cern.ch> <1845501.4feNL5aF6H@pcbe13614> <5bc1757a-3b74-5c77-7c39-00c2513683a1@axentia.se>
Reply-To: <federico.vaga@cern.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5bc1757a-3b74-5c77-7c39-00c2513683a1@axentia.se>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Rosin <peda@axentia.se>
Cc: Peter Korsgaard <peter@korsgaard.com>, Andrew Lunn <andrew@lunn.ch>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

On Monday, February 11, 2019 2:35:15 PM CET Peter Rosin wrote:
> >>> @@ -294,7 +427,7 @@ static int ocores_init(struct device *dev, struct
> >>> ocores_i2c *i2c)
> >>
> >>
> >>
> >>>  
> >>>  
> >>>  
> >>>  	/* Init the device */
> >>>  	oc_setreg(i2c, OCI2C_CMD, OCI2C_CMD_IACK);
> >>>
> >>>
> >>>
> >>> -	oc_setreg(i2c, OCI2C_CONTROL, ctrl | OCI2C_CTRL_IEN | OCI2C_CTRL_EN);
> >>> +	oc_setreg(i2c, OCI2C_CONTROL, ctrl | OCI2C_CTRL_EN);
> >>
> >>
> >>
> >>
> >> You fix this up in patch 5 (in what is perhaps carelessly marketed as
> >> fixes for minor checkpatch issues), but for this patch you are actually
> >> no longer making sure that you clear the OCI2C_CTRL_IEN bit as the code
> >> used to before this patch. I think you intended to preserve that
> >> behavior, no?
> > 
> > 
> > I think you got confused by the two patches because those lines look very
> > 
> > similar.
> > 
> > In PATCH 5 what you see is the "style fix" to clear EN and IEN before
> > clock 
 configuration
> > 
> > in PATCH 3 (this one) what you see is when later (same function, after
> > clock 
 configuration) the device is re-enabled (EN), but without
> > enabling the interrupt because on polling configuration we do not want to
> > see interrupt flowing.
> > 
> > So, the behavior is preserved for what concern clearing the IEN bit before
> > 
 clock configuration.
> > 
> > am I wrong?
> 
> 
> No, I don't think I'm confused and I think you are wrong. Current code does
> this:
> 
> 	u8 ctrl = oc_getreg(i2c, OCI2C_CONTROL);
> 
> 	/* make sure the device is disabled */
> 	oc_setreg(i2c, OCI2C_CONTROL, ctrl & ~(OCI2C_CTRL_IEN|OCI2C_CTRL_EN));
> 	...
> 	oc_setreg(i2c, OCI2C_CONTROL, ctrl | OCI2C_CTRL_IEN | OCI2C_CTRL_EN));
> 
> Here, the final oc_setreg always sets OCI2C_CTRL_IEN.
> 
> Patch 3 changes it to:
> 
> 	u8 ctrl = oc_getreg(i2c, OCI2C_CONTROL);
> 
> 	/* make sure the device is disabled */
> 	oc_setreg(i2c, OCI2C_CONTROL, ctrl & ~(OCI2C_CTRL_IEN|OCI2C_CTRL_EN));
> 	...
> 	oc_setreg(i2c, OCI2C_CONTROL, ctrl | OCI2C_CTRL_EN));
> 
> Here, the final oc_setreg restores OCI2C_CTRL_IEN to whatever it was
> at function entry.
> 
> 
> And patch 5 changes it again to:
> 
> 	u8 ctrl = oc_getreg(i2c, OCI2C_CONTROL);
> 
> 	/* make sure the device is disabled */
> 	ctrl &= ~(OCI2C_CTRL_IEN | OCI2C_CTRL_EN);
> 	oc_setreg(i2c, OCI2C_CONTROL, ctrl);
> 	...
> 	oc_setreg(i2c, OCI2C_CONTROL, ctrl | OCI2C_CTRL_EN));
> 
> Here, the final oc_setreg keeps OCI2C_CTRL_IEN cleared. I think you wanted
> this deterministic behavior for patch 3 as well.

Now I see what you mean and I agree. I will move the fix from PATCH 5 to PATCH 
3, so that bit IEN is clearly cleared.


thanks

> 
> Cheers,
> Peter
