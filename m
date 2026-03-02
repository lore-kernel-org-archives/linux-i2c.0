Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CEED28852E;
	Mon,  2 Mar 2026 05:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772428187; cv=none; b=Dgky622S2x7M7mJ1W7hHdCL0VVYEB2TUgu+sy/qMmS1OMo5z/nGrEp4cN/IT8UfLwo7bmnwVPjfWfNijdguVJEgWWvCl35wrIdqvNn0+3mjjgbDbEVsy3gNdiofslvu45cZTNshnRk77BcUb1R0QDsBBrxkbTtBXcG4ODiK40HQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772428187; c=relaxed/simple;
	bh=VTu68drSWkpGkTnzUL6IgsyRcnCTTwhbTtlzIpiAe4A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SAslufwGwCtVMi5Oo6kD8XstIHQCV+/Yxtw8P64bmIa+vgb5Z8hZNsA6lIX4iBdnz7SevuBf2ciZNap0jaOuUg8AiZmeCpncd8DwPF9e7XYRocE7AfWS66HTRfCuU2RWPMnOoA+9Kdu7lFMAtGg1JphHRaGDwlux5O3ZkzRNIUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mOMv6b9j; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mOMv6b9j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D9B7C19423;
	Mon,  2 Mar 2026 05:09:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772428187;
	bh=VTu68drSWkpGkTnzUL6IgsyRcnCTTwhbTtlzIpiAe4A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mOMv6b9jVxupPFkr//4Vp53PcuNBY5LRCjTSGMU4c+hmuwgWZ0HJzP+NZheokJjzs
	 CTctpCC1BjzgOq6QzXmVO4E4QxwJp7EeGT46KcniK8K+a5Y88TFcHwkiwvnZ2yRVY1
	 gWlglNBVK+NQCAlmwxnlT0W56f3b5cXZTlgLaa/xWkTGv5gloS6AXruo4ySJyy5cDz
	 brEsnkNq7uZV4Py8LCq6o+4DoYhTh7qu9gw1xjPM3z3ULCh6a+xaFpJq60t69wguYA
	 /805+9ZRABnead97wuI5hW32FyKcdzi9HJd4MrCRXqqMF5e+Hmd0zoZzfsRH1XygQB
	 wnhrBqy2Fp/FQ==
Date: Sun, 1 Mar 2026 21:09:46 -0800
From: Kees Cook <kees@kernel.org>
To: Matt Corallo <yalbrymrb@mattcorallo.com>
Cc: Greg KH <gregkh@linuxfoundation.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	linux-hwmon@vger.kernel.org, Linux I2C <linux-i2c@vger.kernel.org>,
	security@kernel.org
Subject: Re: PMBus memory overflow
Message-ID: <202603012052.AE51FCB9@keescook>
References: <bc9a14b5-8b10-436f-a791-28df245465e6@mattcorallo.com>
 <4e198aa1-527b-4ad8-abc5-e7408296bfbd@roeck-us.net>
 <03da7997-74f4-4435-a6c5-6aa5aea2f6d7@mattcorallo.com>
 <2025060749-attendant-trout-d2c8@gregkh>
 <695ebdae-7292-4a83-8aff-763da184921e@mattcorallo.com>
 <2025060848-reset-recovery-f67a@gregkh>
 <d16cb075-f924-4bd4-adec-8eaba589a3f2@mattcorallo.com>
 <a149cb52-925a-4365-8529-081e7e0a7b81@mattcorallo.com>
 <87767DC8-784D-4B9D-A2F2-0BB10EC4A96A@kernel.org>
 <e1eaab50-3a21-4aee-9224-6a1bbf8cfa6e@mattcorallo.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e1eaab50-3a21-4aee-9224-6a1bbf8cfa6e@mattcorallo.com>

On Sun, Mar 01, 2026 at 12:10:08PM -0500, Matt Corallo wrote:
> 
> 
> On 3/1/26 11:12 AM, Kees Cook wrote:
> > 
> > 
> > On March 1, 2026 5:46:33 AM PST, Matt Corallo <yalbrymrb@mattcorallo.com> wrote:
> > > 
> > > 
> > > On 6/9/25 9:57 AM, Matt Corallo wrote:
> > > > 
> > > > 
> > > > On 6/8/25 3:14 AM, Greg KH wrote:
> > > > > Have a pointer to that patch on lore for the maintainers involved to
> > > > > review?  Note, we are in the middle of the merge window, so no new
> > > > > changes can be added to our trees until -rc1 is out.
> > > > 
> > > > A proposed patch was posted by Guenter, and tested and confirmed that it fixes the issue by myself, at https://lore.kernel.org/linux-hwmon/284466fd-39e8-419e-8af5-41dbabb788af@roeck-us.net/ . Wolfram suggested this patch was acceptable at https://lore.kernel.org/linux-hwmon/aAtEydwUfVcE0XeA@shikoro/ but that's the last he chimed in on this issue.
> > > 
> > > Any update on getting this patch applied Wolfram? Looks like the buffer overflow is still present on at least 6.18.
> > 
> > Looking at the code, I think probably the best place to check would be in i2c_smbus_read_block_data() when it does a I2C_SMBUS_BLOCK_DATA cmd, since the callers are all already checking the returned status.
> 
> I believe that's what the above patch does?

Sorry, I mis-pasted. I meant within i2c_smbus_xfer (rather than
i2c_smbus_read_block_data). Like:


diff --git a/drivers/i2c/i2c-core-smbus.c b/drivers/i2c/i2c-core-smbus.c
index 71eb1ef56f0c..fbca606ba35a 100644
--- a/drivers/i2c/i2c-core-smbus.c
+++ b/drivers/i2c/i2c-core-smbus.c
@@ -547,6 +547,10 @@ s32 i2c_smbus_xfer(struct i2c_adapter *adapter, u16 addr,
 			       command, protocol, data);
 	i2c_unlock_bus(adapter, I2C_LOCK_SEGMENT);
 
+	if (WARN_ON_ONCE(res == 0 && command == I2C_SMBUS_BLOCK_DATA &&
+			 data->block[0] > I2C_SMBUS_BLOCK_MAX))
+		res = -E2BIG;
+
 	return res;
 }
 EXPORT_SYMBOL(i2c_smbus_xfer);

-- 
Kees Cook
