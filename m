Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5584A18C2C;
	Sun, 26 Jul 2026 11:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785064280; cv=none; b=pFM36Xopn/yXNkRtWpMqgAt5o46QTwKvXTrL7QABAJrWkazbSY/tQ7r3QU3y0th1IVWXWDx+aztJWPVSYAEmtYcoLSw4otzhRd4Ro8NkSrWCnQbHgctix3tEu6/YJJdk1KA0nTv0Z4Y1zuNgEH/ojHn8rRscpCLYCcm2ma32bx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785064280; c=relaxed/simple;
	bh=dX7xC+F2VfseCFPPjMdEezyv4bbqh09NUjkZEo3thHQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nt0XbvUrsebc0swgfyovT2sIr7GnBk5r5w1aXQxkf7nBNQ4ssMabIvPiZAbTrhzxrxhZWP+hpyBXcvxGstbPuU2Qzjz6maIWPh8jTh48LVnZfifWAgrbZma5EHAsZHOvxA1obWHa1j+8PCmnlADYMWZoSP5HXs1e5rFaj4YvLM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hb/8Cejf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hb/8Cejf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 765A31F000E9;
	Sun, 26 Jul 2026 11:11:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785064279;
	bh=qsnACiFUU54YYrFgpxJ9gvk4dmWGwM/9GcFtaNpJFYM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hb/8CejflmypJ1DS0BYIqFW8aUhhZY+9BLQ5kazwgIBKOpaQgRCC0sVYbzfxwD25M
	 Jh76CtL0Ye3GFswexZ8xbEf3Ni/DN7dGNdp5c3nGvA01lIPOivtgb9xLV3JjESBfsD
	 FFS7O68sPuyT8wCCD65VmlA7oTg1oAaL/akWZls8=
Date: Sun, 26 Jul 2026 13:09:54 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: HE WEI =?utf-8?B?KOOCruOCq+OCryk=?= <skyexpoc@gmail.com>
Cc: Israel Cepeda <israel.a.cepeda.lopez@intel.com>,
	Hans de Goede <hansg@kernel.org>,
	Andi Shyti <andi.shyti@kernel.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	linux-usb@vger.kernel.org, linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] usbio: fix two out-of-bounds accesses and a hang
Message-ID: <2026072622-refusing-smasher-6eed@gregkh>
References: <20260726080129.44969-1-skyexpoc@gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260726080129.44969-1-skyexpoc@gmail.com>

On Sun, Jul 26, 2026 at 04:59:10PM +0900, HE WEI (ギカク) wrote:
> This is variant analysis around 8c6314489550 ("usb: misc: usbio: bound
> bulk IN response length to the received transfer"), which fixed a slab
> out-of-bounds read in usbio_bulk_msg().  Re-reading that function,
> usbio_ctrl_msg() and the I2C client built on top of them turned up three
> further issues.
> 
> Patch 1 fixes the length checks in usbio_ctrl_msg() and
> usbio_bulk_msg().  They are computed as "<buf>_len - sizeof(*pkt)", u16
> minus size_t, which wraps for any endpoint smaller than the protocol
> header.  usb_parse_endpoint() only clamps wMaxPacketSize downwards, so
> a device can advertise 1 and turn the check off entirely; the first I2C
> transfer then overflows a one byte slab object.  The overflow completes
> before usb_bulk_msg() is reached, so it does not depend on the host
> controller accepting the transfer.  Fixed by validating the three
> lengths once in usbio_probe(), which is the only place that assigns
> them.
> 
> Patch 2 is the equivalent arithmetic in i2c-usbio.c, where the overhead
> is 10 rather than 5.  The interesting value there is exactly 10: the
> chunk size is then 0 and the split loop in usbio_i2c_read() never
> advances, so a device that keeps answering keeps the loop alive
> uninterruptibly while holding usbio->bulk_mutex.  That is a hang rather
> than memory corruption, and patch 1 does not address it.  This is also
> the one patch in the series with a behaviour change -- a bridge whose
> bulk wMaxPacketSize is below 11 no longer gets an I2C adapter -- and the
> commit message spells out why such an adapter could never have
> completed a transfer in the first place.
> 
> Patch 3 is a different bug from the two above, and the one that affects
> existing hardware.  usbio_ctrl_msg() and usbio_bulk_msg() hex dump the
> reply with "%*phN" using a length the device supplied and that has not
> been validated yet.  hex_string() caps the field width at 64, not at
> the buffer size, so the dump reads up to byte 67 of ctrlbuf and byte 68
> of rxbuf: out of bounds for every low, full and high speed ep0 packet
> size and for the bulk sizes these bridges actually use.  It needs no
> malformed descriptor at all, only the dev_dbg() calls enabled.
> 
> The new probe checks do not reject any supported bridge: the low, full
> and high speed devices this driver binds to have an ep0 packet size of
> at least 8, and they use bulk endpoints of 64, or 63 via
> USBIO_QUIRK_BULK_MAXP_63.
> 
> What was verified, and what was not:
> 
>  - All three build cleanly with x86_64 gcc 14.2.0 at W=1, with
>    CONFIG_DYNAMIC_DEBUG both disabled and enabled.
> 
>  - The out-of-bounds accesses in patches 1 and 3, and the
>    non-terminating loop in patch 2, reproduce against a userspace model
>    that copies the struct definitions from usbio.h and the checks and
>    stores from usbio.c and i2c-usbio.c verbatim, with only
>    devm_kzalloc(), usb_bulk_msg() and usb_control_msg() replaced; the
>    memory errors are reported by AddressSanitizer.  The same source
>    built with the patches applied is clean, and both a normal device
>    (ep0 64, bulk 64/64) and the USBIO_QUIRK_BULK_MAXP_63 path still
>    work.
> 
>  - The decision space was swept exhaustively, endpoint sizes 0..2048
>    against caller lengths 0..4101: the mainline bulk check can be
>    bypassed for exactly 0..4 and the control check for exactly 0..3.
>    After patch 1 no accepted endpoint size admits an overflow, and no
>    size that could carry a payload byte is rejected.
> 
>  - I have not run any of this on hardware or on dummy_hcd.  The
>    reachability arguments are read from usbcore and from
>    lib/vsprintf.c, not observed at runtime.  I am happy to build a
>    raw-gadget reproducer if that would help review.
> 
> Patches 1 and 3 touch drivers/usb/misc/usbio.c and patch 2 touches
> drivers/i2c/busses/i2c-usbio.c; MAINTAINERS lists all three files under
> the same INTEL USBIO entry, so they are sent as one series.  They apply
> to mainline 3dab139d4795, to usb-next and to usb-testing.
> 
> HE WEI (ギカク) (3):
>   usb: misc: usbio: reject endpoints smaller than the packet header
>   i2c: usbio: reject bridges with undersized transfer buffers
>   usb: misc: usbio: bound the debug hex dumps by the received length
> 
>  drivers/i2c/busses/i2c-usbio.c | 14 ++++++++++++
>  drivers/usb/misc/usbio.c       | 50 ++++++++++++++++++++++++++++++++++++++----
>  2 files changed, 60 insertions(+), 4 deletions(-)

As you obviously used a LLM for these, why did it not properly tag the
changes with an "Assisted-by:" tag?  That is required.

thanks,

greg k-h
