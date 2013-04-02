From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] ACPI / I2C: Use parent's ACPI_HANDLE() in
 acpi_i2c_register_devices()
Date: Tue, 2 Apr 2013 06:52:37 +0200
Message-ID: <20130402045105.GA17682@the-dreams.de>
References: <2966020.zlpeyGGUDW@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <2966020.zlpeyGGUDW-sKB8Sp2ER+y1GS7QM15AGw@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>
Cc: ACPI Devel Maling List <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Mon, Apr 01, 2013 at 02:25:03AM +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> 
> The ACPI handle of struct i2c_adapter's dev member should not be
> set, because this causes that struct i2c_adapter to be associated
> with the ACPI device node corresponding to its parent as the
> second "physical_device", which is incorrect (this happens during
> the registration of struct i2c_adapter).  Consequently,
> acpi_i2c_register_devices() should use the ACPI handle of the
> parent of the struct i2c_adapter it is called for rather than the
> struct i2c_adapter's ACPI handle (which should be NULL).
> 
> Make that happen and modify the i2c-designware-platdrv driver,
> which currently is the only driver for ACPI-enumerated I2C
> controller chips, not to set the ACPI handle for the
> struct i2c_adapter it creates.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

Shall this go via the I2C tree? If not, for the I2C part:

Acked-by: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
