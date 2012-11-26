From: Shubhrajyoti Datta <omaplinuxkernel@gmail.com>
Subject: Re: [PATCH] i2c: omap: Remove the OMAP_I2C_FLAG_RESET_REGS_POSTIDLE flag
Date: Mon, 26 Nov 2012 15:26:45 +0530
Message-ID: <CAM=Q2cszBPhnFwKX2j5DtgOiN1PxT5jApBVUcJohXr1PRckxUA@mail.gmail.com>
References: <1353921235-22408-1-git-send-email-shubhrajyoti@ti.com>
	<20121126091400.GD15766@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <20121126091400.GD15766@arwen.pp.htv.fi>
Sender: linux-omap-owner@vger.kernel.org
To: balbi@ti.com
Cc: Shubhrajyoti D <shubhrajyoti@ti.com>, linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, ben-linux@fluff.org, w.sang@pengutronix.de
List-Id: linux-i2c@vger.kernel.org

On Mon, Nov 26, 2012 at 2:44 PM, Felipe Balbi <balbi@ti.com> wrote:
>
> > -                       OMAP_I2C_FLAG_BUS_SHIFT_2,
> > +     .flags          = OMAP_I2C_FLAG_BUS_SHIFT_2,
>
> if it's not used anymore, how about removing its definition too ?

Just updated the patch , thanks.
