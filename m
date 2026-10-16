Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FBB13BB10E;
	Fri, 16 Oct 2026 06:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792133244; cv=none; b=txAY+X1Lj2EinPYdDYiqc1hhDhW9ry8SGL7YY31b20DzTX03BypsQBVSne27RVRLAWdnazUbzjMtJb5Qno3lNXYD6CCyD80A5UsxXlDeuQqmjduM4QJqQLjdeovykJIuoXqrNPI8OxW0WSmGEQKeX7CMar5ygUYRED21VIsiW5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792133244; c=relaxed/simple;
	bh=lUBOPOqYVqA2KUc9t/yGZ1UCIud8rvDfmuZTz6cXgj0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SLLbsNkrtnZA+QdpxailV0emuJ77FMSMC09OPMMaqw9d+awwFPMSldwSODhqWMtu/vbYynDlI98L6wSa3HiwRrQvb7yUV8wk8cdEvS09uIIL1wOIFAURTtRw8JiAmQiTMB5aq82YSLBqAKjuIJ/8eRd4LI5eL3Sy4S+htG2qZJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZgSha+D2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZgSha+D2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DD011F000C4;
	Fri, 16 Oct 2026 06:47:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792133235;
	bh=1ISyRmIUziV4tIbthI/qB5MryCB1FdZ8qcOmMUPgfcU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ZgSha+D2nx3Q9XmvmY/CRaFx0LnRNkdnE/4t3ItrDULGtAk4cwSbpnSg4LLDO8sbK
	 FvJPawmVo+DJpJHndZPdPMwJKEY2es6q3UYDhRkSZxsB2c3QrDZfFeb/vQRmCD09/c
	 ITsLNFsCB9R+imBV418vfuVTl/4Ngut/H4M/kYDoPMncS4x8faLH8aGCPFvQ+R46BJ
	 8QbFfIn0rcU750n4OuwWJ8Azw88QXiFptSm8HBhQp+0QPXV+pBpBQTj7OE3SQUo3bo
	 paUiJg1Z4HHzKNdfrIcpC1L1F0xsYuYlhdPUNbWdbJ4FKXO32P9U08ImT9vGq4Jqmr
	 NSHt/ZA+VOtTg==
Date: Fri, 16 Oct 2026 07:47:10 +0100
From: Lee Jones <lee@kernel.org>
To: Thomas Richard <thomas.richard@bootlin.com>
Cc: Andi Shyti <andi.shyti@kernel.org>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Werner Gartner <Werner.Gartner@congatec.com>, mfd@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org
Subject: Re: [PATCH v4 4/9] mfd: cgbc: Use PLATFORM_DEVID_AUTO for child
 device registration
Message-ID: <20261016064710.GA2093461@google.com>
References: <20261002-cgbc-i2c-storage-devices-support-v4-0-eb42e0f1df59@bootlin.com>
 <20261002-cgbc-i2c-storage-devices-support-v4-4-eb42e0f1df59@bootlin.com>
 <20261015152741.GB2048969@google.com>
 <a873afcf-ba8b-479d-bb0d-d022895d18d4@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a873afcf-ba8b-479d-bb0d-d022895d18d4@bootlin.com>

On Thu, 15 Oct 2026, Thomas Richard wrote:

> On 10/15/26 5:27 PM, Lee Jones wrote:
> > On Fri, 02 Oct 2026, Thomas Richard (congatec GmbH) wrote:
> > 
> >> Since parameters are now passed to the i2c-cgbc driver via platform
> >> data, the I2C driver no longer depends on the platform device ID to probe
> >> the correct I2C buses. Drop the hardcoded cell ID in favor of
> >> PLATFORM_DEVID_AUTO.
> >>
> >> Signed-off-by: Thomas Richard (congatec GmbH) <thomas.richard@bootlin.com>
> >> ---
> >>  drivers/mfd/cgbc-core.c | 6 ++----
> >>  1 file changed, 2 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/drivers/mfd/cgbc-core.c b/drivers/mfd/cgbc-core.c
> >> index 0cd9e6f888cb..8522df882509 100644
> >> --- a/drivers/mfd/cgbc-core.c
> >> +++ b/drivers/mfd/cgbc-core.c
> >> @@ -71,13 +71,11 @@ static const struct mfd_cell cgbc_devs[] = {
> >>  	MFD_CELL_NAME("cgbc-hwmon"),
> >>  	{
> >>  		.name = "cgbc-i2c",
> >> -		.id = 1,
> > 
> > If you shuffled the patches around a bit, you shouldn't have to hack
> > your own new additions in and out, no?
> For I2C bus names I got it, but not for id.
> I need i2c_platform_data to be able to drop cell id and use
> PLATFORM_DEVID_AUTO, so I don't see how I could reorder the patches.
> And cell ids are there from the beginning, not really a new addition.
> Maybe I misunderstood your comment, or I miss something.

Okay, just the names then.

-- 
Lee Jones
