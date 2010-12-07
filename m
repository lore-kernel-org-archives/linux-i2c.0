From: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Subject: Re: [PATCH 2/2] i2c-algo-bit: Complain about masters which can't
	read SCL
Date: Tue, 7 Dec 2010 12:10:10 +0000
Message-ID: <20101207121009.GD10722@sirena.org.uk>
References: <20101207110705.69792a1a@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20101207110705.69792a1a-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Tue, Dec 07, 2010 at 11:07:05AM +0100, Jean Delvare wrote:
> The I2C specification explicitly describes both SDA and SCL as
> bidirectional lines. An I2C master with a read-only SCL is thus not
> compliant. If a slow slave stretches the clock, errors will happen,
> so the bus can't be considered as reliable.
> 
> Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>

It'd be good to also flag this via sysfs so that it's more readily
visible to things like diagnostic tools.
