From: Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
Subject: Re: [PATCH v2 2/2] i2c: driver for the Conexant Digicolor I2C
 controller
Date: Thu, 19 Mar 2015 13:15:33 +0200
Message-ID: <20150319111533.GF2415@tarshish>
References: <844001df525b3073e50cbd95f357c0eb9912a394.1426758858.git.baruch@tkos.co.il>
 <866aada336ddbeec18749a1c301ab9b365baadde.1426758858.git.baruch@tkos.co.il>
 <20150319110002.GD914@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150319110002.GD914@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Wolfram,

On Thu, Mar 19, 2015 at 12:00:02PM +0100, Wolfram Sang wrote:
> On Thu, Mar 19, 2015 at 11:54:18AM +0200, Baruch Siach wrote:
> > Signed-off-by: Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
> > ---
> > v2:
> >    * Address the comment of Wolfram Sang:
> >     - Advertise the I2C_FUNC_NOSTART capability
> >     - Rebase on v4.0-rc1
> 
> Please fix:
> 
> Applying: i2c: driver for the Conexant Digicolor I2C controller
>     CHECKPATCH
> ...
> 
> ERROR: code indent should use tabs where possible
> #119: FILE: drivers/i2c/busses/i2c-digicolor.c:68:
> +        STATE_IDLE,$

Sorry. I should have caught these earlier. Will fix.

[...]

> There are more checkpatch warnings I don't care about much.
> You can decide about them.

Thanks,
baruch

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org - tel: +972.2.679.5364, http://www.tkos.co.il -
