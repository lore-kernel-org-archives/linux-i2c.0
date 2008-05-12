From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Subject: Re: [RFC][PATCH 4/4] RTC: SMBus support for the M41T80
Date: Mon, 12 May 2008 11:45:44 +0900 (JST)
Message-ID: <20080512.114544.41629483.nemoto@toshiba-tops.co.jp>
References: <Pine.LNX.4.55.0805100116290.10552@cliff.in.clinika.pl>
	<20080510103544.701c7b3f@hyperion.delvare>
	<Pine.LNX.4.55.0805110045010.18978@cliff.in.clinika.pl>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1760741AbYELCqX@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.55.0805110045010.18978@cliff.in.clinika.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: macro@linux-mips.org
Cc: khali@linux-fr.org, david-b@pacbell.net, a.zummo@towertech.it, ab@mycable.de, anemo@mba.ocn.ne.jp, i2c@lm-sensors.org, rtc-linux@googlegroups.com, linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Sun, 11 May 2008 02:59:34 +0100 (BST), "Maciej W. Rozycki" <macro@linux-mips.org> wrote:
>  If we agree on this one, I will retest and submit the whole batch again,
> updated as needed.

Works OK for me (m41t80 + i2c-gpio).

Tested-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

One minor style comment.

> +	if (i2c_check_functionality(client->adapter,
> +				    I2C_FUNC_SMBUS_WRITE_I2C_BLOCK)) {
> +		i = i2c_smbus_write_i2c_block_data(client, reg, num, buf);
> +	} else {
> +		for (i = 0; i < num; i++) {
> +			rc = i2c_smbus_write_byte_data(client, reg + i,
> +						       buf[i]);
> +			if (rc < 0) {
> +				i = rc;
> +				goto out;
> +			}
> +		}
>  	}
> +out:
> +	return i;

This part can be a bit shorter.

	if (i2c_check_functionality(client->adapter,
				    I2C_FUNC_SMBUS_WRITE_I2C_BLOCK))
		return i2c_smbus_write_i2c_block_data(client, reg, num, buf);
	for (i = 0; i < num; i++) {
		rc = i2c_smbus_write_byte_data(client, reg + i, buf[i]);
		if (rc < 0)
			return rc;
	}
	return i;

Saves 6 lines.  Not a big issue.

---
Atsushi Nemoto
