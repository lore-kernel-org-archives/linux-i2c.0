Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.13
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793618837;
	b=MxJUfsbSiuiBcKdCkrxK/EYLMEPQHdEg4CxSyYCiUC6r/RCBF4UKvxKg8soG4k2VUabn
	 kzEpWoJdbmBC+L3fW3lHwugqwLr+S1Ud1CTSlGFvjtDUG4YlZdNF+n+UzXa7jE6L5DSfA
	 rJnOFFCNi1YDzWLMDF5exQVW7uR9GaNlsU3Xz0S8obr3YE7AGHdQ2Y8LacJO16JepyQuM
	 xu3mBp+h88mrZvXKTLf2PajDuWVd80zndWlaVSeYmR24tkGbjDgk8DhYxS+sehcXZplW9
	 Rplf3UGLPUHvtn3ZckMw7bvGlQFi8Mse8wRF51XLeuM+25/4aHh+0htuOix7QyNQT/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793618837;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=Cv9fYOoWwKUfXT2oTsRskBZMj58HrKtQLYQjDyrTVDs=;
	b=BGDqZFaGqGWDnHIqF+DRIzpQv9U1ZQ+aGQVRgE7PBEwJWT/XxbemvIqBBeo7Cft9e0F7
	 GpUoaGia2Mbul85ndYEUYhXo/vFYLIqsHfZ4vQowlTM/p5kboG/NsHH5VJVh9arvwSQpR
	 a2TdDl4EpG3/zyU46mIn3vhvJwga8rmeXXiSRgNFIVd0UPWPAJF9ROMRC1fX8icJt/gGK
	 2St1FM0x3Nwwx+YNioAOn1SfZkH6xSQu7cOeWWYR0UHExDRJ48HRw3q0Wtuzz4BRCD8B5
	 mNhoWFrfwfnUV+Ap50B5wRVWfPEwfeZ286ksPA0dRAUrA9gRqBIJLNMqdUwFrOO20rw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=FG1xp8AQ;
	arc=none smtp.remote-ip=192.198.163.13
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD4F606A326;
	Mon,  2 Nov 2026 11:27:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BBD4F606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=FG1xp8AQ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793618836; x=1825154836;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/nB8lTnfYGUH3O33ofshGMBV5q9MN0RN/P6LQYfKSfI=;
  b=FG1xp8AQtrZzYFYyaCc4K3ci4bOYYREX1ykIKHHDihKsve8pOjKLLNol
   WRGTVAZBMU1cQkl37r6ETpn8J1l8osR4OEDbM3n403iESr1FrnVwP1UT5
   SqTkclW+voaz0D+aghdl/8/+eR01zn8qNy3EHmVL+LDZH7Q3XKZRfjvgy
   u5K7tC+BdxSLDJxTVbWEAc+QdYOyYpje6Kj8G3uxq/GipKGRnJzNuIa4M
   9U6n/UsDT1YNl/pbwkPeBaJfAmBn+r2znQddNybRwwmU6T2eWbY9rAS7+
   Ub0cC7qfOkoA4U3wj6GQdc5cvQd+bnIpwg9ahmWqlFAImLo8ZbApPkfF3
   Q==;
X-CSE-ConnectionGUID: JREeEFtNQ32CJbdxyBiucA==
X-CSE-MsgGUID: fZJjNxdqR+mTVPe3fTrNcQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11953"; a="2300765"
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="2300765"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2026 03:27:15 -0800
X-CSE-ConnectionGUID: VaR2CX81R0aqrzwHP+dLBg==
X-CSE-MsgGUID: jjHG8chRSjW08wU/EISiZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="6422228"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa008.fm.intel.com with ESMTP; 02 Nov 2026 03:27:14 -0800
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id A058A99; Mon, 02 Nov 2026 12:27:12 +0100 (CET)
Date: Mon, 2 Nov 2026 12:27:12 +0100
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: "Baek Kyu, Kim" <pocj8ur4in@gmail.com>
Cc: Andi Shyti <andi.shyti@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i2c: designware: preserve invalid SMBus block count
Message-ID: <20261102112712.GT158991@black.igk.intel.com>
References: <20261031105412.16825-1-pocj8ur4in@gmail.com>
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261031105412.16825-1-pocj8ur4in@gmail.com>

Hi,

On Sat, Oct 31, 2026 at 07:54:12PM +0900, Baek Kyu, Kim wrote:
> When a slave reports an invalid SMBus block count, i2c_dw_read() uses
> one extra read to reach STOP. It currently replaces the received count
> with 1 for scheduling and also stores 1 in the message buffer. A count
> above 32 is therefore exposed as a valid one-byte response.
> 
> Keep the received byte in the buffer and limit only the count passed to
> i2c_dw_recv_len(). This preserves the extra read for STOP while retaining
> the invalid count for the caller to reject.
> 
> Fixes: 69f035c480d7 ("i2c: designware: Handle invalid SMBus block data response length value")
> Signed-off-by: Baek Kyu, Kim <pocj8ur4in@gmail.com>
> ---
> The DesignWare receive functions were exercised with stubbed register
> input for block counts 1, 32, 33 and 255. Counts 33 and 255 became 1
> before the change and remained unchanged after it; both versions
> scheduled one extra read for an invalid count. No physical controller,
> STOP signal, PEC result or end-to-end SMBus return was measured.
> 
>  drivers/i2c/busses/i2c-designware-master.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-designware-master.c b/drivers/i2c/busses/i2c-designware-master.c
> index 7e1d9a2e77332..f38ffc5b0a347 100644
> --- a/drivers/i2c/busses/i2c-designware-master.c
> +++ b/drivers/i2c/busses/i2c-designware-master.c
> @@ -563,7 +563,7 @@ i2c_dw_read(struct dw_i2c_dev *dev)
>  		for (; len > 0 && rx_valid > 0; len--, rx_valid--) {
>  			regmap_read(dev->map, DW_IC_DATA_CMD, &tmp);
>  			tmp &= DW_IC_DATA_CMD_DAT;
> -			/* Ensure length byte is a valid value */
> +			/* Limit the extra read, but keep the raw count for i2c-core */
>  			if (flags & I2C_M_RECV_LEN) {
>  				/*
>  				 * if IC_EMPTYFIFO_HOLD_MASTER_EN is set, which cannot be
> @@ -574,10 +574,8 @@ i2c_dw_read(struct dw_i2c_dev *dev)
>  				 * another byte with STOP bit set when the block data
>  				 * response length is invalid to complete the transaction.
>  				 */
> -				if (!tmp || tmp > I2C_SMBUS_BLOCK_MAX)
> -					tmp = 1;
> -
> -				len = i2c_dw_recv_len(dev, tmp);
> +				len = i2c_dw_recv_len(dev,
> +						  (!tmp || tmp > I2C_SMBUS_BLOCK_MAX) ? 1 : tmp);

I suggest using helper variable here. This is pretty hard to understand
otherwise.

>  			}
>  			*buf++ = tmp;
>  			dev->rx_outstanding--;
> -- 
> 2.55.0
