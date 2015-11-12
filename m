From: Jean Delvare <jdelvare@suse.de>
Subject: Re: [PATCH v5] at24: Support SMBus read/write of 16-bit devices
Date: Thu, 12 Nov 2015 08:53:10 +0100
Message-ID: <20151112085310.5b7440ad@endymion.delvare>
References: <1708959504.44242.1447177870642.JavaMail.zimbra@xes-inc.com>
	<1031257086.44697.1447178019547.JavaMail.zimbra@xes-inc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:33597 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750963AbbKLHxO (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Thu, 12 Nov 2015 02:53:14 -0500
In-Reply-To: <1031257086.44697.1447178019547.JavaMail.zimbra@xes-inc.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Aaron Sierra <asierra@xes-inc.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, Christian Gmeiner <christian.gmeiner@gmail.com>, Nate Case <ncase@xes-inc.com>

Hi Aaron,

On Tue, 10 Nov 2015 11:53:39 -0600 (CST), Aaron Sierra wrote:
> +		if ((chip.flags & AT24_FLAG_ADDR16) &&
> +		    i2c_check_functionality(client->adapter,
> +				I2C_FUNC_SMBUS_READ_BYTE |
> +				I2C_FUNC_SMBUS_WRITE_BYTE_DATA)) {
> +			/*
> +			 * We need SMBUS_WRITE_BYTE_DATA and
> +			 * SMBUS_READ_BYTE_DATA to implement byte reads for

It's a minor thing really but I'm afraid you forgot to update this
comment (SMBUS_READ_BYTE not SMBUS_READ_BYTE_DATA.)

> +			 * 16-bit address devices. This will be slow, but
> +			 * better than nothing (e.g. read @ 3.6 KiB/s). It is
> +			 * also unsafe in a multi-master topology.
> +			 */
> +			use_smbus = I2C_SMBUS_BYTE_DATA;
> +		} else if (i2c_check_functionality(client->adapter,
>  				I2C_FUNC_SMBUS_READ_I2C_BLOCK)) {
>  			use_smbus = I2C_SMBUS_I2C_BLOCK_DATA;
>  		} else if (i2c_check_functionality(client->adapter,

Rest looks alright.

-- 
Jean Delvare
SUSE L3 Support
