From: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH] I2C/ACPI: Fix possible ZERO_SIZE_PTR pointer
 dereferencing error.
Date: Tue, 30 Sep 2014 12:40:08 +0300
Message-ID: <20140930094008.GP1786@lahna.fi.intel.com>
References: <1407810818-33672-1-git-send-email-Li.Xiubo@freescale.com>
 <20140819150355.GD15371@katana>
 <20140819151604.GU1660@lahna.fi.intel.com>
 <20140819153808.GE15371@katana>
 <20140819154555.GW1660@lahna.fi.intel.com>
 <53F4638F.5070704@intel.com>
 <20140820101814.GC1660@lahna.fi.intel.com>
 <20140930091949.GI1325@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140930091949.GI1325@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Lan Tianyu <tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Xiubo Li <Li.Xiubo-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Zheng, Lv" <lv.zheng-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Tue, Sep 30, 2014 at 11:19:49AM +0200, Wolfram Sang wrote:
> Hi people,
> 
> thanks for the additional information here.
> 
> > > Sorry for later response due to leave home today. acpi_gsb_i2c_read_bytes()
> > > dedicates for GenericSerialBus Read/Write N Bytes protocol(ACPI Spec
> > > 5.5.2.4.5.3.8). Bios wants to read N Bytes when uses this protocol and the
> > > length specified by Bios should be greater than 1. If the Bios specified 0
> > > bytes, the associated function(E,G read battery info) would be totally unusable.
> > > I think such Bios can't pass through Windows certification:). From this point, I
> > > think the check is not necessary.
> 
> The simple question behind this is: Do I trust the caller? When I look
> at BIOS (or anything outside the kernel for that matter), I clearly say
> no, so...
> 
> > > If you still thought this maybe happen, I think it makes more sense to add the
> > > check length in the ACPICA. Because ACPICA will allocate a data buffer for I2C
> > > ACPI operation region access before call the callback. The buffer length will be
> > > result of protocol head length plus data length. If data length is 0 and this
> > > means the access will be invalid and ACPICA should ignore it or produce a warning.
> 
> ... I'd think such a check in ACPICA should be made. However, I can
> still ask the question if I trust callers outside my subsystem. This is
> more policy. We can demand that users of acpi_i2c_space_handler() should
> sanity check their arguments. Any foreseeable chance there will be
> another user other than ACPICA? I'd think no?

I'm not entirely sure I understand your question.

It is supposed to work like this:

 1. AML (firmware) code wants to do an I2C transaction. It may be
    triggered from an GPE event or something else.

 2. It reads/writes to an I2C operation region if it is available.

 3. This all is handled inside ACPICA.

 4. ACPICA calls registered address space handler for I2C which is
    acpi_i2c_space_handler().

 5. acpi_i2c_space_handler() handles the I2C transaction in the OS
    context and returns back whatever is requested to the AML (firmware)
    code.

So the only caller of acpi_i2c_space_handler() is ACPICA and we sure can
require it to validate the parameters it passes.
